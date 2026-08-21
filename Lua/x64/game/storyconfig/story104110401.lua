return {
	Play411041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411041001
		arg_1_1.duration_ = 5.47

		local var_1_0 = {
			zh = 4.633,
			ja = 5.466
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
				arg_1_0:Play411041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11r"

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
				local var_4_5 = arg_1_1.bgs_.I11r

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
					if iter_4_0 ~= "I11r" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.366666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.6
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			local var_4_34 = 2
			local var_4_35 = 0.35

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[648].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(411041001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 14
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041001", "story_v_out_411041.awb") ~= 0 then
					local var_4_43 = manager.audio:GetVoiceLength("story_v_out_411041", "411041001", "story_v_out_411041.awb") / 1000

					if var_4_43 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_34
					end

					if var_4_38.prefab_name ~= "" and arg_1_1.actors_[var_4_38.prefab_name] ~= nil then
						local var_4_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_38.prefab_name].transform, "story_v_out_411041", "411041001", "story_v_out_411041.awb")

						arg_1_1:RecordAudio("411041001", var_4_44)
						arg_1_1:RecordAudio("411041001", var_4_44)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411041", "411041001", "story_v_out_411041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411041", "411041001", "story_v_out_411041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_34 + 0.3
			local var_4_46 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411041002
		arg_9_1.duration_ = 2.57

		local var_9_0 = {
			zh = 2.566,
			ja = 1.999999999999
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1095ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1095ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1095ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.98, -6.1)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1095ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1095ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1095ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1095ui_story then
				arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.2

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[471].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(411041002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 8
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041002", "story_v_out_411041.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_411041", "411041002", "story_v_out_411041.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_411041", "411041002", "story_v_out_411041.awb")

						arg_9_1:RecordAudio("411041002", var_12_29)
						arg_9_1:RecordAudio("411041002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411041", "411041002", "story_v_out_411041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411041", "411041002", "story_v_out_411041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play411041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411041003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1095ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1095ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1095ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1095ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1095ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 1.225

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(411041003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 49
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play411041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				local var_20_2 = "play"
				local var_20_3 = "effect"

				arg_17_1:AudioAction(var_20_2, var_20_3, "se_story", "se_story_communication", "")
			end

			local var_20_4 = 0
			local var_20_5 = 1

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(411041004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_8 = 40
				local var_20_9 = utf8.len(var_20_7)
				local var_20_10 = var_20_8 <= 0 and var_20_5 or var_20_5 * (var_20_9 / var_20_8)

				if var_20_10 > 0 and var_20_5 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_11 and arg_17_1.time_ < var_20_4 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play411041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411041005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1095ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_0) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1095ui_story"].transform
			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.var_.moveOldPos1095ui_story = var_24_4.localPosition
			end

			local var_24_6 = 0.001

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / var_24_6
				local var_24_8 = Vector3.New(0, 100, 0)

				var_24_4.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1095ui_story, var_24_8, var_24_7)

				local var_24_9 = manager.ui.mainCamera.transform.position - var_24_4.position

				var_24_4.forward = Vector3.New(var_24_9.x, var_24_9.y, var_24_9.z)

				local var_24_10 = var_24_4.localEulerAngles

				var_24_10.z = 0
				var_24_10.x = 0
				var_24_4.localEulerAngles = var_24_10
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 then
				var_24_4.localPosition = Vector3.New(0, 100, 0)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_4.position

				var_24_4.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_4.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_4.localEulerAngles = var_24_12
			end

			local var_24_13 = 0
			local var_24_14 = 1.35

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:GetWordFromCfg(411041005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.text_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 53
				local var_24_18 = utf8.len(var_24_16)
				local var_24_19 = var_24_17 <= 0 and var_24_14 or var_24_14 * (var_24_18 / var_24_17)

				if var_24_19 > 0 and var_24_14 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_13 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_13
					end
				end

				arg_21_1.text_.text = var_24_16
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_14, arg_21_1.talkMaxDuration)

			if var_24_13 <= arg_21_1.time_ and arg_21_1.time_ < var_24_13 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_13) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_13 + var_24_20 and arg_21_1.time_ < var_24_13 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play411041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411041006
		arg_25_1.duration_ = 2.6

		local var_25_0 = {
			zh = 2.6,
			ja = 2.166
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
				arg_25_0:Play411041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10071ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "10071ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "10071ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["10071ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos10071ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0, -0.9, -6.26)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10071ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["10071ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10071ui_story == nil then
				arg_25_1.var_.characterEffect10071ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect10071ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10071ui_story then
				arg_25_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action2_1")
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_28_20 = 0
			local var_28_21 = 0.125

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[670].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(411041006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 5
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041006", "story_v_out_411041.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_411041", "411041006", "story_v_out_411041.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_411041", "411041006", "story_v_out_411041.awb")

						arg_25_1:RecordAudio("411041006", var_28_29)
						arg_25_1:RecordAudio("411041006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411041", "411041006", "story_v_out_411041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411041", "411041006", "story_v_out_411041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play411041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411041007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10071ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10071ui_story == nil then
				arg_29_1.var_.characterEffect10071ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10071ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10071ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10071ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10071ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.766666666666667

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				local var_32_8 = "play"
				local var_32_9 = "effect"

				arg_29_1:AudioAction(var_32_8, var_32_9, "se_story_6", "se_story_6_monster", "")
			end

			local var_32_10 = 0
			local var_32_11 = 0.15

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_12 = arg_29_1:FormatText(StoryNameCfg[217].name)

				arg_29_1.leftNameTxt_.text = var_32_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2118")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_13 = arg_29_1:GetWordFromCfg(411041007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 6
				local var_32_16 = utf8.len(var_32_14)
				local var_32_17 = var_32_15 <= 0 and var_32_11 or var_32_11 * (var_32_16 / var_32_15)

				if var_32_17 > 0 and var_32_11 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play411041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411041008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1095ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, -0.98, -6.1)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["1095ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_36_15 = arg_33_1.actors_["10071ui_story"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos10071ui_story = var_36_15.localPosition
			end

			local var_36_17 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Vector3.New(0, 100, 0)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10071ui_story, var_36_19, var_36_18)

				local var_36_20 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_20.x, var_36_20.y, var_36_20.z)

				local var_36_21 = var_36_15.localEulerAngles

				var_36_21.z = 0
				var_36_21.x = 0
				var_36_15.localEulerAngles = var_36_21
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(0, 100, 0)

				local var_36_22 = manager.ui.mainCamera.transform.position - var_36_15.position

				var_36_15.forward = Vector3.New(var_36_22.x, var_36_22.y, var_36_22.z)

				local var_36_23 = var_36_15.localEulerAngles

				var_36_23.z = 0
				var_36_23.x = 0
				var_36_15.localEulerAngles = var_36_23
			end

			local var_36_24 = 0
			local var_36_25 = 0.125

			if var_36_24 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_26 = arg_33_1:FormatText(StoryNameCfg[471].name)

				arg_33_1.leftNameTxt_.text = var_36_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_27 = arg_33_1:GetWordFromCfg(411041008)
				local var_36_28 = arg_33_1:FormatText(var_36_27.content)

				arg_33_1.text_.text = var_36_28

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_29 = 5
				local var_36_30 = utf8.len(var_36_28)
				local var_36_31 = var_36_29 <= 0 and var_36_25 or var_36_25 * (var_36_30 / var_36_29)

				if var_36_31 > 0 and var_36_25 < var_36_31 then
					arg_33_1.talkMaxDuration = var_36_31

					if var_36_31 + var_36_24 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_24
					end
				end

				arg_33_1.text_.text = var_36_28
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041008", "story_v_out_411041.awb") ~= 0 then
					local var_36_32 = manager.audio:GetVoiceLength("story_v_out_411041", "411041008", "story_v_out_411041.awb") / 1000

					if var_36_32 + var_36_24 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_32 + var_36_24
					end

					if var_36_27.prefab_name ~= "" and arg_33_1.actors_[var_36_27.prefab_name] ~= nil then
						local var_36_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_27.prefab_name].transform, "story_v_out_411041", "411041008", "story_v_out_411041.awb")

						arg_33_1:RecordAudio("411041008", var_36_33)
						arg_33_1:RecordAudio("411041008", var_36_33)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411041", "411041008", "story_v_out_411041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411041", "411041008", "story_v_out_411041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_34 = math.max(var_36_25, arg_33_1.talkMaxDuration)

			if var_36_24 <= arg_33_1.time_ and arg_33_1.time_ < var_36_24 + var_36_34 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_24) / var_36_34

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_24 + var_36_34 and arg_33_1.time_ < var_36_24 + var_36_34 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411041009
		arg_37_1.duration_ = 6

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1095ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1095ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = var_40_5
			end

			local var_40_6 = arg_37_1.actors_["1095ui_story"].transform
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = var_40_6.localPosition
			end

			local var_40_8 = 0.001

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8
				local var_40_10 = Vector3.New(0, 100, 0)

				var_40_6.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, var_40_10, var_40_9)

				local var_40_11 = manager.ui.mainCamera.transform.position - var_40_6.position

				var_40_6.forward = Vector3.New(var_40_11.x, var_40_11.y, var_40_11.z)

				local var_40_12 = var_40_6.localEulerAngles

				var_40_12.z = 0
				var_40_12.x = 0
				var_40_6.localEulerAngles = var_40_12
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 then
				var_40_6.localPosition = Vector3.New(0, 100, 0)

				local var_40_13 = manager.ui.mainCamera.transform.position - var_40_6.position

				var_40_6.forward = Vector3.New(var_40_13.x, var_40_13.y, var_40_13.z)

				local var_40_14 = var_40_6.localEulerAngles

				var_40_14.z = 0
				var_40_14.x = 0
				var_40_6.localEulerAngles = var_40_14
			end

			local var_40_15 = 0

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = false

				arg_37_1:SetGaussion(false)
			end

			local var_40_16 = 1

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_16 then
				local var_40_17 = (arg_37_1.time_ - var_40_15) / var_40_16
				local var_40_18 = Color.New(1, 1, 1)

				var_40_18.a = Mathf.Lerp(1, 0, var_40_17)
				arg_37_1.mask_.color = var_40_18
			end

			if arg_37_1.time_ >= var_40_15 + var_40_16 and arg_37_1.time_ < var_40_15 + var_40_16 + arg_40_0 then
				local var_40_19 = Color.New(1, 1, 1)
				local var_40_20 = 0

				arg_37_1.mask_.enabled = false
				var_40_19.a = var_40_20
				arg_37_1.mask_.color = var_40_19
			end

			local var_40_21 = 1
			local var_40_22 = 0.9

			if var_40_21 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				local var_40_23 = "play"
				local var_40_24 = "effect"

				arg_37_1:AudioAction(var_40_23, var_40_24, "se_story_131", "se_story_131_1095_skill1", "")
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_25 = 1
			local var_40_26 = 0.9

			if var_40_25 < arg_37_1.time_ and arg_37_1.time_ <= var_40_25 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_27 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_27:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_28 = arg_37_1:GetWordFromCfg(411041009)
				local var_40_29 = arg_37_1:FormatText(var_40_28.content)

				arg_37_1.text_.text = var_40_29

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_30 = 36
				local var_40_31 = utf8.len(var_40_29)
				local var_40_32 = var_40_30 <= 0 and var_40_26 or var_40_26 * (var_40_31 / var_40_30)

				if var_40_32 > 0 and var_40_26 < var_40_32 then
					arg_37_1.talkMaxDuration = var_40_32
					var_40_25 = var_40_25 + 0.3

					if var_40_32 + var_40_25 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_32 + var_40_25
					end
				end

				arg_37_1.text_.text = var_40_29
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_33 = var_40_25 + 0.3
			local var_40_34 = math.max(var_40_26, arg_37_1.talkMaxDuration)

			if var_40_33 <= arg_37_1.time_ and arg_37_1.time_ < var_40_33 + var_40_34 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_33) / var_40_34

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_33 + var_40_34 and arg_37_1.time_ < var_40_33 + var_40_34 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 411041010
		arg_43_1.duration_ = 2.67

		local var_43_0 = {
			zh = 2.066,
			ja = 2.666
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play411041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1095ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1095ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1095ui_story then
				arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_46_4 = 0

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_6 = arg_43_1.actors_["1095ui_story"].transform
			local var_46_7 = 0

			if var_46_7 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 then
				arg_43_1.var_.moveOldPos1095ui_story = var_46_6.localPosition
			end

			local var_46_8 = 0.001

			if var_46_7 <= arg_43_1.time_ and arg_43_1.time_ < var_46_7 + var_46_8 then
				local var_46_9 = (arg_43_1.time_ - var_46_7) / var_46_8
				local var_46_10 = Vector3.New(0, -0.98, -6.1)

				var_46_6.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1095ui_story, var_46_10, var_46_9)

				local var_46_11 = manager.ui.mainCamera.transform.position - var_46_6.position

				var_46_6.forward = Vector3.New(var_46_11.x, var_46_11.y, var_46_11.z)

				local var_46_12 = var_46_6.localEulerAngles

				var_46_12.z = 0
				var_46_12.x = 0
				var_46_6.localEulerAngles = var_46_12
			end

			if arg_43_1.time_ >= var_46_7 + var_46_8 and arg_43_1.time_ < var_46_7 + var_46_8 + arg_46_0 then
				var_46_6.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_46_13 = manager.ui.mainCamera.transform.position - var_46_6.position

				var_46_6.forward = Vector3.New(var_46_13.x, var_46_13.y, var_46_13.z)

				local var_46_14 = var_46_6.localEulerAngles

				var_46_14.z = 0
				var_46_14.x = 0
				var_46_6.localEulerAngles = var_46_14
			end

			local var_46_15 = 0
			local var_46_16 = 0.25

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[471].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(411041010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 10
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041010", "story_v_out_411041.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_411041", "411041010", "story_v_out_411041.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_411041", "411041010", "story_v_out_411041.awb")

						arg_43_1:RecordAudio("411041010", var_46_24)
						arg_43_1:RecordAudio("411041010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_411041", "411041010", "story_v_out_411041.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_411041", "411041010", "story_v_out_411041.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play411041011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411041011
		arg_47_1.duration_ = 6.6

		local var_47_0 = {
			zh = 6.6,
			ja = 4.533
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411041012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1095ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1095ui_story == nil then
				arg_47_1.var_.characterEffect1095ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1095ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1095ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1095ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1095ui_story.fillRatio = var_50_5
			end

			local var_50_6 = arg_47_1.actors_["10071ui_story"].transform
			local var_50_7 = 0

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.var_.moveOldPos10071ui_story = var_50_6.localPosition
			end

			local var_50_8 = 0.001

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 then
				local var_50_9 = (arg_47_1.time_ - var_50_7) / var_50_8
				local var_50_10 = Vector3.New(0.7, -0.9, -6.26)

				var_50_6.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10071ui_story, var_50_10, var_50_9)

				local var_50_11 = manager.ui.mainCamera.transform.position - var_50_6.position

				var_50_6.forward = Vector3.New(var_50_11.x, var_50_11.y, var_50_11.z)

				local var_50_12 = var_50_6.localEulerAngles

				var_50_12.z = 0
				var_50_12.x = 0
				var_50_6.localEulerAngles = var_50_12
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 then
				var_50_6.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_50_13 = manager.ui.mainCamera.transform.position - var_50_6.position

				var_50_6.forward = Vector3.New(var_50_13.x, var_50_13.y, var_50_13.z)

				local var_50_14 = var_50_6.localEulerAngles

				var_50_14.z = 0
				var_50_14.x = 0
				var_50_6.localEulerAngles = var_50_14
			end

			local var_50_15 = arg_47_1.actors_["10071ui_story"]
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.characterEffect10071ui_story == nil then
				arg_47_1.var_.characterEffect10071ui_story = var_50_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_17 = 0.200000002980232

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 and not isNil(var_50_15) then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17

				if arg_47_1.var_.characterEffect10071ui_story and not isNil(var_50_15) then
					arg_47_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.characterEffect10071ui_story then
				arg_47_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_50_20 = arg_47_1.actors_["1095ui_story"].transform
			local var_50_21 = 0

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.var_.moveOldPos1095ui_story = var_50_20.localPosition
			end

			local var_50_22 = 0.001

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_22 then
				local var_50_23 = (arg_47_1.time_ - var_50_21) / var_50_22
				local var_50_24 = Vector3.New(-0.7, -0.98, -6.1)

				var_50_20.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1095ui_story, var_50_24, var_50_23)

				local var_50_25 = manager.ui.mainCamera.transform.position - var_50_20.position

				var_50_20.forward = Vector3.New(var_50_25.x, var_50_25.y, var_50_25.z)

				local var_50_26 = var_50_20.localEulerAngles

				var_50_26.z = 0
				var_50_26.x = 0
				var_50_20.localEulerAngles = var_50_26
			end

			if arg_47_1.time_ >= var_50_21 + var_50_22 and arg_47_1.time_ < var_50_21 + var_50_22 + arg_50_0 then
				var_50_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_50_27 = manager.ui.mainCamera.transform.position - var_50_20.position

				var_50_20.forward = Vector3.New(var_50_27.x, var_50_27.y, var_50_27.z)

				local var_50_28 = var_50_20.localEulerAngles

				var_50_28.z = 0
				var_50_28.x = 0
				var_50_20.localEulerAngles = var_50_28
			end

			local var_50_29 = 0
			local var_50_30 = 0.625

			if var_50_29 < arg_47_1.time_ and arg_47_1.time_ <= var_50_29 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_31 = arg_47_1:FormatText(StoryNameCfg[670].name)

				arg_47_1.leftNameTxt_.text = var_50_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_32 = arg_47_1:GetWordFromCfg(411041011)
				local var_50_33 = arg_47_1:FormatText(var_50_32.content)

				arg_47_1.text_.text = var_50_33

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_34 = 25
				local var_50_35 = utf8.len(var_50_33)
				local var_50_36 = var_50_34 <= 0 and var_50_30 or var_50_30 * (var_50_35 / var_50_34)

				if var_50_36 > 0 and var_50_30 < var_50_36 then
					arg_47_1.talkMaxDuration = var_50_36

					if var_50_36 + var_50_29 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_36 + var_50_29
					end
				end

				arg_47_1.text_.text = var_50_33
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041011", "story_v_out_411041.awb") ~= 0 then
					local var_50_37 = manager.audio:GetVoiceLength("story_v_out_411041", "411041011", "story_v_out_411041.awb") / 1000

					if var_50_37 + var_50_29 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_37 + var_50_29
					end

					if var_50_32.prefab_name ~= "" and arg_47_1.actors_[var_50_32.prefab_name] ~= nil then
						local var_50_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_32.prefab_name].transform, "story_v_out_411041", "411041011", "story_v_out_411041.awb")

						arg_47_1:RecordAudio("411041011", var_50_38)
						arg_47_1:RecordAudio("411041011", var_50_38)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_411041", "411041011", "story_v_out_411041.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_411041", "411041011", "story_v_out_411041.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_39 = math.max(var_50_30, arg_47_1.talkMaxDuration)

			if var_50_29 <= arg_47_1.time_ and arg_47_1.time_ < var_50_29 + var_50_39 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_29) / var_50_39

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_29 + var_50_39 and arg_47_1.time_ < var_50_29 + var_50_39 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play411041012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411041012
		arg_51_1.duration_ = 4.33

		local var_51_0 = {
			zh = 3.4,
			ja = 4.333
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411041013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10071ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect10071ui_story == nil then
				arg_51_1.var_.characterEffect10071ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect10071ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10071ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect10071ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10071ui_story.fillRatio = var_54_5
			end

			local var_54_6 = arg_51_1.actors_["1095ui_story"]
			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1095ui_story == nil then
				arg_51_1.var_.characterEffect1095ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.200000002980232

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 and not isNil(var_54_6) then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8

				if arg_51_1.var_.characterEffect1095ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1095ui_story then
				arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_54_10 = 0
			local var_54_11 = 0.525

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_12 = arg_51_1:FormatText(StoryNameCfg[471].name)

				arg_51_1.leftNameTxt_.text = var_54_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(411041012)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 21
				local var_54_16 = utf8.len(var_54_14)
				local var_54_17 = var_54_15 <= 0 and var_54_11 or var_54_11 * (var_54_16 / var_54_15)

				if var_54_17 > 0 and var_54_11 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041012", "story_v_out_411041.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041012", "story_v_out_411041.awb") / 1000

					if var_54_18 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_10
					end

					if var_54_13.prefab_name ~= "" and arg_51_1.actors_[var_54_13.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_13.prefab_name].transform, "story_v_out_411041", "411041012", "story_v_out_411041.awb")

						arg_51_1:RecordAudio("411041012", var_54_19)
						arg_51_1:RecordAudio("411041012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_411041", "411041012", "story_v_out_411041.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_411041", "411041012", "story_v_out_411041.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_20 and arg_51_1.time_ < var_54_10 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play411041013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411041013
		arg_55_1.duration_ = 2.1

		local var_55_0 = {
			zh = 2.1,
			ja = 1.9
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play411041014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10071ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos10071ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0.7, -0.9, -6.26)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10071ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = arg_55_1.actors_["10071ui_story"]
			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect10071ui_story == nil then
				arg_55_1.var_.characterEffect10071ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_11 = 0.200000002980232

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_11 and not isNil(var_58_9) then
				local var_58_12 = (arg_55_1.time_ - var_58_10) / var_58_11

				if arg_55_1.var_.characterEffect10071ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_10 + var_58_11 and arg_55_1.time_ < var_58_10 + var_58_11 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect10071ui_story then
				arg_55_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_58_13 = arg_55_1.actors_["1095ui_story"]
			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect1095ui_story == nil then
				arg_55_1.var_.characterEffect1095ui_story = var_58_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_15 = 0.200000002980232

			if var_58_14 <= arg_55_1.time_ and arg_55_1.time_ < var_58_14 + var_58_15 and not isNil(var_58_13) then
				local var_58_16 = (arg_55_1.time_ - var_58_14) / var_58_15

				if arg_55_1.var_.characterEffect1095ui_story and not isNil(var_58_13) then
					local var_58_17 = Mathf.Lerp(0, 0.5, var_58_16)

					arg_55_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1095ui_story.fillRatio = var_58_17
				end
			end

			if arg_55_1.time_ >= var_58_14 + var_58_15 and arg_55_1.time_ < var_58_14 + var_58_15 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect1095ui_story then
				local var_58_18 = 0.5

				arg_55_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1095ui_story.fillRatio = var_58_18
			end

			local var_58_19 = 0
			local var_58_20 = 0.15

			if var_58_19 < arg_55_1.time_ and arg_55_1.time_ <= var_58_19 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_21 = arg_55_1:FormatText(StoryNameCfg[670].name)

				arg_55_1.leftNameTxt_.text = var_58_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_22 = arg_55_1:GetWordFromCfg(411041013)
				local var_58_23 = arg_55_1:FormatText(var_58_22.content)

				arg_55_1.text_.text = var_58_23

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_24 = 6
				local var_58_25 = utf8.len(var_58_23)
				local var_58_26 = var_58_24 <= 0 and var_58_20 or var_58_20 * (var_58_25 / var_58_24)

				if var_58_26 > 0 and var_58_20 < var_58_26 then
					arg_55_1.talkMaxDuration = var_58_26

					if var_58_26 + var_58_19 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_26 + var_58_19
					end
				end

				arg_55_1.text_.text = var_58_23
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041013", "story_v_out_411041.awb") ~= 0 then
					local var_58_27 = manager.audio:GetVoiceLength("story_v_out_411041", "411041013", "story_v_out_411041.awb") / 1000

					if var_58_27 + var_58_19 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_27 + var_58_19
					end

					if var_58_22.prefab_name ~= "" and arg_55_1.actors_[var_58_22.prefab_name] ~= nil then
						local var_58_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_22.prefab_name].transform, "story_v_out_411041", "411041013", "story_v_out_411041.awb")

						arg_55_1:RecordAudio("411041013", var_58_28)
						arg_55_1:RecordAudio("411041013", var_58_28)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_411041", "411041013", "story_v_out_411041.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_411041", "411041013", "story_v_out_411041.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_29 = math.max(var_58_20, arg_55_1.talkMaxDuration)

			if var_58_19 <= arg_55_1.time_ and arg_55_1.time_ < var_58_19 + var_58_29 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_19) / var_58_29

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_19 + var_58_29 and arg_55_1.time_ < var_58_19 + var_58_29 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play411041014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411041014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411041015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10071ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos10071ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, 100, 0)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10071ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, 100, 0)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["10071ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10071ui_story == nil then
				arg_59_1.var_.characterEffect10071ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect10071ui_story and not isNil(var_62_9) then
					local var_62_13 = Mathf.Lerp(0, 0.5, var_62_12)

					arg_59_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10071ui_story.fillRatio = var_62_13
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect10071ui_story then
				local var_62_14 = 0.5

				arg_59_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10071ui_story.fillRatio = var_62_14
			end

			local var_62_15 = arg_59_1.actors_["1095ui_story"].transform
			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.var_.moveOldPos1095ui_story = var_62_15.localPosition
			end

			local var_62_17 = 0.001

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_17 then
				local var_62_18 = (arg_59_1.time_ - var_62_16) / var_62_17
				local var_62_19 = Vector3.New(0, 100, 0)

				var_62_15.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1095ui_story, var_62_19, var_62_18)

				local var_62_20 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_20.x, var_62_20.y, var_62_20.z)

				local var_62_21 = var_62_15.localEulerAngles

				var_62_21.z = 0
				var_62_21.x = 0
				var_62_15.localEulerAngles = var_62_21
			end

			if arg_59_1.time_ >= var_62_16 + var_62_17 and arg_59_1.time_ < var_62_16 + var_62_17 + arg_62_0 then
				var_62_15.localPosition = Vector3.New(0, 100, 0)

				local var_62_22 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_22.x, var_62_22.y, var_62_22.z)

				local var_62_23 = var_62_15.localEulerAngles

				var_62_23.z = 0
				var_62_23.x = 0
				var_62_15.localEulerAngles = var_62_23
			end

			local var_62_24 = arg_59_1.actors_["1095ui_story"]
			local var_62_25 = 0

			if var_62_25 < arg_59_1.time_ and arg_59_1.time_ <= var_62_25 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.characterEffect1095ui_story == nil then
				arg_59_1.var_.characterEffect1095ui_story = var_62_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_26 = 0.200000002980232

			if var_62_25 <= arg_59_1.time_ and arg_59_1.time_ < var_62_25 + var_62_26 and not isNil(var_62_24) then
				local var_62_27 = (arg_59_1.time_ - var_62_25) / var_62_26

				if arg_59_1.var_.characterEffect1095ui_story and not isNil(var_62_24) then
					local var_62_28 = Mathf.Lerp(0, 0.5, var_62_27)

					arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_28
				end
			end

			if arg_59_1.time_ >= var_62_25 + var_62_26 and arg_59_1.time_ < var_62_25 + var_62_26 + arg_62_0 and not isNil(var_62_24) and arg_59_1.var_.characterEffect1095ui_story then
				local var_62_29 = 0.5

				arg_59_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1095ui_story.fillRatio = var_62_29
			end

			local var_62_30 = 0
			local var_62_31 = 1.05

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_32 = arg_59_1:GetWordFromCfg(411041014)
				local var_62_33 = arg_59_1:FormatText(var_62_32.content)

				arg_59_1.text_.text = var_62_33

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_34 = 42
				local var_62_35 = utf8.len(var_62_33)
				local var_62_36 = var_62_34 <= 0 and var_62_31 or var_62_31 * (var_62_35 / var_62_34)

				if var_62_36 > 0 and var_62_31 < var_62_36 then
					arg_59_1.talkMaxDuration = var_62_36

					if var_62_36 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_36 + var_62_30
					end
				end

				arg_59_1.text_.text = var_62_33
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_37 = math.max(var_62_31, arg_59_1.talkMaxDuration)

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_37 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_30) / var_62_37

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_30 + var_62_37 and arg_59_1.time_ < var_62_30 + var_62_37 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play411041015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411041015
		arg_63_1.duration_ = 7

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play411041016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = "STwhite"

			if arg_63_1.bgs_[var_66_0] == nil then
				local var_66_1 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_0)
				var_66_1.name = var_66_0
				var_66_1.transform.parent = arg_63_1.stage_.transform
				var_66_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_0] = var_66_1
			end

			local var_66_2 = 2

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				local var_66_3 = manager.ui.mainCamera.transform.localPosition
				local var_66_4 = Vector3.New(0, 0, 10) + Vector3.New(var_66_3.x, var_66_3.y, 0)
				local var_66_5 = arg_63_1.bgs_.STwhite

				var_66_5.transform.localPosition = var_66_4
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = (var_66_5.transform.localPosition - var_66_3).z
					local var_66_8 = manager.ui.mainCameraCom_
					local var_66_9 = 2 * var_66_7 * Mathf.Tan(var_66_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_66_10 = var_66_9 * var_66_8.aspect
					local var_66_11 = var_66_6.sprite.bounds.size.x
					local var_66_12 = var_66_6.sprite.bounds.size.y
					local var_66_13 = var_66_10 / var_66_11
					local var_66_14 = var_66_9 / var_66_12
					local var_66_15 = var_66_14 < var_66_13 and var_66_13 or var_66_14

					var_66_5.transform.localScale = Vector3.New(var_66_15, var_66_15, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STwhite" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_16 = 0

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_17 = 2

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				local var_66_18 = (arg_63_1.time_ - var_66_16) / var_66_17
				local var_66_19 = Color.New(0, 0, 0)

				var_66_19.a = Mathf.Lerp(0, 1, var_66_18)
				arg_63_1.mask_.color = var_66_19
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				local var_66_20 = Color.New(0, 0, 0)

				var_66_20.a = 1
				arg_63_1.mask_.color = var_66_20
			end

			local var_66_21 = 2

			if var_66_21 < arg_63_1.time_ and arg_63_1.time_ <= var_66_21 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_22 = 2

			if var_66_21 <= arg_63_1.time_ and arg_63_1.time_ < var_66_21 + var_66_22 then
				local var_66_23 = (arg_63_1.time_ - var_66_21) / var_66_22
				local var_66_24 = Color.New(0, 0, 0)

				var_66_24.a = Mathf.Lerp(1, 0, var_66_23)
				arg_63_1.mask_.color = var_66_24
			end

			if arg_63_1.time_ >= var_66_21 + var_66_22 and arg_63_1.time_ < var_66_21 + var_66_22 + arg_66_0 then
				local var_66_25 = Color.New(0, 0, 0)
				local var_66_26 = 0

				arg_63_1.mask_.enabled = false
				var_66_25.a = var_66_26
				arg_63_1.mask_.color = var_66_25
			end

			local var_66_27 = 2
			local var_66_28 = 1

			if var_66_27 < arg_63_1.time_ and arg_63_1.time_ <= var_66_27 + arg_66_0 then
				local var_66_29 = "play"
				local var_66_30 = "effect"

				arg_63_1:AudioAction(var_66_29, var_66_30, "se_story_131", "se_story_131_break", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_31 = 2
			local var_66_32 = 1.65

			if var_66_31 < arg_63_1.time_ and arg_63_1.time_ <= var_66_31 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_33 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_33:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_34 = arg_63_1:GetWordFromCfg(411041015)
				local var_66_35 = arg_63_1:FormatText(var_66_34.content)

				arg_63_1.text_.text = var_66_35

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_36 = 66
				local var_66_37 = utf8.len(var_66_35)
				local var_66_38 = var_66_36 <= 0 and var_66_32 or var_66_32 * (var_66_37 / var_66_36)

				if var_66_38 > 0 and var_66_32 < var_66_38 then
					arg_63_1.talkMaxDuration = var_66_38
					var_66_31 = var_66_31 + 0.3

					if var_66_38 + var_66_31 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_38 + var_66_31
					end
				end

				arg_63_1.text_.text = var_66_35
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_39 = var_66_31 + 0.3
			local var_66_40 = math.max(var_66_32, arg_63_1.talkMaxDuration)

			if var_66_39 <= arg_63_1.time_ and arg_63_1.time_ < var_66_39 + var_66_40 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_39) / var_66_40

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_39 + var_66_40 and arg_63_1.time_ < var_66_39 + var_66_40 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play411041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411041016
		arg_69_1.duration_ = 7

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411041017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 2

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				local var_72_1 = manager.ui.mainCamera.transform.localPosition
				local var_72_2 = Vector3.New(0, 0, 10) + Vector3.New(var_72_1.x, var_72_1.y, 0)
				local var_72_3 = arg_69_1.bgs_.I11r

				var_72_3.transform.localPosition = var_72_2
				var_72_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_4 = var_72_3:GetComponent("SpriteRenderer")

				if var_72_4 and var_72_4.sprite then
					local var_72_5 = (var_72_3.transform.localPosition - var_72_1).z
					local var_72_6 = manager.ui.mainCameraCom_
					local var_72_7 = 2 * var_72_5 * Mathf.Tan(var_72_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_8 = var_72_7 * var_72_6.aspect
					local var_72_9 = var_72_4.sprite.bounds.size.x
					local var_72_10 = var_72_4.sprite.bounds.size.y
					local var_72_11 = var_72_8 / var_72_9
					local var_72_12 = var_72_7 / var_72_10
					local var_72_13 = var_72_12 < var_72_11 and var_72_11 or var_72_12

					var_72_3.transform.localScale = Vector3.New(var_72_13, var_72_13, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "I11r" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_15 = 2

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15
				local var_72_17 = Color.New(0, 0, 0)

				var_72_17.a = Mathf.Lerp(0, 1, var_72_16)
				arg_69_1.mask_.color = var_72_17
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 then
				local var_72_18 = Color.New(0, 0, 0)

				var_72_18.a = 1
				arg_69_1.mask_.color = var_72_18
			end

			local var_72_19 = 2

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_20 = 2

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_19) / var_72_20
				local var_72_22 = Color.New(0, 0, 0)

				var_72_22.a = Mathf.Lerp(1, 0, var_72_21)
				arg_69_1.mask_.color = var_72_22
			end

			if arg_69_1.time_ >= var_72_19 + var_72_20 and arg_69_1.time_ < var_72_19 + var_72_20 + arg_72_0 then
				local var_72_23 = Color.New(0, 0, 0)
				local var_72_24 = 0

				arg_69_1.mask_.enabled = false
				var_72_23.a = var_72_24
				arg_69_1.mask_.color = var_72_23
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_25 = 2
			local var_72_26 = 0.825

			if var_72_25 < arg_69_1.time_ and arg_69_1.time_ <= var_72_25 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_27 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_27:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_28 = arg_69_1:GetWordFromCfg(411041016)
				local var_72_29 = arg_69_1:FormatText(var_72_28.content)

				arg_69_1.text_.text = var_72_29

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_30 = 33
				local var_72_31 = utf8.len(var_72_29)
				local var_72_32 = var_72_30 <= 0 and var_72_26 or var_72_26 * (var_72_31 / var_72_30)

				if var_72_32 > 0 and var_72_26 < var_72_32 then
					arg_69_1.talkMaxDuration = var_72_32
					var_72_25 = var_72_25 + 0.3

					if var_72_32 + var_72_25 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_32 + var_72_25
					end
				end

				arg_69_1.text_.text = var_72_29
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = var_72_25 + 0.3
			local var_72_34 = math.max(var_72_26, arg_69_1.talkMaxDuration)

			if var_72_33 <= arg_69_1.time_ and arg_69_1.time_ < var_72_33 + var_72_34 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_33) / var_72_34

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_33 + var_72_34 and arg_69_1.time_ < var_72_33 + var_72_34 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play411041017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411041017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play411041018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 1.025

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(411041017)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 41
				local var_78_5 = utf8.len(var_78_3)
				local var_78_6 = var_78_4 <= 0 and var_78_1 or var_78_1 * (var_78_5 / var_78_4)

				if var_78_6 > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_7 and arg_75_1.time_ < var_78_0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play411041018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411041018
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411041019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1095ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1095ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1095ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1095ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1095ui_story == nil then
				arg_79_1.var_.characterEffect1095ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1095ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1095ui_story then
				arg_79_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_82_13 = 0

			if var_82_13 < arg_79_1.time_ and arg_79_1.time_ <= var_82_13 + arg_82_0 then
				arg_79_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_15 = arg_79_1.actors_["10071ui_story"].transform
			local var_82_16 = 0

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.var_.moveOldPos10071ui_story = var_82_15.localPosition
			end

			local var_82_17 = 0.001

			if var_82_16 <= arg_79_1.time_ and arg_79_1.time_ < var_82_16 + var_82_17 then
				local var_82_18 = (arg_79_1.time_ - var_82_16) / var_82_17
				local var_82_19 = Vector3.New(0.7, -0.9, -6.26)

				var_82_15.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10071ui_story, var_82_19, var_82_18)

				local var_82_20 = manager.ui.mainCamera.transform.position - var_82_15.position

				var_82_15.forward = Vector3.New(var_82_20.x, var_82_20.y, var_82_20.z)

				local var_82_21 = var_82_15.localEulerAngles

				var_82_21.z = 0
				var_82_21.x = 0
				var_82_15.localEulerAngles = var_82_21
			end

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				var_82_15.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_82_22 = manager.ui.mainCamera.transform.position - var_82_15.position

				var_82_15.forward = Vector3.New(var_82_22.x, var_82_22.y, var_82_22.z)

				local var_82_23 = var_82_15.localEulerAngles

				var_82_23.z = 0
				var_82_23.x = 0
				var_82_15.localEulerAngles = var_82_23
			end

			local var_82_24 = arg_79_1.actors_["10071ui_story"]
			local var_82_25 = 0

			if var_82_25 < arg_79_1.time_ and arg_79_1.time_ <= var_82_25 + arg_82_0 and not isNil(var_82_24) and arg_79_1.var_.characterEffect10071ui_story == nil then
				arg_79_1.var_.characterEffect10071ui_story = var_82_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_26 = 0.200000002980232

			if var_82_25 <= arg_79_1.time_ and arg_79_1.time_ < var_82_25 + var_82_26 and not isNil(var_82_24) then
				local var_82_27 = (arg_79_1.time_ - var_82_25) / var_82_26

				if arg_79_1.var_.characterEffect10071ui_story and not isNil(var_82_24) then
					local var_82_28 = Mathf.Lerp(0, 0.5, var_82_27)

					arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10071ui_story.fillRatio = var_82_28
				end
			end

			if arg_79_1.time_ >= var_82_25 + var_82_26 and arg_79_1.time_ < var_82_25 + var_82_26 + arg_82_0 and not isNil(var_82_24) and arg_79_1.var_.characterEffect10071ui_story then
				local var_82_29 = 0.5

				arg_79_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10071ui_story.fillRatio = var_82_29
			end

			local var_82_30 = 0

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				arg_79_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_82_31 = 0

			if var_82_31 < arg_79_1.time_ and arg_79_1.time_ <= var_82_31 + arg_82_0 then
				arg_79_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_82_32 = 0
			local var_82_33 = 0.125

			if var_82_32 < arg_79_1.time_ and arg_79_1.time_ <= var_82_32 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_34 = arg_79_1:FormatText(StoryNameCfg[471].name)

				arg_79_1.leftNameTxt_.text = var_82_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_35 = arg_79_1:GetWordFromCfg(411041018)
				local var_82_36 = arg_79_1:FormatText(var_82_35.content)

				arg_79_1.text_.text = var_82_36

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_37 = 5
				local var_82_38 = utf8.len(var_82_36)
				local var_82_39 = var_82_37 <= 0 and var_82_33 or var_82_33 * (var_82_38 / var_82_37)

				if var_82_39 > 0 and var_82_33 < var_82_39 then
					arg_79_1.talkMaxDuration = var_82_39

					if var_82_39 + var_82_32 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_39 + var_82_32
					end
				end

				arg_79_1.text_.text = var_82_36
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041018", "story_v_out_411041.awb") ~= 0 then
					local var_82_40 = manager.audio:GetVoiceLength("story_v_out_411041", "411041018", "story_v_out_411041.awb") / 1000

					if var_82_40 + var_82_32 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_40 + var_82_32
					end

					if var_82_35.prefab_name ~= "" and arg_79_1.actors_[var_82_35.prefab_name] ~= nil then
						local var_82_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_35.prefab_name].transform, "story_v_out_411041", "411041018", "story_v_out_411041.awb")

						arg_79_1:RecordAudio("411041018", var_82_41)
						arg_79_1:RecordAudio("411041018", var_82_41)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_411041", "411041018", "story_v_out_411041.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_411041", "411041018", "story_v_out_411041.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_42 = math.max(var_82_33, arg_79_1.talkMaxDuration)

			if var_82_32 <= arg_79_1.time_ and arg_79_1.time_ < var_82_32 + var_82_42 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_32) / var_82_42

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_32 + var_82_42 and arg_79_1.time_ < var_82_32 + var_82_42 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play411041019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411041019
		arg_83_1.duration_ = 11.73

		local var_83_0 = {
			zh = 11.733,
			ja = 8.4
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411041020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10071ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10071ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0.7, -0.9, -6.26)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10071ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["10071ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect10071ui_story == nil then
				arg_83_1.var_.characterEffect10071ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect10071ui_story and not isNil(var_86_9) then
					arg_83_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect10071ui_story then
				arg_83_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_86_13 = 0

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				arg_83_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_86_14 = arg_83_1.actors_["1095ui_story"]
			local var_86_15 = 0

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1095ui_story == nil then
				arg_83_1.var_.characterEffect1095ui_story = var_86_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_16 = 0.200000002980232

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_16 and not isNil(var_86_14) then
				local var_86_17 = (arg_83_1.time_ - var_86_15) / var_86_16

				if arg_83_1.var_.characterEffect1095ui_story and not isNil(var_86_14) then
					local var_86_18 = Mathf.Lerp(0, 0.5, var_86_17)

					arg_83_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1095ui_story.fillRatio = var_86_18
				end
			end

			if arg_83_1.time_ >= var_86_15 + var_86_16 and arg_83_1.time_ < var_86_15 + var_86_16 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1095ui_story then
				local var_86_19 = 0.5

				arg_83_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1095ui_story.fillRatio = var_86_19
			end

			local var_86_20 = 0
			local var_86_21 = 0.975

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_22 = arg_83_1:FormatText(StoryNameCfg[670].name)

				arg_83_1.leftNameTxt_.text = var_86_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_23 = arg_83_1:GetWordFromCfg(411041019)
				local var_86_24 = arg_83_1:FormatText(var_86_23.content)

				arg_83_1.text_.text = var_86_24

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_25 = 41
				local var_86_26 = utf8.len(var_86_24)
				local var_86_27 = var_86_25 <= 0 and var_86_21 or var_86_21 * (var_86_26 / var_86_25)

				if var_86_27 > 0 and var_86_21 < var_86_27 then
					arg_83_1.talkMaxDuration = var_86_27

					if var_86_27 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_20
					end
				end

				arg_83_1.text_.text = var_86_24
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041019", "story_v_out_411041.awb") ~= 0 then
					local var_86_28 = manager.audio:GetVoiceLength("story_v_out_411041", "411041019", "story_v_out_411041.awb") / 1000

					if var_86_28 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_20
					end

					if var_86_23.prefab_name ~= "" and arg_83_1.actors_[var_86_23.prefab_name] ~= nil then
						local var_86_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_23.prefab_name].transform, "story_v_out_411041", "411041019", "story_v_out_411041.awb")

						arg_83_1:RecordAudio("411041019", var_86_29)
						arg_83_1:RecordAudio("411041019", var_86_29)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_411041", "411041019", "story_v_out_411041.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_411041", "411041019", "story_v_out_411041.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_30 = math.max(var_86_21, arg_83_1.talkMaxDuration)

			if var_86_20 <= arg_83_1.time_ and arg_83_1.time_ < var_86_20 + var_86_30 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_20) / var_86_30

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_20 + var_86_30 and arg_83_1.time_ < var_86_20 + var_86_30 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play411041020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411041020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411041021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10071ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10071ui_story == nil then
				arg_87_1.var_.characterEffect10071ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10071ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10071ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10071ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10071ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 1.35

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(411041020)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 54
				local var_90_11 = utf8.len(var_90_9)
				local var_90_12 = var_90_10 <= 0 and var_90_7 or var_90_7 * (var_90_11 / var_90_10)

				if var_90_12 > 0 and var_90_7 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_13 and arg_87_1.time_ < var_90_6 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play411041021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 411041021
		arg_91_1.duration_ = 7.9

		local var_91_0 = {
			zh = 3.866,
			ja = 7.9
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play411041022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["10071ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10071ui_story == nil then
				arg_91_1.var_.characterEffect10071ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect10071ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect10071ui_story then
				arg_91_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_94_4 = 0
			local var_94_5 = 0.325

			if var_94_4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_6 = arg_91_1:FormatText(StoryNameCfg[670].name)

				arg_91_1.leftNameTxt_.text = var_94_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:GetWordFromCfg(411041021)
				local var_94_8 = arg_91_1:FormatText(var_94_7.content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 13
				local var_94_10 = utf8.len(var_94_8)
				local var_94_11 = var_94_9 <= 0 and var_94_5 or var_94_5 * (var_94_10 / var_94_9)

				if var_94_11 > 0 and var_94_5 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041021", "story_v_out_411041.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041021", "story_v_out_411041.awb") / 1000

					if var_94_12 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_4
					end

					if var_94_7.prefab_name ~= "" and arg_91_1.actors_[var_94_7.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_7.prefab_name].transform, "story_v_out_411041", "411041021", "story_v_out_411041.awb")

						arg_91_1:RecordAudio("411041021", var_94_13)
						arg_91_1:RecordAudio("411041021", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_411041", "411041021", "story_v_out_411041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_411041", "411041021", "story_v_out_411041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_14 and arg_91_1.time_ < var_94_4 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play411041022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 411041022
		arg_95_1.duration_ = 4.83

		local var_95_0 = {
			zh = 3.5,
			ja = 4.833
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play411041023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1095ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos1095ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1095ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["1095ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1095ui_story == nil then
				arg_95_1.var_.characterEffect1095ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect1095ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect1095ui_story then
				arg_95_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_98_15 = arg_95_1.actors_["10071ui_story"]
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 and not isNil(var_98_15) and arg_95_1.var_.characterEffect10071ui_story == nil then
				arg_95_1.var_.characterEffect10071ui_story = var_98_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_17 = 0.200000002980232

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 and not isNil(var_98_15) then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17

				if arg_95_1.var_.characterEffect10071ui_story and not isNil(var_98_15) then
					local var_98_19 = Mathf.Lerp(0, 0.5, var_98_18)

					arg_95_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10071ui_story.fillRatio = var_98_19
				end
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 and not isNil(var_98_15) and arg_95_1.var_.characterEffect10071ui_story then
				local var_98_20 = 0.5

				arg_95_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10071ui_story.fillRatio = var_98_20
			end

			local var_98_21 = 0
			local var_98_22 = 0.35

			if var_98_21 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_23 = arg_95_1:FormatText(StoryNameCfg[471].name)

				arg_95_1.leftNameTxt_.text = var_98_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_24 = arg_95_1:GetWordFromCfg(411041022)
				local var_98_25 = arg_95_1:FormatText(var_98_24.content)

				arg_95_1.text_.text = var_98_25

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_26 = 14
				local var_98_27 = utf8.len(var_98_25)
				local var_98_28 = var_98_26 <= 0 and var_98_22 or var_98_22 * (var_98_27 / var_98_26)

				if var_98_28 > 0 and var_98_22 < var_98_28 then
					arg_95_1.talkMaxDuration = var_98_28

					if var_98_28 + var_98_21 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_28 + var_98_21
					end
				end

				arg_95_1.text_.text = var_98_25
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041022", "story_v_out_411041.awb") ~= 0 then
					local var_98_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041022", "story_v_out_411041.awb") / 1000

					if var_98_29 + var_98_21 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_29 + var_98_21
					end

					if var_98_24.prefab_name ~= "" and arg_95_1.actors_[var_98_24.prefab_name] ~= nil then
						local var_98_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_24.prefab_name].transform, "story_v_out_411041", "411041022", "story_v_out_411041.awb")

						arg_95_1:RecordAudio("411041022", var_98_30)
						arg_95_1:RecordAudio("411041022", var_98_30)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_411041", "411041022", "story_v_out_411041.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_411041", "411041022", "story_v_out_411041.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_31 = math.max(var_98_22, arg_95_1.talkMaxDuration)

			if var_98_21 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_31 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_21) / var_98_31

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_21 + var_98_31 and arg_95_1.time_ < var_98_21 + var_98_31 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play411041023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411041023
		arg_99_1.duration_ = 5.03

		local var_99_0 = {
			zh = 5,
			ja = 5.033
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411041024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10071ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10071ui_story == nil then
				arg_99_1.var_.characterEffect10071ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect10071ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10071ui_story then
				arg_99_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["1095ui_story"]
			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1095ui_story == nil then
				arg_99_1.var_.characterEffect1095ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 and not isNil(var_102_4) then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6

				if arg_99_1.var_.characterEffect1095ui_story and not isNil(var_102_4) then
					local var_102_8 = Mathf.Lerp(0, 0.5, var_102_7)

					arg_99_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1095ui_story.fillRatio = var_102_8
				end
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1095ui_story then
				local var_102_9 = 0.5

				arg_99_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1095ui_story.fillRatio = var_102_9
			end

			local var_102_10 = 0
			local var_102_11 = 0.6

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_12 = arg_99_1:FormatText(StoryNameCfg[670].name)

				arg_99_1.leftNameTxt_.text = var_102_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_13 = arg_99_1:GetWordFromCfg(411041023)
				local var_102_14 = arg_99_1:FormatText(var_102_13.content)

				arg_99_1.text_.text = var_102_14

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 24
				local var_102_16 = utf8.len(var_102_14)
				local var_102_17 = var_102_15 <= 0 and var_102_11 or var_102_11 * (var_102_16 / var_102_15)

				if var_102_17 > 0 and var_102_11 < var_102_17 then
					arg_99_1.talkMaxDuration = var_102_17

					if var_102_17 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_17 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_14
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041023", "story_v_out_411041.awb") ~= 0 then
					local var_102_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041023", "story_v_out_411041.awb") / 1000

					if var_102_18 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_18 + var_102_10
					end

					if var_102_13.prefab_name ~= "" and arg_99_1.actors_[var_102_13.prefab_name] ~= nil then
						local var_102_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_13.prefab_name].transform, "story_v_out_411041", "411041023", "story_v_out_411041.awb")

						arg_99_1:RecordAudio("411041023", var_102_19)
						arg_99_1:RecordAudio("411041023", var_102_19)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411041", "411041023", "story_v_out_411041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411041", "411041023", "story_v_out_411041.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_20 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_20 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_20

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_20 and arg_99_1.time_ < var_102_10 + var_102_20 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play411041024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411041024
		arg_103_1.duration_ = 9.33

		local var_103_0 = {
			zh = 9.333,
			ja = 6.7
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411041025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1095ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1095ui_story == nil then
				arg_103_1.var_.characterEffect1095ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1095ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1095ui_story then
				arg_103_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_6 = arg_103_1.actors_["10071ui_story"]
			local var_106_7 = 0

			if var_106_7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect10071ui_story == nil then
				arg_103_1.var_.characterEffect10071ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_8 = 0.200000002980232

			if var_106_7 <= arg_103_1.time_ and arg_103_1.time_ < var_106_7 + var_106_8 and not isNil(var_106_6) then
				local var_106_9 = (arg_103_1.time_ - var_106_7) / var_106_8

				if arg_103_1.var_.characterEffect10071ui_story and not isNil(var_106_6) then
					local var_106_10 = Mathf.Lerp(0, 0.5, var_106_9)

					arg_103_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10071ui_story.fillRatio = var_106_10
				end
			end

			if arg_103_1.time_ >= var_106_7 + var_106_8 and arg_103_1.time_ < var_106_7 + var_106_8 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect10071ui_story then
				local var_106_11 = 0.5

				arg_103_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10071ui_story.fillRatio = var_106_11
			end

			local var_106_12 = 0
			local var_106_13 = 1.05

			if var_106_12 < arg_103_1.time_ and arg_103_1.time_ <= var_106_12 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_14 = arg_103_1:FormatText(StoryNameCfg[471].name)

				arg_103_1.leftNameTxt_.text = var_106_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_15 = arg_103_1:GetWordFromCfg(411041024)
				local var_106_16 = arg_103_1:FormatText(var_106_15.content)

				arg_103_1.text_.text = var_106_16

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_17 = 42
				local var_106_18 = utf8.len(var_106_16)
				local var_106_19 = var_106_17 <= 0 and var_106_13 or var_106_13 * (var_106_18 / var_106_17)

				if var_106_19 > 0 and var_106_13 < var_106_19 then
					arg_103_1.talkMaxDuration = var_106_19

					if var_106_19 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_12
					end
				end

				arg_103_1.text_.text = var_106_16
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041024", "story_v_out_411041.awb") ~= 0 then
					local var_106_20 = manager.audio:GetVoiceLength("story_v_out_411041", "411041024", "story_v_out_411041.awb") / 1000

					if var_106_20 + var_106_12 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_20 + var_106_12
					end

					if var_106_15.prefab_name ~= "" and arg_103_1.actors_[var_106_15.prefab_name] ~= nil then
						local var_106_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_15.prefab_name].transform, "story_v_out_411041", "411041024", "story_v_out_411041.awb")

						arg_103_1:RecordAudio("411041024", var_106_21)
						arg_103_1:RecordAudio("411041024", var_106_21)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_411041", "411041024", "story_v_out_411041.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_411041", "411041024", "story_v_out_411041.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_22 = math.max(var_106_13, arg_103_1.talkMaxDuration)

			if var_106_12 <= arg_103_1.time_ and arg_103_1.time_ < var_106_12 + var_106_22 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_12) / var_106_22

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_12 + var_106_22 and arg_103_1.time_ < var_106_12 + var_106_22 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play411041025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411041025
		arg_107_1.duration_ = 5.87

		local var_107_0 = {
			zh = 5.866,
			ja = 3.2
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play411041026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.725

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[471].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(411041025)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 29
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041025", "story_v_out_411041.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041025", "story_v_out_411041.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_411041", "411041025", "story_v_out_411041.awb")

						arg_107_1:RecordAudio("411041025", var_110_9)
						arg_107_1:RecordAudio("411041025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_411041", "411041025", "story_v_out_411041.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_411041", "411041025", "story_v_out_411041.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play411041026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411041026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411041027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1095ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1095ui_story == nil then
				arg_111_1.var_.characterEffect1095ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1095ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1095ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1095ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1095ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 1.325

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(411041026)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 53
				local var_114_11 = utf8.len(var_114_9)
				local var_114_12 = var_114_10 <= 0 and var_114_7 or var_114_7 * (var_114_11 / var_114_10)

				if var_114_12 > 0 and var_114_7 < var_114_12 then
					arg_111_1.talkMaxDuration = var_114_12

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_13 and arg_111_1.time_ < var_114_6 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411041027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411041027
		arg_115_1.duration_ = 4.1

		local var_115_0 = {
			zh = 2.433,
			ja = 4.1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play411041028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1095ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1095ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1095ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1095ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1095ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1095ui_story then
				arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_118_14 = 0
			local var_118_15 = 0.275

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_16 = arg_115_1:FormatText(StoryNameCfg[471].name)

				arg_115_1.leftNameTxt_.text = var_118_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:GetWordFromCfg(411041027)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 11
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_15 or var_118_15 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_15 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041027", "story_v_out_411041.awb") ~= 0 then
					local var_118_22 = manager.audio:GetVoiceLength("story_v_out_411041", "411041027", "story_v_out_411041.awb") / 1000

					if var_118_22 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_14
					end

					if var_118_17.prefab_name ~= "" and arg_115_1.actors_[var_118_17.prefab_name] ~= nil then
						local var_118_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_17.prefab_name].transform, "story_v_out_411041", "411041027", "story_v_out_411041.awb")

						arg_115_1:RecordAudio("411041027", var_118_23)
						arg_115_1:RecordAudio("411041027", var_118_23)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_411041", "411041027", "story_v_out_411041.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_411041", "411041027", "story_v_out_411041.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_24 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_24 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_24

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_24 and arg_115_1.time_ < var_118_14 + var_118_24 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play411041028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411041028
		arg_119_1.duration_ = 6.73

		local var_119_0 = {
			zh = 4.5,
			ja = 6.733
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play411041029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10071ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10071ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0.7, -0.9, -6.26)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10071ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["10071ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10071ui_story == nil then
				arg_119_1.var_.characterEffect10071ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect10071ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10071ui_story then
				arg_119_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_122_13 = arg_119_1.actors_["1095ui_story"]
			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 and not isNil(var_122_13) and arg_119_1.var_.characterEffect1095ui_story == nil then
				arg_119_1.var_.characterEffect1095ui_story = var_122_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_15 = 0.200000002980232

			if var_122_14 <= arg_119_1.time_ and arg_119_1.time_ < var_122_14 + var_122_15 and not isNil(var_122_13) then
				local var_122_16 = (arg_119_1.time_ - var_122_14) / var_122_15

				if arg_119_1.var_.characterEffect1095ui_story and not isNil(var_122_13) then
					local var_122_17 = Mathf.Lerp(0, 0.5, var_122_16)

					arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1095ui_story.fillRatio = var_122_17
				end
			end

			if arg_119_1.time_ >= var_122_14 + var_122_15 and arg_119_1.time_ < var_122_14 + var_122_15 + arg_122_0 and not isNil(var_122_13) and arg_119_1.var_.characterEffect1095ui_story then
				local var_122_18 = 0.5

				arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1095ui_story.fillRatio = var_122_18
			end

			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				arg_119_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_122_20 = 0
			local var_122_21 = 0.425

			if var_122_20 < arg_119_1.time_ and arg_119_1.time_ <= var_122_20 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_22 = arg_119_1:FormatText(StoryNameCfg[670].name)

				arg_119_1.leftNameTxt_.text = var_122_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_23 = arg_119_1:GetWordFromCfg(411041028)
				local var_122_24 = arg_119_1:FormatText(var_122_23.content)

				arg_119_1.text_.text = var_122_24

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_25 = 17
				local var_122_26 = utf8.len(var_122_24)
				local var_122_27 = var_122_25 <= 0 and var_122_21 or var_122_21 * (var_122_26 / var_122_25)

				if var_122_27 > 0 and var_122_21 < var_122_27 then
					arg_119_1.talkMaxDuration = var_122_27

					if var_122_27 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_27 + var_122_20
					end
				end

				arg_119_1.text_.text = var_122_24
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041028", "story_v_out_411041.awb") ~= 0 then
					local var_122_28 = manager.audio:GetVoiceLength("story_v_out_411041", "411041028", "story_v_out_411041.awb") / 1000

					if var_122_28 + var_122_20 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_20
					end

					if var_122_23.prefab_name ~= "" and arg_119_1.actors_[var_122_23.prefab_name] ~= nil then
						local var_122_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_23.prefab_name].transform, "story_v_out_411041", "411041028", "story_v_out_411041.awb")

						arg_119_1:RecordAudio("411041028", var_122_29)
						arg_119_1:RecordAudio("411041028", var_122_29)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411041", "411041028", "story_v_out_411041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411041", "411041028", "story_v_out_411041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_30 = math.max(var_122_21, arg_119_1.talkMaxDuration)

			if var_122_20 <= arg_119_1.time_ and arg_119_1.time_ < var_122_20 + var_122_30 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_20) / var_122_30

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_20 + var_122_30 and arg_119_1.time_ < var_122_20 + var_122_30 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play411041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411041029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play411041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10071ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10071ui_story == nil then
				arg_123_1.var_.characterEffect10071ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10071ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10071ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10071ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10071ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0
			local var_126_7 = 1.55

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(411041029)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 62
				local var_126_11 = utf8.len(var_126_9)
				local var_126_12 = var_126_10 <= 0 and var_126_7 or var_126_7 * (var_126_11 / var_126_10)

				if var_126_12 > 0 and var_126_7 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_13 and arg_123_1.time_ < var_126_6 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411041030
		arg_127_1.duration_ = 6.47

		local var_127_0 = {
			zh = 6.466,
			ja = 6.366
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_130_1 = arg_127_1.actors_["10071ui_story"]
			local var_130_2 = 0

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10071ui_story == nil then
				arg_127_1.var_.characterEffect10071ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_3 and not isNil(var_130_1) then
				local var_130_4 = (arg_127_1.time_ - var_130_2) / var_130_3

				if arg_127_1.var_.characterEffect10071ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_2 + var_130_3 and arg_127_1.time_ < var_130_2 + var_130_3 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10071ui_story then
				arg_127_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_130_5 = 0
			local var_130_6 = 0.55

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_7 = arg_127_1:FormatText(StoryNameCfg[670].name)

				arg_127_1.leftNameTxt_.text = var_130_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(411041030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 22
				local var_130_11 = utf8.len(var_130_9)
				local var_130_12 = var_130_10 <= 0 and var_130_6 or var_130_6 * (var_130_11 / var_130_10)

				if var_130_12 > 0 and var_130_6 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041030", "story_v_out_411041.awb") ~= 0 then
					local var_130_13 = manager.audio:GetVoiceLength("story_v_out_411041", "411041030", "story_v_out_411041.awb") / 1000

					if var_130_13 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_5
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_411041", "411041030", "story_v_out_411041.awb")

						arg_127_1:RecordAudio("411041030", var_130_14)
						arg_127_1:RecordAudio("411041030", var_130_14)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_411041", "411041030", "story_v_out_411041.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_411041", "411041030", "story_v_out_411041.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_15 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_15 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_15

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_15 and arg_127_1.time_ < var_130_5 + var_130_15 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411041031
		arg_131_1.duration_ = 9.5

		local var_131_0 = {
			zh = 7,
			ja = 9.5
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = "I07"

			if arg_131_1.bgs_[var_134_0] == nil then
				local var_134_1 = Object.Instantiate(arg_131_1.paintGo_)

				var_134_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_134_0)
				var_134_1.name = var_134_0
				var_134_1.transform.parent = arg_131_1.stage_.transform
				var_134_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.bgs_[var_134_0] = var_134_1
			end

			local var_134_2 = 2

			if var_134_2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				local var_134_3 = manager.ui.mainCamera.transform.localPosition
				local var_134_4 = Vector3.New(0, 0, 10) + Vector3.New(var_134_3.x, var_134_3.y, 0)
				local var_134_5 = arg_131_1.bgs_.I07

				var_134_5.transform.localPosition = var_134_4
				var_134_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_6 = var_134_5:GetComponent("SpriteRenderer")

				if var_134_6 and var_134_6.sprite then
					local var_134_7 = (var_134_5.transform.localPosition - var_134_3).z
					local var_134_8 = manager.ui.mainCameraCom_
					local var_134_9 = 2 * var_134_7 * Mathf.Tan(var_134_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_134_10 = var_134_9 * var_134_8.aspect
					local var_134_11 = var_134_6.sprite.bounds.size.x
					local var_134_12 = var_134_6.sprite.bounds.size.y
					local var_134_13 = var_134_10 / var_134_11
					local var_134_14 = var_134_9 / var_134_12
					local var_134_15 = var_134_14 < var_134_13 and var_134_13 or var_134_14

					var_134_5.transform.localScale = Vector3.New(var_134_15, var_134_15, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "I07" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_17 = 2

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17
				local var_134_19 = Color.New(0, 0, 0)

				var_134_19.a = Mathf.Lerp(0, 1, var_134_18)
				arg_131_1.mask_.color = var_134_19
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				local var_134_20 = Color.New(0, 0, 0)

				var_134_20.a = 1
				arg_131_1.mask_.color = var_134_20
			end

			local var_134_21 = 2

			if var_134_21 < arg_131_1.time_ and arg_131_1.time_ <= var_134_21 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_22 = 2

			if var_134_21 <= arg_131_1.time_ and arg_131_1.time_ < var_134_21 + var_134_22 then
				local var_134_23 = (arg_131_1.time_ - var_134_21) / var_134_22
				local var_134_24 = Color.New(0, 0, 0)

				var_134_24.a = Mathf.Lerp(1, 0, var_134_23)
				arg_131_1.mask_.color = var_134_24
			end

			if arg_131_1.time_ >= var_134_21 + var_134_22 and arg_131_1.time_ < var_134_21 + var_134_22 + arg_134_0 then
				local var_134_25 = Color.New(0, 0, 0)
				local var_134_26 = 0

				arg_131_1.mask_.enabled = false
				var_134_25.a = var_134_26
				arg_131_1.mask_.color = var_134_25
			end

			local var_134_27 = arg_131_1.actors_["10071ui_story"].transform
			local var_134_28 = 2

			if var_134_28 < arg_131_1.time_ and arg_131_1.time_ <= var_134_28 + arg_134_0 then
				arg_131_1.var_.moveOldPos10071ui_story = var_134_27.localPosition
			end

			local var_134_29 = 0.001

			if var_134_28 <= arg_131_1.time_ and arg_131_1.time_ < var_134_28 + var_134_29 then
				local var_134_30 = (arg_131_1.time_ - var_134_28) / var_134_29
				local var_134_31 = Vector3.New(0.7, -0.9, -6.26)

				var_134_27.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10071ui_story, var_134_31, var_134_30)

				local var_134_32 = manager.ui.mainCamera.transform.position - var_134_27.position

				var_134_27.forward = Vector3.New(var_134_32.x, var_134_32.y, var_134_32.z)

				local var_134_33 = var_134_27.localEulerAngles

				var_134_33.z = 0
				var_134_33.x = 0
				var_134_27.localEulerAngles = var_134_33
			end

			if arg_131_1.time_ >= var_134_28 + var_134_29 and arg_131_1.time_ < var_134_28 + var_134_29 + arg_134_0 then
				var_134_27.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_134_34 = manager.ui.mainCamera.transform.position - var_134_27.position

				var_134_27.forward = Vector3.New(var_134_34.x, var_134_34.y, var_134_34.z)

				local var_134_35 = var_134_27.localEulerAngles

				var_134_35.z = 0
				var_134_35.x = 0
				var_134_27.localEulerAngles = var_134_35
			end

			local var_134_36 = arg_131_1.actors_["10071ui_story"]
			local var_134_37 = 2

			if var_134_37 < arg_131_1.time_ and arg_131_1.time_ <= var_134_37 + arg_134_0 and not isNil(var_134_36) and arg_131_1.var_.characterEffect10071ui_story == nil then
				arg_131_1.var_.characterEffect10071ui_story = var_134_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_38 = 0.200000002980232

			if var_134_37 <= arg_131_1.time_ and arg_131_1.time_ < var_134_37 + var_134_38 and not isNil(var_134_36) then
				local var_134_39 = (arg_131_1.time_ - var_134_37) / var_134_38

				if arg_131_1.var_.characterEffect10071ui_story and not isNil(var_134_36) then
					arg_131_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_37 + var_134_38 and arg_131_1.time_ < var_134_37 + var_134_38 + arg_134_0 and not isNil(var_134_36) and arg_131_1.var_.characterEffect10071ui_story then
				arg_131_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_134_40 = 2

			if var_134_40 < arg_131_1.time_ and arg_131_1.time_ <= var_134_40 + arg_134_0 then
				arg_131_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_134_41 = 2

			if var_134_41 < arg_131_1.time_ and arg_131_1.time_ <= var_134_41 + arg_134_0 then
				arg_131_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_134_42 = arg_131_1.actors_["1095ui_story"].transform
			local var_134_43 = 2

			if var_134_43 < arg_131_1.time_ and arg_131_1.time_ <= var_134_43 + arg_134_0 then
				arg_131_1.var_.moveOldPos1095ui_story = var_134_42.localPosition
			end

			local var_134_44 = 0.001

			if var_134_43 <= arg_131_1.time_ and arg_131_1.time_ < var_134_43 + var_134_44 then
				local var_134_45 = (arg_131_1.time_ - var_134_43) / var_134_44
				local var_134_46 = Vector3.New(-0.7, -0.98, -6.1)

				var_134_42.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1095ui_story, var_134_46, var_134_45)

				local var_134_47 = manager.ui.mainCamera.transform.position - var_134_42.position

				var_134_42.forward = Vector3.New(var_134_47.x, var_134_47.y, var_134_47.z)

				local var_134_48 = var_134_42.localEulerAngles

				var_134_48.z = 0
				var_134_48.x = 0
				var_134_42.localEulerAngles = var_134_48
			end

			if arg_131_1.time_ >= var_134_43 + var_134_44 and arg_131_1.time_ < var_134_43 + var_134_44 + arg_134_0 then
				var_134_42.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_134_49 = manager.ui.mainCamera.transform.position - var_134_42.position

				var_134_42.forward = Vector3.New(var_134_49.x, var_134_49.y, var_134_49.z)

				local var_134_50 = var_134_42.localEulerAngles

				var_134_50.z = 0
				var_134_50.x = 0
				var_134_42.localEulerAngles = var_134_50
			end

			local var_134_51 = arg_131_1.actors_["1095ui_story"]
			local var_134_52 = 2

			if var_134_52 < arg_131_1.time_ and arg_131_1.time_ <= var_134_52 + arg_134_0 and not isNil(var_134_51) and arg_131_1.var_.characterEffect1095ui_story == nil then
				arg_131_1.var_.characterEffect1095ui_story = var_134_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_53 = 0.200000002980232

			if var_134_52 <= arg_131_1.time_ and arg_131_1.time_ < var_134_52 + var_134_53 and not isNil(var_134_51) then
				local var_134_54 = (arg_131_1.time_ - var_134_52) / var_134_53

				if arg_131_1.var_.characterEffect1095ui_story and not isNil(var_134_51) then
					local var_134_55 = Mathf.Lerp(0, 0.5, var_134_54)

					arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1095ui_story.fillRatio = var_134_55
				end
			end

			if arg_131_1.time_ >= var_134_52 + var_134_53 and arg_131_1.time_ < var_134_52 + var_134_53 + arg_134_0 and not isNil(var_134_51) and arg_131_1.var_.characterEffect1095ui_story then
				local var_134_56 = 0.5

				arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1095ui_story.fillRatio = var_134_56
			end

			local var_134_57 = 0
			local var_134_58 = 0.366666666666667

			if var_134_57 < arg_131_1.time_ and arg_131_1.time_ <= var_134_57 + arg_134_0 then
				local var_134_59 = "play"
				local var_134_60 = "music"

				arg_131_1:AudioAction(var_134_59, var_134_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_134_61 = ""
				local var_134_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_134_62 ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_62 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_62

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_62
						arg_131_1.bgmTxt2_.text = var_134_62
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_134_63 = 0.5
			local var_134_64 = 1

			if var_134_63 < arg_131_1.time_ and arg_131_1.time_ <= var_134_63 + arg_134_0 then
				local var_134_65 = "play"
				local var_134_66 = "music"

				arg_131_1:AudioAction(var_134_65, var_134_66, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_134_67 = ""
				local var_134_68 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

				if var_134_68 ~= "" then
					if arg_131_1.bgmTxt_.text ~= var_134_68 and arg_131_1.bgmTxt_.text ~= "" then
						if arg_131_1.bgmTxt2_.text ~= "" then
							arg_131_1.bgmTxt_.text = arg_131_1.bgmTxt2_.text
						end

						arg_131_1.bgmTxt2_.text = var_134_68

						arg_131_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_131_1.bgmTxt_.text = var_134_68
						arg_131_1.bgmTxt2_.text = var_134_68
					end

					if arg_131_1.bgmTimer then
						arg_131_1.bgmTimer:Stop()

						arg_131_1.bgmTimer = nil
					end

					if arg_131_1.settingData.show_music_name == 1 then
						arg_131_1.musicController:SetSelectedState("show")
						arg_131_1.musicAnimator_:Play("open", 0, 0)

						if arg_131_1.settingData.music_time ~= 0 then
							arg_131_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_131_1.settingData.music_time), function()
								if arg_131_1 == nil or isNil(arg_131_1.bgmTxt_) then
									return
								end

								arg_131_1.musicController:SetSelectedState("hide")
								arg_131_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_69 = 2
			local var_134_70 = 0.425

			if var_134_69 < arg_131_1.time_ and arg_131_1.time_ <= var_134_69 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_71 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_71:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_131_1.dialogCg_.alpha = arg_137_0
				end))
				var_134_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_72 = arg_131_1:FormatText(StoryNameCfg[670].name)

				arg_131_1.leftNameTxt_.text = var_134_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_73 = arg_131_1:GetWordFromCfg(411041031)
				local var_134_74 = arg_131_1:FormatText(var_134_73.content)

				arg_131_1.text_.text = var_134_74

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_75 = 17
				local var_134_76 = utf8.len(var_134_74)
				local var_134_77 = var_134_75 <= 0 and var_134_70 or var_134_70 * (var_134_76 / var_134_75)

				if var_134_77 > 0 and var_134_70 < var_134_77 then
					arg_131_1.talkMaxDuration = var_134_77
					var_134_69 = var_134_69 + 0.3

					if var_134_77 + var_134_69 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_77 + var_134_69
					end
				end

				arg_131_1.text_.text = var_134_74
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041031", "story_v_out_411041.awb") ~= 0 then
					local var_134_78 = manager.audio:GetVoiceLength("story_v_out_411041", "411041031", "story_v_out_411041.awb") / 1000

					if var_134_78 + var_134_69 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_78 + var_134_69
					end

					if var_134_73.prefab_name ~= "" and arg_131_1.actors_[var_134_73.prefab_name] ~= nil then
						local var_134_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_73.prefab_name].transform, "story_v_out_411041", "411041031", "story_v_out_411041.awb")

						arg_131_1:RecordAudio("411041031", var_134_79)
						arg_131_1:RecordAudio("411041031", var_134_79)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411041", "411041031", "story_v_out_411041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411041", "411041031", "story_v_out_411041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_80 = var_134_69 + 0.3
			local var_134_81 = math.max(var_134_70, arg_131_1.talkMaxDuration)

			if var_134_80 <= arg_131_1.time_ and arg_131_1.time_ < var_134_80 + var_134_81 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_80) / var_134_81

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_80 + var_134_81 and arg_131_1.time_ < var_134_80 + var_134_81 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play411041032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411041032
		arg_139_1.duration_ = 6.07

		local var_139_0 = {
			zh = 6.066,
			ja = 3.5
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411041033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1095ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1095ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1095ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1095ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1095ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_15 = arg_139_1.actors_["10071ui_story"]
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.characterEffect10071ui_story == nil then
				arg_139_1.var_.characterEffect10071ui_story = var_142_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_17 = 0.200000002980232

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 and not isNil(var_142_15) then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17

				if arg_139_1.var_.characterEffect10071ui_story and not isNil(var_142_15) then
					local var_142_19 = Mathf.Lerp(0, 0.5, var_142_18)

					arg_139_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10071ui_story.fillRatio = var_142_19
				end
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 and not isNil(var_142_15) and arg_139_1.var_.characterEffect10071ui_story then
				local var_142_20 = 0.5

				arg_139_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10071ui_story.fillRatio = var_142_20
			end

			local var_142_21 = 0
			local var_142_22 = 0.75

			if var_142_21 < arg_139_1.time_ and arg_139_1.time_ <= var_142_21 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_23 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_24 = arg_139_1:GetWordFromCfg(411041032)
				local var_142_25 = arg_139_1:FormatText(var_142_24.content)

				arg_139_1.text_.text = var_142_25

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_26 = 30
				local var_142_27 = utf8.len(var_142_25)
				local var_142_28 = var_142_26 <= 0 and var_142_22 or var_142_22 * (var_142_27 / var_142_26)

				if var_142_28 > 0 and var_142_22 < var_142_28 then
					arg_139_1.talkMaxDuration = var_142_28

					if var_142_28 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_28 + var_142_21
					end
				end

				arg_139_1.text_.text = var_142_25
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041032", "story_v_out_411041.awb") ~= 0 then
					local var_142_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041032", "story_v_out_411041.awb") / 1000

					if var_142_29 + var_142_21 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_29 + var_142_21
					end

					if var_142_24.prefab_name ~= "" and arg_139_1.actors_[var_142_24.prefab_name] ~= nil then
						local var_142_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_24.prefab_name].transform, "story_v_out_411041", "411041032", "story_v_out_411041.awb")

						arg_139_1:RecordAudio("411041032", var_142_30)
						arg_139_1:RecordAudio("411041032", var_142_30)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411041", "411041032", "story_v_out_411041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411041", "411041032", "story_v_out_411041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_31 = math.max(var_142_22, arg_139_1.talkMaxDuration)

			if var_142_21 <= arg_139_1.time_ and arg_139_1.time_ < var_142_21 + var_142_31 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_21) / var_142_31

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_21 + var_142_31 and arg_139_1.time_ < var_142_21 + var_142_31 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play411041033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411041033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411041034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1095ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1095ui_story == nil then
				arg_143_1.var_.characterEffect1095ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1095ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1095ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1095ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1095ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_1")
			end

			local var_146_7 = 0
			local var_146_8 = 0.6

			if var_146_7 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(411041033)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 24
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_8 or var_146_8 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_8 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_7
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_8, arg_143_1.talkMaxDuration)

			if var_146_7 <= arg_143_1.time_ and arg_143_1.time_ < var_146_7 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_7) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_7 + var_146_14 and arg_143_1.time_ < var_146_7 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411041034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411041034
		arg_147_1.duration_ = 10.7

		local var_147_0 = {
			zh = 10.7,
			ja = 7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411041035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1095ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1095ui_story == nil then
				arg_147_1.var_.characterEffect1095ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1095ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1095ui_story then
				arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 1.225

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_6 = arg_147_1:FormatText(StoryNameCfg[471].name)

				arg_147_1.leftNameTxt_.text = var_150_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(411041034)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 49
				local var_150_10 = utf8.len(var_150_8)
				local var_150_11 = var_150_9 <= 0 and var_150_5 or var_150_5 * (var_150_10 / var_150_9)

				if var_150_11 > 0 and var_150_5 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041034", "story_v_out_411041.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041034", "story_v_out_411041.awb") / 1000

					if var_150_12 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_4
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_411041", "411041034", "story_v_out_411041.awb")

						arg_147_1:RecordAudio("411041034", var_150_13)
						arg_147_1:RecordAudio("411041034", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411041", "411041034", "story_v_out_411041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411041", "411041034", "story_v_out_411041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_14 and arg_147_1.time_ < var_150_4 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411041035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411041035
		arg_151_1.duration_ = 11.17

		local var_151_0 = {
			zh = 4.766,
			ja = 11.166
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411041036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.675

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[471].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(411041035)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 27
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041035", "story_v_out_411041.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041035", "story_v_out_411041.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_411041", "411041035", "story_v_out_411041.awb")

						arg_151_1:RecordAudio("411041035", var_154_9)
						arg_151_1:RecordAudio("411041035", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411041", "411041035", "story_v_out_411041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411041", "411041035", "story_v_out_411041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play411041036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411041036
		arg_155_1.duration_ = 9.5

		local var_155_0 = {
			zh = 9.5,
			ja = 9.1
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411041037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10071ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10071ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0.7, -0.9, -6.26)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10071ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["10071ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10071ui_story == nil then
				arg_155_1.var_.characterEffect10071ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect10071ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect10071ui_story then
				arg_155_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_14 = arg_155_1.actors_["1095ui_story"]
			local var_158_15 = 0

			if var_158_15 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 and not isNil(var_158_14) and arg_155_1.var_.characterEffect1095ui_story == nil then
				arg_155_1.var_.characterEffect1095ui_story = var_158_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_16 = 0.200000002980232

			if var_158_15 <= arg_155_1.time_ and arg_155_1.time_ < var_158_15 + var_158_16 and not isNil(var_158_14) then
				local var_158_17 = (arg_155_1.time_ - var_158_15) / var_158_16

				if arg_155_1.var_.characterEffect1095ui_story and not isNil(var_158_14) then
					local var_158_18 = Mathf.Lerp(0, 0.5, var_158_17)

					arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1095ui_story.fillRatio = var_158_18
				end
			end

			if arg_155_1.time_ >= var_158_15 + var_158_16 and arg_155_1.time_ < var_158_15 + var_158_16 + arg_158_0 and not isNil(var_158_14) and arg_155_1.var_.characterEffect1095ui_story then
				local var_158_19 = 0.5

				arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1095ui_story.fillRatio = var_158_19
			end

			local var_158_20 = 0

			if var_158_20 < arg_155_1.time_ and arg_155_1.time_ <= var_158_20 + arg_158_0 then
				arg_155_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_2")
			end

			local var_158_21 = 0
			local var_158_22 = 1.075

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[670].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(411041036)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 43
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041036", "story_v_out_411041.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041036", "story_v_out_411041.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_411041", "411041036", "story_v_out_411041.awb")

						arg_155_1:RecordAudio("411041036", var_158_30)
						arg_155_1:RecordAudio("411041036", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411041", "411041036", "story_v_out_411041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411041", "411041036", "story_v_out_411041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play411041037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411041037
		arg_159_1.duration_ = 6.2

		local var_159_0 = {
			zh = 6.2,
			ja = 4.333
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411041038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1095ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1095ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1095ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1095ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1095ui_story == nil then
				arg_159_1.var_.characterEffect1095ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1095ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1095ui_story then
				arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_15 = arg_159_1.actors_["10071ui_story"]
			local var_162_16 = 0

			if var_162_16 < arg_159_1.time_ and arg_159_1.time_ <= var_162_16 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.characterEffect10071ui_story == nil then
				arg_159_1.var_.characterEffect10071ui_story = var_162_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_17 = 0.200000002980232

			if var_162_16 <= arg_159_1.time_ and arg_159_1.time_ < var_162_16 + var_162_17 and not isNil(var_162_15) then
				local var_162_18 = (arg_159_1.time_ - var_162_16) / var_162_17

				if arg_159_1.var_.characterEffect10071ui_story and not isNil(var_162_15) then
					local var_162_19 = Mathf.Lerp(0, 0.5, var_162_18)

					arg_159_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10071ui_story.fillRatio = var_162_19
				end
			end

			if arg_159_1.time_ >= var_162_16 + var_162_17 and arg_159_1.time_ < var_162_16 + var_162_17 + arg_162_0 and not isNil(var_162_15) and arg_159_1.var_.characterEffect10071ui_story then
				local var_162_20 = 0.5

				arg_159_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10071ui_story.fillRatio = var_162_20
			end

			local var_162_21 = 0
			local var_162_22 = 0.75

			if var_162_21 < arg_159_1.time_ and arg_159_1.time_ <= var_162_21 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_23 = arg_159_1:FormatText(StoryNameCfg[471].name)

				arg_159_1.leftNameTxt_.text = var_162_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_24 = arg_159_1:GetWordFromCfg(411041037)
				local var_162_25 = arg_159_1:FormatText(var_162_24.content)

				arg_159_1.text_.text = var_162_25

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_26 = 30
				local var_162_27 = utf8.len(var_162_25)
				local var_162_28 = var_162_26 <= 0 and var_162_22 or var_162_22 * (var_162_27 / var_162_26)

				if var_162_28 > 0 and var_162_22 < var_162_28 then
					arg_159_1.talkMaxDuration = var_162_28

					if var_162_28 + var_162_21 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_28 + var_162_21
					end
				end

				arg_159_1.text_.text = var_162_25
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041037", "story_v_out_411041.awb") ~= 0 then
					local var_162_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041037", "story_v_out_411041.awb") / 1000

					if var_162_29 + var_162_21 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_29 + var_162_21
					end

					if var_162_24.prefab_name ~= "" and arg_159_1.actors_[var_162_24.prefab_name] ~= nil then
						local var_162_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_24.prefab_name].transform, "story_v_out_411041", "411041037", "story_v_out_411041.awb")

						arg_159_1:RecordAudio("411041037", var_162_30)
						arg_159_1:RecordAudio("411041037", var_162_30)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411041", "411041037", "story_v_out_411041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411041", "411041037", "story_v_out_411041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_31 = math.max(var_162_22, arg_159_1.talkMaxDuration)

			if var_162_21 <= arg_159_1.time_ and arg_159_1.time_ < var_162_21 + var_162_31 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_21) / var_162_31

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_21 + var_162_31 and arg_159_1.time_ < var_162_21 + var_162_31 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play411041038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411041038
		arg_163_1.duration_ = 9.97

		local var_163_0 = {
			zh = 9.966,
			ja = 8.4
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411041039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1095ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1095ui_story == nil then
				arg_163_1.var_.characterEffect1095ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1095ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1095ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1095ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1095ui_story.fillRatio = var_166_5
			end

			local var_166_6 = arg_163_1.actors_["10071ui_story"]
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect10071ui_story == nil then
				arg_163_1.var_.characterEffect10071ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_8 = 0.200000002980232

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 and not isNil(var_166_6) then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8

				if arg_163_1.var_.characterEffect10071ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect10071ui_story then
				arg_163_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_166_10 = 0
			local var_166_11 = 1.05

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_12 = arg_163_1:FormatText(StoryNameCfg[670].name)

				arg_163_1.leftNameTxt_.text = var_166_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(411041038)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_15 = 42
				local var_166_16 = utf8.len(var_166_14)
				local var_166_17 = var_166_15 <= 0 and var_166_11 or var_166_11 * (var_166_16 / var_166_15)

				if var_166_17 > 0 and var_166_11 < var_166_17 then
					arg_163_1.talkMaxDuration = var_166_17

					if var_166_17 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_10
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041038", "story_v_out_411041.awb") ~= 0 then
					local var_166_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041038", "story_v_out_411041.awb") / 1000

					if var_166_18 + var_166_10 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_18 + var_166_10
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_411041", "411041038", "story_v_out_411041.awb")

						arg_163_1:RecordAudio("411041038", var_166_19)
						arg_163_1:RecordAudio("411041038", var_166_19)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411041", "411041038", "story_v_out_411041.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411041", "411041038", "story_v_out_411041.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_20 = math.max(var_166_11, arg_163_1.talkMaxDuration)

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_20 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_10) / var_166_20

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_10 + var_166_20 and arg_163_1.time_ < var_166_10 + var_166_20 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411041039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411041039
		arg_167_1.duration_ = 10.23

		local var_167_0 = {
			zh = 9.266,
			ja = 10.233
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411041040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.95

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[670].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:GetWordFromCfg(411041039)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 38
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041039", "story_v_out_411041.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041039", "story_v_out_411041.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_411041", "411041039", "story_v_out_411041.awb")

						arg_167_1:RecordAudio("411041039", var_170_9)
						arg_167_1:RecordAudio("411041039", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411041", "411041039", "story_v_out_411041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411041", "411041039", "story_v_out_411041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play411041040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411041040
		arg_171_1.duration_ = 10.2

		local var_171_0 = {
			zh = 10.2,
			ja = 9.366
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411041041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1095ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1095ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1095ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["1095ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1095ui_story == nil then
				arg_171_1.var_.characterEffect1095ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect1095ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect1095ui_story then
				arg_171_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_15 = arg_171_1.actors_["10071ui_story"]
			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10071ui_story == nil then
				arg_171_1.var_.characterEffect10071ui_story = var_174_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_17 = 0.200000002980232

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 and not isNil(var_174_15) then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / var_174_17

				if arg_171_1.var_.characterEffect10071ui_story and not isNil(var_174_15) then
					local var_174_19 = Mathf.Lerp(0, 0.5, var_174_18)

					arg_171_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10071ui_story.fillRatio = var_174_19
				end
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 and not isNil(var_174_15) and arg_171_1.var_.characterEffect10071ui_story then
				local var_174_20 = 0.5

				arg_171_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10071ui_story.fillRatio = var_174_20
			end

			local var_174_21 = 0
			local var_174_22 = 1.075

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_23 = arg_171_1:FormatText(StoryNameCfg[471].name)

				arg_171_1.leftNameTxt_.text = var_174_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_24 = arg_171_1:GetWordFromCfg(411041040)
				local var_174_25 = arg_171_1:FormatText(var_174_24.content)

				arg_171_1.text_.text = var_174_25

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_26 = 43
				local var_174_27 = utf8.len(var_174_25)
				local var_174_28 = var_174_26 <= 0 and var_174_22 or var_174_22 * (var_174_27 / var_174_26)

				if var_174_28 > 0 and var_174_22 < var_174_28 then
					arg_171_1.talkMaxDuration = var_174_28

					if var_174_28 + var_174_21 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_28 + var_174_21
					end
				end

				arg_171_1.text_.text = var_174_25
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041040", "story_v_out_411041.awb") ~= 0 then
					local var_174_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041040", "story_v_out_411041.awb") / 1000

					if var_174_29 + var_174_21 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_29 + var_174_21
					end

					if var_174_24.prefab_name ~= "" and arg_171_1.actors_[var_174_24.prefab_name] ~= nil then
						local var_174_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_24.prefab_name].transform, "story_v_out_411041", "411041040", "story_v_out_411041.awb")

						arg_171_1:RecordAudio("411041040", var_174_30)
						arg_171_1:RecordAudio("411041040", var_174_30)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411041", "411041040", "story_v_out_411041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411041", "411041040", "story_v_out_411041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_31 = math.max(var_174_22, arg_171_1.talkMaxDuration)

			if var_174_21 <= arg_171_1.time_ and arg_171_1.time_ < var_174_21 + var_174_31 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_21) / var_174_31

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_21 + var_174_31 and arg_171_1.time_ < var_174_21 + var_174_31 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play411041041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411041041
		arg_175_1.duration_ = 4.23

		local var_175_0 = {
			zh = 4.233,
			ja = 3.466
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411041042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10071ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10071ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0.7, -0.9, -6.26)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10071ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["10071ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10071ui_story == nil then
				arg_175_1.var_.characterEffect10071ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect10071ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10071ui_story then
				arg_175_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_178_13 = arg_175_1.actors_["1095ui_story"]
			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 and not isNil(var_178_13) and arg_175_1.var_.characterEffect1095ui_story == nil then
				arg_175_1.var_.characterEffect1095ui_story = var_178_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_15 = 0.200000002980232

			if var_178_14 <= arg_175_1.time_ and arg_175_1.time_ < var_178_14 + var_178_15 and not isNil(var_178_13) then
				local var_178_16 = (arg_175_1.time_ - var_178_14) / var_178_15

				if arg_175_1.var_.characterEffect1095ui_story and not isNil(var_178_13) then
					local var_178_17 = Mathf.Lerp(0, 0.5, var_178_16)

					arg_175_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1095ui_story.fillRatio = var_178_17
				end
			end

			if arg_175_1.time_ >= var_178_14 + var_178_15 and arg_175_1.time_ < var_178_14 + var_178_15 + arg_178_0 and not isNil(var_178_13) and arg_175_1.var_.characterEffect1095ui_story then
				local var_178_18 = 0.5

				arg_175_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1095ui_story.fillRatio = var_178_18
			end

			local var_178_19 = 0
			local var_178_20 = 0.275

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_21 = arg_175_1:FormatText(StoryNameCfg[670].name)

				arg_175_1.leftNameTxt_.text = var_178_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_22 = arg_175_1:GetWordFromCfg(411041041)
				local var_178_23 = arg_175_1:FormatText(var_178_22.content)

				arg_175_1.text_.text = var_178_23

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_24 = 11
				local var_178_25 = utf8.len(var_178_23)
				local var_178_26 = var_178_24 <= 0 and var_178_20 or var_178_20 * (var_178_25 / var_178_24)

				if var_178_26 > 0 and var_178_20 < var_178_26 then
					arg_175_1.talkMaxDuration = var_178_26

					if var_178_26 + var_178_19 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_26 + var_178_19
					end
				end

				arg_175_1.text_.text = var_178_23
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041041", "story_v_out_411041.awb") ~= 0 then
					local var_178_27 = manager.audio:GetVoiceLength("story_v_out_411041", "411041041", "story_v_out_411041.awb") / 1000

					if var_178_27 + var_178_19 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_27 + var_178_19
					end

					if var_178_22.prefab_name ~= "" and arg_175_1.actors_[var_178_22.prefab_name] ~= nil then
						local var_178_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_22.prefab_name].transform, "story_v_out_411041", "411041041", "story_v_out_411041.awb")

						arg_175_1:RecordAudio("411041041", var_178_28)
						arg_175_1:RecordAudio("411041041", var_178_28)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411041", "411041041", "story_v_out_411041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411041", "411041041", "story_v_out_411041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_29 = math.max(var_178_20, arg_175_1.talkMaxDuration)

			if var_178_19 <= arg_175_1.time_ and arg_175_1.time_ < var_178_19 + var_178_29 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_19) / var_178_29

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_19 + var_178_29 and arg_175_1.time_ < var_178_19 + var_178_29 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play411041042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411041042
		arg_179_1.duration_ = 6.8

		local var_179_0 = {
			zh = 5.2,
			ja = 6.8
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411041043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10071ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10071ui_story == nil then
				arg_179_1.var_.characterEffect10071ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10071ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10071ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10071ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10071ui_story.fillRatio = var_182_5
			end

			local var_182_6 = 0
			local var_182_7 = 0.625

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_8 = arg_179_1:FormatText(StoryNameCfg[673].name)

				arg_179_1.leftNameTxt_.text = var_182_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_9 = arg_179_1:GetWordFromCfg(411041042)
				local var_182_10 = arg_179_1:FormatText(var_182_9.content)

				arg_179_1.text_.text = var_182_10

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 25
				local var_182_12 = utf8.len(var_182_10)
				local var_182_13 = var_182_11 <= 0 and var_182_7 or var_182_7 * (var_182_12 / var_182_11)

				if var_182_13 > 0 and var_182_7 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_10
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041042", "story_v_out_411041.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041042", "story_v_out_411041.awb") / 1000

					if var_182_14 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_6
					end

					if var_182_9.prefab_name ~= "" and arg_179_1.actors_[var_182_9.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_9.prefab_name].transform, "story_v_out_411041", "411041042", "story_v_out_411041.awb")

						arg_179_1:RecordAudio("411041042", var_182_15)
						arg_179_1:RecordAudio("411041042", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411041", "411041042", "story_v_out_411041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411041", "411041042", "story_v_out_411041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_16 and arg_179_1.time_ < var_182_6 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play411041043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411041043
		arg_183_1.duration_ = 4.47

		local var_183_0 = {
			zh = 3.5,
			ja = 4.466
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411041044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1095ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1095ui_story == nil then
				arg_183_1.var_.characterEffect1095ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1095ui_story and not isNil(var_186_0) then
					arg_183_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1095ui_story then
				arg_183_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_186_4 = 0

			if var_186_4 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_186_5 = 0

			if var_186_5 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_6 = arg_183_1.actors_["10071ui_story"]
			local var_186_7 = 0

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 and not isNil(var_186_6) and arg_183_1.var_.characterEffect10071ui_story == nil then
				arg_183_1.var_.characterEffect10071ui_story = var_186_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_8 = 0.200000002980232

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 and not isNil(var_186_6) then
				local var_186_9 = (arg_183_1.time_ - var_186_7) / var_186_8

				if arg_183_1.var_.characterEffect10071ui_story and not isNil(var_186_6) then
					local var_186_10 = Mathf.Lerp(0, 0.5, var_186_9)

					arg_183_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10071ui_story.fillRatio = var_186_10
				end
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 and not isNil(var_186_6) and arg_183_1.var_.characterEffect10071ui_story then
				local var_186_11 = 0.5

				arg_183_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10071ui_story.fillRatio = var_186_11
			end

			local var_186_12 = 0
			local var_186_13 = 0.375

			if var_186_12 < arg_183_1.time_ and arg_183_1.time_ <= var_186_12 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_14 = arg_183_1:FormatText(StoryNameCfg[471].name)

				arg_183_1.leftNameTxt_.text = var_186_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_15 = arg_183_1:GetWordFromCfg(411041043)
				local var_186_16 = arg_183_1:FormatText(var_186_15.content)

				arg_183_1.text_.text = var_186_16

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_17 = 15
				local var_186_18 = utf8.len(var_186_16)
				local var_186_19 = var_186_17 <= 0 and var_186_13 or var_186_13 * (var_186_18 / var_186_17)

				if var_186_19 > 0 and var_186_13 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19

					if var_186_19 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_12
					end
				end

				arg_183_1.text_.text = var_186_16
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041043", "story_v_out_411041.awb") ~= 0 then
					local var_186_20 = manager.audio:GetVoiceLength("story_v_out_411041", "411041043", "story_v_out_411041.awb") / 1000

					if var_186_20 + var_186_12 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_20 + var_186_12
					end

					if var_186_15.prefab_name ~= "" and arg_183_1.actors_[var_186_15.prefab_name] ~= nil then
						local var_186_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_15.prefab_name].transform, "story_v_out_411041", "411041043", "story_v_out_411041.awb")

						arg_183_1:RecordAudio("411041043", var_186_21)
						arg_183_1:RecordAudio("411041043", var_186_21)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411041", "411041043", "story_v_out_411041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411041", "411041043", "story_v_out_411041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_22 = math.max(var_186_13, arg_183_1.talkMaxDuration)

			if var_186_12 <= arg_183_1.time_ and arg_183_1.time_ < var_186_12 + var_186_22 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_12) / var_186_22

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_12 + var_186_22 and arg_183_1.time_ < var_186_12 + var_186_22 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play411041044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411041044
		arg_187_1.duration_ = 9.63

		local var_187_0 = {
			zh = 3.033,
			ja = 9.633
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411041045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.35

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[471].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(411041044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 14
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041044", "story_v_out_411041.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041044", "story_v_out_411041.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_411041", "411041044", "story_v_out_411041.awb")

						arg_187_1:RecordAudio("411041044", var_190_9)
						arg_187_1:RecordAudio("411041044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411041", "411041044", "story_v_out_411041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411041", "411041044", "story_v_out_411041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play411041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411041045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10071ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10071ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, 100, 0)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10071ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, 100, 0)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1095ui_story"].transform
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.var_.moveOldPos1095ui_story = var_194_9.localPosition
			end

			local var_194_11 = 0.001

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11
				local var_194_13 = Vector3.New(0, -0.98, -6.1)

				var_194_9.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1095ui_story, var_194_13, var_194_12)

				local var_194_14 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_14.x, var_194_14.y, var_194_14.z)

				local var_194_15 = var_194_9.localEulerAngles

				var_194_15.z = 0
				var_194_15.x = 0
				var_194_9.localEulerAngles = var_194_15
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 then
				var_194_9.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_194_16 = manager.ui.mainCamera.transform.position - var_194_9.position

				var_194_9.forward = Vector3.New(var_194_16.x, var_194_16.y, var_194_16.z)

				local var_194_17 = var_194_9.localEulerAngles

				var_194_17.z = 0
				var_194_17.x = 0
				var_194_9.localEulerAngles = var_194_17
			end

			local var_194_18 = arg_191_1.actors_["1095ui_story"]
			local var_194_19 = 0

			if var_194_19 < arg_191_1.time_ and arg_191_1.time_ <= var_194_19 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect1095ui_story == nil then
				arg_191_1.var_.characterEffect1095ui_story = var_194_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_20 = 0.200000002980232

			if var_194_19 <= arg_191_1.time_ and arg_191_1.time_ < var_194_19 + var_194_20 and not isNil(var_194_18) then
				local var_194_21 = (arg_191_1.time_ - var_194_19) / var_194_20

				if arg_191_1.var_.characterEffect1095ui_story and not isNil(var_194_18) then
					local var_194_22 = Mathf.Lerp(0, 0.5, var_194_21)

					arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1095ui_story.fillRatio = var_194_22
				end
			end

			if arg_191_1.time_ >= var_194_19 + var_194_20 and arg_191_1.time_ < var_194_19 + var_194_20 + arg_194_0 and not isNil(var_194_18) and arg_191_1.var_.characterEffect1095ui_story then
				local var_194_23 = 0.5

				arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1095ui_story.fillRatio = var_194_23
			end

			local var_194_24 = arg_191_1.actors_["10071ui_story"]
			local var_194_25 = 0

			if var_194_25 < arg_191_1.time_ and arg_191_1.time_ <= var_194_25 + arg_194_0 and not isNil(var_194_24) and arg_191_1.var_.characterEffect10071ui_story == nil then
				arg_191_1.var_.characterEffect10071ui_story = var_194_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_26 = 0.200000002980232

			if var_194_25 <= arg_191_1.time_ and arg_191_1.time_ < var_194_25 + var_194_26 and not isNil(var_194_24) then
				local var_194_27 = (arg_191_1.time_ - var_194_25) / var_194_26

				if arg_191_1.var_.characterEffect10071ui_story and not isNil(var_194_24) then
					local var_194_28 = Mathf.Lerp(0, 0.5, var_194_27)

					arg_191_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10071ui_story.fillRatio = var_194_28
				end
			end

			if arg_191_1.time_ >= var_194_25 + var_194_26 and arg_191_1.time_ < var_194_25 + var_194_26 + arg_194_0 and not isNil(var_194_24) and arg_191_1.var_.characterEffect10071ui_story then
				local var_194_29 = 0.5

				arg_191_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10071ui_story.fillRatio = var_194_29
			end

			local var_194_30 = 0
			local var_194_31 = 1.025

			if var_194_30 < arg_191_1.time_ and arg_191_1.time_ <= var_194_30 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_32 = arg_191_1:GetWordFromCfg(411041045)
				local var_194_33 = arg_191_1:FormatText(var_194_32.content)

				arg_191_1.text_.text = var_194_33

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_34 = 41
				local var_194_35 = utf8.len(var_194_33)
				local var_194_36 = var_194_34 <= 0 and var_194_31 or var_194_31 * (var_194_35 / var_194_34)

				if var_194_36 > 0 and var_194_31 < var_194_36 then
					arg_191_1.talkMaxDuration = var_194_36

					if var_194_36 + var_194_30 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_36 + var_194_30
					end
				end

				arg_191_1.text_.text = var_194_33
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_37 = math.max(var_194_31, arg_191_1.talkMaxDuration)

			if var_194_30 <= arg_191_1.time_ and arg_191_1.time_ < var_194_30 + var_194_37 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_30) / var_194_37

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_30 + var_194_37 and arg_191_1.time_ < var_194_30 + var_194_37 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play411041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411041046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.875

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_2 = arg_195_1:GetWordFromCfg(411041046)
				local var_198_3 = arg_195_1:FormatText(var_198_2.content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 35
				local var_198_5 = utf8.len(var_198_3)
				local var_198_6 = var_198_4 <= 0 and var_198_1 or var_198_1 * (var_198_5 / var_198_4)

				if var_198_6 > 0 and var_198_1 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_7 and arg_195_1.time_ < var_198_0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play411041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411041047
		arg_199_1.duration_ = 3.17

		local var_199_0 = {
			zh = 2.6,
			ja = 3.166
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.325

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[673].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(411041047)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 13
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041047", "story_v_out_411041.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041047", "story_v_out_411041.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_411041", "411041047", "story_v_out_411041.awb")

						arg_199_1:RecordAudio("411041047", var_202_9)
						arg_199_1:RecordAudio("411041047", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_411041", "411041047", "story_v_out_411041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_411041", "411041047", "story_v_out_411041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play411041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411041048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1.375

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(411041048)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 55
				local var_206_5 = utf8.len(var_206_3)
				local var_206_6 = var_206_4 <= 0 and var_206_1 or var_206_1 * (var_206_5 / var_206_4)

				if var_206_6 > 0 and var_206_1 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_7 and arg_203_1.time_ < var_206_0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play411041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411041049
		arg_207_1.duration_ = 3.77

		local var_207_0 = {
			zh = 2.4,
			ja = 3.766
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play411041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.225

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[673].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(411041049)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 9
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041049", "story_v_out_411041.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041049", "story_v_out_411041.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_411041", "411041049", "story_v_out_411041.awb")

						arg_207_1:RecordAudio("411041049", var_210_9)
						arg_207_1:RecordAudio("411041049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_411041", "411041049", "story_v_out_411041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_411041", "411041049", "story_v_out_411041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play411041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411041050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.875

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(411041050)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 35
				local var_214_5 = utf8.len(var_214_3)
				local var_214_6 = var_214_4 <= 0 and var_214_1 or var_214_1 * (var_214_5 / var_214_4)

				if var_214_6 > 0 and var_214_1 < var_214_6 then
					arg_211_1.talkMaxDuration = var_214_6

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_7 and arg_211_1.time_ < var_214_0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play411041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411041051
		arg_215_1.duration_ = 10.57

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 1.3

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[673].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(411041051)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 52
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041051", "story_v_out_411041.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041051", "story_v_out_411041.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_411041", "411041051", "story_v_out_411041.awb")

						arg_215_1:RecordAudio("411041051", var_218_9)
						arg_215_1:RecordAudio("411041051", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_411041", "411041051", "story_v_out_411041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_411041", "411041051", "story_v_out_411041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_10 and arg_215_1.time_ < var_218_0 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play411041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411041052
		arg_219_1.duration_ = 9.33

		local var_219_0 = {
			zh = 8.733,
			ja = 9.333
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.025

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[673].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(411041052)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 41
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041052", "story_v_out_411041.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041052", "story_v_out_411041.awb") / 1000

					if var_222_8 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_0
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_out_411041", "411041052", "story_v_out_411041.awb")

						arg_219_1:RecordAudio("411041052", var_222_9)
						arg_219_1:RecordAudio("411041052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_411041", "411041052", "story_v_out_411041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_411041", "411041052", "story_v_out_411041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_10 and arg_219_1.time_ < var_222_0 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play411041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411041053
		arg_223_1.duration_ = 13.8

		local var_223_0 = {
			zh = 9.066,
			ja = 13.8
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.175

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[673].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(411041053)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 47
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041053", "story_v_out_411041.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041053", "story_v_out_411041.awb") / 1000

					if var_226_8 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_0
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_411041", "411041053", "story_v_out_411041.awb")

						arg_223_1:RecordAudio("411041053", var_226_9)
						arg_223_1:RecordAudio("411041053", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_411041", "411041053", "story_v_out_411041.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_411041", "411041053", "story_v_out_411041.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_10 and arg_223_1.time_ < var_226_0 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play411041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411041054
		arg_227_1.duration_ = 5.47

		local var_227_0 = {
			zh = 5.466,
			ja = 5.066
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play411041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1095ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1095ui_story == nil then
				arg_227_1.var_.characterEffect1095ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1095ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1095ui_story then
				arg_227_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_6 = 0
			local var_230_7 = 0.475

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[471].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(411041054)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 19
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041054", "story_v_out_411041.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041054", "story_v_out_411041.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_out_411041", "411041054", "story_v_out_411041.awb")

						arg_227_1:RecordAudio("411041054", var_230_15)
						arg_227_1:RecordAudio("411041054", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411041", "411041054", "story_v_out_411041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411041", "411041054", "story_v_out_411041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_16 and arg_227_1.time_ < var_230_6 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play411041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411041055
		arg_231_1.duration_ = 10.67

		local var_231_0 = {
			zh = 7.233,
			ja = 10.666
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play411041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1095ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1095ui_story == nil then
				arg_231_1.var_.characterEffect1095ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1095ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1095ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1095ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1095ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.95

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[673].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(411041055)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 38
				local var_234_12 = utf8.len(var_234_10)
				local var_234_13 = var_234_11 <= 0 and var_234_7 or var_234_7 * (var_234_12 / var_234_11)

				if var_234_13 > 0 and var_234_7 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041055", "story_v_out_411041.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041055", "story_v_out_411041.awb") / 1000

					if var_234_14 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_6
					end

					if var_234_9.prefab_name ~= "" and arg_231_1.actors_[var_234_9.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_9.prefab_name].transform, "story_v_out_411041", "411041055", "story_v_out_411041.awb")

						arg_231_1:RecordAudio("411041055", var_234_15)
						arg_231_1:RecordAudio("411041055", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411041", "411041055", "story_v_out_411041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411041", "411041055", "story_v_out_411041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_16 and arg_231_1.time_ < var_234_6 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play411041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411041056
		arg_235_1.duration_ = 5.83

		local var_235_0 = {
			zh = 5.833,
			ja = 5.266
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play411041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1095ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1095ui_story == nil then
				arg_235_1.var_.characterEffect1095ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1095ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1095ui_story then
				arg_235_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_238_4 = 0
			local var_238_5 = 0.6

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_6 = arg_235_1:FormatText(StoryNameCfg[471].name)

				arg_235_1.leftNameTxt_.text = var_238_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(411041056)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 24
				local var_238_10 = utf8.len(var_238_8)
				local var_238_11 = var_238_9 <= 0 and var_238_5 or var_238_5 * (var_238_10 / var_238_9)

				if var_238_11 > 0 and var_238_5 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041056", "story_v_out_411041.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041056", "story_v_out_411041.awb") / 1000

					if var_238_12 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_4
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_411041", "411041056", "story_v_out_411041.awb")

						arg_235_1:RecordAudio("411041056", var_238_13)
						arg_235_1:RecordAudio("411041056", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411041", "411041056", "story_v_out_411041.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411041", "411041056", "story_v_out_411041.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_14 and arg_235_1.time_ < var_238_4 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play411041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411041057
		arg_239_1.duration_ = 7.6

		local var_239_0 = {
			zh = 4.6,
			ja = 7.6
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1095ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1095ui_story == nil then
				arg_239_1.var_.characterEffect1095ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1095ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1095ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1095ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1095ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.575

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[673].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_9 = arg_239_1:GetWordFromCfg(411041057)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 23
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041057", "story_v_out_411041.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041057", "story_v_out_411041.awb") / 1000

					if var_242_14 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_6
					end

					if var_242_9.prefab_name ~= "" and arg_239_1.actors_[var_242_9.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_9.prefab_name].transform, "story_v_out_411041", "411041057", "story_v_out_411041.awb")

						arg_239_1:RecordAudio("411041057", var_242_15)
						arg_239_1:RecordAudio("411041057", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411041", "411041057", "story_v_out_411041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411041", "411041057", "story_v_out_411041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_16 and arg_239_1.time_ < var_242_6 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play411041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411041058
		arg_243_1.duration_ = 14.87

		local var_243_0 = {
			zh = 9.2,
			ja = 14.866
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 1.25

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[673].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(411041058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 50
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041058", "story_v_out_411041.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041058", "story_v_out_411041.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_411041", "411041058", "story_v_out_411041.awb")

						arg_243_1:RecordAudio("411041058", var_246_9)
						arg_243_1:RecordAudio("411041058", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411041", "411041058", "story_v_out_411041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411041", "411041058", "story_v_out_411041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play411041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411041059
		arg_247_1.duration_ = 8.8

		local var_247_0 = {
			zh = 4.733,
			ja = 8.8
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play411041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1095ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos1095ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0, -0.98, -6.1)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1095ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["1095ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1095ui_story == nil then
				arg_247_1.var_.characterEffect1095ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect1095ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect1095ui_story then
				arg_247_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_15 = 0
			local var_250_16 = 0.475

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_17 = arg_247_1:FormatText(StoryNameCfg[471].name)

				arg_247_1.leftNameTxt_.text = var_250_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_18 = arg_247_1:GetWordFromCfg(411041059)
				local var_250_19 = arg_247_1:FormatText(var_250_18.content)

				arg_247_1.text_.text = var_250_19

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_20 = 19
				local var_250_21 = utf8.len(var_250_19)
				local var_250_22 = var_250_20 <= 0 and var_250_16 or var_250_16 * (var_250_21 / var_250_20)

				if var_250_22 > 0 and var_250_16 < var_250_22 then
					arg_247_1.talkMaxDuration = var_250_22

					if var_250_22 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_22 + var_250_15
					end
				end

				arg_247_1.text_.text = var_250_19
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041059", "story_v_out_411041.awb") ~= 0 then
					local var_250_23 = manager.audio:GetVoiceLength("story_v_out_411041", "411041059", "story_v_out_411041.awb") / 1000

					if var_250_23 + var_250_15 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_23 + var_250_15
					end

					if var_250_18.prefab_name ~= "" and arg_247_1.actors_[var_250_18.prefab_name] ~= nil then
						local var_250_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_18.prefab_name].transform, "story_v_out_411041", "411041059", "story_v_out_411041.awb")

						arg_247_1:RecordAudio("411041059", var_250_24)
						arg_247_1:RecordAudio("411041059", var_250_24)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411041", "411041059", "story_v_out_411041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411041", "411041059", "story_v_out_411041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_25 = math.max(var_250_16, arg_247_1.talkMaxDuration)

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_25 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_15) / var_250_25

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_15 + var_250_25 and arg_247_1.time_ < var_250_15 + var_250_25 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play411041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411041060
		arg_251_1.duration_ = 2.1

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play411041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1095ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1095ui_story == nil then
				arg_251_1.var_.characterEffect1095ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1095ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1095ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1095ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1095ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.225

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[673].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(411041060)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 9
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041060", "story_v_out_411041.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041060", "story_v_out_411041.awb") / 1000

					if var_254_14 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_6
					end

					if var_254_9.prefab_name ~= "" and arg_251_1.actors_[var_254_9.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_9.prefab_name].transform, "story_v_out_411041", "411041060", "story_v_out_411041.awb")

						arg_251_1:RecordAudio("411041060", var_254_15)
						arg_251_1:RecordAudio("411041060", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411041", "411041060", "story_v_out_411041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411041", "411041060", "story_v_out_411041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_16 and arg_251_1.time_ < var_254_6 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play411041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411041061
		arg_255_1.duration_ = 6

		local var_255_0 = {
			zh = 6,
			ja = 4.4
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play411041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1095ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1095ui_story == nil then
				arg_255_1.var_.characterEffect1095ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1095ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1095ui_story then
				arg_255_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_258_4 = 0
			local var_258_5 = 0.5

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_6 = arg_255_1:FormatText(StoryNameCfg[471].name)

				arg_255_1.leftNameTxt_.text = var_258_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(411041061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 20
				local var_258_10 = utf8.len(var_258_8)
				local var_258_11 = var_258_9 <= 0 and var_258_5 or var_258_5 * (var_258_10 / var_258_9)

				if var_258_11 > 0 and var_258_5 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041061", "story_v_out_411041.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041061", "story_v_out_411041.awb") / 1000

					if var_258_12 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_4
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_411041", "411041061", "story_v_out_411041.awb")

						arg_255_1:RecordAudio("411041061", var_258_13)
						arg_255_1:RecordAudio("411041061", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411041", "411041061", "story_v_out_411041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411041", "411041061", "story_v_out_411041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_14 and arg_255_1.time_ < var_258_4 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play411041062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411041062
		arg_259_1.duration_ = 1.13

		local var_259_0 = {
			zh = 1.133,
			ja = 1.1
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play411041063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1095ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1095ui_story == nil then
				arg_259_1.var_.characterEffect1095ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1095ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1095ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1095ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1095ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.1

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[36].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_9 = arg_259_1:GetWordFromCfg(411041062)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 4
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041062", "story_v_out_411041.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_411041", "411041062", "story_v_out_411041.awb") / 1000

					if var_262_14 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_6
					end

					if var_262_9.prefab_name ~= "" and arg_259_1.actors_[var_262_9.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_9.prefab_name].transform, "story_v_out_411041", "411041062", "story_v_out_411041.awb")

						arg_259_1:RecordAudio("411041062", var_262_15)
						arg_259_1:RecordAudio("411041062", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411041", "411041062", "story_v_out_411041.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411041", "411041062", "story_v_out_411041.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_16 and arg_259_1.time_ < var_262_6 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play411041063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411041063
		arg_263_1.duration_ = 8.57

		local var_263_0 = {
			zh = 6.26666666666667,
			ja = 8.56666666666667
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411041064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 2

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_1 = manager.ui.mainCamera.transform.localPosition
				local var_266_2 = Vector3.New(0, 0, 10) + Vector3.New(var_266_1.x, var_266_1.y, 0)
				local var_266_3 = arg_263_1.bgs_.I07

				var_266_3.transform.localPosition = var_266_2
				var_266_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_4 = var_266_3:GetComponent("SpriteRenderer")

				if var_266_4 and var_266_4.sprite then
					local var_266_5 = (var_266_3.transform.localPosition - var_266_1).z
					local var_266_6 = manager.ui.mainCameraCom_
					local var_266_7 = 2 * var_266_5 * Mathf.Tan(var_266_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_266_8 = var_266_7 * var_266_6.aspect
					local var_266_9 = var_266_4.sprite.bounds.size.x
					local var_266_10 = var_266_4.sprite.bounds.size.y
					local var_266_11 = var_266_8 / var_266_9
					local var_266_12 = var_266_7 / var_266_10
					local var_266_13 = var_266_12 < var_266_11 and var_266_11 or var_266_12

					var_266_3.transform.localScale = Vector3.New(var_266_13, var_266_13, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "I07" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_15 = 2

			if var_266_14 <= arg_263_1.time_ and arg_263_1.time_ < var_266_14 + var_266_15 then
				local var_266_16 = (arg_263_1.time_ - var_266_14) / var_266_15
				local var_266_17 = Color.New(0, 0, 0)

				var_266_17.a = Mathf.Lerp(0, 1, var_266_16)
				arg_263_1.mask_.color = var_266_17
			end

			if arg_263_1.time_ >= var_266_14 + var_266_15 and arg_263_1.time_ < var_266_14 + var_266_15 + arg_266_0 then
				local var_266_18 = Color.New(0, 0, 0)

				var_266_18.a = 1
				arg_263_1.mask_.color = var_266_18
			end

			local var_266_19 = 2

			if var_266_19 < arg_263_1.time_ and arg_263_1.time_ <= var_266_19 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_20 = 1.36666666666667

			if var_266_19 <= arg_263_1.time_ and arg_263_1.time_ < var_266_19 + var_266_20 then
				local var_266_21 = (arg_263_1.time_ - var_266_19) / var_266_20
				local var_266_22 = Color.New(0, 0, 0)

				var_266_22.a = Mathf.Lerp(1, 0, var_266_21)
				arg_263_1.mask_.color = var_266_22
			end

			if arg_263_1.time_ >= var_266_19 + var_266_20 and arg_263_1.time_ < var_266_19 + var_266_20 + arg_266_0 then
				local var_266_23 = Color.New(0, 0, 0)
				local var_266_24 = 0

				arg_263_1.mask_.enabled = false
				var_266_23.a = var_266_24
				arg_263_1.mask_.color = var_266_23
			end

			local var_266_25 = arg_263_1.actors_["1095ui_story"].transform
			local var_266_26 = 3.36666666666667

			if var_266_26 < arg_263_1.time_ and arg_263_1.time_ <= var_266_26 + arg_266_0 then
				arg_263_1.var_.moveOldPos1095ui_story = var_266_25.localPosition
			end

			local var_266_27 = 0.001

			if var_266_26 <= arg_263_1.time_ and arg_263_1.time_ < var_266_26 + var_266_27 then
				local var_266_28 = (arg_263_1.time_ - var_266_26) / var_266_27
				local var_266_29 = Vector3.New(0, -0.98, -6.1)

				var_266_25.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1095ui_story, var_266_29, var_266_28)

				local var_266_30 = manager.ui.mainCamera.transform.position - var_266_25.position

				var_266_25.forward = Vector3.New(var_266_30.x, var_266_30.y, var_266_30.z)

				local var_266_31 = var_266_25.localEulerAngles

				var_266_31.z = 0
				var_266_31.x = 0
				var_266_25.localEulerAngles = var_266_31
			end

			if arg_263_1.time_ >= var_266_26 + var_266_27 and arg_263_1.time_ < var_266_26 + var_266_27 + arg_266_0 then
				var_266_25.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_266_32 = manager.ui.mainCamera.transform.position - var_266_25.position

				var_266_25.forward = Vector3.New(var_266_32.x, var_266_32.y, var_266_32.z)

				local var_266_33 = var_266_25.localEulerAngles

				var_266_33.z = 0
				var_266_33.x = 0
				var_266_25.localEulerAngles = var_266_33
			end

			local var_266_34 = arg_263_1.actors_["1095ui_story"]
			local var_266_35 = 3.36666666666667

			if var_266_35 < arg_263_1.time_ and arg_263_1.time_ <= var_266_35 + arg_266_0 and not isNil(var_266_34) and arg_263_1.var_.characterEffect1095ui_story == nil then
				arg_263_1.var_.characterEffect1095ui_story = var_266_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_36 = 0.200000002980232

			if var_266_35 <= arg_263_1.time_ and arg_263_1.time_ < var_266_35 + var_266_36 and not isNil(var_266_34) then
				local var_266_37 = (arg_263_1.time_ - var_266_35) / var_266_36

				if arg_263_1.var_.characterEffect1095ui_story and not isNil(var_266_34) then
					arg_263_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_35 + var_266_36 and arg_263_1.time_ < var_266_35 + var_266_36 + arg_266_0 and not isNil(var_266_34) and arg_263_1.var_.characterEffect1095ui_story then
				arg_263_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_266_38 = 3.36666666666667

			if var_266_38 < arg_263_1.time_ and arg_263_1.time_ <= var_266_38 + arg_266_0 then
				arg_263_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_266_39 = 3.36666666666667

			if var_266_39 < arg_263_1.time_ and arg_263_1.time_ <= var_266_39 + arg_266_0 then
				arg_263_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_40 = 3.36666666666667
			local var_266_41 = 0.275

			if var_266_40 < arg_263_1.time_ and arg_263_1.time_ <= var_266_40 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_42 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_42:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_43 = arg_263_1:FormatText(StoryNameCfg[471].name)

				arg_263_1.leftNameTxt_.text = var_266_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_44 = arg_263_1:GetWordFromCfg(411041063)
				local var_266_45 = arg_263_1:FormatText(var_266_44.content)

				arg_263_1.text_.text = var_266_45

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_46 = 11
				local var_266_47 = utf8.len(var_266_45)
				local var_266_48 = var_266_46 <= 0 and var_266_41 or var_266_41 * (var_266_47 / var_266_46)

				if var_266_48 > 0 and var_266_41 < var_266_48 then
					arg_263_1.talkMaxDuration = var_266_48
					var_266_40 = var_266_40 + 0.3

					if var_266_48 + var_266_40 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_48 + var_266_40
					end
				end

				arg_263_1.text_.text = var_266_45
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041063", "story_v_out_411041.awb") ~= 0 then
					local var_266_49 = manager.audio:GetVoiceLength("story_v_out_411041", "411041063", "story_v_out_411041.awb") / 1000

					if var_266_49 + var_266_40 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_49 + var_266_40
					end

					if var_266_44.prefab_name ~= "" and arg_263_1.actors_[var_266_44.prefab_name] ~= nil then
						local var_266_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_44.prefab_name].transform, "story_v_out_411041", "411041063", "story_v_out_411041.awb")

						arg_263_1:RecordAudio("411041063", var_266_50)
						arg_263_1:RecordAudio("411041063", var_266_50)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411041", "411041063", "story_v_out_411041.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411041", "411041063", "story_v_out_411041.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_51 = var_266_40 + 0.3
			local var_266_52 = math.max(var_266_41, arg_263_1.talkMaxDuration)

			if var_266_51 <= arg_263_1.time_ and arg_263_1.time_ < var_266_51 + var_266_52 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_51) / var_266_52

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_51 + var_266_52 and arg_263_1.time_ < var_266_51 + var_266_52 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play411041064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 411041064
		arg_269_1.duration_ = 9.43

		local var_269_0 = {
			zh = 8.433,
			ja = 9.433
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play411041065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = "10014ui_story"

			if arg_269_1.actors_[var_272_0] == nil then
				local var_272_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_272_1) then
					local var_272_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_269_1.stage_.transform)

					var_272_2.name = var_272_0
					var_272_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_269_1.actors_[var_272_0] = var_272_2

					local var_272_3 = var_272_2:GetComponentInChildren(typeof(CharacterEffect))

					var_272_3.enabled = true

					local var_272_4 = GameObjectTools.GetOrAddComponent(var_272_2, typeof(DynamicBoneHelper))

					if var_272_4 then
						var_272_4:EnableDynamicBone(false)
					end

					arg_269_1:ShowWeapon(var_272_3.transform, false)

					arg_269_1.var_[var_272_0 .. "Animator"] = var_272_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_269_1.var_[var_272_0 .. "Animator"].applyRootMotion = true
					arg_269_1.var_[var_272_0 .. "LipSync"] = var_272_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_272_5 = arg_269_1.actors_["10014ui_story"].transform
			local var_272_6 = 0

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.var_.moveOldPos10014ui_story = var_272_5.localPosition
			end

			local var_272_7 = 0.001

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_7 then
				local var_272_8 = (arg_269_1.time_ - var_272_6) / var_272_7
				local var_272_9 = Vector3.New(0.7, -1.06, -6.2)

				var_272_5.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10014ui_story, var_272_9, var_272_8)

				local var_272_10 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_10.x, var_272_10.y, var_272_10.z)

				local var_272_11 = var_272_5.localEulerAngles

				var_272_11.z = 0
				var_272_11.x = 0
				var_272_5.localEulerAngles = var_272_11
			end

			if arg_269_1.time_ >= var_272_6 + var_272_7 and arg_269_1.time_ < var_272_6 + var_272_7 + arg_272_0 then
				var_272_5.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_272_12 = manager.ui.mainCamera.transform.position - var_272_5.position

				var_272_5.forward = Vector3.New(var_272_12.x, var_272_12.y, var_272_12.z)

				local var_272_13 = var_272_5.localEulerAngles

				var_272_13.z = 0
				var_272_13.x = 0
				var_272_5.localEulerAngles = var_272_13
			end

			local var_272_14 = arg_269_1.actors_["10014ui_story"]
			local var_272_15 = 0

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.characterEffect10014ui_story == nil then
				arg_269_1.var_.characterEffect10014ui_story = var_272_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_16 = 0.200000002980232

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_16 and not isNil(var_272_14) then
				local var_272_17 = (arg_269_1.time_ - var_272_15) / var_272_16

				if arg_269_1.var_.characterEffect10014ui_story and not isNil(var_272_14) then
					arg_269_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_15 + var_272_16 and arg_269_1.time_ < var_272_15 + var_272_16 + arg_272_0 and not isNil(var_272_14) and arg_269_1.var_.characterEffect10014ui_story then
				arg_269_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_272_19 = 0

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_20 = arg_269_1.actors_["1095ui_story"].transform
			local var_272_21 = 0

			if var_272_21 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1.var_.moveOldPos1095ui_story = var_272_20.localPosition
			end

			local var_272_22 = 0.001

			if var_272_21 <= arg_269_1.time_ and arg_269_1.time_ < var_272_21 + var_272_22 then
				local var_272_23 = (arg_269_1.time_ - var_272_21) / var_272_22
				local var_272_24 = Vector3.New(-0.7, -0.98, -6.1)

				var_272_20.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1095ui_story, var_272_24, var_272_23)

				local var_272_25 = manager.ui.mainCamera.transform.position - var_272_20.position

				var_272_20.forward = Vector3.New(var_272_25.x, var_272_25.y, var_272_25.z)

				local var_272_26 = var_272_20.localEulerAngles

				var_272_26.z = 0
				var_272_26.x = 0
				var_272_20.localEulerAngles = var_272_26
			end

			if arg_269_1.time_ >= var_272_21 + var_272_22 and arg_269_1.time_ < var_272_21 + var_272_22 + arg_272_0 then
				var_272_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_272_27 = manager.ui.mainCamera.transform.position - var_272_20.position

				var_272_20.forward = Vector3.New(var_272_27.x, var_272_27.y, var_272_27.z)

				local var_272_28 = var_272_20.localEulerAngles

				var_272_28.z = 0
				var_272_28.x = 0
				var_272_20.localEulerAngles = var_272_28
			end

			local var_272_29 = arg_269_1.actors_["1095ui_story"]
			local var_272_30 = 0

			if var_272_30 < arg_269_1.time_ and arg_269_1.time_ <= var_272_30 + arg_272_0 and not isNil(var_272_29) and arg_269_1.var_.characterEffect1095ui_story == nil then
				arg_269_1.var_.characterEffect1095ui_story = var_272_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_31 = 0.200000002980232

			if var_272_30 <= arg_269_1.time_ and arg_269_1.time_ < var_272_30 + var_272_31 and not isNil(var_272_29) then
				local var_272_32 = (arg_269_1.time_ - var_272_30) / var_272_31

				if arg_269_1.var_.characterEffect1095ui_story and not isNil(var_272_29) then
					local var_272_33 = Mathf.Lerp(0, 0.5, var_272_32)

					arg_269_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1095ui_story.fillRatio = var_272_33
				end
			end

			if arg_269_1.time_ >= var_272_30 + var_272_31 and arg_269_1.time_ < var_272_30 + var_272_31 + arg_272_0 and not isNil(var_272_29) and arg_269_1.var_.characterEffect1095ui_story then
				local var_272_34 = 0.5

				arg_269_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1095ui_story.fillRatio = var_272_34
			end

			local var_272_35 = 0
			local var_272_36 = 1.1

			if var_272_35 < arg_269_1.time_ and arg_269_1.time_ <= var_272_35 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_37 = arg_269_1:FormatText(StoryNameCfg[264].name)

				arg_269_1.leftNameTxt_.text = var_272_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_38 = arg_269_1:GetWordFromCfg(411041064)
				local var_272_39 = arg_269_1:FormatText(var_272_38.content)

				arg_269_1.text_.text = var_272_39

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_40 = 44
				local var_272_41 = utf8.len(var_272_39)
				local var_272_42 = var_272_40 <= 0 and var_272_36 or var_272_36 * (var_272_41 / var_272_40)

				if var_272_42 > 0 and var_272_36 < var_272_42 then
					arg_269_1.talkMaxDuration = var_272_42

					if var_272_42 + var_272_35 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_42 + var_272_35
					end
				end

				arg_269_1.text_.text = var_272_39
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041064", "story_v_out_411041.awb") ~= 0 then
					local var_272_43 = manager.audio:GetVoiceLength("story_v_out_411041", "411041064", "story_v_out_411041.awb") / 1000

					if var_272_43 + var_272_35 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_43 + var_272_35
					end

					if var_272_38.prefab_name ~= "" and arg_269_1.actors_[var_272_38.prefab_name] ~= nil then
						local var_272_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_38.prefab_name].transform, "story_v_out_411041", "411041064", "story_v_out_411041.awb")

						arg_269_1:RecordAudio("411041064", var_272_44)
						arg_269_1:RecordAudio("411041064", var_272_44)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_411041", "411041064", "story_v_out_411041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_411041", "411041064", "story_v_out_411041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_45 = math.max(var_272_36, arg_269_1.talkMaxDuration)

			if var_272_35 <= arg_269_1.time_ and arg_269_1.time_ < var_272_35 + var_272_45 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_35) / var_272_45

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_35 + var_272_45 and arg_269_1.time_ < var_272_35 + var_272_45 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play411041065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 411041065
		arg_273_1.duration_ = 12.9

		local var_273_0 = {
			zh = 8.533,
			ja = 12.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play411041066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 1.025

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[264].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(411041065)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 41
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041065", "story_v_out_411041.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041065", "story_v_out_411041.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_411041", "411041065", "story_v_out_411041.awb")

						arg_273_1:RecordAudio("411041065", var_276_9)
						arg_273_1:RecordAudio("411041065", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_411041", "411041065", "story_v_out_411041.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_411041", "411041065", "story_v_out_411041.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play411041066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 411041066
		arg_277_1.duration_ = 7.2

		local var_277_0 = {
			zh = 6.833,
			ja = 7.2
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play411041067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1095ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos1095ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1095ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1095ui_story"]
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1095ui_story == nil then
				arg_277_1.var_.characterEffect1095ui_story = var_280_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_11 = 0.200000002980232

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 and not isNil(var_280_9) then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11

				if arg_277_1.var_.characterEffect1095ui_story and not isNil(var_280_9) then
					arg_277_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 and not isNil(var_280_9) and arg_277_1.var_.characterEffect1095ui_story then
				arg_277_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_280_13 = 0

			if var_280_13 < arg_277_1.time_ and arg_277_1.time_ <= var_280_13 + arg_280_0 then
				arg_277_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_280_14 = 0

			if var_280_14 < arg_277_1.time_ and arg_277_1.time_ <= var_280_14 + arg_280_0 then
				arg_277_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_15 = arg_277_1.actors_["10014ui_story"]
			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.characterEffect10014ui_story == nil then
				arg_277_1.var_.characterEffect10014ui_story = var_280_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_17 = 0.200000002980232

			if var_280_16 <= arg_277_1.time_ and arg_277_1.time_ < var_280_16 + var_280_17 and not isNil(var_280_15) then
				local var_280_18 = (arg_277_1.time_ - var_280_16) / var_280_17

				if arg_277_1.var_.characterEffect10014ui_story and not isNil(var_280_15) then
					local var_280_19 = Mathf.Lerp(0, 0.5, var_280_18)

					arg_277_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10014ui_story.fillRatio = var_280_19
				end
			end

			if arg_277_1.time_ >= var_280_16 + var_280_17 and arg_277_1.time_ < var_280_16 + var_280_17 + arg_280_0 and not isNil(var_280_15) and arg_277_1.var_.characterEffect10014ui_story then
				local var_280_20 = 0.5

				arg_277_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10014ui_story.fillRatio = var_280_20
			end

			local var_280_21 = 0
			local var_280_22 = 0.75

			if var_280_21 < arg_277_1.time_ and arg_277_1.time_ <= var_280_21 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_23 = arg_277_1:FormatText(StoryNameCfg[471].name)

				arg_277_1.leftNameTxt_.text = var_280_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_24 = arg_277_1:GetWordFromCfg(411041066)
				local var_280_25 = arg_277_1:FormatText(var_280_24.content)

				arg_277_1.text_.text = var_280_25

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_26 = 30
				local var_280_27 = utf8.len(var_280_25)
				local var_280_28 = var_280_26 <= 0 and var_280_22 or var_280_22 * (var_280_27 / var_280_26)

				if var_280_28 > 0 and var_280_22 < var_280_28 then
					arg_277_1.talkMaxDuration = var_280_28

					if var_280_28 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_28 + var_280_21
					end
				end

				arg_277_1.text_.text = var_280_25
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041066", "story_v_out_411041.awb") ~= 0 then
					local var_280_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041066", "story_v_out_411041.awb") / 1000

					if var_280_29 + var_280_21 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_29 + var_280_21
					end

					if var_280_24.prefab_name ~= "" and arg_277_1.actors_[var_280_24.prefab_name] ~= nil then
						local var_280_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_24.prefab_name].transform, "story_v_out_411041", "411041066", "story_v_out_411041.awb")

						arg_277_1:RecordAudio("411041066", var_280_30)
						arg_277_1:RecordAudio("411041066", var_280_30)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_411041", "411041066", "story_v_out_411041.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_411041", "411041066", "story_v_out_411041.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_31 = math.max(var_280_22, arg_277_1.talkMaxDuration)

			if var_280_21 <= arg_277_1.time_ and arg_277_1.time_ < var_280_21 + var_280_31 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_21) / var_280_31

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_21 + var_280_31 and arg_277_1.time_ < var_280_21 + var_280_31 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play411041067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 411041067
		arg_281_1.duration_ = 6

		local var_281_0 = {
			zh = 6,
			ja = 3.6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play411041068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1095ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1095ui_story == nil then
				arg_281_1.var_.characterEffect1095ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1095ui_story and not isNil(var_284_0) then
					local var_284_4 = Mathf.Lerp(0, 0.5, var_284_3)

					arg_281_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1095ui_story.fillRatio = var_284_4
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1095ui_story then
				local var_284_5 = 0.5

				arg_281_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1095ui_story.fillRatio = var_284_5
			end

			local var_284_6 = arg_281_1.actors_["10014ui_story"]
			local var_284_7 = 0

			if var_284_7 < arg_281_1.time_ and arg_281_1.time_ <= var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10014ui_story == nil then
				arg_281_1.var_.characterEffect10014ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_8 = 0.200000002980232

			if var_284_7 <= arg_281_1.time_ and arg_281_1.time_ < var_284_7 + var_284_8 and not isNil(var_284_6) then
				local var_284_9 = (arg_281_1.time_ - var_284_7) / var_284_8

				if arg_281_1.var_.characterEffect10014ui_story and not isNil(var_284_6) then
					arg_281_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_7 + var_284_8 and arg_281_1.time_ < var_284_7 + var_284_8 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10014ui_story then
				arg_281_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_284_10 = 0
			local var_284_11 = 0.775

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_12 = arg_281_1:FormatText(StoryNameCfg[264].name)

				arg_281_1.leftNameTxt_.text = var_284_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_13 = arg_281_1:GetWordFromCfg(411041067)
				local var_284_14 = arg_281_1:FormatText(var_284_13.content)

				arg_281_1.text_.text = var_284_14

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_15 = 31
				local var_284_16 = utf8.len(var_284_14)
				local var_284_17 = var_284_15 <= 0 and var_284_11 or var_284_11 * (var_284_16 / var_284_15)

				if var_284_17 > 0 and var_284_11 < var_284_17 then
					arg_281_1.talkMaxDuration = var_284_17

					if var_284_17 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_17 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_14
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041067", "story_v_out_411041.awb") ~= 0 then
					local var_284_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041067", "story_v_out_411041.awb") / 1000

					if var_284_18 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_18 + var_284_10
					end

					if var_284_13.prefab_name ~= "" and arg_281_1.actors_[var_284_13.prefab_name] ~= nil then
						local var_284_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_13.prefab_name].transform, "story_v_out_411041", "411041067", "story_v_out_411041.awb")

						arg_281_1:RecordAudio("411041067", var_284_19)
						arg_281_1:RecordAudio("411041067", var_284_19)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_411041", "411041067", "story_v_out_411041.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_411041", "411041067", "story_v_out_411041.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_20 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_20 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_10) / var_284_20

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_10 + var_284_20 and arg_281_1.time_ < var_284_10 + var_284_20 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play411041068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411041068
		arg_285_1.duration_ = 3.13

		local var_285_0 = {
			zh = 2.7,
			ja = 3.133
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play411041069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1095ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1095ui_story == nil then
				arg_285_1.var_.characterEffect1095ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1095ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1095ui_story then
				arg_285_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["10014ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10014ui_story == nil then
				arg_285_1.var_.characterEffect10014ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect10014ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10014ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10014ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10014ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0
			local var_288_11 = 0.35

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_12 = arg_285_1:FormatText(StoryNameCfg[471].name)

				arg_285_1.leftNameTxt_.text = var_288_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(411041068)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_15 = 14
				local var_288_16 = utf8.len(var_288_14)
				local var_288_17 = var_288_15 <= 0 and var_288_11 or var_288_11 * (var_288_16 / var_288_15)

				if var_288_17 > 0 and var_288_11 < var_288_17 then
					arg_285_1.talkMaxDuration = var_288_17

					if var_288_17 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_10
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041068", "story_v_out_411041.awb") ~= 0 then
					local var_288_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041068", "story_v_out_411041.awb") / 1000

					if var_288_18 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_10
					end

					if var_288_13.prefab_name ~= "" and arg_285_1.actors_[var_288_13.prefab_name] ~= nil then
						local var_288_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_13.prefab_name].transform, "story_v_out_411041", "411041068", "story_v_out_411041.awb")

						arg_285_1:RecordAudio("411041068", var_288_19)
						arg_285_1:RecordAudio("411041068", var_288_19)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_411041", "411041068", "story_v_out_411041.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_411041", "411041068", "story_v_out_411041.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_20 = math.max(var_288_11, arg_285_1.talkMaxDuration)

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_20 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_10) / var_288_20

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_10 + var_288_20 and arg_285_1.time_ < var_288_10 + var_288_20 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play411041069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 411041069
		arg_289_1.duration_ = 4.87

		local var_289_0 = {
			zh = 4.866,
			ja = 1.999999999999
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play411041070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10014ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10014ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0.7, -1.06, -6.2)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10014ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["10014ui_story"]
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect10014ui_story == nil then
				arg_289_1.var_.characterEffect10014ui_story = var_292_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_11 = 0.200000002980232

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 and not isNil(var_292_9) then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11

				if arg_289_1.var_.characterEffect10014ui_story and not isNil(var_292_9) then
					arg_289_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 and not isNil(var_292_9) and arg_289_1.var_.characterEffect10014ui_story then
				arg_289_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_292_13 = 0

			if var_292_13 < arg_289_1.time_ and arg_289_1.time_ <= var_292_13 + arg_292_0 then
				arg_289_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_292_14 = 0

			if var_292_14 < arg_289_1.time_ and arg_289_1.time_ <= var_292_14 + arg_292_0 then
				arg_289_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_15 = arg_289_1.actors_["1095ui_story"]
			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect1095ui_story == nil then
				arg_289_1.var_.characterEffect1095ui_story = var_292_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_17 = 0.200000002980232

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 and not isNil(var_292_15) then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17

				if arg_289_1.var_.characterEffect1095ui_story and not isNil(var_292_15) then
					local var_292_19 = Mathf.Lerp(0, 0.5, var_292_18)

					arg_289_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1095ui_story.fillRatio = var_292_19
				end
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 and not isNil(var_292_15) and arg_289_1.var_.characterEffect1095ui_story then
				local var_292_20 = 0.5

				arg_289_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1095ui_story.fillRatio = var_292_20
			end

			local var_292_21 = 0
			local var_292_22 = 0.575

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_23 = arg_289_1:FormatText(StoryNameCfg[264].name)

				arg_289_1.leftNameTxt_.text = var_292_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_24 = arg_289_1:GetWordFromCfg(411041069)
				local var_292_25 = arg_289_1:FormatText(var_292_24.content)

				arg_289_1.text_.text = var_292_25

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_26 = 23
				local var_292_27 = utf8.len(var_292_25)
				local var_292_28 = var_292_26 <= 0 and var_292_22 or var_292_22 * (var_292_27 / var_292_26)

				if var_292_28 > 0 and var_292_22 < var_292_28 then
					arg_289_1.talkMaxDuration = var_292_28

					if var_292_28 + var_292_21 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_28 + var_292_21
					end
				end

				arg_289_1.text_.text = var_292_25
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041069", "story_v_out_411041.awb") ~= 0 then
					local var_292_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041069", "story_v_out_411041.awb") / 1000

					if var_292_29 + var_292_21 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_29 + var_292_21
					end

					if var_292_24.prefab_name ~= "" and arg_289_1.actors_[var_292_24.prefab_name] ~= nil then
						local var_292_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_24.prefab_name].transform, "story_v_out_411041", "411041069", "story_v_out_411041.awb")

						arg_289_1:RecordAudio("411041069", var_292_30)
						arg_289_1:RecordAudio("411041069", var_292_30)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_411041", "411041069", "story_v_out_411041.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_411041", "411041069", "story_v_out_411041.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_31 = math.max(var_292_22, arg_289_1.talkMaxDuration)

			if var_292_21 <= arg_289_1.time_ and arg_289_1.time_ < var_292_21 + var_292_31 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_21) / var_292_31

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_21 + var_292_31 and arg_289_1.time_ < var_292_21 + var_292_31 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play411041070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 411041070
		arg_293_1.duration_ = 3.83

		local var_293_0 = {
			zh = 3.033,
			ja = 3.833
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play411041071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1095ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1095ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1095ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1095ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1095ui_story == nil then
				arg_293_1.var_.characterEffect1095ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1095ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1095ui_story then
				arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_15 = arg_293_1.actors_["10014ui_story"]
			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect10014ui_story == nil then
				arg_293_1.var_.characterEffect10014ui_story = var_296_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_17 = 0.200000002980232

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 and not isNil(var_296_15) then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17

				if arg_293_1.var_.characterEffect10014ui_story and not isNil(var_296_15) then
					local var_296_19 = Mathf.Lerp(0, 0.5, var_296_18)

					arg_293_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10014ui_story.fillRatio = var_296_19
				end
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 and not isNil(var_296_15) and arg_293_1.var_.characterEffect10014ui_story then
				local var_296_20 = 0.5

				arg_293_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10014ui_story.fillRatio = var_296_20
			end

			local var_296_21 = 0
			local var_296_22 = 0.4

			if var_296_21 < arg_293_1.time_ and arg_293_1.time_ <= var_296_21 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_23 = arg_293_1:FormatText(StoryNameCfg[471].name)

				arg_293_1.leftNameTxt_.text = var_296_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_24 = arg_293_1:GetWordFromCfg(411041070)
				local var_296_25 = arg_293_1:FormatText(var_296_24.content)

				arg_293_1.text_.text = var_296_25

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_26 = 16
				local var_296_27 = utf8.len(var_296_25)
				local var_296_28 = var_296_26 <= 0 and var_296_22 or var_296_22 * (var_296_27 / var_296_26)

				if var_296_28 > 0 and var_296_22 < var_296_28 then
					arg_293_1.talkMaxDuration = var_296_28

					if var_296_28 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_28 + var_296_21
					end
				end

				arg_293_1.text_.text = var_296_25
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041070", "story_v_out_411041.awb") ~= 0 then
					local var_296_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041070", "story_v_out_411041.awb") / 1000

					if var_296_29 + var_296_21 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_29 + var_296_21
					end

					if var_296_24.prefab_name ~= "" and arg_293_1.actors_[var_296_24.prefab_name] ~= nil then
						local var_296_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_24.prefab_name].transform, "story_v_out_411041", "411041070", "story_v_out_411041.awb")

						arg_293_1:RecordAudio("411041070", var_296_30)
						arg_293_1:RecordAudio("411041070", var_296_30)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_411041", "411041070", "story_v_out_411041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_411041", "411041070", "story_v_out_411041.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_31 = math.max(var_296_22, arg_293_1.talkMaxDuration)

			if var_296_21 <= arg_293_1.time_ and arg_293_1.time_ < var_296_21 + var_296_31 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_21) / var_296_31

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_21 + var_296_31 and arg_293_1.time_ < var_296_21 + var_296_31 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play411041071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 411041071
		arg_297_1.duration_ = 7.63

		local var_297_0 = {
			zh = 7.2,
			ja = 7.633
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play411041072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10014ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos10014ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0.7, -1.06, -6.2)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10014ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["10014ui_story"]
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect10014ui_story == nil then
				arg_297_1.var_.characterEffect10014ui_story = var_300_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_11 = 0.200000002980232

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 and not isNil(var_300_9) then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11

				if arg_297_1.var_.characterEffect10014ui_story and not isNil(var_300_9) then
					arg_297_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 and not isNil(var_300_9) and arg_297_1.var_.characterEffect10014ui_story then
				arg_297_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_300_13 = 0

			if var_300_13 < arg_297_1.time_ and arg_297_1.time_ <= var_300_13 + arg_300_0 then
				arg_297_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_300_14 = 0

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_300_15 = arg_297_1.actors_["1095ui_story"]
			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1095ui_story == nil then
				arg_297_1.var_.characterEffect1095ui_story = var_300_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_17 = 0.200000002980232

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 and not isNil(var_300_15) then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17

				if arg_297_1.var_.characterEffect1095ui_story and not isNil(var_300_15) then
					local var_300_19 = Mathf.Lerp(0, 0.5, var_300_18)

					arg_297_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1095ui_story.fillRatio = var_300_19
				end
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1095ui_story then
				local var_300_20 = 0.5

				arg_297_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1095ui_story.fillRatio = var_300_20
			end

			local var_300_21 = 0
			local var_300_22 = 0.7

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_23 = arg_297_1:FormatText(StoryNameCfg[264].name)

				arg_297_1.leftNameTxt_.text = var_300_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_24 = arg_297_1:GetWordFromCfg(411041071)
				local var_300_25 = arg_297_1:FormatText(var_300_24.content)

				arg_297_1.text_.text = var_300_25

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_26 = 28
				local var_300_27 = utf8.len(var_300_25)
				local var_300_28 = var_300_26 <= 0 and var_300_22 or var_300_22 * (var_300_27 / var_300_26)

				if var_300_28 > 0 and var_300_22 < var_300_28 then
					arg_297_1.talkMaxDuration = var_300_28

					if var_300_28 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_28 + var_300_21
					end
				end

				arg_297_1.text_.text = var_300_25
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041071", "story_v_out_411041.awb") ~= 0 then
					local var_300_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041071", "story_v_out_411041.awb") / 1000

					if var_300_29 + var_300_21 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_29 + var_300_21
					end

					if var_300_24.prefab_name ~= "" and arg_297_1.actors_[var_300_24.prefab_name] ~= nil then
						local var_300_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_24.prefab_name].transform, "story_v_out_411041", "411041071", "story_v_out_411041.awb")

						arg_297_1:RecordAudio("411041071", var_300_30)
						arg_297_1:RecordAudio("411041071", var_300_30)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_411041", "411041071", "story_v_out_411041.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_411041", "411041071", "story_v_out_411041.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_31 = math.max(var_300_22, arg_297_1.talkMaxDuration)

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_31 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_21) / var_300_31

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_21 + var_300_31 and arg_297_1.time_ < var_300_21 + var_300_31 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play411041072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 411041072
		arg_301_1.duration_ = 7.6

		local var_301_0 = {
			zh = 7.6,
			ja = 5.366
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play411041073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.95

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[264].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(411041072)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 38
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041072", "story_v_out_411041.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041072", "story_v_out_411041.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_411041", "411041072", "story_v_out_411041.awb")

						arg_301_1:RecordAudio("411041072", var_304_9)
						arg_301_1:RecordAudio("411041072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_411041", "411041072", "story_v_out_411041.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_411041", "411041072", "story_v_out_411041.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play411041073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 411041073
		arg_305_1.duration_ = 7.6

		local var_305_0 = {
			zh = 4.933,
			ja = 7.6
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play411041074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.6

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[264].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:GetWordFromCfg(411041073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 24
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041073", "story_v_out_411041.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041073", "story_v_out_411041.awb") / 1000

					if var_308_8 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_0
					end

					if var_308_3.prefab_name ~= "" and arg_305_1.actors_[var_308_3.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_3.prefab_name].transform, "story_v_out_411041", "411041073", "story_v_out_411041.awb")

						arg_305_1:RecordAudio("411041073", var_308_9)
						arg_305_1:RecordAudio("411041073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_411041", "411041073", "story_v_out_411041.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_411041", "411041073", "story_v_out_411041.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_10 and arg_305_1.time_ < var_308_0 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play411041074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 411041074
		arg_309_1.duration_ = 7.83

		local var_309_0 = {
			zh = 6.566,
			ja = 7.833
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play411041075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.875

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[264].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:GetWordFromCfg(411041074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 35
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041074", "story_v_out_411041.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041074", "story_v_out_411041.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_411041", "411041074", "story_v_out_411041.awb")

						arg_309_1:RecordAudio("411041074", var_312_9)
						arg_309_1:RecordAudio("411041074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_411041", "411041074", "story_v_out_411041.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_411041", "411041074", "story_v_out_411041.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play411041075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 411041075
		arg_313_1.duration_ = 4.03

		local var_313_0 = {
			zh = 2,
			ja = 4.033
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play411041076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1095ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1095ui_story == nil then
				arg_313_1.var_.characterEffect1095ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1095ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1095ui_story then
				arg_313_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_6 = arg_313_1.actors_["10014ui_story"]
			local var_316_7 = 0

			if var_316_7 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect10014ui_story == nil then
				arg_313_1.var_.characterEffect10014ui_story = var_316_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_8 = 0.200000002980232

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_8 and not isNil(var_316_6) then
				local var_316_9 = (arg_313_1.time_ - var_316_7) / var_316_8

				if arg_313_1.var_.characterEffect10014ui_story and not isNil(var_316_6) then
					local var_316_10 = Mathf.Lerp(0, 0.5, var_316_9)

					arg_313_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_313_1.var_.characterEffect10014ui_story.fillRatio = var_316_10
				end
			end

			if arg_313_1.time_ >= var_316_7 + var_316_8 and arg_313_1.time_ < var_316_7 + var_316_8 + arg_316_0 and not isNil(var_316_6) and arg_313_1.var_.characterEffect10014ui_story then
				local var_316_11 = 0.5

				arg_313_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_313_1.var_.characterEffect10014ui_story.fillRatio = var_316_11
			end

			local var_316_12 = 0
			local var_316_13 = 0.25

			if var_316_12 < arg_313_1.time_ and arg_313_1.time_ <= var_316_12 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_14 = arg_313_1:FormatText(StoryNameCfg[471].name)

				arg_313_1.leftNameTxt_.text = var_316_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_15 = arg_313_1:GetWordFromCfg(411041075)
				local var_316_16 = arg_313_1:FormatText(var_316_15.content)

				arg_313_1.text_.text = var_316_16

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_17 = 10
				local var_316_18 = utf8.len(var_316_16)
				local var_316_19 = var_316_17 <= 0 and var_316_13 or var_316_13 * (var_316_18 / var_316_17)

				if var_316_19 > 0 and var_316_13 < var_316_19 then
					arg_313_1.talkMaxDuration = var_316_19

					if var_316_19 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_19 + var_316_12
					end
				end

				arg_313_1.text_.text = var_316_16
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041075", "story_v_out_411041.awb") ~= 0 then
					local var_316_20 = manager.audio:GetVoiceLength("story_v_out_411041", "411041075", "story_v_out_411041.awb") / 1000

					if var_316_20 + var_316_12 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_20 + var_316_12
					end

					if var_316_15.prefab_name ~= "" and arg_313_1.actors_[var_316_15.prefab_name] ~= nil then
						local var_316_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_15.prefab_name].transform, "story_v_out_411041", "411041075", "story_v_out_411041.awb")

						arg_313_1:RecordAudio("411041075", var_316_21)
						arg_313_1:RecordAudio("411041075", var_316_21)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_411041", "411041075", "story_v_out_411041.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_411041", "411041075", "story_v_out_411041.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_22 = math.max(var_316_13, arg_313_1.talkMaxDuration)

			if var_316_12 <= arg_313_1.time_ and arg_313_1.time_ < var_316_12 + var_316_22 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_12) / var_316_22

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_12 + var_316_22 and arg_313_1.time_ < var_316_12 + var_316_22 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play411041076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 411041076
		arg_317_1.duration_ = 6.07

		local var_317_0 = {
			zh = 2.366,
			ja = 6.066
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play411041077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10014ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos10014ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0.7, -1.06, -6.2)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10014ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = arg_317_1.actors_["10014ui_story"]
			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect10014ui_story == nil then
				arg_317_1.var_.characterEffect10014ui_story = var_320_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_11 = 0.200000002980232

			if var_320_10 <= arg_317_1.time_ and arg_317_1.time_ < var_320_10 + var_320_11 and not isNil(var_320_9) then
				local var_320_12 = (arg_317_1.time_ - var_320_10) / var_320_11

				if arg_317_1.var_.characterEffect10014ui_story and not isNil(var_320_9) then
					arg_317_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_10 + var_320_11 and arg_317_1.time_ < var_320_10 + var_320_11 + arg_320_0 and not isNil(var_320_9) and arg_317_1.var_.characterEffect10014ui_story then
				arg_317_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_320_13 = 0

			if var_320_13 < arg_317_1.time_ and arg_317_1.time_ <= var_320_13 + arg_320_0 then
				arg_317_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action434")
			end

			local var_320_14 = 0

			if var_320_14 < arg_317_1.time_ and arg_317_1.time_ <= var_320_14 + arg_320_0 then
				arg_317_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_15 = arg_317_1.actors_["1095ui_story"]
			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 and not isNil(var_320_15) and arg_317_1.var_.characterEffect1095ui_story == nil then
				arg_317_1.var_.characterEffect1095ui_story = var_320_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_17 = 0.200000002980232

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_17 and not isNil(var_320_15) then
				local var_320_18 = (arg_317_1.time_ - var_320_16) / var_320_17

				if arg_317_1.var_.characterEffect1095ui_story and not isNil(var_320_15) then
					local var_320_19 = Mathf.Lerp(0, 0.5, var_320_18)

					arg_317_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1095ui_story.fillRatio = var_320_19
				end
			end

			if arg_317_1.time_ >= var_320_16 + var_320_17 and arg_317_1.time_ < var_320_16 + var_320_17 + arg_320_0 and not isNil(var_320_15) and arg_317_1.var_.characterEffect1095ui_story then
				local var_320_20 = 0.5

				arg_317_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1095ui_story.fillRatio = var_320_20
			end

			local var_320_21 = 0
			local var_320_22 = 0.275

			if var_320_21 < arg_317_1.time_ and arg_317_1.time_ <= var_320_21 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_23 = arg_317_1:FormatText(StoryNameCfg[264].name)

				arg_317_1.leftNameTxt_.text = var_320_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_24 = arg_317_1:GetWordFromCfg(411041076)
				local var_320_25 = arg_317_1:FormatText(var_320_24.content)

				arg_317_1.text_.text = var_320_25

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_26 = 11
				local var_320_27 = utf8.len(var_320_25)
				local var_320_28 = var_320_26 <= 0 and var_320_22 or var_320_22 * (var_320_27 / var_320_26)

				if var_320_28 > 0 and var_320_22 < var_320_28 then
					arg_317_1.talkMaxDuration = var_320_28

					if var_320_28 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_28 + var_320_21
					end
				end

				arg_317_1.text_.text = var_320_25
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041076", "story_v_out_411041.awb") ~= 0 then
					local var_320_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041076", "story_v_out_411041.awb") / 1000

					if var_320_29 + var_320_21 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_29 + var_320_21
					end

					if var_320_24.prefab_name ~= "" and arg_317_1.actors_[var_320_24.prefab_name] ~= nil then
						local var_320_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_24.prefab_name].transform, "story_v_out_411041", "411041076", "story_v_out_411041.awb")

						arg_317_1:RecordAudio("411041076", var_320_30)
						arg_317_1:RecordAudio("411041076", var_320_30)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_411041", "411041076", "story_v_out_411041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_411041", "411041076", "story_v_out_411041.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_31 = math.max(var_320_22, arg_317_1.talkMaxDuration)

			if var_320_21 <= arg_317_1.time_ and arg_317_1.time_ < var_320_21 + var_320_31 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_21) / var_320_31

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_21 + var_320_31 and arg_317_1.time_ < var_320_21 + var_320_31 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play411041077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 411041077
		arg_321_1.duration_ = 13.97

		local var_321_0 = {
			zh = 13.966,
			ja = 13.833
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play411041078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10014ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10014ui_story == nil then
				arg_321_1.var_.characterEffect10014ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect10014ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10014ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10014ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10014ui_story.fillRatio = var_324_5
			end

			local var_324_6 = arg_321_1.actors_["1095ui_story"]
			local var_324_7 = 0

			if var_324_7 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1095ui_story == nil then
				arg_321_1.var_.characterEffect1095ui_story = var_324_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_8 = 0.200000002980232

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_8 and not isNil(var_324_6) then
				local var_324_9 = (arg_321_1.time_ - var_324_7) / var_324_8

				if arg_321_1.var_.characterEffect1095ui_story and not isNil(var_324_6) then
					arg_321_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_7 + var_324_8 and arg_321_1.time_ < var_324_7 + var_324_8 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect1095ui_story then
				arg_321_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_324_10 = 0
			local var_324_11 = 1.45

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_12 = arg_321_1:FormatText(StoryNameCfg[471].name)

				arg_321_1.leftNameTxt_.text = var_324_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_13 = arg_321_1:GetWordFromCfg(411041077)
				local var_324_14 = arg_321_1:FormatText(var_324_13.content)

				arg_321_1.text_.text = var_324_14

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_15 = 58
				local var_324_16 = utf8.len(var_324_14)
				local var_324_17 = var_324_15 <= 0 and var_324_11 or var_324_11 * (var_324_16 / var_324_15)

				if var_324_17 > 0 and var_324_11 < var_324_17 then
					arg_321_1.talkMaxDuration = var_324_17

					if var_324_17 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_17 + var_324_10
					end
				end

				arg_321_1.text_.text = var_324_14
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041077", "story_v_out_411041.awb") ~= 0 then
					local var_324_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041077", "story_v_out_411041.awb") / 1000

					if var_324_18 + var_324_10 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_18 + var_324_10
					end

					if var_324_13.prefab_name ~= "" and arg_321_1.actors_[var_324_13.prefab_name] ~= nil then
						local var_324_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_13.prefab_name].transform, "story_v_out_411041", "411041077", "story_v_out_411041.awb")

						arg_321_1:RecordAudio("411041077", var_324_19)
						arg_321_1:RecordAudio("411041077", var_324_19)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_411041", "411041077", "story_v_out_411041.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_411041", "411041077", "story_v_out_411041.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_20 = math.max(var_324_11, arg_321_1.talkMaxDuration)

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_20 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_10) / var_324_20

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_10 + var_324_20 and arg_321_1.time_ < var_324_10 + var_324_20 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play411041078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 411041078
		arg_325_1.duration_ = 10.7

		local var_325_0 = {
			zh = 10.7,
			ja = 10.033
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play411041079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1095ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1095ui_story == nil then
				arg_325_1.var_.characterEffect1095ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1095ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1095ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1095ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1095ui_story.fillRatio = var_328_5
			end

			local var_328_6 = arg_325_1.actors_["10014ui_story"]
			local var_328_7 = 0

			if var_328_7 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect10014ui_story == nil then
				arg_325_1.var_.characterEffect10014ui_story = var_328_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_8 = 0.200000002980232

			if var_328_7 <= arg_325_1.time_ and arg_325_1.time_ < var_328_7 + var_328_8 and not isNil(var_328_6) then
				local var_328_9 = (arg_325_1.time_ - var_328_7) / var_328_8

				if arg_325_1.var_.characterEffect10014ui_story and not isNil(var_328_6) then
					arg_325_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_7 + var_328_8 and arg_325_1.time_ < var_328_7 + var_328_8 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect10014ui_story then
				arg_325_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_328_10 = 0
			local var_328_11 = 1.3

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_12 = arg_325_1:FormatText(StoryNameCfg[264].name)

				arg_325_1.leftNameTxt_.text = var_328_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_13 = arg_325_1:GetWordFromCfg(411041078)
				local var_328_14 = arg_325_1:FormatText(var_328_13.content)

				arg_325_1.text_.text = var_328_14

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_15 = 51
				local var_328_16 = utf8.len(var_328_14)
				local var_328_17 = var_328_15 <= 0 and var_328_11 or var_328_11 * (var_328_16 / var_328_15)

				if var_328_17 > 0 and var_328_11 < var_328_17 then
					arg_325_1.talkMaxDuration = var_328_17

					if var_328_17 + var_328_10 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_17 + var_328_10
					end
				end

				arg_325_1.text_.text = var_328_14
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041078", "story_v_out_411041.awb") ~= 0 then
					local var_328_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041078", "story_v_out_411041.awb") / 1000

					if var_328_18 + var_328_10 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_10
					end

					if var_328_13.prefab_name ~= "" and arg_325_1.actors_[var_328_13.prefab_name] ~= nil then
						local var_328_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_13.prefab_name].transform, "story_v_out_411041", "411041078", "story_v_out_411041.awb")

						arg_325_1:RecordAudio("411041078", var_328_19)
						arg_325_1:RecordAudio("411041078", var_328_19)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_411041", "411041078", "story_v_out_411041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_411041", "411041078", "story_v_out_411041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = math.max(var_328_11, arg_325_1.talkMaxDuration)

			if var_328_10 <= arg_325_1.time_ and arg_325_1.time_ < var_328_10 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_10) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_10 + var_328_20 and arg_325_1.time_ < var_328_10 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play411041079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 411041079
		arg_329_1.duration_ = 6.3

		local var_329_0 = {
			zh = 6.3,
			ja = 4.566
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play411041080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10014ui_story"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos10014ui_story = var_332_0.localPosition
			end

			local var_332_2 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2
				local var_332_4 = Vector3.New(0.7, -1.06, -6.2)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10014ui_story, var_332_4, var_332_3)

				local var_332_5 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_5.x, var_332_5.y, var_332_5.z)

				local var_332_6 = var_332_0.localEulerAngles

				var_332_6.z = 0
				var_332_6.x = 0
				var_332_0.localEulerAngles = var_332_6
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_332_7 = manager.ui.mainCamera.transform.position - var_332_0.position

				var_332_0.forward = Vector3.New(var_332_7.x, var_332_7.y, var_332_7.z)

				local var_332_8 = var_332_0.localEulerAngles

				var_332_8.z = 0
				var_332_8.x = 0
				var_332_0.localEulerAngles = var_332_8
			end

			local var_332_9 = 0
			local var_332_10 = 0.625

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_11 = arg_329_1:FormatText(StoryNameCfg[264].name)

				arg_329_1.leftNameTxt_.text = var_332_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_12 = arg_329_1:GetWordFromCfg(411041079)
				local var_332_13 = arg_329_1:FormatText(var_332_12.content)

				arg_329_1.text_.text = var_332_13

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_14 = 25
				local var_332_15 = utf8.len(var_332_13)
				local var_332_16 = var_332_14 <= 0 and var_332_10 or var_332_10 * (var_332_15 / var_332_14)

				if var_332_16 > 0 and var_332_10 < var_332_16 then
					arg_329_1.talkMaxDuration = var_332_16

					if var_332_16 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_16 + var_332_9
					end
				end

				arg_329_1.text_.text = var_332_13
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041079", "story_v_out_411041.awb") ~= 0 then
					local var_332_17 = manager.audio:GetVoiceLength("story_v_out_411041", "411041079", "story_v_out_411041.awb") / 1000

					if var_332_17 + var_332_9 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_17 + var_332_9
					end

					if var_332_12.prefab_name ~= "" and arg_329_1.actors_[var_332_12.prefab_name] ~= nil then
						local var_332_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_12.prefab_name].transform, "story_v_out_411041", "411041079", "story_v_out_411041.awb")

						arg_329_1:RecordAudio("411041079", var_332_18)
						arg_329_1:RecordAudio("411041079", var_332_18)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_411041", "411041079", "story_v_out_411041.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_411041", "411041079", "story_v_out_411041.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_19 = math.max(var_332_10, arg_329_1.talkMaxDuration)

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_19 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_9) / var_332_19

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_9 + var_332_19 and arg_329_1.time_ < var_332_9 + var_332_19 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play411041080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 411041080
		arg_333_1.duration_ = 7.03

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play411041081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = "ST71a"

			if arg_333_1.bgs_[var_336_0] == nil then
				local var_336_1 = Object.Instantiate(arg_333_1.paintGo_)

				var_336_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_336_0)
				var_336_1.name = var_336_0
				var_336_1.transform.parent = arg_333_1.stage_.transform
				var_336_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.bgs_[var_336_0] = var_336_1
			end

			local var_336_2 = 2

			if var_336_2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				local var_336_3 = manager.ui.mainCamera.transform.localPosition
				local var_336_4 = Vector3.New(0, 0, 10) + Vector3.New(var_336_3.x, var_336_3.y, 0)
				local var_336_5 = arg_333_1.bgs_.ST71a

				var_336_5.transform.localPosition = var_336_4
				var_336_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_6 = var_336_5:GetComponent("SpriteRenderer")

				if var_336_6 and var_336_6.sprite then
					local var_336_7 = (var_336_5.transform.localPosition - var_336_3).z
					local var_336_8 = manager.ui.mainCameraCom_
					local var_336_9 = 2 * var_336_7 * Mathf.Tan(var_336_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_336_10 = var_336_9 * var_336_8.aspect
					local var_336_11 = var_336_6.sprite.bounds.size.x
					local var_336_12 = var_336_6.sprite.bounds.size.y
					local var_336_13 = var_336_10 / var_336_11
					local var_336_14 = var_336_9 / var_336_12
					local var_336_15 = var_336_14 < var_336_13 and var_336_13 or var_336_14

					var_336_5.transform.localScale = Vector3.New(var_336_15, var_336_15, 0)
				end

				for iter_336_0, iter_336_1 in pairs(arg_333_1.bgs_) do
					if iter_336_0 ~= "ST71a" then
						iter_336_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_16 = 0

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_17 = 2

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_17 then
				local var_336_18 = (arg_333_1.time_ - var_336_16) / var_336_17
				local var_336_19 = Color.New(0, 0, 0)

				var_336_19.a = Mathf.Lerp(0, 1, var_336_18)
				arg_333_1.mask_.color = var_336_19
			end

			if arg_333_1.time_ >= var_336_16 + var_336_17 and arg_333_1.time_ < var_336_16 + var_336_17 + arg_336_0 then
				local var_336_20 = Color.New(0, 0, 0)

				var_336_20.a = 1
				arg_333_1.mask_.color = var_336_20
			end

			local var_336_21 = 2

			if var_336_21 < arg_333_1.time_ and arg_333_1.time_ <= var_336_21 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_22 = 2

			if var_336_21 <= arg_333_1.time_ and arg_333_1.time_ < var_336_21 + var_336_22 then
				local var_336_23 = (arg_333_1.time_ - var_336_21) / var_336_22
				local var_336_24 = Color.New(0, 0, 0)

				var_336_24.a = Mathf.Lerp(1, 0, var_336_23)
				arg_333_1.mask_.color = var_336_24
			end

			if arg_333_1.time_ >= var_336_21 + var_336_22 and arg_333_1.time_ < var_336_21 + var_336_22 + arg_336_0 then
				local var_336_25 = Color.New(0, 0, 0)
				local var_336_26 = 0

				arg_333_1.mask_.enabled = false
				var_336_25.a = var_336_26
				arg_333_1.mask_.color = var_336_25
			end

			local var_336_27 = arg_333_1.actors_["1095ui_story"].transform
			local var_336_28 = 2

			if var_336_28 < arg_333_1.time_ and arg_333_1.time_ <= var_336_28 + arg_336_0 then
				arg_333_1.var_.moveOldPos1095ui_story = var_336_27.localPosition
			end

			local var_336_29 = 0.001

			if var_336_28 <= arg_333_1.time_ and arg_333_1.time_ < var_336_28 + var_336_29 then
				local var_336_30 = (arg_333_1.time_ - var_336_28) / var_336_29
				local var_336_31 = Vector3.New(0, 100, 0)

				var_336_27.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1095ui_story, var_336_31, var_336_30)

				local var_336_32 = manager.ui.mainCamera.transform.position - var_336_27.position

				var_336_27.forward = Vector3.New(var_336_32.x, var_336_32.y, var_336_32.z)

				local var_336_33 = var_336_27.localEulerAngles

				var_336_33.z = 0
				var_336_33.x = 0
				var_336_27.localEulerAngles = var_336_33
			end

			if arg_333_1.time_ >= var_336_28 + var_336_29 and arg_333_1.time_ < var_336_28 + var_336_29 + arg_336_0 then
				var_336_27.localPosition = Vector3.New(0, 100, 0)

				local var_336_34 = manager.ui.mainCamera.transform.position - var_336_27.position

				var_336_27.forward = Vector3.New(var_336_34.x, var_336_34.y, var_336_34.z)

				local var_336_35 = var_336_27.localEulerAngles

				var_336_35.z = 0
				var_336_35.x = 0
				var_336_27.localEulerAngles = var_336_35
			end

			local var_336_36 = arg_333_1.actors_["1095ui_story"]
			local var_336_37 = 2

			if var_336_37 < arg_333_1.time_ and arg_333_1.time_ <= var_336_37 + arg_336_0 and not isNil(var_336_36) and arg_333_1.var_.characterEffect1095ui_story == nil then
				arg_333_1.var_.characterEffect1095ui_story = var_336_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_38 = 0.200000002980232

			if var_336_37 <= arg_333_1.time_ and arg_333_1.time_ < var_336_37 + var_336_38 and not isNil(var_336_36) then
				local var_336_39 = (arg_333_1.time_ - var_336_37) / var_336_38

				if arg_333_1.var_.characterEffect1095ui_story and not isNil(var_336_36) then
					local var_336_40 = Mathf.Lerp(0, 0.5, var_336_39)

					arg_333_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1095ui_story.fillRatio = var_336_40
				end
			end

			if arg_333_1.time_ >= var_336_37 + var_336_38 and arg_333_1.time_ < var_336_37 + var_336_38 + arg_336_0 and not isNil(var_336_36) and arg_333_1.var_.characterEffect1095ui_story then
				local var_336_41 = 0.5

				arg_333_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1095ui_story.fillRatio = var_336_41
			end

			local var_336_42 = arg_333_1.actors_["10014ui_story"].transform
			local var_336_43 = 2

			if var_336_43 < arg_333_1.time_ and arg_333_1.time_ <= var_336_43 + arg_336_0 then
				arg_333_1.var_.moveOldPos10014ui_story = var_336_42.localPosition
			end

			local var_336_44 = 0.001

			if var_336_43 <= arg_333_1.time_ and arg_333_1.time_ < var_336_43 + var_336_44 then
				local var_336_45 = (arg_333_1.time_ - var_336_43) / var_336_44
				local var_336_46 = Vector3.New(0, 100, 0)

				var_336_42.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10014ui_story, var_336_46, var_336_45)

				local var_336_47 = manager.ui.mainCamera.transform.position - var_336_42.position

				var_336_42.forward = Vector3.New(var_336_47.x, var_336_47.y, var_336_47.z)

				local var_336_48 = var_336_42.localEulerAngles

				var_336_48.z = 0
				var_336_48.x = 0
				var_336_42.localEulerAngles = var_336_48
			end

			if arg_333_1.time_ >= var_336_43 + var_336_44 and arg_333_1.time_ < var_336_43 + var_336_44 + arg_336_0 then
				var_336_42.localPosition = Vector3.New(0, 100, 0)

				local var_336_49 = manager.ui.mainCamera.transform.position - var_336_42.position

				var_336_42.forward = Vector3.New(var_336_49.x, var_336_49.y, var_336_49.z)

				local var_336_50 = var_336_42.localEulerAngles

				var_336_50.z = 0
				var_336_50.x = 0
				var_336_42.localEulerAngles = var_336_50
			end

			local var_336_51 = arg_333_1.actors_["10014ui_story"]
			local var_336_52 = 2

			if var_336_52 < arg_333_1.time_ and arg_333_1.time_ <= var_336_52 + arg_336_0 and not isNil(var_336_51) and arg_333_1.var_.characterEffect10014ui_story == nil then
				arg_333_1.var_.characterEffect10014ui_story = var_336_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_53 = 0.200000002980232

			if var_336_52 <= arg_333_1.time_ and arg_333_1.time_ < var_336_52 + var_336_53 and not isNil(var_336_51) then
				local var_336_54 = (arg_333_1.time_ - var_336_52) / var_336_53

				if arg_333_1.var_.characterEffect10014ui_story and not isNil(var_336_51) then
					local var_336_55 = Mathf.Lerp(0, 0.5, var_336_54)

					arg_333_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_333_1.var_.characterEffect10014ui_story.fillRatio = var_336_55
				end
			end

			if arg_333_1.time_ >= var_336_52 + var_336_53 and arg_333_1.time_ < var_336_52 + var_336_53 + arg_336_0 and not isNil(var_336_51) and arg_333_1.var_.characterEffect10014ui_story then
				local var_336_56 = 0.5

				arg_333_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_333_1.var_.characterEffect10014ui_story.fillRatio = var_336_56
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_57 = 2.03400000184774
			local var_336_58 = 1.1

			if var_336_57 < arg_333_1.time_ and arg_333_1.time_ <= var_336_57 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_59 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_59:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_60 = arg_333_1:GetWordFromCfg(411041080)
				local var_336_61 = arg_333_1:FormatText(var_336_60.content)

				arg_333_1.text_.text = var_336_61

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_62 = 44
				local var_336_63 = utf8.len(var_336_61)
				local var_336_64 = var_336_62 <= 0 and var_336_58 or var_336_58 * (var_336_63 / var_336_62)

				if var_336_64 > 0 and var_336_58 < var_336_64 then
					arg_333_1.talkMaxDuration = var_336_64
					var_336_57 = var_336_57 + 0.3

					if var_336_64 + var_336_57 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_64 + var_336_57
					end
				end

				arg_333_1.text_.text = var_336_61
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_65 = var_336_57 + 0.3
			local var_336_66 = math.max(var_336_58, arg_333_1.talkMaxDuration)

			if var_336_65 <= arg_333_1.time_ and arg_333_1.time_ < var_336_65 + var_336_66 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_65) / var_336_66

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_65 + var_336_66 and arg_333_1.time_ < var_336_65 + var_336_66 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play411041081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411041081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play411041082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.625

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_2 = arg_339_1:GetWordFromCfg(411041081)
				local var_342_3 = arg_339_1:FormatText(var_342_2.content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 25
				local var_342_5 = utf8.len(var_342_3)
				local var_342_6 = var_342_4 <= 0 and var_342_1 or var_342_1 * (var_342_5 / var_342_4)

				if var_342_6 > 0 and var_342_1 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_7 and arg_339_1.time_ < var_342_0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play411041082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411041082
		arg_343_1.duration_ = 4.8

		local var_343_0 = {
			zh = 4.8,
			ja = 1.999999999999
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411041083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10071ui_story"].transform
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.var_.moveOldPos10071ui_story = var_346_0.localPosition
			end

			local var_346_2 = 0.001

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2
				local var_346_4 = Vector3.New(0, -0.9, -6.26)

				var_346_0.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10071ui_story, var_346_4, var_346_3)

				local var_346_5 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_5.x, var_346_5.y, var_346_5.z)

				local var_346_6 = var_346_0.localEulerAngles

				var_346_6.z = 0
				var_346_6.x = 0
				var_346_0.localEulerAngles = var_346_6
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 then
				var_346_0.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_346_7 = manager.ui.mainCamera.transform.position - var_346_0.position

				var_346_0.forward = Vector3.New(var_346_7.x, var_346_7.y, var_346_7.z)

				local var_346_8 = var_346_0.localEulerAngles

				var_346_8.z = 0
				var_346_8.x = 0
				var_346_0.localEulerAngles = var_346_8
			end

			local var_346_9 = arg_343_1.actors_["10071ui_story"]
			local var_346_10 = 0

			if var_346_10 < arg_343_1.time_ and arg_343_1.time_ <= var_346_10 + arg_346_0 and not isNil(var_346_9) and arg_343_1.var_.characterEffect10071ui_story == nil then
				arg_343_1.var_.characterEffect10071ui_story = var_346_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_11 = 0.200000002980232

			if var_346_10 <= arg_343_1.time_ and arg_343_1.time_ < var_346_10 + var_346_11 and not isNil(var_346_9) then
				local var_346_12 = (arg_343_1.time_ - var_346_10) / var_346_11

				if arg_343_1.var_.characterEffect10071ui_story and not isNil(var_346_9) then
					arg_343_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= var_346_10 + var_346_11 and arg_343_1.time_ < var_346_10 + var_346_11 + arg_346_0 and not isNil(var_346_9) and arg_343_1.var_.characterEffect10071ui_story then
				arg_343_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_346_13 = 0

			if var_346_13 < arg_343_1.time_ and arg_343_1.time_ <= var_346_13 + arg_346_0 then
				arg_343_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_346_14 = 0

			if var_346_14 < arg_343_1.time_ and arg_343_1.time_ <= var_346_14 + arg_346_0 then
				arg_343_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_346_15 = 0
			local var_346_16 = 0.125

			if var_346_15 < arg_343_1.time_ and arg_343_1.time_ <= var_346_15 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_17 = arg_343_1:FormatText(StoryNameCfg[670].name)

				arg_343_1.leftNameTxt_.text = var_346_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_18 = arg_343_1:GetWordFromCfg(411041082)
				local var_346_19 = arg_343_1:FormatText(var_346_18.content)

				arg_343_1.text_.text = var_346_19

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_20 = 5
				local var_346_21 = utf8.len(var_346_19)
				local var_346_22 = var_346_20 <= 0 and var_346_16 or var_346_16 * (var_346_21 / var_346_20)

				if var_346_22 > 0 and var_346_16 < var_346_22 then
					arg_343_1.talkMaxDuration = var_346_22

					if var_346_22 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_22 + var_346_15
					end
				end

				arg_343_1.text_.text = var_346_19
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041082", "story_v_out_411041.awb") ~= 0 then
					local var_346_23 = manager.audio:GetVoiceLength("story_v_out_411041", "411041082", "story_v_out_411041.awb") / 1000

					if var_346_23 + var_346_15 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_15
					end

					if var_346_18.prefab_name ~= "" and arg_343_1.actors_[var_346_18.prefab_name] ~= nil then
						local var_346_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_18.prefab_name].transform, "story_v_out_411041", "411041082", "story_v_out_411041.awb")

						arg_343_1:RecordAudio("411041082", var_346_24)
						arg_343_1:RecordAudio("411041082", var_346_24)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_411041", "411041082", "story_v_out_411041.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_411041", "411041082", "story_v_out_411041.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_25 = math.max(var_346_16, arg_343_1.talkMaxDuration)

			if var_346_15 <= arg_343_1.time_ and arg_343_1.time_ < var_346_15 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_15) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_15 + var_346_25 and arg_343_1.time_ < var_346_15 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play411041083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411041083
		arg_347_1.duration_ = 2.5

		local var_347_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play411041084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1095ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1095ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(0.7, -0.98, -6.1)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1095ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = arg_347_1.actors_["1095ui_story"]
			local var_350_10 = 0

			if var_350_10 < arg_347_1.time_ and arg_347_1.time_ <= var_350_10 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect1095ui_story == nil then
				arg_347_1.var_.characterEffect1095ui_story = var_350_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_11 = 0.200000002980232

			if var_350_10 <= arg_347_1.time_ and arg_347_1.time_ < var_350_10 + var_350_11 and not isNil(var_350_9) then
				local var_350_12 = (arg_347_1.time_ - var_350_10) / var_350_11

				if arg_347_1.var_.characterEffect1095ui_story and not isNil(var_350_9) then
					arg_347_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_10 + var_350_11 and arg_347_1.time_ < var_350_10 + var_350_11 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect1095ui_story then
				arg_347_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_350_13 = 0

			if var_350_13 < arg_347_1.time_ and arg_347_1.time_ <= var_350_13 + arg_350_0 then
				arg_347_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_350_14 = 0

			if var_350_14 < arg_347_1.time_ and arg_347_1.time_ <= var_350_14 + arg_350_0 then
				arg_347_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_350_15 = arg_347_1.actors_["10071ui_story"].transform
			local var_350_16 = 0

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.var_.moveOldPos10071ui_story = var_350_15.localPosition
			end

			local var_350_17 = 0.001

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_17 then
				local var_350_18 = (arg_347_1.time_ - var_350_16) / var_350_17
				local var_350_19 = Vector3.New(-0.7, -0.9, -6.26)

				var_350_15.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10071ui_story, var_350_19, var_350_18)

				local var_350_20 = manager.ui.mainCamera.transform.position - var_350_15.position

				var_350_15.forward = Vector3.New(var_350_20.x, var_350_20.y, var_350_20.z)

				local var_350_21 = var_350_15.localEulerAngles

				var_350_21.z = 0
				var_350_21.x = 0
				var_350_15.localEulerAngles = var_350_21
			end

			if arg_347_1.time_ >= var_350_16 + var_350_17 and arg_347_1.time_ < var_350_16 + var_350_17 + arg_350_0 then
				var_350_15.localPosition = Vector3.New(-0.7, -0.9, -6.26)

				local var_350_22 = manager.ui.mainCamera.transform.position - var_350_15.position

				var_350_15.forward = Vector3.New(var_350_22.x, var_350_22.y, var_350_22.z)

				local var_350_23 = var_350_15.localEulerAngles

				var_350_23.z = 0
				var_350_23.x = 0
				var_350_15.localEulerAngles = var_350_23
			end

			local var_350_24 = arg_347_1.actors_["10071ui_story"]
			local var_350_25 = 0

			if var_350_25 < arg_347_1.time_ and arg_347_1.time_ <= var_350_25 + arg_350_0 and not isNil(var_350_24) and arg_347_1.var_.characterEffect10071ui_story == nil then
				arg_347_1.var_.characterEffect10071ui_story = var_350_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_26 = 0.200000002980232

			if var_350_25 <= arg_347_1.time_ and arg_347_1.time_ < var_350_25 + var_350_26 and not isNil(var_350_24) then
				local var_350_27 = (arg_347_1.time_ - var_350_25) / var_350_26

				if arg_347_1.var_.characterEffect10071ui_story and not isNil(var_350_24) then
					local var_350_28 = Mathf.Lerp(0, 0.5, var_350_27)

					arg_347_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_347_1.var_.characterEffect10071ui_story.fillRatio = var_350_28
				end
			end

			if arg_347_1.time_ >= var_350_25 + var_350_26 and arg_347_1.time_ < var_350_25 + var_350_26 + arg_350_0 and not isNil(var_350_24) and arg_347_1.var_.characterEffect10071ui_story then
				local var_350_29 = 0.5

				arg_347_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_347_1.var_.characterEffect10071ui_story.fillRatio = var_350_29
			end

			local var_350_30 = 0
			local var_350_31 = 0.2

			if var_350_30 < arg_347_1.time_ and arg_347_1.time_ <= var_350_30 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_32 = arg_347_1:FormatText(StoryNameCfg[471].name)

				arg_347_1.leftNameTxt_.text = var_350_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_33 = arg_347_1:GetWordFromCfg(411041083)
				local var_350_34 = arg_347_1:FormatText(var_350_33.content)

				arg_347_1.text_.text = var_350_34

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_35 = 8
				local var_350_36 = utf8.len(var_350_34)
				local var_350_37 = var_350_35 <= 0 and var_350_31 or var_350_31 * (var_350_36 / var_350_35)

				if var_350_37 > 0 and var_350_31 < var_350_37 then
					arg_347_1.talkMaxDuration = var_350_37

					if var_350_37 + var_350_30 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_37 + var_350_30
					end
				end

				arg_347_1.text_.text = var_350_34
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041083", "story_v_out_411041.awb") ~= 0 then
					local var_350_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041083", "story_v_out_411041.awb") / 1000

					if var_350_38 + var_350_30 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_38 + var_350_30
					end

					if var_350_33.prefab_name ~= "" and arg_347_1.actors_[var_350_33.prefab_name] ~= nil then
						local var_350_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_33.prefab_name].transform, "story_v_out_411041", "411041083", "story_v_out_411041.awb")

						arg_347_1:RecordAudio("411041083", var_350_39)
						arg_347_1:RecordAudio("411041083", var_350_39)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_411041", "411041083", "story_v_out_411041.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_411041", "411041083", "story_v_out_411041.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_40 = math.max(var_350_31, arg_347_1.talkMaxDuration)

			if var_350_30 <= arg_347_1.time_ and arg_347_1.time_ < var_350_30 + var_350_40 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_30) / var_350_40

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_30 + var_350_40 and arg_347_1.time_ < var_350_30 + var_350_40 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play411041084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411041084
		arg_351_1.duration_ = 4.97

		local var_351_0 = {
			zh = 3.666,
			ja = 4.966
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411041085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10071ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos10071ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(-0.7, -0.9, -6.26)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10071ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(-0.7, -0.9, -6.26)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["10071ui_story"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect10071ui_story == nil then
				arg_351_1.var_.characterEffect10071ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect10071ui_story and not isNil(var_354_9) then
					arg_351_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect10071ui_story then
				arg_351_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_354_13 = 0

			if var_354_13 < arg_351_1.time_ and arg_351_1.time_ <= var_354_13 + arg_354_0 then
				arg_351_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_354_14 = arg_351_1.actors_["1095ui_story"]
			local var_354_15 = 0

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 and not isNil(var_354_14) and arg_351_1.var_.characterEffect1095ui_story == nil then
				arg_351_1.var_.characterEffect1095ui_story = var_354_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_16 = 0.200000002980232

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_16 and not isNil(var_354_14) then
				local var_354_17 = (arg_351_1.time_ - var_354_15) / var_354_16

				if arg_351_1.var_.characterEffect1095ui_story and not isNil(var_354_14) then
					local var_354_18 = Mathf.Lerp(0, 0.5, var_354_17)

					arg_351_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1095ui_story.fillRatio = var_354_18
				end
			end

			if arg_351_1.time_ >= var_354_15 + var_354_16 and arg_351_1.time_ < var_354_15 + var_354_16 + arg_354_0 and not isNil(var_354_14) and arg_351_1.var_.characterEffect1095ui_story then
				local var_354_19 = 0.5

				arg_351_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1095ui_story.fillRatio = var_354_19
			end

			local var_354_20 = 0
			local var_354_21 = 0.275

			if var_354_20 < arg_351_1.time_ and arg_351_1.time_ <= var_354_20 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_22 = arg_351_1:FormatText(StoryNameCfg[670].name)

				arg_351_1.leftNameTxt_.text = var_354_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_23 = arg_351_1:GetWordFromCfg(411041084)
				local var_354_24 = arg_351_1:FormatText(var_354_23.content)

				arg_351_1.text_.text = var_354_24

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_25 = 11
				local var_354_26 = utf8.len(var_354_24)
				local var_354_27 = var_354_25 <= 0 and var_354_21 or var_354_21 * (var_354_26 / var_354_25)

				if var_354_27 > 0 and var_354_21 < var_354_27 then
					arg_351_1.talkMaxDuration = var_354_27

					if var_354_27 + var_354_20 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_27 + var_354_20
					end
				end

				arg_351_1.text_.text = var_354_24
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041084", "story_v_out_411041.awb") ~= 0 then
					local var_354_28 = manager.audio:GetVoiceLength("story_v_out_411041", "411041084", "story_v_out_411041.awb") / 1000

					if var_354_28 + var_354_20 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_28 + var_354_20
					end

					if var_354_23.prefab_name ~= "" and arg_351_1.actors_[var_354_23.prefab_name] ~= nil then
						local var_354_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_23.prefab_name].transform, "story_v_out_411041", "411041084", "story_v_out_411041.awb")

						arg_351_1:RecordAudio("411041084", var_354_29)
						arg_351_1:RecordAudio("411041084", var_354_29)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_411041", "411041084", "story_v_out_411041.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_411041", "411041084", "story_v_out_411041.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_30 = math.max(var_354_21, arg_351_1.talkMaxDuration)

			if var_354_20 <= arg_351_1.time_ and arg_351_1.time_ < var_354_20 + var_354_30 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_20) / var_354_30

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_20 + var_354_30 and arg_351_1.time_ < var_354_20 + var_354_30 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play411041085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411041085
		arg_355_1.duration_ = 8.1

		local var_355_0 = {
			zh = 5.3,
			ja = 8.1
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411041086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10071ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect10071ui_story == nil then
				arg_355_1.var_.characterEffect10071ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect10071ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_355_1.var_.characterEffect10071ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect10071ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_355_1.var_.characterEffect10071ui_story.fillRatio = var_358_5
			end

			local var_358_6 = arg_355_1.actors_["1095ui_story"]
			local var_358_7 = 0

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 and not isNil(var_358_6) and arg_355_1.var_.characterEffect1095ui_story == nil then
				arg_355_1.var_.characterEffect1095ui_story = var_358_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_8 = 0.200000002980232

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_8 and not isNil(var_358_6) then
				local var_358_9 = (arg_355_1.time_ - var_358_7) / var_358_8

				if arg_355_1.var_.characterEffect1095ui_story and not isNil(var_358_6) then
					arg_355_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_7 + var_358_8 and arg_355_1.time_ < var_358_7 + var_358_8 + arg_358_0 and not isNil(var_358_6) and arg_355_1.var_.characterEffect1095ui_story then
				arg_355_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_358_10 = 0
			local var_358_11 = 0.525

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_12 = arg_355_1:FormatText(StoryNameCfg[471].name)

				arg_355_1.leftNameTxt_.text = var_358_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_13 = arg_355_1:GetWordFromCfg(411041085)
				local var_358_14 = arg_355_1:FormatText(var_358_13.content)

				arg_355_1.text_.text = var_358_14

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_15 = 21
				local var_358_16 = utf8.len(var_358_14)
				local var_358_17 = var_358_15 <= 0 and var_358_11 or var_358_11 * (var_358_16 / var_358_15)

				if var_358_17 > 0 and var_358_11 < var_358_17 then
					arg_355_1.talkMaxDuration = var_358_17

					if var_358_17 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_17 + var_358_10
					end
				end

				arg_355_1.text_.text = var_358_14
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041085", "story_v_out_411041.awb") ~= 0 then
					local var_358_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041085", "story_v_out_411041.awb") / 1000

					if var_358_18 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_18 + var_358_10
					end

					if var_358_13.prefab_name ~= "" and arg_355_1.actors_[var_358_13.prefab_name] ~= nil then
						local var_358_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_13.prefab_name].transform, "story_v_out_411041", "411041085", "story_v_out_411041.awb")

						arg_355_1:RecordAudio("411041085", var_358_19)
						arg_355_1:RecordAudio("411041085", var_358_19)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_411041", "411041085", "story_v_out_411041.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_411041", "411041085", "story_v_out_411041.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_20 = math.max(var_358_11, arg_355_1.talkMaxDuration)

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_20 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_10) / var_358_20

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_10 + var_358_20 and arg_355_1.time_ < var_358_10 + var_358_20 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play411041086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411041086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play411041087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1095ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1095ui_story == nil then
				arg_359_1.var_.characterEffect1095ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1095ui_story and not isNil(var_362_0) then
					local var_362_4 = Mathf.Lerp(0, 0.5, var_362_3)

					arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1095ui_story.fillRatio = var_362_4
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1095ui_story then
				local var_362_5 = 0.5

				arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1095ui_story.fillRatio = var_362_5
			end

			local var_362_6 = 0
			local var_362_7 = 0.85

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_8 = arg_359_1:GetWordFromCfg(411041086)
				local var_362_9 = arg_359_1:FormatText(var_362_8.content)

				arg_359_1.text_.text = var_362_9

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 34
				local var_362_11 = utf8.len(var_362_9)
				local var_362_12 = var_362_10 <= 0 and var_362_7 or var_362_7 * (var_362_11 / var_362_10)

				if var_362_12 > 0 and var_362_7 < var_362_12 then
					arg_359_1.talkMaxDuration = var_362_12

					if var_362_12 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_12 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_9
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_13 and arg_359_1.time_ < var_362_6 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play411041087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411041087
		arg_363_1.duration_ = 2

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play411041088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10071ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos10071ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(-0.7, -0.9, -6.26)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10071ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(-0.7, -0.9, -6.26)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["10071ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect10071ui_story == nil then
				arg_363_1.var_.characterEffect10071ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect10071ui_story and not isNil(var_366_9) then
					arg_363_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect10071ui_story then
				arg_363_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_366_13 = 0

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_366_14 = 0
			local var_366_15 = 0.1

			if var_366_14 < arg_363_1.time_ and arg_363_1.time_ <= var_366_14 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_16 = arg_363_1:FormatText(StoryNameCfg[670].name)

				arg_363_1.leftNameTxt_.text = var_366_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_17 = arg_363_1:GetWordFromCfg(411041087)
				local var_366_18 = arg_363_1:FormatText(var_366_17.content)

				arg_363_1.text_.text = var_366_18

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_19 = 4
				local var_366_20 = utf8.len(var_366_18)
				local var_366_21 = var_366_19 <= 0 and var_366_15 or var_366_15 * (var_366_20 / var_366_19)

				if var_366_21 > 0 and var_366_15 < var_366_21 then
					arg_363_1.talkMaxDuration = var_366_21

					if var_366_21 + var_366_14 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_21 + var_366_14
					end
				end

				arg_363_1.text_.text = var_366_18
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041087", "story_v_out_411041.awb") ~= 0 then
					local var_366_22 = manager.audio:GetVoiceLength("story_v_out_411041", "411041087", "story_v_out_411041.awb") / 1000

					if var_366_22 + var_366_14 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_14
					end

					if var_366_17.prefab_name ~= "" and arg_363_1.actors_[var_366_17.prefab_name] ~= nil then
						local var_366_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_17.prefab_name].transform, "story_v_out_411041", "411041087", "story_v_out_411041.awb")

						arg_363_1:RecordAudio("411041087", var_366_23)
						arg_363_1:RecordAudio("411041087", var_366_23)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_411041", "411041087", "story_v_out_411041.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_411041", "411041087", "story_v_out_411041.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_24 = math.max(var_366_15, arg_363_1.talkMaxDuration)

			if var_366_14 <= arg_363_1.time_ and arg_363_1.time_ < var_366_14 + var_366_24 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_14) / var_366_24

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_14 + var_366_24 and arg_363_1.time_ < var_366_14 + var_366_24 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play411041088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411041088
		arg_367_1.duration_ = 4.43

		local var_367_0 = {
			zh = 4.433,
			ja = 4.166
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play411041089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10014ui_story"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos10014ui_story = var_370_0.localPosition
			end

			local var_370_2 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2
				local var_370_4 = Vector3.New(0, -1.06, -6.2)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10014ui_story, var_370_4, var_370_3)

				local var_370_5 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_5.x, var_370_5.y, var_370_5.z)

				local var_370_6 = var_370_0.localEulerAngles

				var_370_6.z = 0
				var_370_6.x = 0
				var_370_0.localEulerAngles = var_370_6
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_370_7 = manager.ui.mainCamera.transform.position - var_370_0.position

				var_370_0.forward = Vector3.New(var_370_7.x, var_370_7.y, var_370_7.z)

				local var_370_8 = var_370_0.localEulerAngles

				var_370_8.z = 0
				var_370_8.x = 0
				var_370_0.localEulerAngles = var_370_8
			end

			local var_370_9 = arg_367_1.actors_["10014ui_story"]
			local var_370_10 = 0

			if var_370_10 < arg_367_1.time_ and arg_367_1.time_ <= var_370_10 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect10014ui_story == nil then
				arg_367_1.var_.characterEffect10014ui_story = var_370_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_11 = 0.200000002980232

			if var_370_10 <= arg_367_1.time_ and arg_367_1.time_ < var_370_10 + var_370_11 and not isNil(var_370_9) then
				local var_370_12 = (arg_367_1.time_ - var_370_10) / var_370_11

				if arg_367_1.var_.characterEffect10014ui_story and not isNil(var_370_9) then
					arg_367_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_10 + var_370_11 and arg_367_1.time_ < var_370_10 + var_370_11 + arg_370_0 and not isNil(var_370_9) and arg_367_1.var_.characterEffect10014ui_story then
				arg_367_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_370_13 = 0

			if var_370_13 < arg_367_1.time_ and arg_367_1.time_ <= var_370_13 + arg_370_0 then
				arg_367_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_370_14 = 0

			if var_370_14 < arg_367_1.time_ and arg_367_1.time_ <= var_370_14 + arg_370_0 then
				arg_367_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_15 = arg_367_1.actors_["10071ui_story"].transform
			local var_370_16 = 0

			if var_370_16 < arg_367_1.time_ and arg_367_1.time_ <= var_370_16 + arg_370_0 then
				arg_367_1.var_.moveOldPos10071ui_story = var_370_15.localPosition
			end

			local var_370_17 = 0.001

			if var_370_16 <= arg_367_1.time_ and arg_367_1.time_ < var_370_16 + var_370_17 then
				local var_370_18 = (arg_367_1.time_ - var_370_16) / var_370_17
				local var_370_19 = Vector3.New(0, 100, 0)

				var_370_15.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10071ui_story, var_370_19, var_370_18)

				local var_370_20 = manager.ui.mainCamera.transform.position - var_370_15.position

				var_370_15.forward = Vector3.New(var_370_20.x, var_370_20.y, var_370_20.z)

				local var_370_21 = var_370_15.localEulerAngles

				var_370_21.z = 0
				var_370_21.x = 0
				var_370_15.localEulerAngles = var_370_21
			end

			if arg_367_1.time_ >= var_370_16 + var_370_17 and arg_367_1.time_ < var_370_16 + var_370_17 + arg_370_0 then
				var_370_15.localPosition = Vector3.New(0, 100, 0)

				local var_370_22 = manager.ui.mainCamera.transform.position - var_370_15.position

				var_370_15.forward = Vector3.New(var_370_22.x, var_370_22.y, var_370_22.z)

				local var_370_23 = var_370_15.localEulerAngles

				var_370_23.z = 0
				var_370_23.x = 0
				var_370_15.localEulerAngles = var_370_23
			end

			local var_370_24 = arg_367_1.actors_["10071ui_story"]
			local var_370_25 = 0

			if var_370_25 < arg_367_1.time_ and arg_367_1.time_ <= var_370_25 + arg_370_0 and not isNil(var_370_24) and arg_367_1.var_.characterEffect10071ui_story == nil then
				arg_367_1.var_.characterEffect10071ui_story = var_370_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_26 = 0.200000002980232

			if var_370_25 <= arg_367_1.time_ and arg_367_1.time_ < var_370_25 + var_370_26 and not isNil(var_370_24) then
				local var_370_27 = (arg_367_1.time_ - var_370_25) / var_370_26

				if arg_367_1.var_.characterEffect10071ui_story and not isNil(var_370_24) then
					local var_370_28 = Mathf.Lerp(0, 0.5, var_370_27)

					arg_367_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_367_1.var_.characterEffect10071ui_story.fillRatio = var_370_28
				end
			end

			if arg_367_1.time_ >= var_370_25 + var_370_26 and arg_367_1.time_ < var_370_25 + var_370_26 + arg_370_0 and not isNil(var_370_24) and arg_367_1.var_.characterEffect10071ui_story then
				local var_370_29 = 0.5

				arg_367_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_367_1.var_.characterEffect10071ui_story.fillRatio = var_370_29
			end

			local var_370_30 = arg_367_1.actors_["1095ui_story"].transform
			local var_370_31 = 0

			if var_370_31 < arg_367_1.time_ and arg_367_1.time_ <= var_370_31 + arg_370_0 then
				arg_367_1.var_.moveOldPos1095ui_story = var_370_30.localPosition
			end

			local var_370_32 = 0.001

			if var_370_31 <= arg_367_1.time_ and arg_367_1.time_ < var_370_31 + var_370_32 then
				local var_370_33 = (arg_367_1.time_ - var_370_31) / var_370_32
				local var_370_34 = Vector3.New(0, 100, 0)

				var_370_30.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1095ui_story, var_370_34, var_370_33)

				local var_370_35 = manager.ui.mainCamera.transform.position - var_370_30.position

				var_370_30.forward = Vector3.New(var_370_35.x, var_370_35.y, var_370_35.z)

				local var_370_36 = var_370_30.localEulerAngles

				var_370_36.z = 0
				var_370_36.x = 0
				var_370_30.localEulerAngles = var_370_36
			end

			if arg_367_1.time_ >= var_370_31 + var_370_32 and arg_367_1.time_ < var_370_31 + var_370_32 + arg_370_0 then
				var_370_30.localPosition = Vector3.New(0, 100, 0)

				local var_370_37 = manager.ui.mainCamera.transform.position - var_370_30.position

				var_370_30.forward = Vector3.New(var_370_37.x, var_370_37.y, var_370_37.z)

				local var_370_38 = var_370_30.localEulerAngles

				var_370_38.z = 0
				var_370_38.x = 0
				var_370_30.localEulerAngles = var_370_38
			end

			local var_370_39 = arg_367_1.actors_["1095ui_story"]
			local var_370_40 = 0

			if var_370_40 < arg_367_1.time_ and arg_367_1.time_ <= var_370_40 + arg_370_0 and not isNil(var_370_39) and arg_367_1.var_.characterEffect1095ui_story == nil then
				arg_367_1.var_.characterEffect1095ui_story = var_370_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_41 = 0.200000002980232

			if var_370_40 <= arg_367_1.time_ and arg_367_1.time_ < var_370_40 + var_370_41 and not isNil(var_370_39) then
				local var_370_42 = (arg_367_1.time_ - var_370_40) / var_370_41

				if arg_367_1.var_.characterEffect1095ui_story and not isNil(var_370_39) then
					local var_370_43 = Mathf.Lerp(0, 0.5, var_370_42)

					arg_367_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1095ui_story.fillRatio = var_370_43
				end
			end

			if arg_367_1.time_ >= var_370_40 + var_370_41 and arg_367_1.time_ < var_370_40 + var_370_41 + arg_370_0 and not isNil(var_370_39) and arg_367_1.var_.characterEffect1095ui_story then
				local var_370_44 = 0.5

				arg_367_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1095ui_story.fillRatio = var_370_44
			end

			local var_370_45 = 0
			local var_370_46 = 0.45

			if var_370_45 < arg_367_1.time_ and arg_367_1.time_ <= var_370_45 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_47 = arg_367_1:FormatText(StoryNameCfg[264].name)

				arg_367_1.leftNameTxt_.text = var_370_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_48 = arg_367_1:GetWordFromCfg(411041088)
				local var_370_49 = arg_367_1:FormatText(var_370_48.content)

				arg_367_1.text_.text = var_370_49

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_50 = 18
				local var_370_51 = utf8.len(var_370_49)
				local var_370_52 = var_370_50 <= 0 and var_370_46 or var_370_46 * (var_370_51 / var_370_50)

				if var_370_52 > 0 and var_370_46 < var_370_52 then
					arg_367_1.talkMaxDuration = var_370_52

					if var_370_52 + var_370_45 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_52 + var_370_45
					end
				end

				arg_367_1.text_.text = var_370_49
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041088", "story_v_out_411041.awb") ~= 0 then
					local var_370_53 = manager.audio:GetVoiceLength("story_v_out_411041", "411041088", "story_v_out_411041.awb") / 1000

					if var_370_53 + var_370_45 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_53 + var_370_45
					end

					if var_370_48.prefab_name ~= "" and arg_367_1.actors_[var_370_48.prefab_name] ~= nil then
						local var_370_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_48.prefab_name].transform, "story_v_out_411041", "411041088", "story_v_out_411041.awb")

						arg_367_1:RecordAudio("411041088", var_370_54)
						arg_367_1:RecordAudio("411041088", var_370_54)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_411041", "411041088", "story_v_out_411041.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_411041", "411041088", "story_v_out_411041.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_55 = math.max(var_370_46, arg_367_1.talkMaxDuration)

			if var_370_45 <= arg_367_1.time_ and arg_367_1.time_ < var_370_45 + var_370_55 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_45) / var_370_55

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_45 + var_370_55 and arg_367_1.time_ < var_370_45 + var_370_55 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play411041089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411041089
		arg_371_1.duration_ = 7

		local var_371_0 = {
			zh = 7,
			ja = 5.266
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play411041090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10071ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos10071ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -0.9, -6.26)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10071ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.9, -6.26)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["10071ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect10071ui_story == nil then
				arg_371_1.var_.characterEffect10071ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect10071ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect10071ui_story then
				arg_371_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_374_14 = arg_371_1.actors_["10014ui_story"].transform
			local var_374_15 = 0

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.var_.moveOldPos10014ui_story = var_374_14.localPosition
			end

			local var_374_16 = 0.001

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_16 then
				local var_374_17 = (arg_371_1.time_ - var_374_15) / var_374_16
				local var_374_18 = Vector3.New(0, 100, 0)

				var_374_14.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10014ui_story, var_374_18, var_374_17)

				local var_374_19 = manager.ui.mainCamera.transform.position - var_374_14.position

				var_374_14.forward = Vector3.New(var_374_19.x, var_374_19.y, var_374_19.z)

				local var_374_20 = var_374_14.localEulerAngles

				var_374_20.z = 0
				var_374_20.x = 0
				var_374_14.localEulerAngles = var_374_20
			end

			if arg_371_1.time_ >= var_374_15 + var_374_16 and arg_371_1.time_ < var_374_15 + var_374_16 + arg_374_0 then
				var_374_14.localPosition = Vector3.New(0, 100, 0)

				local var_374_21 = manager.ui.mainCamera.transform.position - var_374_14.position

				var_374_14.forward = Vector3.New(var_374_21.x, var_374_21.y, var_374_21.z)

				local var_374_22 = var_374_14.localEulerAngles

				var_374_22.z = 0
				var_374_22.x = 0
				var_374_14.localEulerAngles = var_374_22
			end

			local var_374_23 = arg_371_1.actors_["10014ui_story"]
			local var_374_24 = 0

			if var_374_24 < arg_371_1.time_ and arg_371_1.time_ <= var_374_24 + arg_374_0 and not isNil(var_374_23) and arg_371_1.var_.characterEffect10014ui_story == nil then
				arg_371_1.var_.characterEffect10014ui_story = var_374_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_25 = 0.200000002980232

			if var_374_24 <= arg_371_1.time_ and arg_371_1.time_ < var_374_24 + var_374_25 and not isNil(var_374_23) then
				local var_374_26 = (arg_371_1.time_ - var_374_24) / var_374_25

				if arg_371_1.var_.characterEffect10014ui_story and not isNil(var_374_23) then
					local var_374_27 = Mathf.Lerp(0, 0.5, var_374_26)

					arg_371_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_371_1.var_.characterEffect10014ui_story.fillRatio = var_374_27
				end
			end

			if arg_371_1.time_ >= var_374_24 + var_374_25 and arg_371_1.time_ < var_374_24 + var_374_25 + arg_374_0 and not isNil(var_374_23) and arg_371_1.var_.characterEffect10014ui_story then
				local var_374_28 = 0.5

				arg_371_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_371_1.var_.characterEffect10014ui_story.fillRatio = var_374_28
			end

			local var_374_29 = 0
			local var_374_30 = 0.6

			if var_374_29 < arg_371_1.time_ and arg_371_1.time_ <= var_374_29 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_31 = arg_371_1:FormatText(StoryNameCfg[670].name)

				arg_371_1.leftNameTxt_.text = var_374_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_32 = arg_371_1:GetWordFromCfg(411041089)
				local var_374_33 = arg_371_1:FormatText(var_374_32.content)

				arg_371_1.text_.text = var_374_33

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_34 = 24
				local var_374_35 = utf8.len(var_374_33)
				local var_374_36 = var_374_34 <= 0 and var_374_30 or var_374_30 * (var_374_35 / var_374_34)

				if var_374_36 > 0 and var_374_30 < var_374_36 then
					arg_371_1.talkMaxDuration = var_374_36

					if var_374_36 + var_374_29 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_36 + var_374_29
					end
				end

				arg_371_1.text_.text = var_374_33
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041089", "story_v_out_411041.awb") ~= 0 then
					local var_374_37 = manager.audio:GetVoiceLength("story_v_out_411041", "411041089", "story_v_out_411041.awb") / 1000

					if var_374_37 + var_374_29 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_37 + var_374_29
					end

					if var_374_32.prefab_name ~= "" and arg_371_1.actors_[var_374_32.prefab_name] ~= nil then
						local var_374_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_32.prefab_name].transform, "story_v_out_411041", "411041089", "story_v_out_411041.awb")

						arg_371_1:RecordAudio("411041089", var_374_38)
						arg_371_1:RecordAudio("411041089", var_374_38)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_411041", "411041089", "story_v_out_411041.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_411041", "411041089", "story_v_out_411041.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_39 = math.max(var_374_30, arg_371_1.talkMaxDuration)

			if var_374_29 <= arg_371_1.time_ and arg_371_1.time_ < var_374_29 + var_374_39 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_29) / var_374_39

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_29 + var_374_39 and arg_371_1.time_ < var_374_29 + var_374_39 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play411041090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 411041090
		arg_375_1.duration_ = 10.57

		local var_375_0 = {
			zh = 10.566,
			ja = 5.466
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play411041091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1095ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1095ui_story = var_378_0.localPosition
			end

			local var_378_2 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2
				local var_378_4 = Vector3.New(0.7, -0.98, -6.1)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1095ui_story, var_378_4, var_378_3)

				local var_378_5 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_5.x, var_378_5.y, var_378_5.z)

				local var_378_6 = var_378_0.localEulerAngles

				var_378_6.z = 0
				var_378_6.x = 0
				var_378_0.localEulerAngles = var_378_6
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_378_7 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_7.x, var_378_7.y, var_378_7.z)

				local var_378_8 = var_378_0.localEulerAngles

				var_378_8.z = 0
				var_378_8.x = 0
				var_378_0.localEulerAngles = var_378_8
			end

			local var_378_9 = arg_375_1.actors_["1095ui_story"]
			local var_378_10 = 0

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1095ui_story == nil then
				arg_375_1.var_.characterEffect1095ui_story = var_378_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_11 = 0.200000002980232

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_11 and not isNil(var_378_9) then
				local var_378_12 = (arg_375_1.time_ - var_378_10) / var_378_11

				if arg_375_1.var_.characterEffect1095ui_story and not isNil(var_378_9) then
					arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_10 + var_378_11 and arg_375_1.time_ < var_378_10 + var_378_11 + arg_378_0 and not isNil(var_378_9) and arg_375_1.var_.characterEffect1095ui_story then
				arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_378_13 = 0

			if var_378_13 < arg_375_1.time_ and arg_375_1.time_ <= var_378_13 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_378_14 = 0

			if var_378_14 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_15 = arg_375_1.actors_["10071ui_story"].transform
			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 then
				arg_375_1.var_.moveOldPos10071ui_story = var_378_15.localPosition
			end

			local var_378_17 = 0.001

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_17 then
				local var_378_18 = (arg_375_1.time_ - var_378_16) / var_378_17
				local var_378_19 = Vector3.New(-0.7, -0.9, -6.26)

				var_378_15.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10071ui_story, var_378_19, var_378_18)

				local var_378_20 = manager.ui.mainCamera.transform.position - var_378_15.position

				var_378_15.forward = Vector3.New(var_378_20.x, var_378_20.y, var_378_20.z)

				local var_378_21 = var_378_15.localEulerAngles

				var_378_21.z = 0
				var_378_21.x = 0
				var_378_15.localEulerAngles = var_378_21
			end

			if arg_375_1.time_ >= var_378_16 + var_378_17 and arg_375_1.time_ < var_378_16 + var_378_17 + arg_378_0 then
				var_378_15.localPosition = Vector3.New(-0.7, -0.9, -6.26)

				local var_378_22 = manager.ui.mainCamera.transform.position - var_378_15.position

				var_378_15.forward = Vector3.New(var_378_22.x, var_378_22.y, var_378_22.z)

				local var_378_23 = var_378_15.localEulerAngles

				var_378_23.z = 0
				var_378_23.x = 0
				var_378_15.localEulerAngles = var_378_23
			end

			local var_378_24 = arg_375_1.actors_["10071ui_story"]
			local var_378_25 = 0

			if var_378_25 < arg_375_1.time_ and arg_375_1.time_ <= var_378_25 + arg_378_0 and not isNil(var_378_24) and arg_375_1.var_.characterEffect10071ui_story == nil then
				arg_375_1.var_.characterEffect10071ui_story = var_378_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_26 = 0.200000002980232

			if var_378_25 <= arg_375_1.time_ and arg_375_1.time_ < var_378_25 + var_378_26 and not isNil(var_378_24) then
				local var_378_27 = (arg_375_1.time_ - var_378_25) / var_378_26

				if arg_375_1.var_.characterEffect10071ui_story and not isNil(var_378_24) then
					local var_378_28 = Mathf.Lerp(0, 0.5, var_378_27)

					arg_375_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_375_1.var_.characterEffect10071ui_story.fillRatio = var_378_28
				end
			end

			if arg_375_1.time_ >= var_378_25 + var_378_26 and arg_375_1.time_ < var_378_25 + var_378_26 + arg_378_0 and not isNil(var_378_24) and arg_375_1.var_.characterEffect10071ui_story then
				local var_378_29 = 0.5

				arg_375_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_375_1.var_.characterEffect10071ui_story.fillRatio = var_378_29
			end

			local var_378_30 = 0
			local var_378_31 = 0.875

			if var_378_30 < arg_375_1.time_ and arg_375_1.time_ <= var_378_30 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_32 = arg_375_1:FormatText(StoryNameCfg[471].name)

				arg_375_1.leftNameTxt_.text = var_378_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_33 = arg_375_1:GetWordFromCfg(411041090)
				local var_378_34 = arg_375_1:FormatText(var_378_33.content)

				arg_375_1.text_.text = var_378_34

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_35 = 35
				local var_378_36 = utf8.len(var_378_34)
				local var_378_37 = var_378_35 <= 0 and var_378_31 or var_378_31 * (var_378_36 / var_378_35)

				if var_378_37 > 0 and var_378_31 < var_378_37 then
					arg_375_1.talkMaxDuration = var_378_37

					if var_378_37 + var_378_30 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_37 + var_378_30
					end
				end

				arg_375_1.text_.text = var_378_34
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041090", "story_v_out_411041.awb") ~= 0 then
					local var_378_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041090", "story_v_out_411041.awb") / 1000

					if var_378_38 + var_378_30 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_38 + var_378_30
					end

					if var_378_33.prefab_name ~= "" and arg_375_1.actors_[var_378_33.prefab_name] ~= nil then
						local var_378_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_33.prefab_name].transform, "story_v_out_411041", "411041090", "story_v_out_411041.awb")

						arg_375_1:RecordAudio("411041090", var_378_39)
						arg_375_1:RecordAudio("411041090", var_378_39)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_411041", "411041090", "story_v_out_411041.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_411041", "411041090", "story_v_out_411041.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_40 = math.max(var_378_31, arg_375_1.talkMaxDuration)

			if var_378_30 <= arg_375_1.time_ and arg_375_1.time_ < var_378_30 + var_378_40 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_30) / var_378_40

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_30 + var_378_40 and arg_375_1.time_ < var_378_30 + var_378_40 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play411041091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 411041091
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play411041092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1095ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1095ui_story == nil then
				arg_379_1.var_.characterEffect1095ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1095ui_story and not isNil(var_382_0) then
					local var_382_4 = Mathf.Lerp(0, 0.5, var_382_3)

					arg_379_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1095ui_story.fillRatio = var_382_4
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1095ui_story then
				local var_382_5 = 0.5

				arg_379_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1095ui_story.fillRatio = var_382_5
			end

			local var_382_6 = 0
			local var_382_7 = 0.625

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(411041091)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 25
				local var_382_11 = utf8.len(var_382_9)
				local var_382_12 = var_382_10 <= 0 and var_382_7 or var_382_7 * (var_382_11 / var_382_10)

				if var_382_12 > 0 and var_382_7 < var_382_12 then
					arg_379_1.talkMaxDuration = var_382_12

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_13 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_13 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_13

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_13 and arg_379_1.time_ < var_382_6 + var_382_13 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play411041092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411041092
		arg_383_1.duration_ = 15.73

		local var_383_0 = {
			zh = 15.733,
			ja = 12.066
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411041093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1095ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1095ui_story == nil then
				arg_383_1.var_.characterEffect1095ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1095ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1095ui_story then
				arg_383_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_386_4 = 0
			local var_386_5 = 1.425

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_6 = arg_383_1:FormatText(StoryNameCfg[471].name)

				arg_383_1.leftNameTxt_.text = var_386_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_7 = arg_383_1:GetWordFromCfg(411041092)
				local var_386_8 = arg_383_1:FormatText(var_386_7.content)

				arg_383_1.text_.text = var_386_8

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 57
				local var_386_10 = utf8.len(var_386_8)
				local var_386_11 = var_386_9 <= 0 and var_386_5 or var_386_5 * (var_386_10 / var_386_9)

				if var_386_11 > 0 and var_386_5 < var_386_11 then
					arg_383_1.talkMaxDuration = var_386_11

					if var_386_11 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_11 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_8
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041092", "story_v_out_411041.awb") ~= 0 then
					local var_386_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041092", "story_v_out_411041.awb") / 1000

					if var_386_12 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_12 + var_386_4
					end

					if var_386_7.prefab_name ~= "" and arg_383_1.actors_[var_386_7.prefab_name] ~= nil then
						local var_386_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_7.prefab_name].transform, "story_v_out_411041", "411041092", "story_v_out_411041.awb")

						arg_383_1:RecordAudio("411041092", var_386_13)
						arg_383_1:RecordAudio("411041092", var_386_13)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_411041", "411041092", "story_v_out_411041.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_411041", "411041092", "story_v_out_411041.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_14 and arg_383_1.time_ < var_386_4 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play411041093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411041093
		arg_387_1.duration_ = 6.57

		local var_387_0 = {
			zh = 6.566,
			ja = 5.766
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play411041094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.9

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[471].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_3 = arg_387_1:GetWordFromCfg(411041093)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 36
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041093", "story_v_out_411041.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041093", "story_v_out_411041.awb") / 1000

					if var_390_8 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_0
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_out_411041", "411041093", "story_v_out_411041.awb")

						arg_387_1:RecordAudio("411041093", var_390_9)
						arg_387_1:RecordAudio("411041093", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_411041", "411041093", "story_v_out_411041.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_411041", "411041093", "story_v_out_411041.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_10 and arg_387_1.time_ < var_390_0 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play411041094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411041094
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play411041095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1095ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1095ui_story == nil then
				arg_391_1.var_.characterEffect1095ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 and not isNil(var_394_0) then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1095ui_story and not isNil(var_394_0) then
					local var_394_4 = Mathf.Lerp(0, 0.5, var_394_3)

					arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1095ui_story.fillRatio = var_394_4
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and not isNil(var_394_0) and arg_391_1.var_.characterEffect1095ui_story then
				local var_394_5 = 0.5

				arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1095ui_story.fillRatio = var_394_5
			end

			local var_394_6 = 0
			local var_394_7 = 0.6

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_8 = arg_391_1:GetWordFromCfg(411041094)
				local var_394_9 = arg_391_1:FormatText(var_394_8.content)

				arg_391_1.text_.text = var_394_9

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_10 = 24
				local var_394_11 = utf8.len(var_394_9)
				local var_394_12 = var_394_10 <= 0 and var_394_7 or var_394_7 * (var_394_11 / var_394_10)

				if var_394_12 > 0 and var_394_7 < var_394_12 then
					arg_391_1.talkMaxDuration = var_394_12

					if var_394_12 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_12 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_9
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_13 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_13 and arg_391_1.time_ < var_394_6 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play411041095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 411041095
		arg_395_1.duration_ = 8.6

		local var_395_0 = {
			zh = 5.5,
			ja = 8.6
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play411041096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1095ui_story"].transform
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.var_.moveOldPos1095ui_story = var_398_0.localPosition
			end

			local var_398_2 = 0.001

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2
				local var_398_4 = Vector3.New(0.7, -0.98, -6.1)

				var_398_0.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1095ui_story, var_398_4, var_398_3)

				local var_398_5 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_5.x, var_398_5.y, var_398_5.z)

				local var_398_6 = var_398_0.localEulerAngles

				var_398_6.z = 0
				var_398_6.x = 0
				var_398_0.localEulerAngles = var_398_6
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 then
				var_398_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_398_7 = manager.ui.mainCamera.transform.position - var_398_0.position

				var_398_0.forward = Vector3.New(var_398_7.x, var_398_7.y, var_398_7.z)

				local var_398_8 = var_398_0.localEulerAngles

				var_398_8.z = 0
				var_398_8.x = 0
				var_398_0.localEulerAngles = var_398_8
			end

			local var_398_9 = arg_395_1.actors_["1095ui_story"]
			local var_398_10 = 0

			if var_398_10 < arg_395_1.time_ and arg_395_1.time_ <= var_398_10 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect1095ui_story == nil then
				arg_395_1.var_.characterEffect1095ui_story = var_398_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_11 = 0.200000002980232

			if var_398_10 <= arg_395_1.time_ and arg_395_1.time_ < var_398_10 + var_398_11 and not isNil(var_398_9) then
				local var_398_12 = (arg_395_1.time_ - var_398_10) / var_398_11

				if arg_395_1.var_.characterEffect1095ui_story and not isNil(var_398_9) then
					arg_395_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_10 + var_398_11 and arg_395_1.time_ < var_398_10 + var_398_11 + arg_398_0 and not isNil(var_398_9) and arg_395_1.var_.characterEffect1095ui_story then
				arg_395_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_398_13 = 0

			if var_398_13 < arg_395_1.time_ and arg_395_1.time_ <= var_398_13 + arg_398_0 then
				arg_395_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_398_14 = 0

			if var_398_14 < arg_395_1.time_ and arg_395_1.time_ <= var_398_14 + arg_398_0 then
				arg_395_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_398_15 = 0
			local var_398_16 = 0.6

			if var_398_15 < arg_395_1.time_ and arg_395_1.time_ <= var_398_15 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_17 = arg_395_1:FormatText(StoryNameCfg[471].name)

				arg_395_1.leftNameTxt_.text = var_398_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_18 = arg_395_1:GetWordFromCfg(411041095)
				local var_398_19 = arg_395_1:FormatText(var_398_18.content)

				arg_395_1.text_.text = var_398_19

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_20 = 24
				local var_398_21 = utf8.len(var_398_19)
				local var_398_22 = var_398_20 <= 0 and var_398_16 or var_398_16 * (var_398_21 / var_398_20)

				if var_398_22 > 0 and var_398_16 < var_398_22 then
					arg_395_1.talkMaxDuration = var_398_22

					if var_398_22 + var_398_15 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_22 + var_398_15
					end
				end

				arg_395_1.text_.text = var_398_19
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041095", "story_v_out_411041.awb") ~= 0 then
					local var_398_23 = manager.audio:GetVoiceLength("story_v_out_411041", "411041095", "story_v_out_411041.awb") / 1000

					if var_398_23 + var_398_15 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_23 + var_398_15
					end

					if var_398_18.prefab_name ~= "" and arg_395_1.actors_[var_398_18.prefab_name] ~= nil then
						local var_398_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_18.prefab_name].transform, "story_v_out_411041", "411041095", "story_v_out_411041.awb")

						arg_395_1:RecordAudio("411041095", var_398_24)
						arg_395_1:RecordAudio("411041095", var_398_24)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_411041", "411041095", "story_v_out_411041.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_411041", "411041095", "story_v_out_411041.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_25 = math.max(var_398_16, arg_395_1.talkMaxDuration)

			if var_398_15 <= arg_395_1.time_ and arg_395_1.time_ < var_398_15 + var_398_25 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_15) / var_398_25

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_15 + var_398_25 and arg_395_1.time_ < var_398_15 + var_398_25 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play411041096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 411041096
		arg_399_1.duration_ = 7.27

		local var_399_0 = {
			zh = 7.266,
			ja = 5.4
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play411041097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["10071ui_story"].transform
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.var_.moveOldPos10071ui_story = var_402_0.localPosition
			end

			local var_402_2 = 0.001

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2
				local var_402_4 = Vector3.New(-0.7, -0.9, -6.26)

				var_402_0.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos10071ui_story, var_402_4, var_402_3)

				local var_402_5 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_5.x, var_402_5.y, var_402_5.z)

				local var_402_6 = var_402_0.localEulerAngles

				var_402_6.z = 0
				var_402_6.x = 0
				var_402_0.localEulerAngles = var_402_6
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 then
				var_402_0.localPosition = Vector3.New(-0.7, -0.9, -6.26)

				local var_402_7 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_7.x, var_402_7.y, var_402_7.z)

				local var_402_8 = var_402_0.localEulerAngles

				var_402_8.z = 0
				var_402_8.x = 0
				var_402_0.localEulerAngles = var_402_8
			end

			local var_402_9 = arg_399_1.actors_["10071ui_story"]
			local var_402_10 = 0

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect10071ui_story == nil then
				arg_399_1.var_.characterEffect10071ui_story = var_402_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_11 = 0.200000002980232

			if var_402_10 <= arg_399_1.time_ and arg_399_1.time_ < var_402_10 + var_402_11 and not isNil(var_402_9) then
				local var_402_12 = (arg_399_1.time_ - var_402_10) / var_402_11

				if arg_399_1.var_.characterEffect10071ui_story and not isNil(var_402_9) then
					arg_399_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_10 + var_402_11 and arg_399_1.time_ < var_402_10 + var_402_11 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect10071ui_story then
				arg_399_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_402_13 = 0

			if var_402_13 < arg_399_1.time_ and arg_399_1.time_ <= var_402_13 + arg_402_0 then
				arg_399_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_1")
			end

			local var_402_14 = 0

			if var_402_14 < arg_399_1.time_ and arg_399_1.time_ <= var_402_14 + arg_402_0 then
				arg_399_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_15 = arg_399_1.actors_["1095ui_story"]
			local var_402_16 = 0

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.characterEffect1095ui_story == nil then
				arg_399_1.var_.characterEffect1095ui_story = var_402_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_17 = 0.200000002980232

			if var_402_16 <= arg_399_1.time_ and arg_399_1.time_ < var_402_16 + var_402_17 and not isNil(var_402_15) then
				local var_402_18 = (arg_399_1.time_ - var_402_16) / var_402_17

				if arg_399_1.var_.characterEffect1095ui_story and not isNil(var_402_15) then
					local var_402_19 = Mathf.Lerp(0, 0.5, var_402_18)

					arg_399_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1095ui_story.fillRatio = var_402_19
				end
			end

			if arg_399_1.time_ >= var_402_16 + var_402_17 and arg_399_1.time_ < var_402_16 + var_402_17 + arg_402_0 and not isNil(var_402_15) and arg_399_1.var_.characterEffect1095ui_story then
				local var_402_20 = 0.5

				arg_399_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1095ui_story.fillRatio = var_402_20
			end

			local var_402_21 = 0
			local var_402_22 = 0.525

			if var_402_21 < arg_399_1.time_ and arg_399_1.time_ <= var_402_21 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_23 = arg_399_1:FormatText(StoryNameCfg[670].name)

				arg_399_1.leftNameTxt_.text = var_402_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_24 = arg_399_1:GetWordFromCfg(411041096)
				local var_402_25 = arg_399_1:FormatText(var_402_24.content)

				arg_399_1.text_.text = var_402_25

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_26 = 21
				local var_402_27 = utf8.len(var_402_25)
				local var_402_28 = var_402_26 <= 0 and var_402_22 or var_402_22 * (var_402_27 / var_402_26)

				if var_402_28 > 0 and var_402_22 < var_402_28 then
					arg_399_1.talkMaxDuration = var_402_28

					if var_402_28 + var_402_21 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_28 + var_402_21
					end
				end

				arg_399_1.text_.text = var_402_25
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041096", "story_v_out_411041.awb") ~= 0 then
					local var_402_29 = manager.audio:GetVoiceLength("story_v_out_411041", "411041096", "story_v_out_411041.awb") / 1000

					if var_402_29 + var_402_21 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_29 + var_402_21
					end

					if var_402_24.prefab_name ~= "" and arg_399_1.actors_[var_402_24.prefab_name] ~= nil then
						local var_402_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_24.prefab_name].transform, "story_v_out_411041", "411041096", "story_v_out_411041.awb")

						arg_399_1:RecordAudio("411041096", var_402_30)
						arg_399_1:RecordAudio("411041096", var_402_30)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_411041", "411041096", "story_v_out_411041.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_411041", "411041096", "story_v_out_411041.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_31 = math.max(var_402_22, arg_399_1.talkMaxDuration)

			if var_402_21 <= arg_399_1.time_ and arg_399_1.time_ < var_402_21 + var_402_31 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_21) / var_402_31

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_21 + var_402_31 and arg_399_1.time_ < var_402_21 + var_402_31 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play411041097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 411041097
		arg_403_1.duration_ = 15.43

		local var_403_0 = {
			zh = 15.433,
			ja = 8.5
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play411041098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.225

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[670].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_3 = arg_403_1:GetWordFromCfg(411041097)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 49
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041097", "story_v_out_411041.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041097", "story_v_out_411041.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_411041", "411041097", "story_v_out_411041.awb")

						arg_403_1:RecordAudio("411041097", var_406_9)
						arg_403_1:RecordAudio("411041097", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_411041", "411041097", "story_v_out_411041.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_411041", "411041097", "story_v_out_411041.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play411041098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 411041098
		arg_407_1.duration_ = 10.5

		local var_407_0 = {
			zh = 10.5,
			ja = 9.9
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play411041099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 1.1

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[670].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:GetWordFromCfg(411041098)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 44
				local var_410_6 = utf8.len(var_410_4)
				local var_410_7 = var_410_5 <= 0 and var_410_1 or var_410_1 * (var_410_6 / var_410_5)

				if var_410_7 > 0 and var_410_1 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041098", "story_v_out_411041.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041098", "story_v_out_411041.awb") / 1000

					if var_410_8 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_0
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_out_411041", "411041098", "story_v_out_411041.awb")

						arg_407_1:RecordAudio("411041098", var_410_9)
						arg_407_1:RecordAudio("411041098", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_411041", "411041098", "story_v_out_411041.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_411041", "411041098", "story_v_out_411041.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_10 and arg_407_1.time_ < var_410_0 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play411041099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 411041099
		arg_411_1.duration_ = 8.1

		local var_411_0 = {
			zh = 8.1,
			ja = 7
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play411041100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["10014ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos10014ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0, -1.06, -6.2)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10014ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["10014ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect10014ui_story == nil then
				arg_411_1.var_.characterEffect10014ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect10014ui_story and not isNil(var_414_9) then
					arg_411_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect10014ui_story then
				arg_411_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_414_13 = 0

			if var_414_13 < arg_411_1.time_ and arg_411_1.time_ <= var_414_13 + arg_414_0 then
				arg_411_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_1")
			end

			local var_414_14 = 0

			if var_414_14 < arg_411_1.time_ and arg_411_1.time_ <= var_414_14 + arg_414_0 then
				arg_411_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_15 = arg_411_1.actors_["10071ui_story"].transform
			local var_414_16 = 0

			if var_414_16 < arg_411_1.time_ and arg_411_1.time_ <= var_414_16 + arg_414_0 then
				arg_411_1.var_.moveOldPos10071ui_story = var_414_15.localPosition
			end

			local var_414_17 = 0.001

			if var_414_16 <= arg_411_1.time_ and arg_411_1.time_ < var_414_16 + var_414_17 then
				local var_414_18 = (arg_411_1.time_ - var_414_16) / var_414_17
				local var_414_19 = Vector3.New(0, 100, 0)

				var_414_15.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10071ui_story, var_414_19, var_414_18)

				local var_414_20 = manager.ui.mainCamera.transform.position - var_414_15.position

				var_414_15.forward = Vector3.New(var_414_20.x, var_414_20.y, var_414_20.z)

				local var_414_21 = var_414_15.localEulerAngles

				var_414_21.z = 0
				var_414_21.x = 0
				var_414_15.localEulerAngles = var_414_21
			end

			if arg_411_1.time_ >= var_414_16 + var_414_17 and arg_411_1.time_ < var_414_16 + var_414_17 + arg_414_0 then
				var_414_15.localPosition = Vector3.New(0, 100, 0)

				local var_414_22 = manager.ui.mainCamera.transform.position - var_414_15.position

				var_414_15.forward = Vector3.New(var_414_22.x, var_414_22.y, var_414_22.z)

				local var_414_23 = var_414_15.localEulerAngles

				var_414_23.z = 0
				var_414_23.x = 0
				var_414_15.localEulerAngles = var_414_23
			end

			local var_414_24 = arg_411_1.actors_["10071ui_story"]
			local var_414_25 = 0

			if var_414_25 < arg_411_1.time_ and arg_411_1.time_ <= var_414_25 + arg_414_0 and not isNil(var_414_24) and arg_411_1.var_.characterEffect10071ui_story == nil then
				arg_411_1.var_.characterEffect10071ui_story = var_414_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_26 = 0.200000002980232

			if var_414_25 <= arg_411_1.time_ and arg_411_1.time_ < var_414_25 + var_414_26 and not isNil(var_414_24) then
				local var_414_27 = (arg_411_1.time_ - var_414_25) / var_414_26

				if arg_411_1.var_.characterEffect10071ui_story and not isNil(var_414_24) then
					local var_414_28 = Mathf.Lerp(0, 0.5, var_414_27)

					arg_411_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_411_1.var_.characterEffect10071ui_story.fillRatio = var_414_28
				end
			end

			if arg_411_1.time_ >= var_414_25 + var_414_26 and arg_411_1.time_ < var_414_25 + var_414_26 + arg_414_0 and not isNil(var_414_24) and arg_411_1.var_.characterEffect10071ui_story then
				local var_414_29 = 0.5

				arg_411_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_411_1.var_.characterEffect10071ui_story.fillRatio = var_414_29
			end

			local var_414_30 = arg_411_1.actors_["1095ui_story"].transform
			local var_414_31 = 0

			if var_414_31 < arg_411_1.time_ and arg_411_1.time_ <= var_414_31 + arg_414_0 then
				arg_411_1.var_.moveOldPos1095ui_story = var_414_30.localPosition
			end

			local var_414_32 = 0.001

			if var_414_31 <= arg_411_1.time_ and arg_411_1.time_ < var_414_31 + var_414_32 then
				local var_414_33 = (arg_411_1.time_ - var_414_31) / var_414_32
				local var_414_34 = Vector3.New(0, 100, 0)

				var_414_30.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1095ui_story, var_414_34, var_414_33)

				local var_414_35 = manager.ui.mainCamera.transform.position - var_414_30.position

				var_414_30.forward = Vector3.New(var_414_35.x, var_414_35.y, var_414_35.z)

				local var_414_36 = var_414_30.localEulerAngles

				var_414_36.z = 0
				var_414_36.x = 0
				var_414_30.localEulerAngles = var_414_36
			end

			if arg_411_1.time_ >= var_414_31 + var_414_32 and arg_411_1.time_ < var_414_31 + var_414_32 + arg_414_0 then
				var_414_30.localPosition = Vector3.New(0, 100, 0)

				local var_414_37 = manager.ui.mainCamera.transform.position - var_414_30.position

				var_414_30.forward = Vector3.New(var_414_37.x, var_414_37.y, var_414_37.z)

				local var_414_38 = var_414_30.localEulerAngles

				var_414_38.z = 0
				var_414_38.x = 0
				var_414_30.localEulerAngles = var_414_38
			end

			local var_414_39 = arg_411_1.actors_["1095ui_story"]
			local var_414_40 = 0

			if var_414_40 < arg_411_1.time_ and arg_411_1.time_ <= var_414_40 + arg_414_0 and not isNil(var_414_39) and arg_411_1.var_.characterEffect1095ui_story == nil then
				arg_411_1.var_.characterEffect1095ui_story = var_414_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_41 = 0.200000002980232

			if var_414_40 <= arg_411_1.time_ and arg_411_1.time_ < var_414_40 + var_414_41 and not isNil(var_414_39) then
				local var_414_42 = (arg_411_1.time_ - var_414_40) / var_414_41

				if arg_411_1.var_.characterEffect1095ui_story and not isNil(var_414_39) then
					local var_414_43 = Mathf.Lerp(0, 0.5, var_414_42)

					arg_411_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1095ui_story.fillRatio = var_414_43
				end
			end

			if arg_411_1.time_ >= var_414_40 + var_414_41 and arg_411_1.time_ < var_414_40 + var_414_41 + arg_414_0 and not isNil(var_414_39) and arg_411_1.var_.characterEffect1095ui_story then
				local var_414_44 = 0.5

				arg_411_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1095ui_story.fillRatio = var_414_44
			end

			local var_414_45 = 0
			local var_414_46 = 0.925

			if var_414_45 < arg_411_1.time_ and arg_411_1.time_ <= var_414_45 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_47 = arg_411_1:FormatText(StoryNameCfg[264].name)

				arg_411_1.leftNameTxt_.text = var_414_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_48 = arg_411_1:GetWordFromCfg(411041099)
				local var_414_49 = arg_411_1:FormatText(var_414_48.content)

				arg_411_1.text_.text = var_414_49

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_50 = 37
				local var_414_51 = utf8.len(var_414_49)
				local var_414_52 = var_414_50 <= 0 and var_414_46 or var_414_46 * (var_414_51 / var_414_50)

				if var_414_52 > 0 and var_414_46 < var_414_52 then
					arg_411_1.talkMaxDuration = var_414_52

					if var_414_52 + var_414_45 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_52 + var_414_45
					end
				end

				arg_411_1.text_.text = var_414_49
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041099", "story_v_out_411041.awb") ~= 0 then
					local var_414_53 = manager.audio:GetVoiceLength("story_v_out_411041", "411041099", "story_v_out_411041.awb") / 1000

					if var_414_53 + var_414_45 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_53 + var_414_45
					end

					if var_414_48.prefab_name ~= "" and arg_411_1.actors_[var_414_48.prefab_name] ~= nil then
						local var_414_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_48.prefab_name].transform, "story_v_out_411041", "411041099", "story_v_out_411041.awb")

						arg_411_1:RecordAudio("411041099", var_414_54)
						arg_411_1:RecordAudio("411041099", var_414_54)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_411041", "411041099", "story_v_out_411041.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_411041", "411041099", "story_v_out_411041.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_55 = math.max(var_414_46, arg_411_1.talkMaxDuration)

			if var_414_45 <= arg_411_1.time_ and arg_411_1.time_ < var_414_45 + var_414_55 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_45) / var_414_55

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_45 + var_414_55 and arg_411_1.time_ < var_414_45 + var_414_55 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play411041100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 411041100
		arg_415_1.duration_ = 2

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play411041101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["10071ui_story"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos10071ui_story = var_418_0.localPosition
			end

			local var_418_2 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2
				local var_418_4 = Vector3.New(0.7, -0.9, -6.26)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10071ui_story, var_418_4, var_418_3)

				local var_418_5 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_5.x, var_418_5.y, var_418_5.z)

				local var_418_6 = var_418_0.localEulerAngles

				var_418_6.z = 0
				var_418_6.x = 0
				var_418_0.localEulerAngles = var_418_6
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_418_7 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_7.x, var_418_7.y, var_418_7.z)

				local var_418_8 = var_418_0.localEulerAngles

				var_418_8.z = 0
				var_418_8.x = 0
				var_418_0.localEulerAngles = var_418_8
			end

			local var_418_9 = arg_415_1.actors_["10071ui_story"]
			local var_418_10 = 0

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect10071ui_story == nil then
				arg_415_1.var_.characterEffect10071ui_story = var_418_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_11 = 0.200000002980232

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_11 and not isNil(var_418_9) then
				local var_418_12 = (arg_415_1.time_ - var_418_10) / var_418_11

				if arg_415_1.var_.characterEffect10071ui_story and not isNil(var_418_9) then
					arg_415_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_10 + var_418_11 and arg_415_1.time_ < var_418_10 + var_418_11 + arg_418_0 and not isNil(var_418_9) and arg_415_1.var_.characterEffect10071ui_story then
				arg_415_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_418_13 = 0

			if var_418_13 < arg_415_1.time_ and arg_415_1.time_ <= var_418_13 + arg_418_0 then
				arg_415_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_2")
			end

			local var_418_14 = 0

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				arg_415_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_418_15 = arg_415_1.actors_["10014ui_story"].transform
			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.var_.moveOldPos10014ui_story = var_418_15.localPosition
			end

			local var_418_17 = 0.001

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17
				local var_418_19 = Vector3.New(-0.7, -1.06, -6.2)

				var_418_15.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10014ui_story, var_418_19, var_418_18)

				local var_418_20 = manager.ui.mainCamera.transform.position - var_418_15.position

				var_418_15.forward = Vector3.New(var_418_20.x, var_418_20.y, var_418_20.z)

				local var_418_21 = var_418_15.localEulerAngles

				var_418_21.z = 0
				var_418_21.x = 0
				var_418_15.localEulerAngles = var_418_21
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 then
				var_418_15.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_418_22 = manager.ui.mainCamera.transform.position - var_418_15.position

				var_418_15.forward = Vector3.New(var_418_22.x, var_418_22.y, var_418_22.z)

				local var_418_23 = var_418_15.localEulerAngles

				var_418_23.z = 0
				var_418_23.x = 0
				var_418_15.localEulerAngles = var_418_23
			end

			local var_418_24 = arg_415_1.actors_["10014ui_story"]
			local var_418_25 = 0

			if var_418_25 < arg_415_1.time_ and arg_415_1.time_ <= var_418_25 + arg_418_0 and not isNil(var_418_24) and arg_415_1.var_.characterEffect10014ui_story == nil then
				arg_415_1.var_.characterEffect10014ui_story = var_418_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_26 = 0.200000002980232

			if var_418_25 <= arg_415_1.time_ and arg_415_1.time_ < var_418_25 + var_418_26 and not isNil(var_418_24) then
				local var_418_27 = (arg_415_1.time_ - var_418_25) / var_418_26

				if arg_415_1.var_.characterEffect10014ui_story and not isNil(var_418_24) then
					local var_418_28 = Mathf.Lerp(0, 0.5, var_418_27)

					arg_415_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_415_1.var_.characterEffect10014ui_story.fillRatio = var_418_28
				end
			end

			if arg_415_1.time_ >= var_418_25 + var_418_26 and arg_415_1.time_ < var_418_25 + var_418_26 + arg_418_0 and not isNil(var_418_24) and arg_415_1.var_.characterEffect10014ui_story then
				local var_418_29 = 0.5

				arg_415_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_415_1.var_.characterEffect10014ui_story.fillRatio = var_418_29
			end

			local var_418_30 = 0
			local var_418_31 = 0.125

			if var_418_30 < arg_415_1.time_ and arg_415_1.time_ <= var_418_30 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_32 = arg_415_1:FormatText(StoryNameCfg[670].name)

				arg_415_1.leftNameTxt_.text = var_418_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_33 = arg_415_1:GetWordFromCfg(411041100)
				local var_418_34 = arg_415_1:FormatText(var_418_33.content)

				arg_415_1.text_.text = var_418_34

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_35 = 5
				local var_418_36 = utf8.len(var_418_34)
				local var_418_37 = var_418_35 <= 0 and var_418_31 or var_418_31 * (var_418_36 / var_418_35)

				if var_418_37 > 0 and var_418_31 < var_418_37 then
					arg_415_1.talkMaxDuration = var_418_37

					if var_418_37 + var_418_30 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_37 + var_418_30
					end
				end

				arg_415_1.text_.text = var_418_34
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041100", "story_v_out_411041.awb") ~= 0 then
					local var_418_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041100", "story_v_out_411041.awb") / 1000

					if var_418_38 + var_418_30 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_38 + var_418_30
					end

					if var_418_33.prefab_name ~= "" and arg_415_1.actors_[var_418_33.prefab_name] ~= nil then
						local var_418_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_33.prefab_name].transform, "story_v_out_411041", "411041100", "story_v_out_411041.awb")

						arg_415_1:RecordAudio("411041100", var_418_39)
						arg_415_1:RecordAudio("411041100", var_418_39)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_411041", "411041100", "story_v_out_411041.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_411041", "411041100", "story_v_out_411041.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_40 = math.max(var_418_31, arg_415_1.talkMaxDuration)

			if var_418_30 <= arg_415_1.time_ and arg_415_1.time_ < var_418_30 + var_418_40 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_30) / var_418_40

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_30 + var_418_40 and arg_415_1.time_ < var_418_30 + var_418_40 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play411041101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 411041101
		arg_419_1.duration_ = 10.3

		local var_419_0 = {
			zh = 10.2,
			ja = 10.3
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play411041102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["10014ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos10014ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(-0.7, -1.06, -6.2)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10014ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["10014ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect10014ui_story == nil then
				arg_419_1.var_.characterEffect10014ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect10014ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect10014ui_story then
				arg_419_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_422_13 = arg_419_1.actors_["10071ui_story"]
			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 and not isNil(var_422_13) and arg_419_1.var_.characterEffect10071ui_story == nil then
				arg_419_1.var_.characterEffect10071ui_story = var_422_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_15 = 0.200000002980232

			if var_422_14 <= arg_419_1.time_ and arg_419_1.time_ < var_422_14 + var_422_15 and not isNil(var_422_13) then
				local var_422_16 = (arg_419_1.time_ - var_422_14) / var_422_15

				if arg_419_1.var_.characterEffect10071ui_story and not isNil(var_422_13) then
					local var_422_17 = Mathf.Lerp(0, 0.5, var_422_16)

					arg_419_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_419_1.var_.characterEffect10071ui_story.fillRatio = var_422_17
				end
			end

			if arg_419_1.time_ >= var_422_14 + var_422_15 and arg_419_1.time_ < var_422_14 + var_422_15 + arg_422_0 and not isNil(var_422_13) and arg_419_1.var_.characterEffect10071ui_story then
				local var_422_18 = 0.5

				arg_419_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_419_1.var_.characterEffect10071ui_story.fillRatio = var_422_18
			end

			local var_422_19 = 0
			local var_422_20 = 1.3

			if var_422_19 < arg_419_1.time_ and arg_419_1.time_ <= var_422_19 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_21 = arg_419_1:FormatText(StoryNameCfg[264].name)

				arg_419_1.leftNameTxt_.text = var_422_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_22 = arg_419_1:GetWordFromCfg(411041101)
				local var_422_23 = arg_419_1:FormatText(var_422_22.content)

				arg_419_1.text_.text = var_422_23

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_24 = 52
				local var_422_25 = utf8.len(var_422_23)
				local var_422_26 = var_422_24 <= 0 and var_422_20 or var_422_20 * (var_422_25 / var_422_24)

				if var_422_26 > 0 and var_422_20 < var_422_26 then
					arg_419_1.talkMaxDuration = var_422_26

					if var_422_26 + var_422_19 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_26 + var_422_19
					end
				end

				arg_419_1.text_.text = var_422_23
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041101", "story_v_out_411041.awb") ~= 0 then
					local var_422_27 = manager.audio:GetVoiceLength("story_v_out_411041", "411041101", "story_v_out_411041.awb") / 1000

					if var_422_27 + var_422_19 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_27 + var_422_19
					end

					if var_422_22.prefab_name ~= "" and arg_419_1.actors_[var_422_22.prefab_name] ~= nil then
						local var_422_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_22.prefab_name].transform, "story_v_out_411041", "411041101", "story_v_out_411041.awb")

						arg_419_1:RecordAudio("411041101", var_422_28)
						arg_419_1:RecordAudio("411041101", var_422_28)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_411041", "411041101", "story_v_out_411041.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_411041", "411041101", "story_v_out_411041.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_29 = math.max(var_422_20, arg_419_1.talkMaxDuration)

			if var_422_19 <= arg_419_1.time_ and arg_419_1.time_ < var_422_19 + var_422_29 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_19) / var_422_29

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_19 + var_422_29 and arg_419_1.time_ < var_422_19 + var_422_29 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play411041102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 411041102
		arg_423_1.duration_ = 8.43

		local var_423_0 = {
			zh = 8.433,
			ja = 5.7
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play411041103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["10014ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10014ui_story == nil then
				arg_423_1.var_.characterEffect10014ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect10014ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_423_1.var_.characterEffect10014ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect10014ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_423_1.var_.characterEffect10014ui_story.fillRatio = var_426_5
			end

			local var_426_6 = arg_423_1.actors_["10071ui_story"]
			local var_426_7 = 0

			if var_426_7 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect10071ui_story == nil then
				arg_423_1.var_.characterEffect10071ui_story = var_426_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_8 = 0.200000002980232

			if var_426_7 <= arg_423_1.time_ and arg_423_1.time_ < var_426_7 + var_426_8 and not isNil(var_426_6) then
				local var_426_9 = (arg_423_1.time_ - var_426_7) / var_426_8

				if arg_423_1.var_.characterEffect10071ui_story and not isNil(var_426_6) then
					arg_423_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= var_426_7 + var_426_8 and arg_423_1.time_ < var_426_7 + var_426_8 + arg_426_0 and not isNil(var_426_6) and arg_423_1.var_.characterEffect10071ui_story then
				arg_423_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_426_10 = 0
			local var_426_11 = 0.825

			if var_426_10 < arg_423_1.time_ and arg_423_1.time_ <= var_426_10 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_12 = arg_423_1:FormatText(StoryNameCfg[670].name)

				arg_423_1.leftNameTxt_.text = var_426_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_13 = arg_423_1:GetWordFromCfg(411041102)
				local var_426_14 = arg_423_1:FormatText(var_426_13.content)

				arg_423_1.text_.text = var_426_14

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_15 = 33
				local var_426_16 = utf8.len(var_426_14)
				local var_426_17 = var_426_15 <= 0 and var_426_11 or var_426_11 * (var_426_16 / var_426_15)

				if var_426_17 > 0 and var_426_11 < var_426_17 then
					arg_423_1.talkMaxDuration = var_426_17

					if var_426_17 + var_426_10 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_17 + var_426_10
					end
				end

				arg_423_1.text_.text = var_426_14
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041102", "story_v_out_411041.awb") ~= 0 then
					local var_426_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041102", "story_v_out_411041.awb") / 1000

					if var_426_18 + var_426_10 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_18 + var_426_10
					end

					if var_426_13.prefab_name ~= "" and arg_423_1.actors_[var_426_13.prefab_name] ~= nil then
						local var_426_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_13.prefab_name].transform, "story_v_out_411041", "411041102", "story_v_out_411041.awb")

						arg_423_1:RecordAudio("411041102", var_426_19)
						arg_423_1:RecordAudio("411041102", var_426_19)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_411041", "411041102", "story_v_out_411041.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_411041", "411041102", "story_v_out_411041.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_20 = math.max(var_426_11, arg_423_1.talkMaxDuration)

			if var_426_10 <= arg_423_1.time_ and arg_423_1.time_ < var_426_10 + var_426_20 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_10) / var_426_20

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_10 + var_426_20 and arg_423_1.time_ < var_426_10 + var_426_20 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play411041103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 411041103
		arg_427_1.duration_ = 11.4

		local var_427_0 = {
			zh = 11.4,
			ja = 2.6
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play411041104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["10014ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect10014ui_story == nil then
				arg_427_1.var_.characterEffect10014ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 and not isNil(var_430_0) then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect10014ui_story and not isNil(var_430_0) then
					arg_427_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and not isNil(var_430_0) and arg_427_1.var_.characterEffect10014ui_story then
				arg_427_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_430_4 = 0
			local var_430_5 = 1.05

			if var_430_4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_6 = arg_427_1:FormatText(StoryNameCfg[264].name)

				arg_427_1.leftNameTxt_.text = var_430_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_7 = arg_427_1:GetWordFromCfg(411041103)
				local var_430_8 = arg_427_1:FormatText(var_430_7.content)

				arg_427_1.text_.text = var_430_8

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 42
				local var_430_10 = utf8.len(var_430_8)
				local var_430_11 = var_430_9 <= 0 and var_430_5 or var_430_5 * (var_430_10 / var_430_9)

				if var_430_11 > 0 and var_430_5 < var_430_11 then
					arg_427_1.talkMaxDuration = var_430_11

					if var_430_11 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_11 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_8
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041103", "story_v_out_411041.awb") ~= 0 then
					local var_430_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041103", "story_v_out_411041.awb") / 1000

					if var_430_12 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_12 + var_430_4
					end

					if var_430_7.prefab_name ~= "" and arg_427_1.actors_[var_430_7.prefab_name] ~= nil then
						local var_430_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_7.prefab_name].transform, "story_v_out_411041", "411041103", "story_v_out_411041.awb")

						arg_427_1:RecordAudio("411041103", var_430_13)
						arg_427_1:RecordAudio("411041103", var_430_13)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_411041", "411041103", "story_v_out_411041.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_411041", "411041103", "story_v_out_411041.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_14 and arg_427_1.time_ < var_430_4 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play411041104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 411041104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play411041105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["10014ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect10014ui_story == nil then
				arg_431_1.var_.characterEffect10014ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect10014ui_story and not isNil(var_434_0) then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_431_1.var_.characterEffect10014ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.characterEffect10014ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_431_1.var_.characterEffect10014ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.95

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_8 = arg_431_1:GetWordFromCfg(411041104)
				local var_434_9 = arg_431_1:FormatText(var_434_8.content)

				arg_431_1.text_.text = var_434_9

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_10 = 38
				local var_434_11 = utf8.len(var_434_9)
				local var_434_12 = var_434_10 <= 0 and var_434_7 or var_434_7 * (var_434_11 / var_434_10)

				if var_434_12 > 0 and var_434_7 < var_434_12 then
					arg_431_1.talkMaxDuration = var_434_12

					if var_434_12 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_12 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_9
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_13 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_13 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_13

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_13 and arg_431_1.time_ < var_434_6 + var_434_13 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play411041105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 411041105
		arg_435_1.duration_ = 6.13

		local var_435_0 = {
			zh = 4.133,
			ja = 6.133
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play411041106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1095ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1095ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, -0.98, -6.1)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1095ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1095ui_story"]
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1095ui_story == nil then
				arg_435_1.var_.characterEffect1095ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_11 = 0.200000002980232

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 and not isNil(var_438_9) then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11

				if arg_435_1.var_.characterEffect1095ui_story and not isNil(var_438_9) then
					arg_435_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1095ui_story then
				arg_435_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_438_13 = 0

			if var_438_13 < arg_435_1.time_ and arg_435_1.time_ <= var_438_13 + arg_438_0 then
				arg_435_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_438_14 = 0

			if var_438_14 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				arg_435_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_438_15 = arg_435_1.actors_["10014ui_story"].transform
			local var_438_16 = 0

			if var_438_16 < arg_435_1.time_ and arg_435_1.time_ <= var_438_16 + arg_438_0 then
				arg_435_1.var_.moveOldPos10014ui_story = var_438_15.localPosition
			end

			local var_438_17 = 0.001

			if var_438_16 <= arg_435_1.time_ and arg_435_1.time_ < var_438_16 + var_438_17 then
				local var_438_18 = (arg_435_1.time_ - var_438_16) / var_438_17
				local var_438_19 = Vector3.New(0, 100, 0)

				var_438_15.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10014ui_story, var_438_19, var_438_18)

				local var_438_20 = manager.ui.mainCamera.transform.position - var_438_15.position

				var_438_15.forward = Vector3.New(var_438_20.x, var_438_20.y, var_438_20.z)

				local var_438_21 = var_438_15.localEulerAngles

				var_438_21.z = 0
				var_438_21.x = 0
				var_438_15.localEulerAngles = var_438_21
			end

			if arg_435_1.time_ >= var_438_16 + var_438_17 and arg_435_1.time_ < var_438_16 + var_438_17 + arg_438_0 then
				var_438_15.localPosition = Vector3.New(0, 100, 0)

				local var_438_22 = manager.ui.mainCamera.transform.position - var_438_15.position

				var_438_15.forward = Vector3.New(var_438_22.x, var_438_22.y, var_438_22.z)

				local var_438_23 = var_438_15.localEulerAngles

				var_438_23.z = 0
				var_438_23.x = 0
				var_438_15.localEulerAngles = var_438_23
			end

			local var_438_24 = arg_435_1.actors_["10014ui_story"]
			local var_438_25 = 0

			if var_438_25 < arg_435_1.time_ and arg_435_1.time_ <= var_438_25 + arg_438_0 and not isNil(var_438_24) and arg_435_1.var_.characterEffect10014ui_story == nil then
				arg_435_1.var_.characterEffect10014ui_story = var_438_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_26 = 0.200000002980232

			if var_438_25 <= arg_435_1.time_ and arg_435_1.time_ < var_438_25 + var_438_26 and not isNil(var_438_24) then
				local var_438_27 = (arg_435_1.time_ - var_438_25) / var_438_26

				if arg_435_1.var_.characterEffect10014ui_story and not isNil(var_438_24) then
					local var_438_28 = Mathf.Lerp(0, 0.5, var_438_27)

					arg_435_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_435_1.var_.characterEffect10014ui_story.fillRatio = var_438_28
				end
			end

			if arg_435_1.time_ >= var_438_25 + var_438_26 and arg_435_1.time_ < var_438_25 + var_438_26 + arg_438_0 and not isNil(var_438_24) and arg_435_1.var_.characterEffect10014ui_story then
				local var_438_29 = 0.5

				arg_435_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_435_1.var_.characterEffect10014ui_story.fillRatio = var_438_29
			end

			local var_438_30 = arg_435_1.actors_["10071ui_story"].transform
			local var_438_31 = 0

			if var_438_31 < arg_435_1.time_ and arg_435_1.time_ <= var_438_31 + arg_438_0 then
				arg_435_1.var_.moveOldPos10071ui_story = var_438_30.localPosition
			end

			local var_438_32 = 0.001

			if var_438_31 <= arg_435_1.time_ and arg_435_1.time_ < var_438_31 + var_438_32 then
				local var_438_33 = (arg_435_1.time_ - var_438_31) / var_438_32
				local var_438_34 = Vector3.New(0, 100, 0)

				var_438_30.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10071ui_story, var_438_34, var_438_33)

				local var_438_35 = manager.ui.mainCamera.transform.position - var_438_30.position

				var_438_30.forward = Vector3.New(var_438_35.x, var_438_35.y, var_438_35.z)

				local var_438_36 = var_438_30.localEulerAngles

				var_438_36.z = 0
				var_438_36.x = 0
				var_438_30.localEulerAngles = var_438_36
			end

			if arg_435_1.time_ >= var_438_31 + var_438_32 and arg_435_1.time_ < var_438_31 + var_438_32 + arg_438_0 then
				var_438_30.localPosition = Vector3.New(0, 100, 0)

				local var_438_37 = manager.ui.mainCamera.transform.position - var_438_30.position

				var_438_30.forward = Vector3.New(var_438_37.x, var_438_37.y, var_438_37.z)

				local var_438_38 = var_438_30.localEulerAngles

				var_438_38.z = 0
				var_438_38.x = 0
				var_438_30.localEulerAngles = var_438_38
			end

			local var_438_39 = arg_435_1.actors_["10071ui_story"]
			local var_438_40 = 0

			if var_438_40 < arg_435_1.time_ and arg_435_1.time_ <= var_438_40 + arg_438_0 and not isNil(var_438_39) and arg_435_1.var_.characterEffect10071ui_story == nil then
				arg_435_1.var_.characterEffect10071ui_story = var_438_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_41 = 0.200000002980232

			if var_438_40 <= arg_435_1.time_ and arg_435_1.time_ < var_438_40 + var_438_41 and not isNil(var_438_39) then
				local var_438_42 = (arg_435_1.time_ - var_438_40) / var_438_41

				if arg_435_1.var_.characterEffect10071ui_story and not isNil(var_438_39) then
					local var_438_43 = Mathf.Lerp(0, 0.5, var_438_42)

					arg_435_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_435_1.var_.characterEffect10071ui_story.fillRatio = var_438_43
				end
			end

			if arg_435_1.time_ >= var_438_40 + var_438_41 and arg_435_1.time_ < var_438_40 + var_438_41 + arg_438_0 and not isNil(var_438_39) and arg_435_1.var_.characterEffect10071ui_story then
				local var_438_44 = 0.5

				arg_435_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_435_1.var_.characterEffect10071ui_story.fillRatio = var_438_44
			end

			local var_438_45 = 0
			local var_438_46 = 0.5

			if var_438_45 < arg_435_1.time_ and arg_435_1.time_ <= var_438_45 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_47 = arg_435_1:FormatText(StoryNameCfg[471].name)

				arg_435_1.leftNameTxt_.text = var_438_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_48 = arg_435_1:GetWordFromCfg(411041105)
				local var_438_49 = arg_435_1:FormatText(var_438_48.content)

				arg_435_1.text_.text = var_438_49

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_50 = 20
				local var_438_51 = utf8.len(var_438_49)
				local var_438_52 = var_438_50 <= 0 and var_438_46 or var_438_46 * (var_438_51 / var_438_50)

				if var_438_52 > 0 and var_438_46 < var_438_52 then
					arg_435_1.talkMaxDuration = var_438_52

					if var_438_52 + var_438_45 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_52 + var_438_45
					end
				end

				arg_435_1.text_.text = var_438_49
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041105", "story_v_out_411041.awb") ~= 0 then
					local var_438_53 = manager.audio:GetVoiceLength("story_v_out_411041", "411041105", "story_v_out_411041.awb") / 1000

					if var_438_53 + var_438_45 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_53 + var_438_45
					end

					if var_438_48.prefab_name ~= "" and arg_435_1.actors_[var_438_48.prefab_name] ~= nil then
						local var_438_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_48.prefab_name].transform, "story_v_out_411041", "411041105", "story_v_out_411041.awb")

						arg_435_1:RecordAudio("411041105", var_438_54)
						arg_435_1:RecordAudio("411041105", var_438_54)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_411041", "411041105", "story_v_out_411041.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_411041", "411041105", "story_v_out_411041.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_55 = math.max(var_438_46, arg_435_1.talkMaxDuration)

			if var_438_45 <= arg_435_1.time_ and arg_435_1.time_ < var_438_45 + var_438_55 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_45) / var_438_55

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_45 + var_438_55 and arg_435_1.time_ < var_438_45 + var_438_55 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play411041106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 411041106
		arg_439_1.duration_ = 6.53

		local var_439_0 = {
			zh = 3.933,
			ja = 6.533
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play411041107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 0.55

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[471].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(411041106)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 22
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041106", "story_v_out_411041.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041106", "story_v_out_411041.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_411041", "411041106", "story_v_out_411041.awb")

						arg_439_1:RecordAudio("411041106", var_442_9)
						arg_439_1:RecordAudio("411041106", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_411041", "411041106", "story_v_out_411041.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_411041", "411041106", "story_v_out_411041.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play411041107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 411041107
		arg_443_1.duration_ = 5.83

		local var_443_0 = {
			zh = 5.833,
			ja = 2.1
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play411041108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["10014ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos10014ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0, -1.06, -6.2)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos10014ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = arg_443_1.actors_["10014ui_story"]
			local var_446_10 = 0

			if var_446_10 < arg_443_1.time_ and arg_443_1.time_ <= var_446_10 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect10014ui_story == nil then
				arg_443_1.var_.characterEffect10014ui_story = var_446_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_11 = 0.200000002980232

			if var_446_10 <= arg_443_1.time_ and arg_443_1.time_ < var_446_10 + var_446_11 and not isNil(var_446_9) then
				local var_446_12 = (arg_443_1.time_ - var_446_10) / var_446_11

				if arg_443_1.var_.characterEffect10014ui_story and not isNil(var_446_9) then
					arg_443_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= var_446_10 + var_446_11 and arg_443_1.time_ < var_446_10 + var_446_11 + arg_446_0 and not isNil(var_446_9) and arg_443_1.var_.characterEffect10014ui_story then
				arg_443_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_446_13 = 0

			if var_446_13 < arg_443_1.time_ and arg_443_1.time_ <= var_446_13 + arg_446_0 then
				arg_443_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action4_2")
			end

			local var_446_14 = 0

			if var_446_14 < arg_443_1.time_ and arg_443_1.time_ <= var_446_14 + arg_446_0 then
				arg_443_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_446_15 = arg_443_1.actors_["1095ui_story"].transform
			local var_446_16 = 0

			if var_446_16 < arg_443_1.time_ and arg_443_1.time_ <= var_446_16 + arg_446_0 then
				arg_443_1.var_.moveOldPos1095ui_story = var_446_15.localPosition
			end

			local var_446_17 = 0.001

			if var_446_16 <= arg_443_1.time_ and arg_443_1.time_ < var_446_16 + var_446_17 then
				local var_446_18 = (arg_443_1.time_ - var_446_16) / var_446_17
				local var_446_19 = Vector3.New(0, 100, 0)

				var_446_15.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1095ui_story, var_446_19, var_446_18)

				local var_446_20 = manager.ui.mainCamera.transform.position - var_446_15.position

				var_446_15.forward = Vector3.New(var_446_20.x, var_446_20.y, var_446_20.z)

				local var_446_21 = var_446_15.localEulerAngles

				var_446_21.z = 0
				var_446_21.x = 0
				var_446_15.localEulerAngles = var_446_21
			end

			if arg_443_1.time_ >= var_446_16 + var_446_17 and arg_443_1.time_ < var_446_16 + var_446_17 + arg_446_0 then
				var_446_15.localPosition = Vector3.New(0, 100, 0)

				local var_446_22 = manager.ui.mainCamera.transform.position - var_446_15.position

				var_446_15.forward = Vector3.New(var_446_22.x, var_446_22.y, var_446_22.z)

				local var_446_23 = var_446_15.localEulerAngles

				var_446_23.z = 0
				var_446_23.x = 0
				var_446_15.localEulerAngles = var_446_23
			end

			local var_446_24 = arg_443_1.actors_["1095ui_story"]
			local var_446_25 = 0

			if var_446_25 < arg_443_1.time_ and arg_443_1.time_ <= var_446_25 + arg_446_0 and not isNil(var_446_24) and arg_443_1.var_.characterEffect1095ui_story == nil then
				arg_443_1.var_.characterEffect1095ui_story = var_446_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_26 = 0.200000002980232

			if var_446_25 <= arg_443_1.time_ and arg_443_1.time_ < var_446_25 + var_446_26 and not isNil(var_446_24) then
				local var_446_27 = (arg_443_1.time_ - var_446_25) / var_446_26

				if arg_443_1.var_.characterEffect1095ui_story and not isNil(var_446_24) then
					local var_446_28 = Mathf.Lerp(0, 0.5, var_446_27)

					arg_443_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1095ui_story.fillRatio = var_446_28
				end
			end

			if arg_443_1.time_ >= var_446_25 + var_446_26 and arg_443_1.time_ < var_446_25 + var_446_26 + arg_446_0 and not isNil(var_446_24) and arg_443_1.var_.characterEffect1095ui_story then
				local var_446_29 = 0.5

				arg_443_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1095ui_story.fillRatio = var_446_29
			end

			local var_446_30 = 0
			local var_446_31 = 0.55

			if var_446_30 < arg_443_1.time_ and arg_443_1.time_ <= var_446_30 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_32 = arg_443_1:FormatText(StoryNameCfg[264].name)

				arg_443_1.leftNameTxt_.text = var_446_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_33 = arg_443_1:GetWordFromCfg(411041107)
				local var_446_34 = arg_443_1:FormatText(var_446_33.content)

				arg_443_1.text_.text = var_446_34

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_35 = 22
				local var_446_36 = utf8.len(var_446_34)
				local var_446_37 = var_446_35 <= 0 and var_446_31 or var_446_31 * (var_446_36 / var_446_35)

				if var_446_37 > 0 and var_446_31 < var_446_37 then
					arg_443_1.talkMaxDuration = var_446_37

					if var_446_37 + var_446_30 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_37 + var_446_30
					end
				end

				arg_443_1.text_.text = var_446_34
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041107", "story_v_out_411041.awb") ~= 0 then
					local var_446_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041107", "story_v_out_411041.awb") / 1000

					if var_446_38 + var_446_30 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_38 + var_446_30
					end

					if var_446_33.prefab_name ~= "" and arg_443_1.actors_[var_446_33.prefab_name] ~= nil then
						local var_446_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_33.prefab_name].transform, "story_v_out_411041", "411041107", "story_v_out_411041.awb")

						arg_443_1:RecordAudio("411041107", var_446_39)
						arg_443_1:RecordAudio("411041107", var_446_39)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_411041", "411041107", "story_v_out_411041.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_411041", "411041107", "story_v_out_411041.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_40 = math.max(var_446_31, arg_443_1.talkMaxDuration)

			if var_446_30 <= arg_443_1.time_ and arg_443_1.time_ < var_446_30 + var_446_40 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_30) / var_446_40

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_30 + var_446_40 and arg_443_1.time_ < var_446_30 + var_446_40 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play411041108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 411041108
		arg_447_1.duration_ = 11.57

		local var_447_0 = {
			zh = 8.9,
			ja = 11.566
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play411041109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 0.975

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[264].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(411041108)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 39
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041108", "story_v_out_411041.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_411041", "411041108", "story_v_out_411041.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_411041", "411041108", "story_v_out_411041.awb")

						arg_447_1:RecordAudio("411041108", var_450_9)
						arg_447_1:RecordAudio("411041108", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_411041", "411041108", "story_v_out_411041.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_411041", "411041108", "story_v_out_411041.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play411041109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 411041109
		arg_451_1.duration_ = 11.7

		local var_451_0 = {
			zh = 11.7,
			ja = 10.6
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play411041110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1095ui_story"].transform
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 then
				arg_451_1.var_.moveOldPos1095ui_story = var_454_0.localPosition
			end

			local var_454_2 = 0.001

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2
				local var_454_4 = Vector3.New(0, -0.98, -6.1)

				var_454_0.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1095ui_story, var_454_4, var_454_3)

				local var_454_5 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_5.x, var_454_5.y, var_454_5.z)

				local var_454_6 = var_454_0.localEulerAngles

				var_454_6.z = 0
				var_454_6.x = 0
				var_454_0.localEulerAngles = var_454_6
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 then
				var_454_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_454_7 = manager.ui.mainCamera.transform.position - var_454_0.position

				var_454_0.forward = Vector3.New(var_454_7.x, var_454_7.y, var_454_7.z)

				local var_454_8 = var_454_0.localEulerAngles

				var_454_8.z = 0
				var_454_8.x = 0
				var_454_0.localEulerAngles = var_454_8
			end

			local var_454_9 = arg_451_1.actors_["1095ui_story"]
			local var_454_10 = 0

			if var_454_10 < arg_451_1.time_ and arg_451_1.time_ <= var_454_10 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1095ui_story == nil then
				arg_451_1.var_.characterEffect1095ui_story = var_454_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_11 = 0.200000002980232

			if var_454_10 <= arg_451_1.time_ and arg_451_1.time_ < var_454_10 + var_454_11 and not isNil(var_454_9) then
				local var_454_12 = (arg_451_1.time_ - var_454_10) / var_454_11

				if arg_451_1.var_.characterEffect1095ui_story and not isNil(var_454_9) then
					arg_451_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_10 + var_454_11 and arg_451_1.time_ < var_454_10 + var_454_11 + arg_454_0 and not isNil(var_454_9) and arg_451_1.var_.characterEffect1095ui_story then
				arg_451_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_454_13 = 0

			if var_454_13 < arg_451_1.time_ and arg_451_1.time_ <= var_454_13 + arg_454_0 then
				arg_451_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_454_14 = 0

			if var_454_14 < arg_451_1.time_ and arg_451_1.time_ <= var_454_14 + arg_454_0 then
				arg_451_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_15 = arg_451_1.actors_["10014ui_story"].transform
			local var_454_16 = 0

			if var_454_16 < arg_451_1.time_ and arg_451_1.time_ <= var_454_16 + arg_454_0 then
				arg_451_1.var_.moveOldPos10014ui_story = var_454_15.localPosition
			end

			local var_454_17 = 0.001

			if var_454_16 <= arg_451_1.time_ and arg_451_1.time_ < var_454_16 + var_454_17 then
				local var_454_18 = (arg_451_1.time_ - var_454_16) / var_454_17
				local var_454_19 = Vector3.New(0, 100, 0)

				var_454_15.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10014ui_story, var_454_19, var_454_18)

				local var_454_20 = manager.ui.mainCamera.transform.position - var_454_15.position

				var_454_15.forward = Vector3.New(var_454_20.x, var_454_20.y, var_454_20.z)

				local var_454_21 = var_454_15.localEulerAngles

				var_454_21.z = 0
				var_454_21.x = 0
				var_454_15.localEulerAngles = var_454_21
			end

			if arg_451_1.time_ >= var_454_16 + var_454_17 and arg_451_1.time_ < var_454_16 + var_454_17 + arg_454_0 then
				var_454_15.localPosition = Vector3.New(0, 100, 0)

				local var_454_22 = manager.ui.mainCamera.transform.position - var_454_15.position

				var_454_15.forward = Vector3.New(var_454_22.x, var_454_22.y, var_454_22.z)

				local var_454_23 = var_454_15.localEulerAngles

				var_454_23.z = 0
				var_454_23.x = 0
				var_454_15.localEulerAngles = var_454_23
			end

			local var_454_24 = arg_451_1.actors_["10014ui_story"]
			local var_454_25 = 0

			if var_454_25 < arg_451_1.time_ and arg_451_1.time_ <= var_454_25 + arg_454_0 and not isNil(var_454_24) and arg_451_1.var_.characterEffect10014ui_story == nil then
				arg_451_1.var_.characterEffect10014ui_story = var_454_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_26 = 0.200000002980232

			if var_454_25 <= arg_451_1.time_ and arg_451_1.time_ < var_454_25 + var_454_26 and not isNil(var_454_24) then
				local var_454_27 = (arg_451_1.time_ - var_454_25) / var_454_26

				if arg_451_1.var_.characterEffect10014ui_story and not isNil(var_454_24) then
					local var_454_28 = Mathf.Lerp(0, 0.5, var_454_27)

					arg_451_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_451_1.var_.characterEffect10014ui_story.fillRatio = var_454_28
				end
			end

			if arg_451_1.time_ >= var_454_25 + var_454_26 and arg_451_1.time_ < var_454_25 + var_454_26 + arg_454_0 and not isNil(var_454_24) and arg_451_1.var_.characterEffect10014ui_story then
				local var_454_29 = 0.5

				arg_451_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_451_1.var_.characterEffect10014ui_story.fillRatio = var_454_29
			end

			local var_454_30 = 0
			local var_454_31 = 1.4

			if var_454_30 < arg_451_1.time_ and arg_451_1.time_ <= var_454_30 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_32 = arg_451_1:FormatText(StoryNameCfg[471].name)

				arg_451_1.leftNameTxt_.text = var_454_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_33 = arg_451_1:GetWordFromCfg(411041109)
				local var_454_34 = arg_451_1:FormatText(var_454_33.content)

				arg_451_1.text_.text = var_454_34

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_35 = 56
				local var_454_36 = utf8.len(var_454_34)
				local var_454_37 = var_454_35 <= 0 and var_454_31 or var_454_31 * (var_454_36 / var_454_35)

				if var_454_37 > 0 and var_454_31 < var_454_37 then
					arg_451_1.talkMaxDuration = var_454_37

					if var_454_37 + var_454_30 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_37 + var_454_30
					end
				end

				arg_451_1.text_.text = var_454_34
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041109", "story_v_out_411041.awb") ~= 0 then
					local var_454_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041109", "story_v_out_411041.awb") / 1000

					if var_454_38 + var_454_30 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_38 + var_454_30
					end

					if var_454_33.prefab_name ~= "" and arg_451_1.actors_[var_454_33.prefab_name] ~= nil then
						local var_454_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_33.prefab_name].transform, "story_v_out_411041", "411041109", "story_v_out_411041.awb")

						arg_451_1:RecordAudio("411041109", var_454_39)
						arg_451_1:RecordAudio("411041109", var_454_39)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_411041", "411041109", "story_v_out_411041.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_411041", "411041109", "story_v_out_411041.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_40 = math.max(var_454_31, arg_451_1.talkMaxDuration)

			if var_454_30 <= arg_451_1.time_ and arg_451_1.time_ < var_454_30 + var_454_40 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_30) / var_454_40

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_30 + var_454_40 and arg_451_1.time_ < var_454_30 + var_454_40 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play411041110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 411041110
		arg_455_1.duration_ = 2

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play411041111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["10071ui_story"].transform
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.var_.moveOldPos10071ui_story = var_458_0.localPosition
			end

			local var_458_2 = 0.001

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2
				local var_458_4 = Vector3.New(0.7, -0.9, -6.26)

				var_458_0.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10071ui_story, var_458_4, var_458_3)

				local var_458_5 = manager.ui.mainCamera.transform.position - var_458_0.position

				var_458_0.forward = Vector3.New(var_458_5.x, var_458_5.y, var_458_5.z)

				local var_458_6 = var_458_0.localEulerAngles

				var_458_6.z = 0
				var_458_6.x = 0
				var_458_0.localEulerAngles = var_458_6
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 then
				var_458_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_458_7 = manager.ui.mainCamera.transform.position - var_458_0.position

				var_458_0.forward = Vector3.New(var_458_7.x, var_458_7.y, var_458_7.z)

				local var_458_8 = var_458_0.localEulerAngles

				var_458_8.z = 0
				var_458_8.x = 0
				var_458_0.localEulerAngles = var_458_8
			end

			local var_458_9 = arg_455_1.actors_["10071ui_story"]
			local var_458_10 = 0

			if var_458_10 < arg_455_1.time_ and arg_455_1.time_ <= var_458_10 + arg_458_0 and not isNil(var_458_9) and arg_455_1.var_.characterEffect10071ui_story == nil then
				arg_455_1.var_.characterEffect10071ui_story = var_458_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_11 = 0.200000002980232

			if var_458_10 <= arg_455_1.time_ and arg_455_1.time_ < var_458_10 + var_458_11 and not isNil(var_458_9) then
				local var_458_12 = (arg_455_1.time_ - var_458_10) / var_458_11

				if arg_455_1.var_.characterEffect10071ui_story and not isNil(var_458_9) then
					arg_455_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_455_1.time_ >= var_458_10 + var_458_11 and arg_455_1.time_ < var_458_10 + var_458_11 + arg_458_0 and not isNil(var_458_9) and arg_455_1.var_.characterEffect10071ui_story then
				arg_455_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_458_13 = 0

			if var_458_13 < arg_455_1.time_ and arg_455_1.time_ <= var_458_13 + arg_458_0 then
				arg_455_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action3_1")
			end

			local var_458_14 = 0

			if var_458_14 < arg_455_1.time_ and arg_455_1.time_ <= var_458_14 + arg_458_0 then
				arg_455_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_458_15 = arg_455_1.actors_["1095ui_story"].transform
			local var_458_16 = 0

			if var_458_16 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.var_.moveOldPos1095ui_story = var_458_15.localPosition
			end

			local var_458_17 = 0.001

			if var_458_16 <= arg_455_1.time_ and arg_455_1.time_ < var_458_16 + var_458_17 then
				local var_458_18 = (arg_455_1.time_ - var_458_16) / var_458_17
				local var_458_19 = Vector3.New(-0.7, -0.98, -6.1)

				var_458_15.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1095ui_story, var_458_19, var_458_18)

				local var_458_20 = manager.ui.mainCamera.transform.position - var_458_15.position

				var_458_15.forward = Vector3.New(var_458_20.x, var_458_20.y, var_458_20.z)

				local var_458_21 = var_458_15.localEulerAngles

				var_458_21.z = 0
				var_458_21.x = 0
				var_458_15.localEulerAngles = var_458_21
			end

			if arg_455_1.time_ >= var_458_16 + var_458_17 and arg_455_1.time_ < var_458_16 + var_458_17 + arg_458_0 then
				var_458_15.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_458_22 = manager.ui.mainCamera.transform.position - var_458_15.position

				var_458_15.forward = Vector3.New(var_458_22.x, var_458_22.y, var_458_22.z)

				local var_458_23 = var_458_15.localEulerAngles

				var_458_23.z = 0
				var_458_23.x = 0
				var_458_15.localEulerAngles = var_458_23
			end

			local var_458_24 = arg_455_1.actors_["1095ui_story"]
			local var_458_25 = 0

			if var_458_25 < arg_455_1.time_ and arg_455_1.time_ <= var_458_25 + arg_458_0 and not isNil(var_458_24) and arg_455_1.var_.characterEffect1095ui_story == nil then
				arg_455_1.var_.characterEffect1095ui_story = var_458_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_26 = 0.200000002980232

			if var_458_25 <= arg_455_1.time_ and arg_455_1.time_ < var_458_25 + var_458_26 and not isNil(var_458_24) then
				local var_458_27 = (arg_455_1.time_ - var_458_25) / var_458_26

				if arg_455_1.var_.characterEffect1095ui_story and not isNil(var_458_24) then
					local var_458_28 = Mathf.Lerp(0, 0.5, var_458_27)

					arg_455_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1095ui_story.fillRatio = var_458_28
				end
			end

			if arg_455_1.time_ >= var_458_25 + var_458_26 and arg_455_1.time_ < var_458_25 + var_458_26 + arg_458_0 and not isNil(var_458_24) and arg_455_1.var_.characterEffect1095ui_story then
				local var_458_29 = 0.5

				arg_455_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1095ui_story.fillRatio = var_458_29
			end

			local var_458_30 = 0
			local var_458_31 = 0.075

			if var_458_30 < arg_455_1.time_ and arg_455_1.time_ <= var_458_30 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_32 = arg_455_1:FormatText(StoryNameCfg[670].name)

				arg_455_1.leftNameTxt_.text = var_458_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_33 = arg_455_1:GetWordFromCfg(411041110)
				local var_458_34 = arg_455_1:FormatText(var_458_33.content)

				arg_455_1.text_.text = var_458_34

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_35 = 3
				local var_458_36 = utf8.len(var_458_34)
				local var_458_37 = var_458_35 <= 0 and var_458_31 or var_458_31 * (var_458_36 / var_458_35)

				if var_458_37 > 0 and var_458_31 < var_458_37 then
					arg_455_1.talkMaxDuration = var_458_37

					if var_458_37 + var_458_30 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_37 + var_458_30
					end
				end

				arg_455_1.text_.text = var_458_34
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041110", "story_v_out_411041.awb") ~= 0 then
					local var_458_38 = manager.audio:GetVoiceLength("story_v_out_411041", "411041110", "story_v_out_411041.awb") / 1000

					if var_458_38 + var_458_30 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_38 + var_458_30
					end

					if var_458_33.prefab_name ~= "" and arg_455_1.actors_[var_458_33.prefab_name] ~= nil then
						local var_458_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_33.prefab_name].transform, "story_v_out_411041", "411041110", "story_v_out_411041.awb")

						arg_455_1:RecordAudio("411041110", var_458_39)
						arg_455_1:RecordAudio("411041110", var_458_39)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_411041", "411041110", "story_v_out_411041.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_411041", "411041110", "story_v_out_411041.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_40 = math.max(var_458_31, arg_455_1.talkMaxDuration)

			if var_458_30 <= arg_455_1.time_ and arg_455_1.time_ < var_458_30 + var_458_40 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_30) / var_458_40

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_30 + var_458_40 and arg_455_1.time_ < var_458_30 + var_458_40 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play411041111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 411041111
		arg_459_1.duration_ = 15.03

		local var_459_0 = {
			zh = 15.033,
			ja = 5.9
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play411041112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = arg_459_1.actors_["10071ui_story"]
			local var_462_1 = 0

			if var_462_1 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect10071ui_story == nil then
				arg_459_1.var_.characterEffect10071ui_story = var_462_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_2 = 0.200000002980232

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_2 and not isNil(var_462_0) then
				local var_462_3 = (arg_459_1.time_ - var_462_1) / var_462_2

				if arg_459_1.var_.characterEffect10071ui_story and not isNil(var_462_0) then
					local var_462_4 = Mathf.Lerp(0, 0.5, var_462_3)

					arg_459_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_459_1.var_.characterEffect10071ui_story.fillRatio = var_462_4
				end
			end

			if arg_459_1.time_ >= var_462_1 + var_462_2 and arg_459_1.time_ < var_462_1 + var_462_2 + arg_462_0 and not isNil(var_462_0) and arg_459_1.var_.characterEffect10071ui_story then
				local var_462_5 = 0.5

				arg_459_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_459_1.var_.characterEffect10071ui_story.fillRatio = var_462_5
			end

			local var_462_6 = arg_459_1.actors_["1095ui_story"]
			local var_462_7 = 0

			if var_462_7 < arg_459_1.time_ and arg_459_1.time_ <= var_462_7 + arg_462_0 and not isNil(var_462_6) and arg_459_1.var_.characterEffect1095ui_story == nil then
				arg_459_1.var_.characterEffect1095ui_story = var_462_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_8 = 0.200000002980232

			if var_462_7 <= arg_459_1.time_ and arg_459_1.time_ < var_462_7 + var_462_8 and not isNil(var_462_6) then
				local var_462_9 = (arg_459_1.time_ - var_462_7) / var_462_8

				if arg_459_1.var_.characterEffect1095ui_story and not isNil(var_462_6) then
					arg_459_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= var_462_7 + var_462_8 and arg_459_1.time_ < var_462_7 + var_462_8 + arg_462_0 and not isNil(var_462_6) and arg_459_1.var_.characterEffect1095ui_story then
				arg_459_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_462_10 = 0
			local var_462_11 = 1.5

			if var_462_10 < arg_459_1.time_ and arg_459_1.time_ <= var_462_10 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_12 = arg_459_1:FormatText(StoryNameCfg[471].name)

				arg_459_1.leftNameTxt_.text = var_462_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_13 = arg_459_1:GetWordFromCfg(411041111)
				local var_462_14 = arg_459_1:FormatText(var_462_13.content)

				arg_459_1.text_.text = var_462_14

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_15 = 60
				local var_462_16 = utf8.len(var_462_14)
				local var_462_17 = var_462_15 <= 0 and var_462_11 or var_462_11 * (var_462_16 / var_462_15)

				if var_462_17 > 0 and var_462_11 < var_462_17 then
					arg_459_1.talkMaxDuration = var_462_17

					if var_462_17 + var_462_10 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_17 + var_462_10
					end
				end

				arg_459_1.text_.text = var_462_14
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041111", "story_v_out_411041.awb") ~= 0 then
					local var_462_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041111", "story_v_out_411041.awb") / 1000

					if var_462_18 + var_462_10 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_18 + var_462_10
					end

					if var_462_13.prefab_name ~= "" and arg_459_1.actors_[var_462_13.prefab_name] ~= nil then
						local var_462_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_13.prefab_name].transform, "story_v_out_411041", "411041111", "story_v_out_411041.awb")

						arg_459_1:RecordAudio("411041111", var_462_19)
						arg_459_1:RecordAudio("411041111", var_462_19)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_411041", "411041111", "story_v_out_411041.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_411041", "411041111", "story_v_out_411041.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_20 = math.max(var_462_11, arg_459_1.talkMaxDuration)

			if var_462_10 <= arg_459_1.time_ and arg_459_1.time_ < var_462_10 + var_462_20 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_10) / var_462_20

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_10 + var_462_20 and arg_459_1.time_ < var_462_10 + var_462_20 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play411041112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 411041112
		arg_463_1.duration_ = 8.93

		local var_463_0 = {
			zh = 8.933,
			ja = 6.866
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play411041113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["10071ui_story"]
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect10071ui_story == nil then
				arg_463_1.var_.characterEffect10071ui_story = var_466_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_2 = 0.200000002980232

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 and not isNil(var_466_0) then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2

				if arg_463_1.var_.characterEffect10071ui_story and not isNil(var_466_0) then
					arg_463_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 and not isNil(var_466_0) and arg_463_1.var_.characterEffect10071ui_story then
				arg_463_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_466_4 = arg_463_1.actors_["1095ui_story"]
			local var_466_5 = 0

			if var_466_5 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 and not isNil(var_466_4) and arg_463_1.var_.characterEffect1095ui_story == nil then
				arg_463_1.var_.characterEffect1095ui_story = var_466_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_6 = 0.200000002980232

			if var_466_5 <= arg_463_1.time_ and arg_463_1.time_ < var_466_5 + var_466_6 and not isNil(var_466_4) then
				local var_466_7 = (arg_463_1.time_ - var_466_5) / var_466_6

				if arg_463_1.var_.characterEffect1095ui_story and not isNil(var_466_4) then
					local var_466_8 = Mathf.Lerp(0, 0.5, var_466_7)

					arg_463_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1095ui_story.fillRatio = var_466_8
				end
			end

			if arg_463_1.time_ >= var_466_5 + var_466_6 and arg_463_1.time_ < var_466_5 + var_466_6 + arg_466_0 and not isNil(var_466_4) and arg_463_1.var_.characterEffect1095ui_story then
				local var_466_9 = 0.5

				arg_463_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1095ui_story.fillRatio = var_466_9
			end

			local var_466_10 = 0
			local var_466_11 = 0.65

			if var_466_10 < arg_463_1.time_ and arg_463_1.time_ <= var_466_10 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_12 = arg_463_1:FormatText(StoryNameCfg[670].name)

				arg_463_1.leftNameTxt_.text = var_466_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_13 = arg_463_1:GetWordFromCfg(411041112)
				local var_466_14 = arg_463_1:FormatText(var_466_13.content)

				arg_463_1.text_.text = var_466_14

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_15 = 26
				local var_466_16 = utf8.len(var_466_14)
				local var_466_17 = var_466_15 <= 0 and var_466_11 or var_466_11 * (var_466_16 / var_466_15)

				if var_466_17 > 0 and var_466_11 < var_466_17 then
					arg_463_1.talkMaxDuration = var_466_17

					if var_466_17 + var_466_10 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_17 + var_466_10
					end
				end

				arg_463_1.text_.text = var_466_14
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041112", "story_v_out_411041.awb") ~= 0 then
					local var_466_18 = manager.audio:GetVoiceLength("story_v_out_411041", "411041112", "story_v_out_411041.awb") / 1000

					if var_466_18 + var_466_10 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_18 + var_466_10
					end

					if var_466_13.prefab_name ~= "" and arg_463_1.actors_[var_466_13.prefab_name] ~= nil then
						local var_466_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_13.prefab_name].transform, "story_v_out_411041", "411041112", "story_v_out_411041.awb")

						arg_463_1:RecordAudio("411041112", var_466_19)
						arg_463_1:RecordAudio("411041112", var_466_19)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_411041", "411041112", "story_v_out_411041.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_411041", "411041112", "story_v_out_411041.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_20 = math.max(var_466_11, arg_463_1.talkMaxDuration)

			if var_466_10 <= arg_463_1.time_ and arg_463_1.time_ < var_466_10 + var_466_20 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_10) / var_466_20

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_10 + var_466_20 and arg_463_1.time_ < var_466_10 + var_466_20 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play411041113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 411041113
		arg_467_1.duration_ = 8.9

		local var_467_0 = {
			zh = 8.9,
			ja = 7.333
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play411041114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = arg_467_1.actors_["10014ui_story"].transform
			local var_470_1 = 0

			if var_470_1 < arg_467_1.time_ and arg_467_1.time_ <= var_470_1 + arg_470_0 then
				arg_467_1.var_.moveOldPos10014ui_story = var_470_0.localPosition
			end

			local var_470_2 = 0.001

			if var_470_1 <= arg_467_1.time_ and arg_467_1.time_ < var_470_1 + var_470_2 then
				local var_470_3 = (arg_467_1.time_ - var_470_1) / var_470_2
				local var_470_4 = Vector3.New(0, -1.06, -6.2)

				var_470_0.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10014ui_story, var_470_4, var_470_3)

				local var_470_5 = manager.ui.mainCamera.transform.position - var_470_0.position

				var_470_0.forward = Vector3.New(var_470_5.x, var_470_5.y, var_470_5.z)

				local var_470_6 = var_470_0.localEulerAngles

				var_470_6.z = 0
				var_470_6.x = 0
				var_470_0.localEulerAngles = var_470_6
			end

			if arg_467_1.time_ >= var_470_1 + var_470_2 and arg_467_1.time_ < var_470_1 + var_470_2 + arg_470_0 then
				var_470_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_470_7 = manager.ui.mainCamera.transform.position - var_470_0.position

				var_470_0.forward = Vector3.New(var_470_7.x, var_470_7.y, var_470_7.z)

				local var_470_8 = var_470_0.localEulerAngles

				var_470_8.z = 0
				var_470_8.x = 0
				var_470_0.localEulerAngles = var_470_8
			end

			local var_470_9 = arg_467_1.actors_["10014ui_story"]
			local var_470_10 = 0

			if var_470_10 < arg_467_1.time_ and arg_467_1.time_ <= var_470_10 + arg_470_0 and not isNil(var_470_9) and arg_467_1.var_.characterEffect10014ui_story == nil then
				arg_467_1.var_.characterEffect10014ui_story = var_470_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_11 = 0.200000002980232

			if var_470_10 <= arg_467_1.time_ and arg_467_1.time_ < var_470_10 + var_470_11 and not isNil(var_470_9) then
				local var_470_12 = (arg_467_1.time_ - var_470_10) / var_470_11

				if arg_467_1.var_.characterEffect10014ui_story and not isNil(var_470_9) then
					arg_467_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= var_470_10 + var_470_11 and arg_467_1.time_ < var_470_10 + var_470_11 + arg_470_0 and not isNil(var_470_9) and arg_467_1.var_.characterEffect10014ui_story then
				arg_467_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_470_13 = 0

			if var_470_13 < arg_467_1.time_ and arg_467_1.time_ <= var_470_13 + arg_470_0 then
				arg_467_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_470_14 = 0

			if var_470_14 < arg_467_1.time_ and arg_467_1.time_ <= var_470_14 + arg_470_0 then
				arg_467_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_470_15 = arg_467_1.actors_["10071ui_story"].transform
			local var_470_16 = 0

			if var_470_16 < arg_467_1.time_ and arg_467_1.time_ <= var_470_16 + arg_470_0 then
				arg_467_1.var_.moveOldPos10071ui_story = var_470_15.localPosition
			end

			local var_470_17 = 0.001

			if var_470_16 <= arg_467_1.time_ and arg_467_1.time_ < var_470_16 + var_470_17 then
				local var_470_18 = (arg_467_1.time_ - var_470_16) / var_470_17
				local var_470_19 = Vector3.New(0, 100, 0)

				var_470_15.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos10071ui_story, var_470_19, var_470_18)

				local var_470_20 = manager.ui.mainCamera.transform.position - var_470_15.position

				var_470_15.forward = Vector3.New(var_470_20.x, var_470_20.y, var_470_20.z)

				local var_470_21 = var_470_15.localEulerAngles

				var_470_21.z = 0
				var_470_21.x = 0
				var_470_15.localEulerAngles = var_470_21
			end

			if arg_467_1.time_ >= var_470_16 + var_470_17 and arg_467_1.time_ < var_470_16 + var_470_17 + arg_470_0 then
				var_470_15.localPosition = Vector3.New(0, 100, 0)

				local var_470_22 = manager.ui.mainCamera.transform.position - var_470_15.position

				var_470_15.forward = Vector3.New(var_470_22.x, var_470_22.y, var_470_22.z)

				local var_470_23 = var_470_15.localEulerAngles

				var_470_23.z = 0
				var_470_23.x = 0
				var_470_15.localEulerAngles = var_470_23
			end

			local var_470_24 = arg_467_1.actors_["10071ui_story"]
			local var_470_25 = 0

			if var_470_25 < arg_467_1.time_ and arg_467_1.time_ <= var_470_25 + arg_470_0 and not isNil(var_470_24) and arg_467_1.var_.characterEffect10071ui_story == nil then
				arg_467_1.var_.characterEffect10071ui_story = var_470_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_26 = 0.200000002980232

			if var_470_25 <= arg_467_1.time_ and arg_467_1.time_ < var_470_25 + var_470_26 and not isNil(var_470_24) then
				local var_470_27 = (arg_467_1.time_ - var_470_25) / var_470_26

				if arg_467_1.var_.characterEffect10071ui_story and not isNil(var_470_24) then
					local var_470_28 = Mathf.Lerp(0, 0.5, var_470_27)

					arg_467_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_467_1.var_.characterEffect10071ui_story.fillRatio = var_470_28
				end
			end

			if arg_467_1.time_ >= var_470_25 + var_470_26 and arg_467_1.time_ < var_470_25 + var_470_26 + arg_470_0 and not isNil(var_470_24) and arg_467_1.var_.characterEffect10071ui_story then
				local var_470_29 = 0.5

				arg_467_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_467_1.var_.characterEffect10071ui_story.fillRatio = var_470_29
			end

			local var_470_30 = arg_467_1.actors_["1095ui_story"].transform
			local var_470_31 = 0

			if var_470_31 < arg_467_1.time_ and arg_467_1.time_ <= var_470_31 + arg_470_0 then
				arg_467_1.var_.moveOldPos1095ui_story = var_470_30.localPosition
			end

			local var_470_32 = 0.001

			if var_470_31 <= arg_467_1.time_ and arg_467_1.time_ < var_470_31 + var_470_32 then
				local var_470_33 = (arg_467_1.time_ - var_470_31) / var_470_32
				local var_470_34 = Vector3.New(0, 100, 0)

				var_470_30.localPosition = Vector3.Lerp(arg_467_1.var_.moveOldPos1095ui_story, var_470_34, var_470_33)

				local var_470_35 = manager.ui.mainCamera.transform.position - var_470_30.position

				var_470_30.forward = Vector3.New(var_470_35.x, var_470_35.y, var_470_35.z)

				local var_470_36 = var_470_30.localEulerAngles

				var_470_36.z = 0
				var_470_36.x = 0
				var_470_30.localEulerAngles = var_470_36
			end

			if arg_467_1.time_ >= var_470_31 + var_470_32 and arg_467_1.time_ < var_470_31 + var_470_32 + arg_470_0 then
				var_470_30.localPosition = Vector3.New(0, 100, 0)

				local var_470_37 = manager.ui.mainCamera.transform.position - var_470_30.position

				var_470_30.forward = Vector3.New(var_470_37.x, var_470_37.y, var_470_37.z)

				local var_470_38 = var_470_30.localEulerAngles

				var_470_38.z = 0
				var_470_38.x = 0
				var_470_30.localEulerAngles = var_470_38
			end

			local var_470_39 = arg_467_1.actors_["1095ui_story"]
			local var_470_40 = 0

			if var_470_40 < arg_467_1.time_ and arg_467_1.time_ <= var_470_40 + arg_470_0 and not isNil(var_470_39) and arg_467_1.var_.characterEffect1095ui_story == nil then
				arg_467_1.var_.characterEffect1095ui_story = var_470_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_41 = 0.200000002980232

			if var_470_40 <= arg_467_1.time_ and arg_467_1.time_ < var_470_40 + var_470_41 and not isNil(var_470_39) then
				local var_470_42 = (arg_467_1.time_ - var_470_40) / var_470_41

				if arg_467_1.var_.characterEffect1095ui_story and not isNil(var_470_39) then
					local var_470_43 = Mathf.Lerp(0, 0.5, var_470_42)

					arg_467_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_467_1.var_.characterEffect1095ui_story.fillRatio = var_470_43
				end
			end

			if arg_467_1.time_ >= var_470_40 + var_470_41 and arg_467_1.time_ < var_470_40 + var_470_41 + arg_470_0 and not isNil(var_470_39) and arg_467_1.var_.characterEffect1095ui_story then
				local var_470_44 = 0.5

				arg_467_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_467_1.var_.characterEffect1095ui_story.fillRatio = var_470_44
			end

			local var_470_45 = 0
			local var_470_46 = 0.975

			if var_470_45 < arg_467_1.time_ and arg_467_1.time_ <= var_470_45 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_47 = arg_467_1:FormatText(StoryNameCfg[264].name)

				arg_467_1.leftNameTxt_.text = var_470_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_48 = arg_467_1:GetWordFromCfg(411041113)
				local var_470_49 = arg_467_1:FormatText(var_470_48.content)

				arg_467_1.text_.text = var_470_49

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_50 = 39
				local var_470_51 = utf8.len(var_470_49)
				local var_470_52 = var_470_50 <= 0 and var_470_46 or var_470_46 * (var_470_51 / var_470_50)

				if var_470_52 > 0 and var_470_46 < var_470_52 then
					arg_467_1.talkMaxDuration = var_470_52

					if var_470_52 + var_470_45 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_52 + var_470_45
					end
				end

				arg_467_1.text_.text = var_470_49
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041113", "story_v_out_411041.awb") ~= 0 then
					local var_470_53 = manager.audio:GetVoiceLength("story_v_out_411041", "411041113", "story_v_out_411041.awb") / 1000

					if var_470_53 + var_470_45 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_53 + var_470_45
					end

					if var_470_48.prefab_name ~= "" and arg_467_1.actors_[var_470_48.prefab_name] ~= nil then
						local var_470_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_48.prefab_name].transform, "story_v_out_411041", "411041113", "story_v_out_411041.awb")

						arg_467_1:RecordAudio("411041113", var_470_54)
						arg_467_1:RecordAudio("411041113", var_470_54)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_411041", "411041113", "story_v_out_411041.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_411041", "411041113", "story_v_out_411041.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_55 = math.max(var_470_46, arg_467_1.talkMaxDuration)

			if var_470_45 <= arg_467_1.time_ and arg_467_1.time_ < var_470_45 + var_470_55 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_45) / var_470_55

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_45 + var_470_55 and arg_467_1.time_ < var_470_45 + var_470_55 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_467_1:InitPlayNodeList()
	end,
	Play411041114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 411041114
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play411041115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["10014ui_story"].transform
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.var_.moveOldPos10014ui_story = var_474_0.localPosition
			end

			local var_474_2 = 0.001

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2
				local var_474_4 = Vector3.New(0, 100, 0)

				var_474_0.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos10014ui_story, var_474_4, var_474_3)

				local var_474_5 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_5.x, var_474_5.y, var_474_5.z)

				local var_474_6 = var_474_0.localEulerAngles

				var_474_6.z = 0
				var_474_6.x = 0
				var_474_0.localEulerAngles = var_474_6
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 then
				var_474_0.localPosition = Vector3.New(0, 100, 0)

				local var_474_7 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_7.x, var_474_7.y, var_474_7.z)

				local var_474_8 = var_474_0.localEulerAngles

				var_474_8.z = 0
				var_474_8.x = 0
				var_474_0.localEulerAngles = var_474_8
			end

			local var_474_9 = arg_471_1.actors_["10014ui_story"]
			local var_474_10 = 0

			if var_474_10 < arg_471_1.time_ and arg_471_1.time_ <= var_474_10 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect10014ui_story == nil then
				arg_471_1.var_.characterEffect10014ui_story = var_474_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_11 = 0.200000002980232

			if var_474_10 <= arg_471_1.time_ and arg_471_1.time_ < var_474_10 + var_474_11 and not isNil(var_474_9) then
				local var_474_12 = (arg_471_1.time_ - var_474_10) / var_474_11

				if arg_471_1.var_.characterEffect10014ui_story and not isNil(var_474_9) then
					local var_474_13 = Mathf.Lerp(0, 0.5, var_474_12)

					arg_471_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_471_1.var_.characterEffect10014ui_story.fillRatio = var_474_13
				end
			end

			if arg_471_1.time_ >= var_474_10 + var_474_11 and arg_471_1.time_ < var_474_10 + var_474_11 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect10014ui_story then
				local var_474_14 = 0.5

				arg_471_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_471_1.var_.characterEffect10014ui_story.fillRatio = var_474_14
			end

			local var_474_15 = 0
			local var_474_16 = 1.325

			if var_474_15 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_17 = arg_471_1:GetWordFromCfg(411041114)
				local var_474_18 = arg_471_1:FormatText(var_474_17.content)

				arg_471_1.text_.text = var_474_18

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_19 = 53
				local var_474_20 = utf8.len(var_474_18)
				local var_474_21 = var_474_19 <= 0 and var_474_16 or var_474_16 * (var_474_20 / var_474_19)

				if var_474_21 > 0 and var_474_16 < var_474_21 then
					arg_471_1.talkMaxDuration = var_474_21

					if var_474_21 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_21 + var_474_15
					end
				end

				arg_471_1.text_.text = var_474_18
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_22 = math.max(var_474_16, arg_471_1.talkMaxDuration)

			if var_474_15 <= arg_471_1.time_ and arg_471_1.time_ < var_474_15 + var_474_22 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_15) / var_474_22

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_15 + var_474_22 and arg_471_1.time_ < var_474_15 + var_474_22 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_471_1:InitPlayNodeList()
	end,
	Play411041115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 411041115
		arg_475_1.duration_ = 10.67

		local var_475_0 = {
			zh = 9.5,
			ja = 10.666
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play411041116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1095ui_story"].transform
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 then
				arg_475_1.var_.moveOldPos1095ui_story = var_478_0.localPosition
			end

			local var_478_2 = 0.001

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2
				local var_478_4 = Vector3.New(0, -0.98, -6.1)

				var_478_0.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1095ui_story, var_478_4, var_478_3)

				local var_478_5 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_5.x, var_478_5.y, var_478_5.z)

				local var_478_6 = var_478_0.localEulerAngles

				var_478_6.z = 0
				var_478_6.x = 0
				var_478_0.localEulerAngles = var_478_6
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 then
				var_478_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_478_7 = manager.ui.mainCamera.transform.position - var_478_0.position

				var_478_0.forward = Vector3.New(var_478_7.x, var_478_7.y, var_478_7.z)

				local var_478_8 = var_478_0.localEulerAngles

				var_478_8.z = 0
				var_478_8.x = 0
				var_478_0.localEulerAngles = var_478_8
			end

			local var_478_9 = arg_475_1.actors_["1095ui_story"]
			local var_478_10 = 0

			if var_478_10 < arg_475_1.time_ and arg_475_1.time_ <= var_478_10 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1095ui_story == nil then
				arg_475_1.var_.characterEffect1095ui_story = var_478_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_11 = 0.200000002980232

			if var_478_10 <= arg_475_1.time_ and arg_475_1.time_ < var_478_10 + var_478_11 and not isNil(var_478_9) then
				local var_478_12 = (arg_475_1.time_ - var_478_10) / var_478_11

				if arg_475_1.var_.characterEffect1095ui_story and not isNil(var_478_9) then
					arg_475_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_10 + var_478_11 and arg_475_1.time_ < var_478_10 + var_478_11 + arg_478_0 and not isNil(var_478_9) and arg_475_1.var_.characterEffect1095ui_story then
				arg_475_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_478_13 = 0

			if var_478_13 < arg_475_1.time_ and arg_475_1.time_ <= var_478_13 + arg_478_0 then
				arg_475_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_478_14 = 0

			if var_478_14 < arg_475_1.time_ and arg_475_1.time_ <= var_478_14 + arg_478_0 then
				arg_475_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_478_15 = 0
			local var_478_16 = 0.65

			if var_478_15 < arg_475_1.time_ and arg_475_1.time_ <= var_478_15 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_17 = arg_475_1:FormatText(StoryNameCfg[471].name)

				arg_475_1.leftNameTxt_.text = var_478_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_18 = arg_475_1:GetWordFromCfg(411041115)
				local var_478_19 = arg_475_1:FormatText(var_478_18.content)

				arg_475_1.text_.text = var_478_19

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_20 = 26
				local var_478_21 = utf8.len(var_478_19)
				local var_478_22 = var_478_20 <= 0 and var_478_16 or var_478_16 * (var_478_21 / var_478_20)

				if var_478_22 > 0 and var_478_16 < var_478_22 then
					arg_475_1.talkMaxDuration = var_478_22

					if var_478_22 + var_478_15 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_22 + var_478_15
					end
				end

				arg_475_1.text_.text = var_478_19
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041115", "story_v_out_411041.awb") ~= 0 then
					local var_478_23 = manager.audio:GetVoiceLength("story_v_out_411041", "411041115", "story_v_out_411041.awb") / 1000

					if var_478_23 + var_478_15 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_23 + var_478_15
					end

					if var_478_18.prefab_name ~= "" and arg_475_1.actors_[var_478_18.prefab_name] ~= nil then
						local var_478_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_18.prefab_name].transform, "story_v_out_411041", "411041115", "story_v_out_411041.awb")

						arg_475_1:RecordAudio("411041115", var_478_24)
						arg_475_1:RecordAudio("411041115", var_478_24)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_411041", "411041115", "story_v_out_411041.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_411041", "411041115", "story_v_out_411041.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_25 = math.max(var_478_16, arg_475_1.talkMaxDuration)

			if var_478_15 <= arg_475_1.time_ and arg_475_1.time_ < var_478_15 + var_478_25 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_15) / var_478_25

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_15 + var_478_25 and arg_475_1.time_ < var_478_15 + var_478_25 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play411041116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 411041116
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play411041117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1095ui_story"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1095ui_story == nil then
				arg_479_1.var_.characterEffect1095ui_story = var_482_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.characterEffect1095ui_story and not isNil(var_482_0) then
					local var_482_4 = Mathf.Lerp(0, 0.5, var_482_3)

					arg_479_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_479_1.var_.characterEffect1095ui_story.fillRatio = var_482_4
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.characterEffect1095ui_story then
				local var_482_5 = 0.5

				arg_479_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_479_1.var_.characterEffect1095ui_story.fillRatio = var_482_5
			end

			local var_482_6 = 0
			local var_482_7 = 0.8

			if var_482_6 < arg_479_1.time_ and arg_479_1.time_ <= var_482_6 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_8 = arg_479_1:GetWordFromCfg(411041116)
				local var_482_9 = arg_479_1:FormatText(var_482_8.content)

				arg_479_1.text_.text = var_482_9

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_10 = 32
				local var_482_11 = utf8.len(var_482_9)
				local var_482_12 = var_482_10 <= 0 and var_482_7 or var_482_7 * (var_482_11 / var_482_10)

				if var_482_12 > 0 and var_482_7 < var_482_12 then
					arg_479_1.talkMaxDuration = var_482_12

					if var_482_12 + var_482_6 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_12 + var_482_6
					end
				end

				arg_479_1.text_.text = var_482_9
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_13 = math.max(var_482_7, arg_479_1.talkMaxDuration)

			if var_482_6 <= arg_479_1.time_ and arg_479_1.time_ < var_482_6 + var_482_13 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_6) / var_482_13

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_6 + var_482_13 and arg_479_1.time_ < var_482_6 + var_482_13 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play411041117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 411041117
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play411041118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.475

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(411041117)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 59
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play411041118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 411041118
		arg_487_1.duration_ = 7.57

		local var_487_0 = {
			zh = 7.566,
			ja = 5.633
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play411041119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["10071ui_story"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos10071ui_story = var_490_0.localPosition
			end

			local var_490_2 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2
				local var_490_4 = Vector3.New(0.7, -0.9, -6.26)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10071ui_story, var_490_4, var_490_3)

				local var_490_5 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_5.x, var_490_5.y, var_490_5.z)

				local var_490_6 = var_490_0.localEulerAngles

				var_490_6.z = 0
				var_490_6.x = 0
				var_490_0.localEulerAngles = var_490_6
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(0.7, -0.9, -6.26)

				local var_490_7 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_7.x, var_490_7.y, var_490_7.z)

				local var_490_8 = var_490_0.localEulerAngles

				var_490_8.z = 0
				var_490_8.x = 0
				var_490_0.localEulerAngles = var_490_8
			end

			local var_490_9 = arg_487_1.actors_["10071ui_story"]
			local var_490_10 = 0

			if var_490_10 < arg_487_1.time_ and arg_487_1.time_ <= var_490_10 + arg_490_0 and not isNil(var_490_9) and arg_487_1.var_.characterEffect10071ui_story == nil then
				arg_487_1.var_.characterEffect10071ui_story = var_490_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_11 = 0.200000002980232

			if var_490_10 <= arg_487_1.time_ and arg_487_1.time_ < var_490_10 + var_490_11 and not isNil(var_490_9) then
				local var_490_12 = (arg_487_1.time_ - var_490_10) / var_490_11

				if arg_487_1.var_.characterEffect10071ui_story and not isNil(var_490_9) then
					arg_487_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_10 + var_490_11 and arg_487_1.time_ < var_490_10 + var_490_11 + arg_490_0 and not isNil(var_490_9) and arg_487_1.var_.characterEffect10071ui_story then
				arg_487_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_490_13 = arg_487_1.actors_["1095ui_story"].transform
			local var_490_14 = 0

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1.var_.moveOldPos1095ui_story = var_490_13.localPosition
			end

			local var_490_15 = 0.001

			if var_490_14 <= arg_487_1.time_ and arg_487_1.time_ < var_490_14 + var_490_15 then
				local var_490_16 = (arg_487_1.time_ - var_490_14) / var_490_15
				local var_490_17 = Vector3.New(-0.7, -0.98, -6.1)

				var_490_13.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1095ui_story, var_490_17, var_490_16)

				local var_490_18 = manager.ui.mainCamera.transform.position - var_490_13.position

				var_490_13.forward = Vector3.New(var_490_18.x, var_490_18.y, var_490_18.z)

				local var_490_19 = var_490_13.localEulerAngles

				var_490_19.z = 0
				var_490_19.x = 0
				var_490_13.localEulerAngles = var_490_19
			end

			if arg_487_1.time_ >= var_490_14 + var_490_15 and arg_487_1.time_ < var_490_14 + var_490_15 + arg_490_0 then
				var_490_13.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_490_20 = manager.ui.mainCamera.transform.position - var_490_13.position

				var_490_13.forward = Vector3.New(var_490_20.x, var_490_20.y, var_490_20.z)

				local var_490_21 = var_490_13.localEulerAngles

				var_490_21.z = 0
				var_490_21.x = 0
				var_490_13.localEulerAngles = var_490_21
			end

			local var_490_22 = arg_487_1.actors_["1095ui_story"]
			local var_490_23 = 0

			if var_490_23 < arg_487_1.time_ and arg_487_1.time_ <= var_490_23 + arg_490_0 and not isNil(var_490_22) and arg_487_1.var_.characterEffect1095ui_story == nil then
				arg_487_1.var_.characterEffect1095ui_story = var_490_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_24 = 0.200000002980232

			if var_490_23 <= arg_487_1.time_ and arg_487_1.time_ < var_490_23 + var_490_24 and not isNil(var_490_22) then
				local var_490_25 = (arg_487_1.time_ - var_490_23) / var_490_24

				if arg_487_1.var_.characterEffect1095ui_story and not isNil(var_490_22) then
					local var_490_26 = Mathf.Lerp(0, 0.5, var_490_25)

					arg_487_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1095ui_story.fillRatio = var_490_26
				end
			end

			if arg_487_1.time_ >= var_490_23 + var_490_24 and arg_487_1.time_ < var_490_23 + var_490_24 + arg_490_0 and not isNil(var_490_22) and arg_487_1.var_.characterEffect1095ui_story then
				local var_490_27 = 0.5

				arg_487_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1095ui_story.fillRatio = var_490_27
			end

			local var_490_28 = 0

			if var_490_28 < arg_487_1.time_ and arg_487_1.time_ <= var_490_28 + arg_490_0 then
				arg_487_1:PlayTimeline("10071ui_story", "StoryTimeline/CharAction/story10071/story10071action/10071action1_1")
			end

			local var_490_29 = 0
			local var_490_30 = 0.75

			if var_490_29 < arg_487_1.time_ and arg_487_1.time_ <= var_490_29 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_31 = arg_487_1:FormatText(StoryNameCfg[670].name)

				arg_487_1.leftNameTxt_.text = var_490_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_32 = arg_487_1:GetWordFromCfg(411041118)
				local var_490_33 = arg_487_1:FormatText(var_490_32.content)

				arg_487_1.text_.text = var_490_33

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_34 = 30
				local var_490_35 = utf8.len(var_490_33)
				local var_490_36 = var_490_34 <= 0 and var_490_30 or var_490_30 * (var_490_35 / var_490_34)

				if var_490_36 > 0 and var_490_30 < var_490_36 then
					arg_487_1.talkMaxDuration = var_490_36

					if var_490_36 + var_490_29 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_36 + var_490_29
					end
				end

				arg_487_1.text_.text = var_490_33
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041118", "story_v_out_411041.awb") ~= 0 then
					local var_490_37 = manager.audio:GetVoiceLength("story_v_out_411041", "411041118", "story_v_out_411041.awb") / 1000

					if var_490_37 + var_490_29 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_37 + var_490_29
					end

					if var_490_32.prefab_name ~= "" and arg_487_1.actors_[var_490_32.prefab_name] ~= nil then
						local var_490_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_32.prefab_name].transform, "story_v_out_411041", "411041118", "story_v_out_411041.awb")

						arg_487_1:RecordAudio("411041118", var_490_38)
						arg_487_1:RecordAudio("411041118", var_490_38)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_411041", "411041118", "story_v_out_411041.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_411041", "411041118", "story_v_out_411041.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_39 = math.max(var_490_30, arg_487_1.talkMaxDuration)

			if var_490_29 <= arg_487_1.time_ and arg_487_1.time_ < var_490_29 + var_490_39 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_29) / var_490_39

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_29 + var_490_39 and arg_487_1.time_ < var_490_29 + var_490_39 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play411041119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 411041119
		arg_491_1.duration_ = 5.43

		local var_491_0 = {
			zh = 4.766,
			ja = 5.433
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play411041120(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["10071ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect10071ui_story == nil then
				arg_491_1.var_.characterEffect10071ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 and not isNil(var_494_0) then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect10071ui_story and not isNil(var_494_0) then
					arg_491_1.var_.characterEffect10071ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and not isNil(var_494_0) and arg_491_1.var_.characterEffect10071ui_story then
				arg_491_1.var_.characterEffect10071ui_story.fillFlat = false
			end

			local var_494_4 = 0
			local var_494_5 = 0.475

			if var_494_4 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_6 = arg_491_1:FormatText(StoryNameCfg[670].name)

				arg_491_1.leftNameTxt_.text = var_494_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_7 = arg_491_1:GetWordFromCfg(411041119)
				local var_494_8 = arg_491_1:FormatText(var_494_7.content)

				arg_491_1.text_.text = var_494_8

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_9 = 19
				local var_494_10 = utf8.len(var_494_8)
				local var_494_11 = var_494_9 <= 0 and var_494_5 or var_494_5 * (var_494_10 / var_494_9)

				if var_494_11 > 0 and var_494_5 < var_494_11 then
					arg_491_1.talkMaxDuration = var_494_11

					if var_494_11 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_4
					end
				end

				arg_491_1.text_.text = var_494_8
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411041", "411041119", "story_v_out_411041.awb") ~= 0 then
					local var_494_12 = manager.audio:GetVoiceLength("story_v_out_411041", "411041119", "story_v_out_411041.awb") / 1000

					if var_494_12 + var_494_4 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_12 + var_494_4
					end

					if var_494_7.prefab_name ~= "" and arg_491_1.actors_[var_494_7.prefab_name] ~= nil then
						local var_494_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_7.prefab_name].transform, "story_v_out_411041", "411041119", "story_v_out_411041.awb")

						arg_491_1:RecordAudio("411041119", var_494_13)
						arg_491_1:RecordAudio("411041119", var_494_13)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_411041", "411041119", "story_v_out_411041.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_411041", "411041119", "story_v_out_411041.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_14 = math.max(var_494_5, arg_491_1.talkMaxDuration)

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_14 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_4) / var_494_14

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_4 + var_494_14 and arg_491_1.time_ < var_494_4 + var_494_14 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play411041120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 411041120
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play411041121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["10071ui_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10071ui_story == nil then
				arg_495_1.var_.characterEffect10071ui_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect10071ui_story and not isNil(var_498_0) then
					local var_498_4 = Mathf.Lerp(0, 0.5, var_498_3)

					arg_495_1.var_.characterEffect10071ui_story.fillFlat = true
					arg_495_1.var_.characterEffect10071ui_story.fillRatio = var_498_4
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.characterEffect10071ui_story then
				local var_498_5 = 0.5

				arg_495_1.var_.characterEffect10071ui_story.fillFlat = true
				arg_495_1.var_.characterEffect10071ui_story.fillRatio = var_498_5
			end

			local var_498_6 = 0
			local var_498_7 = 1.3

			if var_498_6 < arg_495_1.time_ and arg_495_1.time_ <= var_498_6 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_8 = arg_495_1:GetWordFromCfg(411041120)
				local var_498_9 = arg_495_1:FormatText(var_498_8.content)

				arg_495_1.text_.text = var_498_9

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_10 = 52
				local var_498_11 = utf8.len(var_498_9)
				local var_498_12 = var_498_10 <= 0 and var_498_7 or var_498_7 * (var_498_11 / var_498_10)

				if var_498_12 > 0 and var_498_7 < var_498_12 then
					arg_495_1.talkMaxDuration = var_498_12

					if var_498_12 + var_498_6 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_12 + var_498_6
					end
				end

				arg_495_1.text_.text = var_498_9
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_13 = math.max(var_498_7, arg_495_1.talkMaxDuration)

			if var_498_6 <= arg_495_1.time_ and arg_495_1.time_ < var_498_6 + var_498_13 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_6) / var_498_13

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_6 + var_498_13 and arg_495_1.time_ < var_498_6 + var_498_13 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play411041121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 411041121
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play411041122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.425

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(411041121)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 57
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play411041122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 411041122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
			arg_503_1.auto_ = false
		end

		function arg_503_1.playNext_(arg_505_0)
			arg_503_1.onStoryFinished_()
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.7

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_2 = arg_503_1:GetWordFromCfg(411041122)
				local var_506_3 = arg_503_1:FormatText(var_506_2.content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 28
				local var_506_5 = utf8.len(var_506_3)
				local var_506_6 = var_506_4 <= 0 and var_506_1 or var_506_1 * (var_506_5 / var_506_4)

				if var_506_6 > 0 and var_506_1 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_7 and arg_503_1.time_ < var_506_0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/I07",
		"TextureConfig/Background/ST71a"
	},
	voices = {
		"story_v_out_411041.awb"
	}
}
