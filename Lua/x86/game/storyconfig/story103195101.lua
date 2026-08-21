return {
	Play319511001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319511001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319511002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST72"

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
				local var_4_5 = arg_1_1.bgs_.ST72

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
					if iter_4_0 ~= "ST72" then
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
			local var_4_23 = 0.0666666666666667

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

			local var_4_28 = 0.1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

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
			local var_4_35 = 1.125

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(319511001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 45
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319511002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319511002
		arg_9_1.duration_ = 6.23

		local var_9_0 = {
			zh = 2.5,
			ja = 6.233
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
				arg_9_0:Play319511003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10069ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10069ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10069ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -1.08, -6.33)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10069ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["10069ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10069ui_story == nil then
				arg_9_1.var_.characterEffect10069ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect10069ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10069ui_story then
				arg_9_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = 0
			local var_12_21 = 0.325

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[693].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(319511002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511002", "story_v_out_319511.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_319511", "319511002", "story_v_out_319511.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_319511", "319511002", "story_v_out_319511.awb")

						arg_9_1:RecordAudio("319511002", var_12_29)
						arg_9_1:RecordAudio("319511002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319511", "319511002", "story_v_out_319511.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319511", "319511002", "story_v_out_319511.awb")
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
				actorName = "10069ui_story",
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
	Play319511003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319511003
		arg_13_1.duration_ = 6.3

		local var_13_0 = {
			zh = 4.533,
			ja = 6.3
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319511004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1084ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1084ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0.7, -0.97, -6)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = arg_13_1.actors_["1084ui_story"]
			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_16 = 0.200000002980232

			if var_16_15 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 and not isNil(var_16_14) then
				local var_16_17 = (arg_13_1.time_ - var_16_15) / var_16_16

				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_14) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 and not isNil(var_16_14) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_16_18 = 0

			if var_16_18 < arg_13_1.time_ and arg_13_1.time_ <= var_16_18 + arg_16_0 then
				arg_13_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_16_20 = arg_13_1.actors_["10069ui_story"].transform
			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.var_.moveOldPos10069ui_story = var_16_20.localPosition
			end

			local var_16_22 = 0.001

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_21) / var_16_22
				local var_16_24 = Vector3.New(-0.7, -1.08, -6.33)

				var_16_20.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10069ui_story, var_16_24, var_16_23)

				local var_16_25 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_25.x, var_16_25.y, var_16_25.z)

				local var_16_26 = var_16_20.localEulerAngles

				var_16_26.z = 0
				var_16_26.x = 0
				var_16_20.localEulerAngles = var_16_26
			end

			if arg_13_1.time_ >= var_16_21 + var_16_22 and arg_13_1.time_ < var_16_21 + var_16_22 + arg_16_0 then
				var_16_20.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_16_27 = manager.ui.mainCamera.transform.position - var_16_20.position

				var_16_20.forward = Vector3.New(var_16_27.x, var_16_27.y, var_16_27.z)

				local var_16_28 = var_16_20.localEulerAngles

				var_16_28.z = 0
				var_16_28.x = 0
				var_16_20.localEulerAngles = var_16_28
			end

			local var_16_29 = arg_13_1.actors_["10069ui_story"]
			local var_16_30 = 0

			if var_16_30 < arg_13_1.time_ and arg_13_1.time_ <= var_16_30 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect10069ui_story == nil then
				arg_13_1.var_.characterEffect10069ui_story = var_16_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_31 = 0.200000002980232

			if var_16_30 <= arg_13_1.time_ and arg_13_1.time_ < var_16_30 + var_16_31 and not isNil(var_16_29) then
				local var_16_32 = (arg_13_1.time_ - var_16_30) / var_16_31

				if arg_13_1.var_.characterEffect10069ui_story and not isNil(var_16_29) then
					local var_16_33 = Mathf.Lerp(0, 0.5, var_16_32)

					arg_13_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10069ui_story.fillRatio = var_16_33
				end
			end

			if arg_13_1.time_ >= var_16_30 + var_16_31 and arg_13_1.time_ < var_16_30 + var_16_31 + arg_16_0 and not isNil(var_16_29) and arg_13_1.var_.characterEffect10069ui_story then
				local var_16_34 = 0.5

				arg_13_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10069ui_story.fillRatio = var_16_34
			end

			local var_16_35 = 0
			local var_16_36 = 0.55

			if var_16_35 < arg_13_1.time_ and arg_13_1.time_ <= var_16_35 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_37 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_38 = arg_13_1:GetWordFromCfg(319511003)
				local var_16_39 = arg_13_1:FormatText(var_16_38.content)

				arg_13_1.text_.text = var_16_39

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_40 = 22
				local var_16_41 = utf8.len(var_16_39)
				local var_16_42 = var_16_40 <= 0 and var_16_36 or var_16_36 * (var_16_41 / var_16_40)

				if var_16_42 > 0 and var_16_36 < var_16_42 then
					arg_13_1.talkMaxDuration = var_16_42

					if var_16_42 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_42 + var_16_35
					end
				end

				arg_13_1.text_.text = var_16_39
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511003", "story_v_out_319511.awb") ~= 0 then
					local var_16_43 = manager.audio:GetVoiceLength("story_v_out_319511", "319511003", "story_v_out_319511.awb") / 1000

					if var_16_43 + var_16_35 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_43 + var_16_35
					end

					if var_16_38.prefab_name ~= "" and arg_13_1.actors_[var_16_38.prefab_name] ~= nil then
						local var_16_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_38.prefab_name].transform, "story_v_out_319511", "319511003", "story_v_out_319511.awb")

						arg_13_1:RecordAudio("319511003", var_16_44)
						arg_13_1:RecordAudio("319511003", var_16_44)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319511", "319511003", "story_v_out_319511.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319511", "319511003", "story_v_out_319511.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_45 = math.max(var_16_36, arg_13_1.talkMaxDuration)

			if var_16_35 <= arg_13_1.time_ and arg_13_1.time_ < var_16_35 + var_16_45 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_35) / var_16_45

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_35 + var_16_45 and arg_13_1.time_ < var_16_35 + var_16_45 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play319511004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319511004
		arg_17_1.duration_ = 10.13

		local var_17_0 = {
			zh = 4.833,
			ja = 10.133
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319511005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1084ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1084ui_story.fillRatio = var_20_5
			end

			local var_20_6 = arg_17_1.actors_["10069ui_story"]
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect10069ui_story == nil then
				arg_17_1.var_.characterEffect10069ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 and not isNil(var_20_6) then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8

				if arg_17_1.var_.characterEffect10069ui_story and not isNil(var_20_6) then
					arg_17_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect10069ui_story then
				arg_17_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_20_10 = 0
			local var_20_11 = 0.6

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_12 = arg_17_1:FormatText(StoryNameCfg[693].name)

				arg_17_1.leftNameTxt_.text = var_20_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(319511004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 24
				local var_20_16 = utf8.len(var_20_14)
				local var_20_17 = var_20_15 <= 0 and var_20_11 or var_20_11 * (var_20_16 / var_20_15)

				if var_20_17 > 0 and var_20_11 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511004", "story_v_out_319511.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511004", "story_v_out_319511.awb") / 1000

					if var_20_18 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_10
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_319511", "319511004", "story_v_out_319511.awb")

						arg_17_1:RecordAudio("319511004", var_20_19)
						arg_17_1:RecordAudio("319511004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319511", "319511004", "story_v_out_319511.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319511", "319511004", "story_v_out_319511.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_20 and arg_17_1.time_ < var_20_10 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319511005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319511005
		arg_21_1.duration_ = 15.93

		local var_21_0 = {
			zh = 5.333,
			ja = 15.933
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319511006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.6

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[693].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(319511005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 24
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511005", "story_v_out_319511.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511005", "story_v_out_319511.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_319511", "319511005", "story_v_out_319511.awb")

						arg_21_1:RecordAudio("319511005", var_24_9)
						arg_21_1:RecordAudio("319511005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319511", "319511005", "story_v_out_319511.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319511", "319511005", "story_v_out_319511.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319511006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319511006
		arg_25_1.duration_ = 8.03

		local var_25_0 = {
			zh = 3.533,
			ja = 8.033
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
				arg_25_0:Play319511007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0.7, -0.97, -6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1084ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4712")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = arg_25_1.actors_["10069ui_story"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect10069ui_story == nil then
				arg_25_1.var_.characterEffect10069ui_story = var_28_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_17 = 0.200000002980232

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.characterEffect10069ui_story and not isNil(var_28_15) then
					local var_28_19 = Mathf.Lerp(0, 0.5, var_28_18)

					arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10069ui_story.fillRatio = var_28_19
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.characterEffect10069ui_story then
				local var_28_20 = 0.5

				arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10069ui_story.fillRatio = var_28_20
			end

			local var_28_21 = 0
			local var_28_22 = 0.45

			if var_28_21 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_23 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(319511006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 18
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_22 or var_28_22 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_22 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511006", "story_v_out_319511.awb") ~= 0 then
					local var_28_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511006", "story_v_out_319511.awb") / 1000

					if var_28_29 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_29 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_319511", "319511006", "story_v_out_319511.awb")

						arg_25_1:RecordAudio("319511006", var_28_30)
						arg_25_1:RecordAudio("319511006", var_28_30)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319511", "319511006", "story_v_out_319511.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319511", "319511006", "story_v_out_319511.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 <= arg_25_1.time_ and arg_25_1.time_ < var_28_21 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_21) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_21 + var_28_31 and arg_25_1.time_ < var_28_21 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319511007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319511007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319511008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.825

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(319511007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 33
				local var_32_11 = utf8.len(var_32_9)
				local var_32_12 = var_32_10 <= 0 and var_32_7 or var_32_7 * (var_32_11 / var_32_10)

				if var_32_12 > 0 and var_32_7 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_13 and arg_29_1.time_ < var_32_6 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319511008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319511008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319511009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.025

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(319511008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 41
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319511009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319511009
		arg_37_1.duration_ = 5.2

		local var_37_0 = {
			zh = 5.2,
			ja = 4.6
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319511010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.5

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_6 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(319511009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 20
				local var_40_10 = utf8.len(var_40_8)
				local var_40_11 = var_40_9 <= 0 and var_40_5 or var_40_5 * (var_40_10 / var_40_9)

				if var_40_11 > 0 and var_40_5 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511009", "story_v_out_319511.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511009", "story_v_out_319511.awb") / 1000

					if var_40_12 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_4
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_319511", "319511009", "story_v_out_319511.awb")

						arg_37_1:RecordAudio("319511009", var_40_13)
						arg_37_1:RecordAudio("319511009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319511", "319511009", "story_v_out_319511.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319511", "319511009", "story_v_out_319511.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_14 and arg_37_1.time_ < var_40_4 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319511010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319511010
		arg_41_1.duration_ = 6.5

		local var_41_0 = {
			zh = 3.5,
			ja = 6.5
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319511011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10069ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10069ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -1.08, -6.33)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10069ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -1.08, -6.33)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10069ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10069ui_story == nil then
				arg_41_1.var_.characterEffect10069ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect10069ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect10069ui_story then
				arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_15 = arg_41_1.actors_["1084ui_story"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_17 = 0.200000002980232

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_15) then
					local var_44_19 = Mathf.Lerp(0, 0.5, var_44_18)

					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_19
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.characterEffect1084ui_story then
				local var_44_20 = 0.5

				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_20
			end

			local var_44_21 = 0
			local var_44_22 = 0.375

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_23 = arg_41_1:FormatText(StoryNameCfg[693].name)

				arg_41_1.leftNameTxt_.text = var_44_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_24 = arg_41_1:GetWordFromCfg(319511010)
				local var_44_25 = arg_41_1:FormatText(var_44_24.content)

				arg_41_1.text_.text = var_44_25

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_26 = 15
				local var_44_27 = utf8.len(var_44_25)
				local var_44_28 = var_44_26 <= 0 and var_44_22 or var_44_22 * (var_44_27 / var_44_26)

				if var_44_28 > 0 and var_44_22 < var_44_28 then
					arg_41_1.talkMaxDuration = var_44_28

					if var_44_28 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_28 + var_44_21
					end
				end

				arg_41_1.text_.text = var_44_25
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511010", "story_v_out_319511.awb") ~= 0 then
					local var_44_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511010", "story_v_out_319511.awb") / 1000

					if var_44_29 + var_44_21 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_29 + var_44_21
					end

					if var_44_24.prefab_name ~= "" and arg_41_1.actors_[var_44_24.prefab_name] ~= nil then
						local var_44_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_24.prefab_name].transform, "story_v_out_319511", "319511010", "story_v_out_319511.awb")

						arg_41_1:RecordAudio("319511010", var_44_30)
						arg_41_1:RecordAudio("319511010", var_44_30)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319511", "319511010", "story_v_out_319511.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319511", "319511010", "story_v_out_319511.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_31 = math.max(var_44_22, arg_41_1.talkMaxDuration)

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_31 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_21) / var_44_31

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_21 + var_44_31 and arg_41_1.time_ < var_44_21 + var_44_31 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319511011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319511011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 1.5,
			ja = 4.5
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319511012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10069ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10069ui_story == nil then
				arg_45_1.var_.characterEffect10069ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10069ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10069ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10069ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10069ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["1084ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_10 = 0
			local var_48_11 = 0.1

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(319511011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 4
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511011", "story_v_out_319511.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511011", "story_v_out_319511.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_319511", "319511011", "story_v_out_319511.awb")

						arg_45_1:RecordAudio("319511011", var_48_19)
						arg_45_1:RecordAudio("319511011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319511", "319511011", "story_v_out_319511.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319511", "319511011", "story_v_out_319511.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319511012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319511012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play319511013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1084ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.275

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[698].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_9 = arg_49_1:GetWordFromCfg(319511012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 11
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319511013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319511013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play319511014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.8

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(319511013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 32
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319511014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319511014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play319511015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.85

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[698].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(319511014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 34
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319511015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319511015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319511016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.725

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[698].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(319511015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 29
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319511016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319511016
		arg_65_1.duration_ = 7.57

		local var_65_0 = {
			zh = 2.3,
			ja = 7.566
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play319511017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1084ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0.7, -0.97, -6)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1084ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_15 = 0
			local var_68_16 = 0.15

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[6].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(319511016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 6
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511016", "story_v_out_319511.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511016", "story_v_out_319511.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_319511", "319511016", "story_v_out_319511.awb")

						arg_65_1:RecordAudio("319511016", var_68_24)
						arg_65_1:RecordAudio("319511016", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319511", "319511016", "story_v_out_319511.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319511", "319511016", "story_v_out_319511.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play319511017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319511017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319511018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1084ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1084ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1084ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.725

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[698].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(319511017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 29
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319511018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319511018
		arg_73_1.duration_ = 8.97

		local var_73_0 = {
			zh = 7.2,
			ja = 8.966
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319511019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1084ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_76_4 = 0
			local var_76_5 = 0.85

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_6 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(319511018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 34
				local var_76_10 = utf8.len(var_76_8)
				local var_76_11 = var_76_9 <= 0 and var_76_5 or var_76_5 * (var_76_10 / var_76_9)

				if var_76_11 > 0 and var_76_5 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511018", "story_v_out_319511.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511018", "story_v_out_319511.awb") / 1000

					if var_76_12 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_4
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_319511", "319511018", "story_v_out_319511.awb")

						arg_73_1:RecordAudio("319511018", var_76_13)
						arg_73_1:RecordAudio("319511018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319511", "319511018", "story_v_out_319511.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319511", "319511018", "story_v_out_319511.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_14 and arg_73_1.time_ < var_76_4 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319511019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319511019
		arg_77_1.duration_ = 7

		local var_77_0 = {
			zh = 7,
			ja = 5.866
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319511020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.85

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[6].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(319511019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 34
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511019", "story_v_out_319511.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511019", "story_v_out_319511.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_319511", "319511019", "story_v_out_319511.awb")

						arg_77_1:RecordAudio("319511019", var_80_9)
						arg_77_1:RecordAudio("319511019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319511", "319511019", "story_v_out_319511.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319511", "319511019", "story_v_out_319511.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319511020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319511020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play319511021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1084ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.425

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[698].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(319511020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 17
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319511021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319511021
		arg_85_1.duration_ = 11

		local var_85_0 = {
			zh = 5.533,
			ja = 11
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319511022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1084ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0.7, -0.97, -6)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1084ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1084ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.425

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(319511021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 17
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511021", "story_v_out_319511.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511021", "story_v_out_319511.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_319511", "319511021", "story_v_out_319511.awb")

						arg_85_1:RecordAudio("319511021", var_88_24)
						arg_85_1:RecordAudio("319511021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319511", "319511021", "story_v_out_319511.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319511", "319511021", "story_v_out_319511.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play319511022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319511022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319511023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1084ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.875

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[698].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(319511022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 35
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319511023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319511023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319511024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1084ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_6 = 0
			local var_96_7 = 0.075

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(319511023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 3
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511023", "story_v_out_319511.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511023", "story_v_out_319511.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_319511", "319511023", "story_v_out_319511.awb")

						arg_93_1:RecordAudio("319511023", var_96_15)
						arg_93_1:RecordAudio("319511023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319511", "319511023", "story_v_out_319511.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319511", "319511023", "story_v_out_319511.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319511024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319511024
		arg_97_1.duration_ = 2.6

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319511025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = "STblack"

			if arg_97_1.bgs_[var_100_0] == nil then
				local var_100_1 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_0)
				var_100_1.name = var_100_0
				var_100_1.transform.parent = arg_97_1.stage_.transform
				var_100_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_0] = var_100_1
			end

			local var_100_2 = 4.44089209850063e-16

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				local var_100_3 = manager.ui.mainCamera.transform.localPosition
				local var_100_4 = Vector3.New(0, 0, 10) + Vector3.New(var_100_3.x, var_100_3.y, 0)
				local var_100_5 = arg_97_1.bgs_.STblack

				var_100_5.transform.localPosition = var_100_4
				var_100_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_6 = var_100_5:GetComponent("SpriteRenderer")

				if var_100_6 and var_100_6.sprite then
					local var_100_7 = (var_100_5.transform.localPosition - var_100_3).z
					local var_100_8 = manager.ui.mainCameraCom_
					local var_100_9 = 2 * var_100_7 * Mathf.Tan(var_100_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_10 = var_100_9 * var_100_8.aspect
					local var_100_11 = var_100_6.sprite.bounds.size.x
					local var_100_12 = var_100_6.sprite.bounds.size.y
					local var_100_13 = var_100_10 / var_100_11
					local var_100_14 = var_100_9 / var_100_12
					local var_100_15 = var_100_14 < var_100_13 and var_100_13 or var_100_14

					var_100_5.transform.localScale = Vector3.New(var_100_15, var_100_15, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "STblack" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				local var_100_17 = arg_97_1.fswbg_.transform:Find("textbox/adapt/content") or arg_97_1.fswbg_.transform:Find("textbox/content")
				local var_100_18 = arg_97_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_100_19 = var_100_17:GetComponent("Text")
				local var_100_20 = var_100_17:GetComponent("RectTransform")

				var_100_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_100_20.offsetMin = Vector2.New(0, 0)
				var_100_20.offsetMax = Vector2.New(0, 0)
			end

			local var_100_21 = 4.44089209850063e-16

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1.fswbg_:SetActive(true)
				arg_97_1.dialog_:SetActive(false)

				arg_97_1.fswtw_.percent = 0

				local var_100_22 = arg_97_1:GetWordFromCfg(319511024)
				local var_100_23 = arg_97_1:FormatText(var_100_22.content)

				arg_97_1.fswt_.text = var_100_23

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.fswt_)

				arg_97_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_97_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_97_1.fswtw_:SetDirty()

				arg_97_1.typewritterCharCountI18N = 0

				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_24 = 0.4

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.var_.oldValueTypewriter = arg_97_1.fswtw_.percent

				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_25 = 21
			local var_100_26 = 1.4
			local var_100_27 = arg_97_1:GetWordFromCfg(319511024)
			local var_100_28 = arg_97_1:FormatText(var_100_27.content)
			local var_100_29, var_100_30 = arg_97_1:GetPercentByPara(var_100_28, 1)

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				local var_100_31 = var_100_25 <= 0 and var_100_26 or var_100_26 * ((var_100_30 - arg_97_1.typewritterCharCountI18N) / var_100_25)

				if var_100_31 > 0 and var_100_26 < var_100_31 then
					arg_97_1.talkMaxDuration = var_100_31

					if var_100_31 + var_100_24 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_24
					end
				end
			end

			local var_100_32 = 1.4
			local var_100_33 = math.max(var_100_32, arg_97_1.talkMaxDuration)

			if var_100_24 <= arg_97_1.time_ and arg_97_1.time_ < var_100_24 + var_100_33 then
				local var_100_34 = (arg_97_1.time_ - var_100_24) / var_100_33

				arg_97_1.fswtw_.percent = Mathf.Lerp(arg_97_1.var_.oldValueTypewriter, var_100_29, var_100_34)
				arg_97_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_97_1.fswtw_:SetDirty()
			end

			if arg_97_1.time_ >= var_100_24 + var_100_33 and arg_97_1.time_ < var_100_24 + var_100_33 + arg_100_0 then
				arg_97_1.fswtw_.percent = var_100_29

				arg_97_1.fswtw_:SetDirty()
				arg_97_1:ShowNextGo(true)

				arg_97_1.typewritterCharCountI18N = var_100_30
			end

			local var_100_35 = 4.44089209850063e-16

			if var_100_35 < arg_97_1.time_ and arg_97_1.time_ <= var_100_35 + arg_100_0 then
				arg_97_1.cswbg_:SetActive(true)

				local var_100_36 = arg_97_1.cswt_:GetComponent("RectTransform")

				arg_97_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_100_36.offsetMin = Vector2.New(410, 330)
				var_100_36.offsetMax = Vector2.New(-400, -180)

				local var_100_37 = arg_97_1:GetWordFromCfg(419026)
				local var_100_38 = arg_97_1:FormatText(var_100_37.content)

				arg_97_1.cswt_.text = var_100_38

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.cswt_)

				arg_97_1.cswt_.fontSize = 175
				arg_97_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_97_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_97_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_100_39 = arg_97_1.actors_["10069ui_story"].transform
			local var_100_40 = 4.44089209850063e-16

			if var_100_40 < arg_97_1.time_ and arg_97_1.time_ <= var_100_40 + arg_100_0 then
				arg_97_1.var_.moveOldPos10069ui_story = var_100_39.localPosition
			end

			local var_100_41 = 0.001

			if var_100_40 <= arg_97_1.time_ and arg_97_1.time_ < var_100_40 + var_100_41 then
				local var_100_42 = (arg_97_1.time_ - var_100_40) / var_100_41
				local var_100_43 = Vector3.New(0, 100, 0)

				var_100_39.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10069ui_story, var_100_43, var_100_42)

				local var_100_44 = manager.ui.mainCamera.transform.position - var_100_39.position

				var_100_39.forward = Vector3.New(var_100_44.x, var_100_44.y, var_100_44.z)

				local var_100_45 = var_100_39.localEulerAngles

				var_100_45.z = 0
				var_100_45.x = 0
				var_100_39.localEulerAngles = var_100_45
			end

			if arg_97_1.time_ >= var_100_40 + var_100_41 and arg_97_1.time_ < var_100_40 + var_100_41 + arg_100_0 then
				var_100_39.localPosition = Vector3.New(0, 100, 0)

				local var_100_46 = manager.ui.mainCamera.transform.position - var_100_39.position

				var_100_39.forward = Vector3.New(var_100_46.x, var_100_46.y, var_100_46.z)

				local var_100_47 = var_100_39.localEulerAngles

				var_100_47.z = 0
				var_100_47.x = 0
				var_100_39.localEulerAngles = var_100_47
			end

			local var_100_48 = arg_97_1.actors_["1084ui_story"].transform
			local var_100_49 = 4.44089209850063e-16

			if var_100_49 < arg_97_1.time_ and arg_97_1.time_ <= var_100_49 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_48.localPosition
			end

			local var_100_50 = 0.001

			if var_100_49 <= arg_97_1.time_ and arg_97_1.time_ < var_100_49 + var_100_50 then
				local var_100_51 = (arg_97_1.time_ - var_100_49) / var_100_50
				local var_100_52 = Vector3.New(0, 100, 0)

				var_100_48.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, var_100_52, var_100_51)

				local var_100_53 = manager.ui.mainCamera.transform.position - var_100_48.position

				var_100_48.forward = Vector3.New(var_100_53.x, var_100_53.y, var_100_53.z)

				local var_100_54 = var_100_48.localEulerAngles

				var_100_54.z = 0
				var_100_54.x = 0
				var_100_48.localEulerAngles = var_100_54
			end

			if arg_97_1.time_ >= var_100_49 + var_100_50 and arg_97_1.time_ < var_100_49 + var_100_50 + arg_100_0 then
				var_100_48.localPosition = Vector3.New(0, 100, 0)

				local var_100_55 = manager.ui.mainCamera.transform.position - var_100_48.position

				var_100_48.forward = Vector3.New(var_100_55.x, var_100_55.y, var_100_55.z)

				local var_100_56 = var_100_48.localEulerAngles

				var_100_56.z = 0
				var_100_56.x = 0
				var_100_48.localEulerAngles = var_100_56
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319511025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319511025
		arg_101_1.duration_ = 6.18

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319511026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_1 = manager.ui.mainCamera.transform.localPosition
				local var_104_2 = Vector3.New(0, 0, 10) + Vector3.New(var_104_1.x, var_104_1.y, 0)
				local var_104_3 = arg_101_1.bgs_.ST72

				var_104_3.transform.localPosition = var_104_2
				var_104_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_4 = var_104_3:GetComponent("SpriteRenderer")

				if var_104_4 and var_104_4.sprite then
					local var_104_5 = (var_104_3.transform.localPosition - var_104_1).z
					local var_104_6 = manager.ui.mainCameraCom_
					local var_104_7 = 2 * var_104_5 * Mathf.Tan(var_104_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_8 = var_104_7 * var_104_6.aspect
					local var_104_9 = var_104_4.sprite.bounds.size.x
					local var_104_10 = var_104_4.sprite.bounds.size.y
					local var_104_11 = var_104_8 / var_104_9
					local var_104_12 = var_104_7 / var_104_10
					local var_104_13 = var_104_12 < var_104_11 and var_104_11 or var_104_12

					var_104_3.transform.localScale = Vector3.New(var_104_13, var_104_13, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST72" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_14 = 1.175

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_15 = 0.3

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_16 = arg_101_1.actors_["1084ui_story"].transform
			local var_104_17 = 1.175

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_16.localPosition
			end

			local var_104_18 = 0.001

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_18 then
				local var_104_19 = (arg_101_1.time_ - var_104_17) / var_104_18
				local var_104_20 = Vector3.New(0, 100, 0)

				var_104_16.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, var_104_20, var_104_19)

				local var_104_21 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_21.x, var_104_21.y, var_104_21.z)

				local var_104_22 = var_104_16.localEulerAngles

				var_104_22.z = 0
				var_104_22.x = 0
				var_104_16.localEulerAngles = var_104_22
			end

			if arg_101_1.time_ >= var_104_17 + var_104_18 and arg_101_1.time_ < var_104_17 + var_104_18 + arg_104_0 then
				var_104_16.localPosition = Vector3.New(0, 100, 0)

				local var_104_23 = manager.ui.mainCamera.transform.position - var_104_16.position

				var_104_16.forward = Vector3.New(var_104_23.x, var_104_23.y, var_104_23.z)

				local var_104_24 = var_104_16.localEulerAngles

				var_104_24.z = 0
				var_104_24.x = 0
				var_104_16.localEulerAngles = var_104_24
			end

			local var_104_25 = arg_101_1.actors_["1084ui_story"]
			local var_104_26 = 1.175

			if var_104_26 < arg_101_1.time_ and arg_101_1.time_ <= var_104_26 + arg_104_0 and not isNil(var_104_25) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_27 = 0.200000002980232

			if var_104_26 <= arg_101_1.time_ and arg_101_1.time_ < var_104_26 + var_104_27 and not isNil(var_104_25) then
				local var_104_28 = (arg_101_1.time_ - var_104_26) / var_104_27

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_25) then
					local var_104_29 = Mathf.Lerp(0, 0.5, var_104_28)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_29
				end
			end

			if arg_101_1.time_ >= var_104_26 + var_104_27 and arg_101_1.time_ < var_104_26 + var_104_27 + arg_104_0 and not isNil(var_104_25) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_30 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_30
			end

			local var_104_31 = arg_101_1.actors_["10069ui_story"].transform
			local var_104_32 = 1.175

			if var_104_32 < arg_101_1.time_ and arg_101_1.time_ <= var_104_32 + arg_104_0 then
				arg_101_1.var_.moveOldPos10069ui_story = var_104_31.localPosition
			end

			local var_104_33 = 0.001

			if var_104_32 <= arg_101_1.time_ and arg_101_1.time_ < var_104_32 + var_104_33 then
				local var_104_34 = (arg_101_1.time_ - var_104_32) / var_104_33
				local var_104_35 = Vector3.New(0, 100, 0)

				var_104_31.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10069ui_story, var_104_35, var_104_34)

				local var_104_36 = manager.ui.mainCamera.transform.position - var_104_31.position

				var_104_31.forward = Vector3.New(var_104_36.x, var_104_36.y, var_104_36.z)

				local var_104_37 = var_104_31.localEulerAngles

				var_104_37.z = 0
				var_104_37.x = 0
				var_104_31.localEulerAngles = var_104_37
			end

			if arg_101_1.time_ >= var_104_32 + var_104_33 and arg_101_1.time_ < var_104_32 + var_104_33 + arg_104_0 then
				var_104_31.localPosition = Vector3.New(0, 100, 0)

				local var_104_38 = manager.ui.mainCamera.transform.position - var_104_31.position

				var_104_31.forward = Vector3.New(var_104_38.x, var_104_38.y, var_104_38.z)

				local var_104_39 = var_104_31.localEulerAngles

				var_104_39.z = 0
				var_104_39.x = 0
				var_104_31.localEulerAngles = var_104_39
			end

			local var_104_40 = arg_101_1.actors_["10069ui_story"]
			local var_104_41 = 1.175

			if var_104_41 < arg_101_1.time_ and arg_101_1.time_ <= var_104_41 + arg_104_0 and not isNil(var_104_40) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = var_104_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_42 = 0.200000002980232

			if var_104_41 <= arg_101_1.time_ and arg_101_1.time_ < var_104_41 + var_104_42 and not isNil(var_104_40) then
				local var_104_43 = (arg_101_1.time_ - var_104_41) / var_104_42

				if arg_101_1.var_.characterEffect10069ui_story and not isNil(var_104_40) then
					local var_104_44 = Mathf.Lerp(0, 0.5, var_104_43)

					arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_44
				end
			end

			if arg_101_1.time_ >= var_104_41 + var_104_42 and arg_101_1.time_ < var_104_41 + var_104_42 + arg_104_0 and not isNil(var_104_40) and arg_101_1.var_.characterEffect10069ui_story then
				local var_104_45 = 0.5

				arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_45
			end

			local var_104_46 = 0

			if var_104_46 < arg_101_1.time_ and arg_101_1.time_ <= var_104_46 + arg_104_0 then
				arg_101_1.fswbg_:SetActive(false)
				arg_101_1.dialog_:SetActive(false)
				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_47 = 0

			if var_104_47 < arg_101_1.time_ and arg_101_1.time_ <= var_104_47 + arg_104_0 then
				arg_101_1.cswbg_:SetActive(false)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_48 = 1.175
			local var_104_49 = 1.125

			if var_104_48 < arg_101_1.time_ and arg_101_1.time_ <= var_104_48 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_50 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_50:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_51 = arg_101_1:GetWordFromCfg(319511025)
				local var_104_52 = arg_101_1:FormatText(var_104_51.content)

				arg_101_1.text_.text = var_104_52

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_53 = 45
				local var_104_54 = utf8.len(var_104_52)
				local var_104_55 = var_104_53 <= 0 and var_104_49 or var_104_49 * (var_104_54 / var_104_53)

				if var_104_55 > 0 and var_104_49 < var_104_55 then
					arg_101_1.talkMaxDuration = var_104_55
					var_104_48 = var_104_48 + 0.3

					if var_104_55 + var_104_48 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_55 + var_104_48
					end
				end

				arg_101_1.text_.text = var_104_52
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_56 = var_104_48 + 0.3
			local var_104_57 = math.max(var_104_49, arg_101_1.talkMaxDuration)

			if var_104_56 <= arg_101_1.time_ and arg_101_1.time_ < var_104_56 + var_104_57 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_56) / var_104_57

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_56 + var_104_57 and arg_101_1.time_ < var_104_56 + var_104_57 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.175,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.175,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319511026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319511026
		arg_107_1.duration_ = 5.23

		local var_107_0 = {
			zh = 3.2,
			ja = 5.233
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
				arg_107_0:Play319511027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1084ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos1084ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0, -0.97, -6)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1084ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["1084ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_110_14 = 0

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_110_15 = 0
			local var_110_16 = 0.35

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_17 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_18 = arg_107_1:GetWordFromCfg(319511026)
				local var_110_19 = arg_107_1:FormatText(var_110_18.content)

				arg_107_1.text_.text = var_110_19

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 14
				local var_110_21 = utf8.len(var_110_19)
				local var_110_22 = var_110_20 <= 0 and var_110_16 or var_110_16 * (var_110_21 / var_110_20)

				if var_110_22 > 0 and var_110_16 < var_110_22 then
					arg_107_1.talkMaxDuration = var_110_22

					if var_110_22 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_22 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_19
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511026", "story_v_out_319511.awb") ~= 0 then
					local var_110_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511026", "story_v_out_319511.awb") / 1000

					if var_110_23 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_23 + var_110_15
					end

					if var_110_18.prefab_name ~= "" and arg_107_1.actors_[var_110_18.prefab_name] ~= nil then
						local var_110_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_18.prefab_name].transform, "story_v_out_319511", "319511026", "story_v_out_319511.awb")

						arg_107_1:RecordAudio("319511026", var_110_24)
						arg_107_1:RecordAudio("319511026", var_110_24)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319511", "319511026", "story_v_out_319511.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319511", "319511026", "story_v_out_319511.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_25 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_25 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_25

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_25 and arg_107_1.time_ < var_110_15 + var_110_25 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play319511027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319511027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319511028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1084ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.45

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[698].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(319511027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 18
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319511028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319511028
		arg_115_1.duration_ = 7.53

		local var_115_0 = {
			zh = 5,
			ja = 7.533
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
				arg_115_0:Play319511029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1084ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_118_4 = 0

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action445")
			end

			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_118_6 = 0
			local var_118_7 = 0.625

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[6].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_9 = arg_115_1:GetWordFromCfg(319511028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 25
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511028", "story_v_out_319511.awb") ~= 0 then
					local var_118_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511028", "story_v_out_319511.awb") / 1000

					if var_118_14 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_6
					end

					if var_118_9.prefab_name ~= "" and arg_115_1.actors_[var_118_9.prefab_name] ~= nil then
						local var_118_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_9.prefab_name].transform, "story_v_out_319511", "319511028", "story_v_out_319511.awb")

						arg_115_1:RecordAudio("319511028", var_118_15)
						arg_115_1:RecordAudio("319511028", var_118_15)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319511", "319511028", "story_v_out_319511.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319511", "319511028", "story_v_out_319511.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_16 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_16 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_16

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_16 and arg_115_1.time_ < var_118_6 + var_118_16 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319511029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319511029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play319511030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1084ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1084ui_story == nil then
				arg_119_1.var_.characterEffect1084ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1084ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1084ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1084ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1084ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.85

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(319511029)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 34
				local var_122_11 = utf8.len(var_122_9)
				local var_122_12 = var_122_10 <= 0 and var_122_7 or var_122_7 * (var_122_11 / var_122_10)

				if var_122_12 > 0 and var_122_7 < var_122_12 then
					arg_119_1.talkMaxDuration = var_122_12

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_13 and arg_119_1.time_ < var_122_6 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319511030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319511030
		arg_123_1.duration_ = 4.87

		local var_123_0 = {
			zh = 1.999999999999,
			ja = 4.866
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319511031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10069ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10069ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0.7, -1.08, -6.33)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10069ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["10069ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10069ui_story == nil then
				arg_123_1.var_.characterEffect10069ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect10069ui_story and not isNil(var_126_9) then
					arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10069ui_story then
				arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_15 = arg_123_1.actors_["1084ui_story"].transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.moveOldPos1084ui_story = var_126_15.localPosition
			end

			local var_126_17 = 0.001

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17
				local var_126_19 = Vector3.New(-0.7, -0.97, -6)

				var_126_15.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1084ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_15.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_15.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_15.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_15.localEulerAngles = var_126_23
			end

			local var_126_24 = arg_123_1.actors_["1084ui_story"]
			local var_126_25 = 0

			if var_126_25 < arg_123_1.time_ and arg_123_1.time_ <= var_126_25 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_26 = 0.200000002980232

			if var_126_25 <= arg_123_1.time_ and arg_123_1.time_ < var_126_25 + var_126_26 and not isNil(var_126_24) then
				local var_126_27 = (arg_123_1.time_ - var_126_25) / var_126_26

				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_24) then
					local var_126_28 = Mathf.Lerp(0, 0.5, var_126_27)

					arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1084ui_story.fillRatio = var_126_28
				end
			end

			if arg_123_1.time_ >= var_126_25 + var_126_26 and arg_123_1.time_ < var_126_25 + var_126_26 + arg_126_0 and not isNil(var_126_24) and arg_123_1.var_.characterEffect1084ui_story then
				local var_126_29 = 0.5

				arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1084ui_story.fillRatio = var_126_29
			end

			local var_126_30 = 0

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_126_31 = 0

			if var_126_31 < arg_123_1.time_ and arg_123_1.time_ <= var_126_31 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_126_32 = 0
			local var_126_33 = 0.2

			if var_126_32 < arg_123_1.time_ and arg_123_1.time_ <= var_126_32 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_34 = arg_123_1:FormatText(StoryNameCfg[693].name)

				arg_123_1.leftNameTxt_.text = var_126_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_35 = arg_123_1:GetWordFromCfg(319511030)
				local var_126_36 = arg_123_1:FormatText(var_126_35.content)

				arg_123_1.text_.text = var_126_36

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_37 = 8
				local var_126_38 = utf8.len(var_126_36)
				local var_126_39 = var_126_37 <= 0 and var_126_33 or var_126_33 * (var_126_38 / var_126_37)

				if var_126_39 > 0 and var_126_33 < var_126_39 then
					arg_123_1.talkMaxDuration = var_126_39

					if var_126_39 + var_126_32 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_39 + var_126_32
					end
				end

				arg_123_1.text_.text = var_126_36
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511030", "story_v_out_319511.awb") ~= 0 then
					local var_126_40 = manager.audio:GetVoiceLength("story_v_out_319511", "319511030", "story_v_out_319511.awb") / 1000

					if var_126_40 + var_126_32 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_40 + var_126_32
					end

					if var_126_35.prefab_name ~= "" and arg_123_1.actors_[var_126_35.prefab_name] ~= nil then
						local var_126_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_35.prefab_name].transform, "story_v_out_319511", "319511030", "story_v_out_319511.awb")

						arg_123_1:RecordAudio("319511030", var_126_41)
						arg_123_1:RecordAudio("319511030", var_126_41)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319511", "319511030", "story_v_out_319511.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319511", "319511030", "story_v_out_319511.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_42 = math.max(var_126_33, arg_123_1.talkMaxDuration)

			if var_126_32 <= arg_123_1.time_ and arg_123_1.time_ < var_126_32 + var_126_42 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_32) / var_126_42

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_32 + var_126_42 and arg_123_1.time_ < var_126_32 + var_126_42 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_123_1:InitPlayNodeList()
	end,
	Play319511031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319511031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319511032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10069ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10069ui_story == nil then
				arg_127_1.var_.characterEffect10069ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10069ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10069ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10069ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10069ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.675

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[698].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(319511031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 27
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319511032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319511032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319511033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.575

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[698].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(319511032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 23
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319511033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319511033
		arg_135_1.duration_ = 2.7

		local var_135_0 = {
			zh = 1.999999999999,
			ja = 2.7
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319511034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1084ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_138_5 = 0
			local var_138_6 = 0.075

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_7 = arg_135_1:FormatText(StoryNameCfg[6].name)

				arg_135_1.leftNameTxt_.text = var_138_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(319511033)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 3
				local var_138_11 = utf8.len(var_138_9)
				local var_138_12 = var_138_10 <= 0 and var_138_6 or var_138_6 * (var_138_11 / var_138_10)

				if var_138_12 > 0 and var_138_6 < var_138_12 then
					arg_135_1.talkMaxDuration = var_138_12

					if var_138_12 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511033", "story_v_out_319511.awb") ~= 0 then
					local var_138_13 = manager.audio:GetVoiceLength("story_v_out_319511", "319511033", "story_v_out_319511.awb") / 1000

					if var_138_13 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_5
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_319511", "319511033", "story_v_out_319511.awb")

						arg_135_1:RecordAudio("319511033", var_138_14)
						arg_135_1:RecordAudio("319511033", var_138_14)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319511", "319511033", "story_v_out_319511.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319511", "319511033", "story_v_out_319511.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_15 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_15

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_15 and arg_135_1.time_ < var_138_5 + var_138_15 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319511034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319511034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play319511035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, 100, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, 100, 0)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1084ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_9) then
					local var_142_13 = Mathf.Lerp(0, 0.5, var_142_12)

					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_13
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1084ui_story then
				local var_142_14 = 0.5

				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = var_142_14
			end

			local var_142_15 = arg_139_1.actors_["10069ui_story"].transform
			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.var_.moveOldPos10069ui_story = var_142_15.localPosition
			end

			local var_142_17 = 0.001

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_17 then
				local var_142_18 = (arg_139_1.time_ - var_142_16) / var_142_17
				local var_142_19 = Vector3.New(0, 100, 0)

				var_142_15.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10069ui_story, var_142_19, var_142_18)

				local var_142_20 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_20.x, var_142_20.y, var_142_20.z)

				local var_142_21 = var_142_15.localEulerAngles

				var_142_21.z = 0
				var_142_21.x = 0
				var_142_15.localEulerAngles = var_142_21
			end

			if arg_139_1.time_ >= var_142_16 + var_142_17 and arg_139_1.time_ < var_142_16 + var_142_17 + arg_142_0 then
				var_142_15.localPosition = Vector3.New(0, 100, 0)

				local var_142_22 = manager.ui.mainCamera.transform.position - var_142_15.position

				var_142_15.forward = Vector3.New(var_142_22.x, var_142_22.y, var_142_22.z)

				local var_142_23 = var_142_15.localEulerAngles

				var_142_23.z = 0
				var_142_23.x = 0
				var_142_15.localEulerAngles = var_142_23
			end

			local var_142_24 = arg_139_1.actors_["10069ui_story"]
			local var_142_25 = 0

			if var_142_25 < arg_139_1.time_ and arg_139_1.time_ <= var_142_25 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_26 = 0.200000002980232

			if var_142_25 <= arg_139_1.time_ and arg_139_1.time_ < var_142_25 + var_142_26 and not isNil(var_142_24) then
				local var_142_27 = (arg_139_1.time_ - var_142_25) / var_142_26

				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_24) then
					local var_142_28 = Mathf.Lerp(0, 0.5, var_142_27)

					arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10069ui_story.fillRatio = var_142_28
				end
			end

			if arg_139_1.time_ >= var_142_25 + var_142_26 and arg_139_1.time_ < var_142_25 + var_142_26 + arg_142_0 and not isNil(var_142_24) and arg_139_1.var_.characterEffect10069ui_story then
				local var_142_29 = 0.5

				arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10069ui_story.fillRatio = var_142_29
			end

			local var_142_30 = 0
			local var_142_31 = 1.3

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_32 = arg_139_1:GetWordFromCfg(319511034)
				local var_142_33 = arg_139_1:FormatText(var_142_32.content)

				arg_139_1.text_.text = var_142_33

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_34 = 52
				local var_142_35 = utf8.len(var_142_33)
				local var_142_36 = var_142_34 <= 0 and var_142_31 or var_142_31 * (var_142_35 / var_142_34)

				if var_142_36 > 0 and var_142_31 < var_142_36 then
					arg_139_1.talkMaxDuration = var_142_36

					if var_142_36 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_36 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_33
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_37 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_37 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_37

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_37 and arg_139_1.time_ < var_142_30 + var_142_37 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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
	Play319511035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319511035
		arg_143_1.duration_ = 5.8

		local var_143_0 = {
			zh = 3.233,
			ja = 5.8
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play319511036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = "10068ui_story"

			if arg_143_1.actors_[var_146_0] == nil then
				local var_146_1 = Asset.Load("Char/" .. "10068ui_story")

				if not isNil(var_146_1) then
					local var_146_2 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_143_1.stage_.transform)

					var_146_2.name = var_146_0
					var_146_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_143_1.actors_[var_146_0] = var_146_2

					local var_146_3 = var_146_2:GetComponentInChildren(typeof(CharacterEffect))

					var_146_3.enabled = true

					local var_146_4 = GameObjectTools.GetOrAddComponent(var_146_2, typeof(DynamicBoneHelper))

					if var_146_4 then
						var_146_4:EnableDynamicBone(false)
					end

					arg_143_1:ShowWeapon(var_146_3.transform, false)

					arg_143_1.var_[var_146_0 .. "Animator"] = var_146_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_143_1.var_[var_146_0 .. "Animator"].applyRootMotion = true
					arg_143_1.var_[var_146_0 .. "LipSync"] = var_146_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_146_5 = arg_143_1.actors_["10068ui_story"].transform
			local var_146_6 = 0

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.var_.moveOldPos10068ui_story = var_146_5.localPosition
			end

			local var_146_7 = 0.001

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_7 then
				local var_146_8 = (arg_143_1.time_ - var_146_6) / var_146_7
				local var_146_9 = Vector3.New(0, -0.75, -6.18)

				var_146_5.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10068ui_story, var_146_9, var_146_8)

				local var_146_10 = manager.ui.mainCamera.transform.position - var_146_5.position

				var_146_5.forward = Vector3.New(var_146_10.x, var_146_10.y, var_146_10.z)

				local var_146_11 = var_146_5.localEulerAngles

				var_146_11.z = 0
				var_146_11.x = 0
				var_146_5.localEulerAngles = var_146_11
			end

			if arg_143_1.time_ >= var_146_6 + var_146_7 and arg_143_1.time_ < var_146_6 + var_146_7 + arg_146_0 then
				var_146_5.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_146_12 = manager.ui.mainCamera.transform.position - var_146_5.position

				var_146_5.forward = Vector3.New(var_146_12.x, var_146_12.y, var_146_12.z)

				local var_146_13 = var_146_5.localEulerAngles

				var_146_13.z = 0
				var_146_13.x = 0
				var_146_5.localEulerAngles = var_146_13
			end

			local var_146_14 = arg_143_1.actors_["10068ui_story"]
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.characterEffect10068ui_story == nil then
				arg_143_1.var_.characterEffect10068ui_story = var_146_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_16 = 0.200000002980232

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 and not isNil(var_146_14) then
				local var_146_17 = (arg_143_1.time_ - var_146_15) / var_146_16

				if arg_143_1.var_.characterEffect10068ui_story and not isNil(var_146_14) then
					arg_143_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.characterEffect10068ui_story then
				arg_143_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_146_18 = 0

			if var_146_18 < arg_143_1.time_ and arg_143_1.time_ <= var_146_18 + arg_146_0 then
				arg_143_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_146_20 = 0
			local var_146_21 = 0.35

			if var_146_20 < arg_143_1.time_ and arg_143_1.time_ <= var_146_20 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_22 = arg_143_1:FormatText(StoryNameCfg[697].name)

				arg_143_1.leftNameTxt_.text = var_146_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_23 = arg_143_1:GetWordFromCfg(319511035)
				local var_146_24 = arg_143_1:FormatText(var_146_23.content)

				arg_143_1.text_.text = var_146_24

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_25 = 14
				local var_146_26 = utf8.len(var_146_24)
				local var_146_27 = var_146_25 <= 0 and var_146_21 or var_146_21 * (var_146_26 / var_146_25)

				if var_146_27 > 0 and var_146_21 < var_146_27 then
					arg_143_1.talkMaxDuration = var_146_27

					if var_146_27 + var_146_20 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_27 + var_146_20
					end
				end

				arg_143_1.text_.text = var_146_24
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511035", "story_v_out_319511.awb") ~= 0 then
					local var_146_28 = manager.audio:GetVoiceLength("story_v_out_319511", "319511035", "story_v_out_319511.awb") / 1000

					if var_146_28 + var_146_20 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_28 + var_146_20
					end

					if var_146_23.prefab_name ~= "" and arg_143_1.actors_[var_146_23.prefab_name] ~= nil then
						local var_146_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_23.prefab_name].transform, "story_v_out_319511", "319511035", "story_v_out_319511.awb")

						arg_143_1:RecordAudio("319511035", var_146_29)
						arg_143_1:RecordAudio("319511035", var_146_29)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319511", "319511035", "story_v_out_319511.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319511", "319511035", "story_v_out_319511.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_30 = math.max(var_146_21, arg_143_1.talkMaxDuration)

			if var_146_20 <= arg_143_1.time_ and arg_143_1.time_ < var_146_20 + var_146_30 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_20) / var_146_30

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_20 + var_146_30 and arg_143_1.time_ < var_146_20 + var_146_30 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319511036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319511036
		arg_147_1.duration_ = 4.23

		local var_147_0 = {
			zh = 2.366,
			ja = 4.233
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
				arg_147_0:Play319511037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_150_1 = 0
			local var_150_2 = 0.575

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_3 = arg_147_1:FormatText(StoryNameCfg[697].name)

				arg_147_1.leftNameTxt_.text = var_150_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(319511036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 23
				local var_150_7 = utf8.len(var_150_5)
				local var_150_8 = var_150_6 <= 0 and var_150_2 or var_150_2 * (var_150_7 / var_150_6)

				if var_150_8 > 0 and var_150_2 < var_150_8 then
					arg_147_1.talkMaxDuration = var_150_8

					if var_150_8 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511036", "story_v_out_319511.awb") ~= 0 then
					local var_150_9 = manager.audio:GetVoiceLength("story_v_out_319511", "319511036", "story_v_out_319511.awb") / 1000

					if var_150_9 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_1
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_319511", "319511036", "story_v_out_319511.awb")

						arg_147_1:RecordAudio("319511036", var_150_10)
						arg_147_1:RecordAudio("319511036", var_150_10)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319511", "319511036", "story_v_out_319511.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319511", "319511036", "story_v_out_319511.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_11 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_11 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_11

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_11 and arg_147_1.time_ < var_150_1 + var_150_11 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319511037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319511037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319511038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10068ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10068ui_story == nil then
				arg_151_1.var_.characterEffect10068ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10068ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10068ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10068ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10068ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.7

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[698].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(319511037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 28
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319511038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319511038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319511039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 1.45

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(319511038)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 58
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319511039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319511039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319511040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.8

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[698].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(319511039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 32
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319511040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319511040
		arg_163_1.duration_ = 8.27

		local var_163_0 = {
			zh = 5.3,
			ja = 8.266
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
				arg_163_0:Play319511041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10068ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10068ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(0, -0.75, -6.18)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10068ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["10068ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10068ui_story == nil then
				arg_163_1.var_.characterEffect10068ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 and not isNil(var_166_9) then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect10068ui_story and not isNil(var_166_9) then
					arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and not isNil(var_166_9) and arg_163_1.var_.characterEffect10068ui_story then
				arg_163_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_15 = 0
			local var_166_16 = 0.8

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[697].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(319511040)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 32
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511040", "story_v_out_319511.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511040", "story_v_out_319511.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_319511", "319511040", "story_v_out_319511.awb")

						arg_163_1:RecordAudio("319511040", var_166_24)
						arg_163_1:RecordAudio("319511040", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319511", "319511040", "story_v_out_319511.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319511", "319511040", "story_v_out_319511.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play319511041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319511041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319511042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10068ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10068ui_story == nil then
				arg_167_1.var_.characterEffect10068ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10068ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10068ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10068ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10068ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.1

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[698].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(319511041)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 4
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319511042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319511042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play319511043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.125

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(319511042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 45
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319511043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319511043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319511044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.275

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[698].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(319511043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 11
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319511044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319511044
		arg_179_1.duration_ = 6.33

		local var_179_0 = {
			zh = 4.533,
			ja = 6.333
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
				arg_179_0:Play319511045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10068ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10068ui_story == nil then
				arg_179_1.var_.characterEffect10068ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10068ui_story and not isNil(var_182_0) then
					arg_179_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10068ui_story then
				arg_179_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_182_4 = 0

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_182_5 = 0
			local var_182_6 = 0.425

			if var_182_5 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_7 = arg_179_1:FormatText(StoryNameCfg[697].name)

				arg_179_1.leftNameTxt_.text = var_182_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(319511044)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 17
				local var_182_11 = utf8.len(var_182_9)
				local var_182_12 = var_182_10 <= 0 and var_182_6 or var_182_6 * (var_182_11 / var_182_10)

				if var_182_12 > 0 and var_182_6 < var_182_12 then
					arg_179_1.talkMaxDuration = var_182_12

					if var_182_12 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511044", "story_v_out_319511.awb") ~= 0 then
					local var_182_13 = manager.audio:GetVoiceLength("story_v_out_319511", "319511044", "story_v_out_319511.awb") / 1000

					if var_182_13 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_5
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_319511", "319511044", "story_v_out_319511.awb")

						arg_179_1:RecordAudio("319511044", var_182_14)
						arg_179_1:RecordAudio("319511044", var_182_14)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319511", "319511044", "story_v_out_319511.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319511", "319511044", "story_v_out_319511.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_15 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_15 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_15

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_15 and arg_179_1.time_ < var_182_5 + var_182_15 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319511045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319511045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319511046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10068ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect10068ui_story == nil then
				arg_183_1.var_.characterEffect10068ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect10068ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10068ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect10068ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10068ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 1.225

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(319511045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 49
				local var_186_11 = utf8.len(var_186_9)
				local var_186_12 = var_186_10 <= 0 and var_186_7 or var_186_7 * (var_186_11 / var_186_10)

				if var_186_12 > 0 and var_186_7 < var_186_12 then
					arg_183_1.talkMaxDuration = var_186_12

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_13 and arg_183_1.time_ < var_186_6 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319511046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319511046
		arg_187_1.duration_ = 8.63

		local var_187_0 = {
			zh = 8.633,
			ja = 8.3
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
				arg_187_0:Play319511047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10068ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10068ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(0, -0.75, -6.18)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10068ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["10068ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10068ui_story == nil then
				arg_187_1.var_.characterEffect10068ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 and not isNil(var_190_9) then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect10068ui_story and not isNil(var_190_9) then
					arg_187_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and not isNil(var_190_9) and arg_187_1.var_.characterEffect10068ui_story then
				arg_187_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_190_15 = 0
			local var_190_16 = 0.75

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_17 = arg_187_1:FormatText(StoryNameCfg[697].name)

				arg_187_1.leftNameTxt_.text = var_190_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_18 = arg_187_1:GetWordFromCfg(319511046)
				local var_190_19 = arg_187_1:FormatText(var_190_18.content)

				arg_187_1.text_.text = var_190_19

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_20 = 30
				local var_190_21 = utf8.len(var_190_19)
				local var_190_22 = var_190_20 <= 0 and var_190_16 or var_190_16 * (var_190_21 / var_190_20)

				if var_190_22 > 0 and var_190_16 < var_190_22 then
					arg_187_1.talkMaxDuration = var_190_22

					if var_190_22 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_22 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_19
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511046", "story_v_out_319511.awb") ~= 0 then
					local var_190_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511046", "story_v_out_319511.awb") / 1000

					if var_190_23 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_23 + var_190_15
					end

					if var_190_18.prefab_name ~= "" and arg_187_1.actors_[var_190_18.prefab_name] ~= nil then
						local var_190_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_18.prefab_name].transform, "story_v_out_319511", "319511046", "story_v_out_319511.awb")

						arg_187_1:RecordAudio("319511046", var_190_24)
						arg_187_1:RecordAudio("319511046", var_190_24)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319511", "319511046", "story_v_out_319511.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319511", "319511046", "story_v_out_319511.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_25 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_25 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_25

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_25 and arg_187_1.time_ < var_190_15 + var_190_25 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play319511047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319511047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319511048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10068ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10068ui_story == nil then
				arg_191_1.var_.characterEffect10068ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10068ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10068ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10068ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10068ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.5

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[698].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(319511047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 20
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319511048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319511048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319511049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10068ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos10068ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10068ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["10068ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10068ui_story == nil then
				arg_195_1.var_.characterEffect10068ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect10068ui_story and not isNil(var_198_9) then
					local var_198_13 = Mathf.Lerp(0, 0.5, var_198_12)

					arg_195_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10068ui_story.fillRatio = var_198_13
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect10068ui_story then
				local var_198_14 = 0.5

				arg_195_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10068ui_story.fillRatio = var_198_14
			end

			local var_198_15 = 0
			local var_198_16 = 0.825

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_17 = arg_195_1:GetWordFromCfg(319511048)
				local var_198_18 = arg_195_1:FormatText(var_198_17.content)

				arg_195_1.text_.text = var_198_18

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_19 = 33
				local var_198_20 = utf8.len(var_198_18)
				local var_198_21 = var_198_19 <= 0 and var_198_16 or var_198_16 * (var_198_20 / var_198_19)

				if var_198_21 > 0 and var_198_16 < var_198_21 then
					arg_195_1.talkMaxDuration = var_198_21

					if var_198_21 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_21 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_18
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_22 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_22 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_22

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_22 and arg_195_1.time_ < var_198_15 + var_198_22 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play319511049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319511049
		arg_199_1.duration_ = 6.67

		local var_199_0 = {
			zh = 3.6,
			ja = 6.666
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
				arg_199_0:Play319511050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10069ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10069ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, -1.08, -6.33)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10069ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["10069ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10069ui_story == nil then
				arg_199_1.var_.characterEffect10069ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect10069ui_story and not isNil(var_202_9) then
					arg_199_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10069ui_story then
				arg_199_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_202_13 = 0

			if var_202_13 < arg_199_1.time_ and arg_199_1.time_ <= var_202_13 + arg_202_0 then
				arg_199_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_202_14 = 0

			if var_202_14 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_15 = 0
			local var_202_16 = 0.375

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_17 = arg_199_1:FormatText(StoryNameCfg[693].name)

				arg_199_1.leftNameTxt_.text = var_202_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:GetWordFromCfg(319511049)
				local var_202_19 = arg_199_1:FormatText(var_202_18.content)

				arg_199_1.text_.text = var_202_19

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 15
				local var_202_21 = utf8.len(var_202_19)
				local var_202_22 = var_202_20 <= 0 and var_202_16 or var_202_16 * (var_202_21 / var_202_20)

				if var_202_22 > 0 and var_202_16 < var_202_22 then
					arg_199_1.talkMaxDuration = var_202_22

					if var_202_22 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_22 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_19
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511049", "story_v_out_319511.awb") ~= 0 then
					local var_202_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511049", "story_v_out_319511.awb") / 1000

					if var_202_23 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_23 + var_202_15
					end

					if var_202_18.prefab_name ~= "" and arg_199_1.actors_[var_202_18.prefab_name] ~= nil then
						local var_202_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_18.prefab_name].transform, "story_v_out_319511", "319511049", "story_v_out_319511.awb")

						arg_199_1:RecordAudio("319511049", var_202_24)
						arg_199_1:RecordAudio("319511049", var_202_24)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319511", "319511049", "story_v_out_319511.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319511", "319511049", "story_v_out_319511.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_25 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_25 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_25

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_25 and arg_199_1.time_ < var_202_15 + var_202_25 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319511050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319511050
		arg_203_1.duration_ = 2.87

		local var_203_0 = {
			zh = 2.866,
			ja = 2.6
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319511051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10069ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10069ui_story == nil then
				arg_203_1.var_.characterEffect10069ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect10069ui_story and not isNil(var_206_0) then
					local var_206_4 = Mathf.Lerp(0, 0.5, var_206_3)

					arg_203_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10069ui_story.fillRatio = var_206_4
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect10069ui_story then
				local var_206_5 = 0.5

				arg_203_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10069ui_story.fillRatio = var_206_5
			end

			local var_206_6 = 0
			local var_206_7 = 0.15

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[692].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_9 = arg_203_1:GetWordFromCfg(319511050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 6
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511050", "story_v_out_319511.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511050", "story_v_out_319511.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_out_319511", "319511050", "story_v_out_319511.awb")

						arg_203_1:RecordAudio("319511050", var_206_15)
						arg_203_1:RecordAudio("319511050", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319511", "319511050", "story_v_out_319511.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319511", "319511050", "story_v_out_319511.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319511051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319511051
		arg_207_1.duration_ = 3.57

		local var_207_0 = {
			zh = 3.166,
			ja = 3.566
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
				arg_207_0:Play319511052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10069ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10069ui_story == nil then
				arg_207_1.var_.characterEffect10069ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10069ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10069ui_story then
				arg_207_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_210_4 = 0
			local var_210_5 = 0.325

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_6 = arg_207_1:FormatText(StoryNameCfg[693].name)

				arg_207_1.leftNameTxt_.text = var_210_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(319511051)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 13
				local var_210_10 = utf8.len(var_210_8)
				local var_210_11 = var_210_9 <= 0 and var_210_5 or var_210_5 * (var_210_10 / var_210_9)

				if var_210_11 > 0 and var_210_5 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511051", "story_v_out_319511.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511051", "story_v_out_319511.awb") / 1000

					if var_210_12 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_4
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_319511", "319511051", "story_v_out_319511.awb")

						arg_207_1:RecordAudio("319511051", var_210_13)
						arg_207_1:RecordAudio("319511051", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319511", "319511051", "story_v_out_319511.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319511", "319511051", "story_v_out_319511.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_14 and arg_207_1.time_ < var_210_4 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319511052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319511052
		arg_211_1.duration_ = 8.8

		local var_211_0 = {
			zh = 4.2,
			ja = 8.8
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319511053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10069ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10069ui_story == nil then
				arg_211_1.var_.characterEffect10069ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10069ui_story and not isNil(var_214_0) then
					local var_214_4 = Mathf.Lerp(0, 0.5, var_214_3)

					arg_211_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10069ui_story.fillRatio = var_214_4
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10069ui_story then
				local var_214_5 = 0.5

				arg_211_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10069ui_story.fillRatio = var_214_5
			end

			local var_214_6 = 0
			local var_214_7 = 0.3

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_8 = arg_211_1:FormatText(StoryNameCfg[692].name)

				arg_211_1.leftNameTxt_.text = var_214_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_9 = arg_211_1:GetWordFromCfg(319511052)
				local var_214_10 = arg_211_1:FormatText(var_214_9.content)

				arg_211_1.text_.text = var_214_10

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 12
				local var_214_12 = utf8.len(var_214_10)
				local var_214_13 = var_214_11 <= 0 and var_214_7 or var_214_7 * (var_214_12 / var_214_11)

				if var_214_13 > 0 and var_214_7 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_10
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511052", "story_v_out_319511.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511052", "story_v_out_319511.awb") / 1000

					if var_214_14 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_6
					end

					if var_214_9.prefab_name ~= "" and arg_211_1.actors_[var_214_9.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_9.prefab_name].transform, "story_v_out_319511", "319511052", "story_v_out_319511.awb")

						arg_211_1:RecordAudio("319511052", var_214_15)
						arg_211_1:RecordAudio("319511052", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319511", "319511052", "story_v_out_319511.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319511", "319511052", "story_v_out_319511.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_16 and arg_211_1.time_ < var_214_6 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319511053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319511053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319511054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10069ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10069ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, 100, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10069ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, 100, 0)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10069ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10069ui_story == nil then
				arg_215_1.var_.characterEffect10069ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect10069ui_story and not isNil(var_218_9) then
					local var_218_13 = Mathf.Lerp(0, 0.5, var_218_12)

					arg_215_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10069ui_story.fillRatio = var_218_13
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10069ui_story then
				local var_218_14 = 0.5

				arg_215_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10069ui_story.fillRatio = var_218_14
			end

			local var_218_15 = 0
			local var_218_16 = 0.725

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_17 = arg_215_1:GetWordFromCfg(319511053)
				local var_218_18 = arg_215_1:FormatText(var_218_17.content)

				arg_215_1.text_.text = var_218_18

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_19 = 29
				local var_218_20 = utf8.len(var_218_18)
				local var_218_21 = var_218_19 <= 0 and var_218_16 or var_218_16 * (var_218_20 / var_218_19)

				if var_218_21 > 0 and var_218_16 < var_218_21 then
					arg_215_1.talkMaxDuration = var_218_21

					if var_218_21 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_21 + var_218_15
					end
				end

				arg_215_1.text_.text = var_218_18
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = math.max(var_218_16, arg_215_1.talkMaxDuration)

			if var_218_15 <= arg_215_1.time_ and arg_215_1.time_ < var_218_15 + var_218_22 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_15) / var_218_22

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_15 + var_218_22 and arg_215_1.time_ < var_218_15 + var_218_22 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play319511054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319511054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319511055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1.125

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(319511054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 45
				local var_222_5 = utf8.len(var_222_3)
				local var_222_6 = var_222_4 <= 0 and var_222_1 or var_222_1 * (var_222_5 / var_222_4)

				if var_222_6 > 0 and var_222_1 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_7 and arg_219_1.time_ < var_222_0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319511055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319511055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319511056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 1.225

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_2 = arg_223_1:GetWordFromCfg(319511055)
				local var_226_3 = arg_223_1:FormatText(var_226_2.content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 49
				local var_226_5 = utf8.len(var_226_3)
				local var_226_6 = var_226_4 <= 0 and var_226_1 or var_226_1 * (var_226_5 / var_226_4)

				if var_226_6 > 0 and var_226_1 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_7 and arg_223_1.time_ < var_226_0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319511056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319511056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play319511057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.3

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(319511056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 12
				local var_230_5 = utf8.len(var_230_3)
				local var_230_6 = var_230_4 <= 0 and var_230_1 or var_230_1 * (var_230_5 / var_230_4)

				if var_230_6 > 0 and var_230_1 < var_230_6 then
					arg_227_1.talkMaxDuration = var_230_6

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_7 and arg_227_1.time_ < var_230_0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play319511057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319511057
		arg_231_1.duration_ = 3.27

		local var_231_0 = {
			zh = 2.2,
			ja = 3.266
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
				arg_231_0:Play319511058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1084ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, -0.97, -6)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1084ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_13 = 0

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_234_15 = 0
			local var_234_16 = 0.9

			if var_234_15 < arg_231_1.time_ and arg_231_1.time_ <= var_234_15 + arg_234_0 then
				local var_234_17 = "play"
				local var_234_18 = "music"

				arg_231_1:AudioAction(var_234_17, var_234_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_234_19 = ""
				local var_234_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_234_20 ~= "" then
					if arg_231_1.bgmTxt_.text ~= var_234_20 and arg_231_1.bgmTxt_.text ~= "" then
						if arg_231_1.bgmTxt2_.text ~= "" then
							arg_231_1.bgmTxt_.text = arg_231_1.bgmTxt2_.text
						end

						arg_231_1.bgmTxt2_.text = var_234_20

						arg_231_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_231_1.bgmTxt_.text = var_234_20
						arg_231_1.bgmTxt2_.text = var_234_20
					end

					if arg_231_1.bgmTimer then
						arg_231_1.bgmTimer:Stop()

						arg_231_1.bgmTimer = nil
					end

					if arg_231_1.settingData.show_music_name == 1 then
						arg_231_1.musicController:SetSelectedState("show")
						arg_231_1.musicAnimator_:Play("open", 0, 0)

						if arg_231_1.settingData.music_time ~= 0 then
							arg_231_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_231_1.settingData.music_time), function()
								if arg_231_1 == nil or isNil(arg_231_1.bgmTxt_) then
									return
								end

								arg_231_1.musicController:SetSelectedState("hide")
								arg_231_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_234_21 = 0
			local var_234_22 = 0.25

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_23 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(319511057)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_26 = 10
				local var_234_27 = utf8.len(var_234_25)
				local var_234_28 = var_234_26 <= 0 and var_234_22 or var_234_22 * (var_234_27 / var_234_26)

				if var_234_28 > 0 and var_234_22 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511057", "story_v_out_319511.awb") ~= 0 then
					local var_234_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511057", "story_v_out_319511.awb") / 1000

					if var_234_29 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_29 + var_234_21
					end

					if var_234_24.prefab_name ~= "" and arg_231_1.actors_[var_234_24.prefab_name] ~= nil then
						local var_234_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_24.prefab_name].transform, "story_v_out_319511", "319511057", "story_v_out_319511.awb")

						arg_231_1:RecordAudio("319511057", var_234_30)
						arg_231_1:RecordAudio("319511057", var_234_30)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319511", "319511057", "story_v_out_319511.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319511", "319511057", "story_v_out_319511.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_31 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_31 and arg_231_1.time_ < var_234_21 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play319511058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 319511058
		arg_236_1.duration_ = 70.96

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play319511059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_1 = 2

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_1 then
				local var_239_2 = (arg_236_1.time_ - var_239_0) / var_239_1
				local var_239_3 = Color.New(0, 0, 0)

				var_239_3.a = Mathf.Lerp(0, 1, var_239_2)
				arg_236_1.mask_.color = var_239_3
			end

			if arg_236_1.time_ >= var_239_0 + var_239_1 and arg_236_1.time_ < var_239_0 + var_239_1 + arg_239_0 then
				local var_239_4 = Color.New(0, 0, 0)

				var_239_4.a = 1
				arg_236_1.mask_.color = var_239_4
			end

			local var_239_5 = 2

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_6 = 2

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_6 then
				local var_239_7 = (arg_236_1.time_ - var_239_5) / var_239_6
				local var_239_8 = Color.New(0, 0, 0)

				var_239_8.a = Mathf.Lerp(1, 0, var_239_7)
				arg_236_1.mask_.color = var_239_8
			end

			if arg_236_1.time_ >= var_239_5 + var_239_6 and arg_236_1.time_ < var_239_5 + var_239_6 + arg_239_0 then
				local var_239_9 = Color.New(0, 0, 0)
				local var_239_10 = 0

				arg_236_1.mask_.enabled = false
				var_239_9.a = var_239_10
				arg_236_1.mask_.color = var_239_9
			end

			local var_239_11 = arg_236_1.actors_["1084ui_story"].transform
			local var_239_12 = 2

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 then
				arg_236_1.var_.moveOldPos1084ui_story = var_239_11.localPosition
			end

			local var_239_13 = 0.001

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_13 then
				local var_239_14 = (arg_236_1.time_ - var_239_12) / var_239_13
				local var_239_15 = Vector3.New(0, 100, 0)

				var_239_11.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1084ui_story, var_239_15, var_239_14)

				local var_239_16 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_16.x, var_239_16.y, var_239_16.z)

				local var_239_17 = var_239_11.localEulerAngles

				var_239_17.z = 0
				var_239_17.x = 0
				var_239_11.localEulerAngles = var_239_17
			end

			if arg_236_1.time_ >= var_239_12 + var_239_13 and arg_236_1.time_ < var_239_12 + var_239_13 + arg_239_0 then
				var_239_11.localPosition = Vector3.New(0, 100, 0)

				local var_239_18 = manager.ui.mainCamera.transform.position - var_239_11.position

				var_239_11.forward = Vector3.New(var_239_18.x, var_239_18.y, var_239_18.z)

				local var_239_19 = var_239_11.localEulerAngles

				var_239_19.z = 0
				var_239_19.x = 0
				var_239_11.localEulerAngles = var_239_19
			end

			local var_239_20 = arg_236_1.actors_["1084ui_story"]
			local var_239_21 = 2

			if var_239_21 < arg_236_1.time_ and arg_236_1.time_ <= var_239_21 + arg_239_0 and not isNil(var_239_20) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_22 = 0.2

			if var_239_21 <= arg_236_1.time_ and arg_236_1.time_ < var_239_21 + var_239_22 and not isNil(var_239_20) then
				local var_239_23 = (arg_236_1.time_ - var_239_21) / var_239_22

				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_20) then
					local var_239_24 = Mathf.Lerp(0, 0.5, var_239_23)

					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_24
				end
			end

			if arg_236_1.time_ >= var_239_21 + var_239_22 and arg_236_1.time_ < var_239_21 + var_239_22 + arg_239_0 and not isNil(var_239_20) and arg_236_1.var_.characterEffect1084ui_story then
				local var_239_25 = 0.5

				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_25
			end

			local var_239_26 = 2

			if var_239_26 < arg_236_1.time_ and arg_236_1.time_ <= var_239_26 + arg_239_0 then
				SetActive(arg_236_1.dialog_, false)
				SetActive(arg_236_1.allBtn_.gameObject, false)
				arg_236_1.hideBtnsController_:SetSelectedIndex(1)
				arg_236_1:StopAllVoice()

				arg_236_1.marker = "stop1"

				manager.video:Play("SofdecAsset/story/story_1031951.usm", function(arg_240_0)
					if arg_236_1.state_ == "playing" then
						arg_236_1:JumpToEnd()
					end

					if arg_236_1.playNext_ and not arg_236_1.auto_ then
						arg_236_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_241_0)
					if arg_241_0 then
						arg_236_1.state_ = "pause"
					else
						arg_236_1.state_ = "playing"
					end
				end, 1031951)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_239_27 = 68.9583333333333

			if var_239_26 <= arg_236_1.time_ and arg_236_1.time_ < var_239_26 + var_239_27 then
				-- block empty
			end

			if arg_236_1.time_ >= var_239_26 + var_239_27 and arg_236_1.time_ < var_239_26 + var_239_27 + arg_239_0 then
				arg_236_1.marker = ""
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play319511059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319511059
		arg_242_1.duration_ = 5.9

		local var_242_0 = {
			zh = 4.433333333332,
			ja = 5.9
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319511060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = "ST71"

			if arg_242_1.bgs_[var_245_0] == nil then
				local var_245_1 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_245_0)
				var_245_1.name = var_245_0
				var_245_1.transform.parent = arg_242_1.stage_.transform
				var_245_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_[var_245_0] = var_245_1
			end

			local var_245_2 = 0

			if var_245_2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				local var_245_3 = manager.ui.mainCamera.transform.localPosition
				local var_245_4 = Vector3.New(0, 0, 10) + Vector3.New(var_245_3.x, var_245_3.y, 0)
				local var_245_5 = arg_242_1.bgs_.ST71

				var_245_5.transform.localPosition = var_245_4
				var_245_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_6 = var_245_5:GetComponent("SpriteRenderer")

				if var_245_6 and var_245_6.sprite then
					local var_245_7 = (var_245_5.transform.localPosition - var_245_3).z
					local var_245_8 = manager.ui.mainCameraCom_
					local var_245_9 = 2 * var_245_7 * Mathf.Tan(var_245_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_245_10 = var_245_9 * var_245_8.aspect
					local var_245_11 = var_245_6.sprite.bounds.size.x
					local var_245_12 = var_245_6.sprite.bounds.size.y
					local var_245_13 = var_245_10 / var_245_11
					local var_245_14 = var_245_9 / var_245_12
					local var_245_15 = var_245_14 < var_245_13 and var_245_13 or var_245_14

					var_245_5.transform.localScale = Vector3.New(var_245_15, var_245_15, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "ST71" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_16 = 0

			if var_245_16 < arg_242_1.time_ and arg_242_1.time_ <= var_245_16 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_17 = 1.5

			if var_245_16 <= arg_242_1.time_ and arg_242_1.time_ < var_245_16 + var_245_17 then
				local var_245_18 = (arg_242_1.time_ - var_245_16) / var_245_17
				local var_245_19 = Color.New(0, 0, 0)

				var_245_19.a = Mathf.Lerp(1, 0, var_245_18)
				arg_242_1.mask_.color = var_245_19
			end

			if arg_242_1.time_ >= var_245_16 + var_245_17 and arg_242_1.time_ < var_245_16 + var_245_17 + arg_245_0 then
				local var_245_20 = Color.New(0, 0, 0)
				local var_245_21 = 0

				arg_242_1.mask_.enabled = false
				var_245_20.a = var_245_21
				arg_242_1.mask_.color = var_245_20
			end

			local var_245_22 = "10050ui_story"

			if arg_242_1.actors_[var_245_22] == nil then
				local var_245_23 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_245_23) then
					local var_245_24 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_242_1.stage_.transform)

					var_245_24.name = var_245_22
					var_245_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_242_1.actors_[var_245_22] = var_245_24

					local var_245_25 = var_245_24:GetComponentInChildren(typeof(CharacterEffect))

					var_245_25.enabled = true

					local var_245_26 = GameObjectTools.GetOrAddComponent(var_245_24, typeof(DynamicBoneHelper))

					if var_245_26 then
						var_245_26:EnableDynamicBone(false)
					end

					arg_242_1:ShowWeapon(var_245_25.transform, false)

					arg_242_1.var_[var_245_22 .. "Animator"] = var_245_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_242_1.var_[var_245_22 .. "Animator"].applyRootMotion = true
					arg_242_1.var_[var_245_22 .. "LipSync"] = var_245_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_245_27 = arg_242_1.actors_["10050ui_story"].transform
			local var_245_28 = 1.5

			if var_245_28 < arg_242_1.time_ and arg_242_1.time_ <= var_245_28 + arg_245_0 then
				arg_242_1.var_.moveOldPos10050ui_story = var_245_27.localPosition
			end

			local var_245_29 = 0.001

			if var_245_28 <= arg_242_1.time_ and arg_242_1.time_ < var_245_28 + var_245_29 then
				local var_245_30 = (arg_242_1.time_ - var_245_28) / var_245_29
				local var_245_31 = Vector3.New(0, -0.715, -6.15)

				var_245_27.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10050ui_story, var_245_31, var_245_30)

				local var_245_32 = manager.ui.mainCamera.transform.position - var_245_27.position

				var_245_27.forward = Vector3.New(var_245_32.x, var_245_32.y, var_245_32.z)

				local var_245_33 = var_245_27.localEulerAngles

				var_245_33.z = 0
				var_245_33.x = 0
				var_245_27.localEulerAngles = var_245_33
			end

			if arg_242_1.time_ >= var_245_28 + var_245_29 and arg_242_1.time_ < var_245_28 + var_245_29 + arg_245_0 then
				var_245_27.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_245_34 = manager.ui.mainCamera.transform.position - var_245_27.position

				var_245_27.forward = Vector3.New(var_245_34.x, var_245_34.y, var_245_34.z)

				local var_245_35 = var_245_27.localEulerAngles

				var_245_35.z = 0
				var_245_35.x = 0
				var_245_27.localEulerAngles = var_245_35
			end

			local var_245_36 = arg_242_1.actors_["10050ui_story"]
			local var_245_37 = 1.5

			if var_245_37 < arg_242_1.time_ and arg_242_1.time_ <= var_245_37 + arg_245_0 and not isNil(var_245_36) and arg_242_1.var_.characterEffect10050ui_story == nil then
				arg_242_1.var_.characterEffect10050ui_story = var_245_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_38 = 0.200000002980232

			if var_245_37 <= arg_242_1.time_ and arg_242_1.time_ < var_245_37 + var_245_38 and not isNil(var_245_36) then
				local var_245_39 = (arg_242_1.time_ - var_245_37) / var_245_38

				if arg_242_1.var_.characterEffect10050ui_story and not isNil(var_245_36) then
					arg_242_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_37 + var_245_38 and arg_242_1.time_ < var_245_37 + var_245_38 + arg_245_0 and not isNil(var_245_36) and arg_242_1.var_.characterEffect10050ui_story then
				arg_242_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_245_40 = 1.5

			if var_245_40 < arg_242_1.time_ and arg_242_1.time_ <= var_245_40 + arg_245_0 then
				arg_242_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			local var_245_41 = 1.5

			if var_245_41 < arg_242_1.time_ and arg_242_1.time_ <= var_245_41 + arg_245_0 then
				arg_242_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_245_42 = 0
			local var_245_43 = 0.0666666666666667

			if var_245_42 < arg_242_1.time_ and arg_242_1.time_ <= var_245_42 + arg_245_0 then
				local var_245_44 = "play"
				local var_245_45 = "music"

				arg_242_1:AudioAction(var_245_44, var_245_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_245_46 = ""
				local var_245_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_245_47 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_47 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_47

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_47
						arg_242_1.bgmTxt2_.text = var_245_47
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_48 = 0.133333333333333
			local var_245_49 = 1

			if var_245_48 < arg_242_1.time_ and arg_242_1.time_ <= var_245_48 + arg_245_0 then
				local var_245_50 = "play"
				local var_245_51 = "music"

				arg_242_1:AudioAction(var_245_50, var_245_51, "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_245_52 = ""
				local var_245_53 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if var_245_53 ~= "" then
					if arg_242_1.bgmTxt_.text ~= var_245_53 and arg_242_1.bgmTxt_.text ~= "" then
						if arg_242_1.bgmTxt2_.text ~= "" then
							arg_242_1.bgmTxt_.text = arg_242_1.bgmTxt2_.text
						end

						arg_242_1.bgmTxt2_.text = var_245_53

						arg_242_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_242_1.bgmTxt_.text = var_245_53
						arg_242_1.bgmTxt2_.text = var_245_53
					end

					if arg_242_1.bgmTimer then
						arg_242_1.bgmTimer:Stop()

						arg_242_1.bgmTimer = nil
					end

					if arg_242_1.settingData.show_music_name == 1 then
						arg_242_1.musicController:SetSelectedState("show")
						arg_242_1.musicAnimator_:Play("open", 0, 0)

						if arg_242_1.settingData.music_time ~= 0 then
							arg_242_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_242_1.settingData.music_time), function()
								if arg_242_1 == nil or isNil(arg_242_1.bgmTxt_) then
									return
								end

								arg_242_1.musicController:SetSelectedState("hide")
								arg_242_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_245_54 = 0

			if var_245_54 < arg_242_1.time_ and arg_242_1.time_ <= var_245_54 + arg_245_0 then
				SetActive(arg_242_1.dialog_, false)
				SetActive(arg_242_1.allBtn_.gameObject, true)
				arg_242_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_242_1.isInLoopVideo = false
			end

			local var_245_55 = 0.0333333333333333

			if var_245_54 <= arg_242_1.time_ and arg_242_1.time_ < var_245_54 + var_245_55 then
				-- block empty
			end

			if arg_242_1.time_ >= var_245_54 + var_245_55 and arg_242_1.time_ < var_245_54 + var_245_55 + arg_245_0 then
				arg_242_1.marker = ""
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_56 = 1.5
			local var_245_57 = 0.2

			if var_245_56 < arg_242_1.time_ and arg_242_1.time_ <= var_245_56 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_58 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_58:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_242_1.dialogCg_.alpha = arg_248_0
				end))
				var_245_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_59 = arg_242_1:FormatText(StoryNameCfg[692].name)

				arg_242_1.leftNameTxt_.text = var_245_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_60 = arg_242_1:GetWordFromCfg(319511059)
				local var_245_61 = arg_242_1:FormatText(var_245_60.content)

				arg_242_1.text_.text = var_245_61

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_62 = 8
				local var_245_63 = utf8.len(var_245_61)
				local var_245_64 = var_245_62 <= 0 and var_245_57 or var_245_57 * (var_245_63 / var_245_62)

				if var_245_64 > 0 and var_245_57 < var_245_64 then
					arg_242_1.talkMaxDuration = var_245_64
					var_245_56 = var_245_56 + 0.3

					if var_245_64 + var_245_56 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_64 + var_245_56
					end
				end

				arg_242_1.text_.text = var_245_61
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511059", "story_v_out_319511.awb") ~= 0 then
					local var_245_65 = manager.audio:GetVoiceLength("story_v_out_319511", "319511059", "story_v_out_319511.awb") / 1000

					if var_245_65 + var_245_56 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_65 + var_245_56
					end

					if var_245_60.prefab_name ~= "" and arg_242_1.actors_[var_245_60.prefab_name] ~= nil then
						local var_245_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_60.prefab_name].transform, "story_v_out_319511", "319511059", "story_v_out_319511.awb")

						arg_242_1:RecordAudio("319511059", var_245_66)
						arg_242_1:RecordAudio("319511059", var_245_66)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319511", "319511059", "story_v_out_319511.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319511", "319511059", "story_v_out_319511.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_67 = var_245_56 + 0.3
			local var_245_68 = math.max(var_245_57, arg_242_1.talkMaxDuration)

			if var_245_67 <= arg_242_1.time_ and arg_242_1.time_ < var_245_67 + var_245_68 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_67) / var_245_68

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_67 + var_245_68 and arg_242_1.time_ < var_245_67 + var_245_68 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play319511060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319511060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319511061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10050ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10050ui_story == nil then
				arg_250_1.var_.characterEffect10050ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect10050ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10050ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect10050ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10050ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.925

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_8 = arg_250_1:GetWordFromCfg(319511060)
				local var_253_9 = arg_250_1:FormatText(var_253_8.content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 37
				local var_253_11 = utf8.len(var_253_9)
				local var_253_12 = var_253_10 <= 0 and var_253_7 or var_253_7 * (var_253_11 / var_253_10)

				if var_253_12 > 0 and var_253_7 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_13 and arg_250_1.time_ < var_253_6 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play319511061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319511061
		arg_254_1.duration_ = 6.2

		local var_254_0 = {
			zh = 2.666,
			ja = 6.2
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319511062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10050ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10050ui_story == nil then
				arg_254_1.var_.characterEffect10050ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect10050ui_story and not isNil(var_257_0) then
					arg_254_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect10050ui_story then
				arg_254_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_257_4 = 0
			local var_257_5 = 0.225

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_6 = arg_254_1:FormatText(StoryNameCfg[692].name)

				arg_254_1.leftNameTxt_.text = var_257_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_7 = arg_254_1:GetWordFromCfg(319511061)
				local var_257_8 = arg_254_1:FormatText(var_257_7.content)

				arg_254_1.text_.text = var_257_8

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 9
				local var_257_10 = utf8.len(var_257_8)
				local var_257_11 = var_257_9 <= 0 and var_257_5 or var_257_5 * (var_257_10 / var_257_9)

				if var_257_11 > 0 and var_257_5 < var_257_11 then
					arg_254_1.talkMaxDuration = var_257_11

					if var_257_11 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_8
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511061", "story_v_out_319511.awb") ~= 0 then
					local var_257_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511061", "story_v_out_319511.awb") / 1000

					if var_257_12 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_4
					end

					if var_257_7.prefab_name ~= "" and arg_254_1.actors_[var_257_7.prefab_name] ~= nil then
						local var_257_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_7.prefab_name].transform, "story_v_out_319511", "319511061", "story_v_out_319511.awb")

						arg_254_1:RecordAudio("319511061", var_257_13)
						arg_254_1:RecordAudio("319511061", var_257_13)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319511", "319511061", "story_v_out_319511.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319511", "319511061", "story_v_out_319511.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_14 and arg_254_1.time_ < var_257_4 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319511062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319511062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319511063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10050ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10050ui_story == nil then
				arg_258_1.var_.characterEffect10050ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect10050ui_story and not isNil(var_261_0) then
					local var_261_4 = Mathf.Lerp(0, 0.5, var_261_3)

					arg_258_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10050ui_story.fillRatio = var_261_4
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect10050ui_story then
				local var_261_5 = 0.5

				arg_258_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10050ui_story.fillRatio = var_261_5
			end

			local var_261_6 = 0
			local var_261_7 = 0.425

			if var_261_6 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_8 = arg_258_1:FormatText(StoryNameCfg[698].name)

				arg_258_1.leftNameTxt_.text = var_261_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_9 = arg_258_1:GetWordFromCfg(319511062)
				local var_261_10 = arg_258_1:FormatText(var_261_9.content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 17
				local var_261_12 = utf8.len(var_261_10)
				local var_261_13 = var_261_11 <= 0 and var_261_7 or var_261_7 * (var_261_12 / var_261_11)

				if var_261_13 > 0 and var_261_7 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319511063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319511063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319511064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.45

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[698].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(319511063)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 18
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319511064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319511064
		arg_266_1.duration_ = 12.43

		local var_266_0 = {
			zh = 8.466,
			ja = 12.433
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319511065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10050ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos10050ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, -0.715, -6.15)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10050ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["10050ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect10050ui_story == nil then
				arg_266_1.var_.characterEffect10050ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect10050ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect10050ui_story then
				arg_266_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_15 = 0
			local var_269_16 = 1

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[692].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(319511064)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 40
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511064", "story_v_out_319511.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511064", "story_v_out_319511.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_out_319511", "319511064", "story_v_out_319511.awb")

						arg_266_1:RecordAudio("319511064", var_269_24)
						arg_266_1:RecordAudio("319511064", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319511", "319511064", "story_v_out_319511.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319511", "319511064", "story_v_out_319511.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play319511065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319511065
		arg_270_1.duration_ = 5.33

		local var_270_0 = {
			zh = 4.8,
			ja = 5.333
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319511066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.55

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[692].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:GetWordFromCfg(319511065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 22
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511065", "story_v_out_319511.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511065", "story_v_out_319511.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_319511", "319511065", "story_v_out_319511.awb")

						arg_270_1:RecordAudio("319511065", var_273_9)
						arg_270_1:RecordAudio("319511065", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_319511", "319511065", "story_v_out_319511.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_319511", "319511065", "story_v_out_319511.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play319511066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319511066
		arg_274_1.duration_ = 4.57

		local var_274_0 = {
			zh = 3.3,
			ja = 4.566
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319511067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10068ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos10068ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0.7, -0.75, -6.18)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10068ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0.7, -0.75, -6.18)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["10068ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10068ui_story == nil then
				arg_274_1.var_.characterEffect10068ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect10068ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect10068ui_story then
				arg_274_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_277_15 = arg_274_1.actors_["10050ui_story"].transform
			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.var_.moveOldPos10050ui_story = var_277_15.localPosition
			end

			local var_277_17 = 0.001

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_17 then
				local var_277_18 = (arg_274_1.time_ - var_277_16) / var_277_17
				local var_277_19 = Vector3.New(-0.7, -0.715, -6.15)

				var_277_15.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10050ui_story, var_277_19, var_277_18)

				local var_277_20 = manager.ui.mainCamera.transform.position - var_277_15.position

				var_277_15.forward = Vector3.New(var_277_20.x, var_277_20.y, var_277_20.z)

				local var_277_21 = var_277_15.localEulerAngles

				var_277_21.z = 0
				var_277_21.x = 0
				var_277_15.localEulerAngles = var_277_21
			end

			if arg_274_1.time_ >= var_277_16 + var_277_17 and arg_274_1.time_ < var_277_16 + var_277_17 + arg_277_0 then
				var_277_15.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_277_22 = manager.ui.mainCamera.transform.position - var_277_15.position

				var_277_15.forward = Vector3.New(var_277_22.x, var_277_22.y, var_277_22.z)

				local var_277_23 = var_277_15.localEulerAngles

				var_277_23.z = 0
				var_277_23.x = 0
				var_277_15.localEulerAngles = var_277_23
			end

			local var_277_24 = arg_274_1.actors_["10050ui_story"]
			local var_277_25 = 0

			if var_277_25 < arg_274_1.time_ and arg_274_1.time_ <= var_277_25 + arg_277_0 and not isNil(var_277_24) and arg_274_1.var_.characterEffect10050ui_story == nil then
				arg_274_1.var_.characterEffect10050ui_story = var_277_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_26 = 0.200000002980232

			if var_277_25 <= arg_274_1.time_ and arg_274_1.time_ < var_277_25 + var_277_26 and not isNil(var_277_24) then
				local var_277_27 = (arg_274_1.time_ - var_277_25) / var_277_26

				if arg_274_1.var_.characterEffect10050ui_story and not isNil(var_277_24) then
					local var_277_28 = Mathf.Lerp(0, 0.5, var_277_27)

					arg_274_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_274_1.var_.characterEffect10050ui_story.fillRatio = var_277_28
				end
			end

			if arg_274_1.time_ >= var_277_25 + var_277_26 and arg_274_1.time_ < var_277_25 + var_277_26 + arg_277_0 and not isNil(var_277_24) and arg_274_1.var_.characterEffect10050ui_story then
				local var_277_29 = 0.5

				arg_274_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_274_1.var_.characterEffect10050ui_story.fillRatio = var_277_29
			end

			local var_277_30 = 0
			local var_277_31 = 0.35

			if var_277_30 < arg_274_1.time_ and arg_274_1.time_ <= var_277_30 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_32 = arg_274_1:FormatText(StoryNameCfg[697].name)

				arg_274_1.leftNameTxt_.text = var_277_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_33 = arg_274_1:GetWordFromCfg(319511066)
				local var_277_34 = arg_274_1:FormatText(var_277_33.content)

				arg_274_1.text_.text = var_277_34

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_35 = 14
				local var_277_36 = utf8.len(var_277_34)
				local var_277_37 = var_277_35 <= 0 and var_277_31 or var_277_31 * (var_277_36 / var_277_35)

				if var_277_37 > 0 and var_277_31 < var_277_37 then
					arg_274_1.talkMaxDuration = var_277_37

					if var_277_37 + var_277_30 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_37 + var_277_30
					end
				end

				arg_274_1.text_.text = var_277_34
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511066", "story_v_out_319511.awb") ~= 0 then
					local var_277_38 = manager.audio:GetVoiceLength("story_v_out_319511", "319511066", "story_v_out_319511.awb") / 1000

					if var_277_38 + var_277_30 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_38 + var_277_30
					end

					if var_277_33.prefab_name ~= "" and arg_274_1.actors_[var_277_33.prefab_name] ~= nil then
						local var_277_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_33.prefab_name].transform, "story_v_out_319511", "319511066", "story_v_out_319511.awb")

						arg_274_1:RecordAudio("319511066", var_277_39)
						arg_274_1:RecordAudio("319511066", var_277_39)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319511", "319511066", "story_v_out_319511.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319511", "319511066", "story_v_out_319511.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_40 = math.max(var_277_31, arg_274_1.talkMaxDuration)

			if var_277_30 <= arg_274_1.time_ and arg_274_1.time_ < var_277_30 + var_277_40 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_30) / var_277_40

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_30 + var_277_40 and arg_274_1.time_ < var_277_30 + var_277_40 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play319511067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319511067
		arg_278_1.duration_ = 7.5

		local var_278_0 = {
			zh = 7.5,
			ja = 6.966
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319511068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10068ui_story"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10068ui_story == nil then
				arg_278_1.var_.characterEffect10068ui_story = var_281_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.characterEffect10068ui_story and not isNil(var_281_0) then
					local var_281_4 = Mathf.Lerp(0, 0.5, var_281_3)

					arg_278_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_278_1.var_.characterEffect10068ui_story.fillRatio = var_281_4
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.characterEffect10068ui_story then
				local var_281_5 = 0.5

				arg_278_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_278_1.var_.characterEffect10068ui_story.fillRatio = var_281_5
			end

			local var_281_6 = arg_278_1.actors_["10050ui_story"]
			local var_281_7 = 0

			if var_281_7 < arg_278_1.time_ and arg_278_1.time_ <= var_281_7 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10050ui_story == nil then
				arg_278_1.var_.characterEffect10050ui_story = var_281_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_8 = 0.200000002980232

			if var_281_7 <= arg_278_1.time_ and arg_278_1.time_ < var_281_7 + var_281_8 and not isNil(var_281_6) then
				local var_281_9 = (arg_278_1.time_ - var_281_7) / var_281_8

				if arg_278_1.var_.characterEffect10050ui_story and not isNil(var_281_6) then
					arg_278_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= var_281_7 + var_281_8 and arg_278_1.time_ < var_281_7 + var_281_8 + arg_281_0 and not isNil(var_281_6) and arg_278_1.var_.characterEffect10050ui_story then
				arg_278_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_281_10 = 0
			local var_281_11 = 0.85

			if var_281_10 < arg_278_1.time_ and arg_278_1.time_ <= var_281_10 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_12 = arg_278_1:FormatText(StoryNameCfg[692].name)

				arg_278_1.leftNameTxt_.text = var_281_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_13 = arg_278_1:GetWordFromCfg(319511067)
				local var_281_14 = arg_278_1:FormatText(var_281_13.content)

				arg_278_1.text_.text = var_281_14

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_15 = 34
				local var_281_16 = utf8.len(var_281_14)
				local var_281_17 = var_281_15 <= 0 and var_281_11 or var_281_11 * (var_281_16 / var_281_15)

				if var_281_17 > 0 and var_281_11 < var_281_17 then
					arg_278_1.talkMaxDuration = var_281_17

					if var_281_17 + var_281_10 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_10
					end
				end

				arg_278_1.text_.text = var_281_14
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511067", "story_v_out_319511.awb") ~= 0 then
					local var_281_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511067", "story_v_out_319511.awb") / 1000

					if var_281_18 + var_281_10 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_18 + var_281_10
					end

					if var_281_13.prefab_name ~= "" and arg_278_1.actors_[var_281_13.prefab_name] ~= nil then
						local var_281_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_13.prefab_name].transform, "story_v_out_319511", "319511067", "story_v_out_319511.awb")

						arg_278_1:RecordAudio("319511067", var_281_19)
						arg_278_1:RecordAudio("319511067", var_281_19)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319511", "319511067", "story_v_out_319511.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319511", "319511067", "story_v_out_319511.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_20 = math.max(var_281_11, arg_278_1.talkMaxDuration)

			if var_281_10 <= arg_278_1.time_ and arg_278_1.time_ < var_281_10 + var_281_20 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_10) / var_281_20

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_10 + var_281_20 and arg_278_1.time_ < var_281_10 + var_281_20 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319511068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319511068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319511069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10050ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10050ui_story == nil then
				arg_282_1.var_.characterEffect10050ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect10050ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_282_1.var_.characterEffect10050ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect10050ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_282_1.var_.characterEffect10050ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.325

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[698].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(319511068)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 13
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319511069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319511069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319511070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.575

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(319511069)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 23
				local var_289_5 = utf8.len(var_289_3)
				local var_289_6 = var_289_4 <= 0 and var_289_1 or var_289_1 * (var_289_5 / var_289_4)

				if var_289_6 > 0 and var_289_1 < var_289_6 then
					arg_286_1.talkMaxDuration = var_289_6

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_7 and arg_286_1.time_ < var_289_0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319511070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319511070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319511071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.7

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[698].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(319511070)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 28
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319511071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319511071
		arg_294_1.duration_ = 8

		local var_294_0 = {
			zh = 4,
			ja = 8
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319511072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10050ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos10050ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, -0.715, -6.15)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10050ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["10050ui_story"]
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10050ui_story == nil then
				arg_294_1.var_.characterEffect10050ui_story = var_297_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_11 = 0.200000002980232

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 and not isNil(var_297_9) then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11

				if arg_294_1.var_.characterEffect10050ui_story and not isNil(var_297_9) then
					arg_294_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 and not isNil(var_297_9) and arg_294_1.var_.characterEffect10050ui_story then
				arg_294_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_297_13 = 0

			if var_297_13 < arg_294_1.time_ and arg_294_1.time_ <= var_297_13 + arg_297_0 then
				arg_294_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_1")
			end

			local var_297_14 = 0

			if var_297_14 < arg_294_1.time_ and arg_294_1.time_ <= var_297_14 + arg_297_0 then
				arg_294_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_297_15 = arg_294_1.actors_["10068ui_story"].transform
			local var_297_16 = 0

			if var_297_16 < arg_294_1.time_ and arg_294_1.time_ <= var_297_16 + arg_297_0 then
				arg_294_1.var_.moveOldPos10068ui_story = var_297_15.localPosition
			end

			local var_297_17 = 0.001

			if var_297_16 <= arg_294_1.time_ and arg_294_1.time_ < var_297_16 + var_297_17 then
				local var_297_18 = (arg_294_1.time_ - var_297_16) / var_297_17
				local var_297_19 = Vector3.New(0, 100, 0)

				var_297_15.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10068ui_story, var_297_19, var_297_18)

				local var_297_20 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_20.x, var_297_20.y, var_297_20.z)

				local var_297_21 = var_297_15.localEulerAngles

				var_297_21.z = 0
				var_297_21.x = 0
				var_297_15.localEulerAngles = var_297_21
			end

			if arg_294_1.time_ >= var_297_16 + var_297_17 and arg_294_1.time_ < var_297_16 + var_297_17 + arg_297_0 then
				var_297_15.localPosition = Vector3.New(0, 100, 0)

				local var_297_22 = manager.ui.mainCamera.transform.position - var_297_15.position

				var_297_15.forward = Vector3.New(var_297_22.x, var_297_22.y, var_297_22.z)

				local var_297_23 = var_297_15.localEulerAngles

				var_297_23.z = 0
				var_297_23.x = 0
				var_297_15.localEulerAngles = var_297_23
			end

			local var_297_24 = arg_294_1.actors_["10068ui_story"]
			local var_297_25 = 0

			if var_297_25 < arg_294_1.time_ and arg_294_1.time_ <= var_297_25 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect10068ui_story == nil then
				arg_294_1.var_.characterEffect10068ui_story = var_297_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_26 = 0.200000002980232

			if var_297_25 <= arg_294_1.time_ and arg_294_1.time_ < var_297_25 + var_297_26 and not isNil(var_297_24) then
				local var_297_27 = (arg_294_1.time_ - var_297_25) / var_297_26

				if arg_294_1.var_.characterEffect10068ui_story and not isNil(var_297_24) then
					arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_25 + var_297_26 and arg_294_1.time_ < var_297_25 + var_297_26 + arg_297_0 and not isNil(var_297_24) and arg_294_1.var_.characterEffect10068ui_story then
				arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_297_28 = 0
			local var_297_29 = 0.45

			if var_297_28 < arg_294_1.time_ and arg_294_1.time_ <= var_297_28 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_30 = arg_294_1:FormatText(StoryNameCfg[692].name)

				arg_294_1.leftNameTxt_.text = var_297_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_31 = arg_294_1:GetWordFromCfg(319511071)
				local var_297_32 = arg_294_1:FormatText(var_297_31.content)

				arg_294_1.text_.text = var_297_32

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_33 = 18
				local var_297_34 = utf8.len(var_297_32)
				local var_297_35 = var_297_33 <= 0 and var_297_29 or var_297_29 * (var_297_34 / var_297_33)

				if var_297_35 > 0 and var_297_29 < var_297_35 then
					arg_294_1.talkMaxDuration = var_297_35

					if var_297_35 + var_297_28 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_35 + var_297_28
					end
				end

				arg_294_1.text_.text = var_297_32
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511071", "story_v_out_319511.awb") ~= 0 then
					local var_297_36 = manager.audio:GetVoiceLength("story_v_out_319511", "319511071", "story_v_out_319511.awb") / 1000

					if var_297_36 + var_297_28 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_36 + var_297_28
					end

					if var_297_31.prefab_name ~= "" and arg_294_1.actors_[var_297_31.prefab_name] ~= nil then
						local var_297_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_31.prefab_name].transform, "story_v_out_319511", "319511071", "story_v_out_319511.awb")

						arg_294_1:RecordAudio("319511071", var_297_37)
						arg_294_1:RecordAudio("319511071", var_297_37)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319511", "319511071", "story_v_out_319511.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319511", "319511071", "story_v_out_319511.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_38 = math.max(var_297_29, arg_294_1.talkMaxDuration)

			if var_297_28 <= arg_294_1.time_ and arg_294_1.time_ < var_297_28 + var_297_38 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_28) / var_297_38

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_28 + var_297_38 and arg_294_1.time_ < var_297_28 + var_297_38 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319511072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319511072
		arg_298_1.duration_ = 2.57

		local var_298_0 = {
			zh = 2.033,
			ja = 2.566
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play319511073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1084ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1084ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0.7, -0.97, -6)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1084ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1084ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1084ui_story == nil then
				arg_298_1.var_.characterEffect1084ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.200000002980232

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect1084ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1084ui_story then
				arg_298_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_301_13 = 0

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_301_14 = 0

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_301_15 = arg_298_1.actors_["10050ui_story"].transform
			local var_301_16 = 0

			if var_301_16 < arg_298_1.time_ and arg_298_1.time_ <= var_301_16 + arg_301_0 then
				arg_298_1.var_.moveOldPos10050ui_story = var_301_15.localPosition
			end

			local var_301_17 = 0.001

			if var_301_16 <= arg_298_1.time_ and arg_298_1.time_ < var_301_16 + var_301_17 then
				local var_301_18 = (arg_298_1.time_ - var_301_16) / var_301_17
				local var_301_19 = Vector3.New(-0.7, -0.715, -6.15)

				var_301_15.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10050ui_story, var_301_19, var_301_18)

				local var_301_20 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_20.x, var_301_20.y, var_301_20.z)

				local var_301_21 = var_301_15.localEulerAngles

				var_301_21.z = 0
				var_301_21.x = 0
				var_301_15.localEulerAngles = var_301_21
			end

			if arg_298_1.time_ >= var_301_16 + var_301_17 and arg_298_1.time_ < var_301_16 + var_301_17 + arg_301_0 then
				var_301_15.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_301_22 = manager.ui.mainCamera.transform.position - var_301_15.position

				var_301_15.forward = Vector3.New(var_301_22.x, var_301_22.y, var_301_22.z)

				local var_301_23 = var_301_15.localEulerAngles

				var_301_23.z = 0
				var_301_23.x = 0
				var_301_15.localEulerAngles = var_301_23
			end

			local var_301_24 = arg_298_1.actors_["10050ui_story"]
			local var_301_25 = 0

			if var_301_25 < arg_298_1.time_ and arg_298_1.time_ <= var_301_25 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect10050ui_story == nil then
				arg_298_1.var_.characterEffect10050ui_story = var_301_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_26 = 0.200000002980232

			if var_301_25 <= arg_298_1.time_ and arg_298_1.time_ < var_301_25 + var_301_26 and not isNil(var_301_24) then
				local var_301_27 = (arg_298_1.time_ - var_301_25) / var_301_26

				if arg_298_1.var_.characterEffect10050ui_story and not isNil(var_301_24) then
					local var_301_28 = Mathf.Lerp(0, 0.5, var_301_27)

					arg_298_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_298_1.var_.characterEffect10050ui_story.fillRatio = var_301_28
				end
			end

			if arg_298_1.time_ >= var_301_25 + var_301_26 and arg_298_1.time_ < var_301_25 + var_301_26 + arg_301_0 and not isNil(var_301_24) and arg_298_1.var_.characterEffect10050ui_story then
				local var_301_29 = 0.5

				arg_298_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_298_1.var_.characterEffect10050ui_story.fillRatio = var_301_29
			end

			local var_301_30 = 0
			local var_301_31 = 0.15

			if var_301_30 < arg_298_1.time_ and arg_298_1.time_ <= var_301_30 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_32 = arg_298_1:FormatText(StoryNameCfg[6].name)

				arg_298_1.leftNameTxt_.text = var_301_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_33 = arg_298_1:GetWordFromCfg(319511072)
				local var_301_34 = arg_298_1:FormatText(var_301_33.content)

				arg_298_1.text_.text = var_301_34

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_35 = 6
				local var_301_36 = utf8.len(var_301_34)
				local var_301_37 = var_301_35 <= 0 and var_301_31 or var_301_31 * (var_301_36 / var_301_35)

				if var_301_37 > 0 and var_301_31 < var_301_37 then
					arg_298_1.talkMaxDuration = var_301_37

					if var_301_37 + var_301_30 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_37 + var_301_30
					end
				end

				arg_298_1.text_.text = var_301_34
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511072", "story_v_out_319511.awb") ~= 0 then
					local var_301_38 = manager.audio:GetVoiceLength("story_v_out_319511", "319511072", "story_v_out_319511.awb") / 1000

					if var_301_38 + var_301_30 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_38 + var_301_30
					end

					if var_301_33.prefab_name ~= "" and arg_298_1.actors_[var_301_33.prefab_name] ~= nil then
						local var_301_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_33.prefab_name].transform, "story_v_out_319511", "319511072", "story_v_out_319511.awb")

						arg_298_1:RecordAudio("319511072", var_301_39)
						arg_298_1:RecordAudio("319511072", var_301_39)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_319511", "319511072", "story_v_out_319511.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_319511", "319511072", "story_v_out_319511.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_40 = math.max(var_301_31, arg_298_1.talkMaxDuration)

			if var_301_30 <= arg_298_1.time_ and arg_298_1.time_ < var_301_30 + var_301_40 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_30) / var_301_40

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_30 + var_301_40 and arg_298_1.time_ < var_301_30 + var_301_40 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play319511073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319511073
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319511074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1084ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1084ui_story == nil then
				arg_302_1.var_.characterEffect1084ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1084ui_story and not isNil(var_305_0) then
					local var_305_4 = Mathf.Lerp(0, 0.5, var_305_3)

					arg_302_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1084ui_story.fillRatio = var_305_4
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1084ui_story then
				local var_305_5 = 0.5

				arg_302_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1084ui_story.fillRatio = var_305_5
			end

			local var_305_6 = 0
			local var_305_7 = 1.125

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(319511073)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 45
				local var_305_11 = utf8.len(var_305_9)
				local var_305_12 = var_305_10 <= 0 and var_305_7 or var_305_7 * (var_305_11 / var_305_10)

				if var_305_12 > 0 and var_305_7 < var_305_12 then
					arg_302_1.talkMaxDuration = var_305_12

					if var_305_12 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_13 and arg_302_1.time_ < var_305_6 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play319511074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319511074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play319511075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.225

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(319511074)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 49
				local var_309_5 = utf8.len(var_309_3)
				local var_309_6 = var_309_4 <= 0 and var_309_1 or var_309_1 * (var_309_5 / var_309_4)

				if var_309_6 > 0 and var_309_1 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_7 and arg_306_1.time_ < var_309_0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319511075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319511075
		arg_310_1.duration_ = 8.67

		local var_310_0 = {
			zh = 4.133,
			ja = 8.666
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319511076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_2")
			end

			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_313_2 = arg_310_1.actors_["10050ui_story"]
			local var_313_3 = 0

			if var_313_3 < arg_310_1.time_ and arg_310_1.time_ <= var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect10050ui_story == nil then
				arg_310_1.var_.characterEffect10050ui_story = var_313_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_4 = 0.200000002980232

			if var_313_3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_3 + var_313_4 and not isNil(var_313_2) then
				local var_313_5 = (arg_310_1.time_ - var_313_3) / var_313_4

				if arg_310_1.var_.characterEffect10050ui_story and not isNil(var_313_2) then
					arg_310_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_3 + var_313_4 and arg_310_1.time_ < var_313_3 + var_313_4 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect10050ui_story then
				arg_310_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_313_6 = 0
			local var_313_7 = 0.525

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[692].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_9 = arg_310_1:GetWordFromCfg(319511075)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 21
				local var_313_12 = utf8.len(var_313_10)
				local var_313_13 = var_313_11 <= 0 and var_313_7 or var_313_7 * (var_313_12 / var_313_11)

				if var_313_13 > 0 and var_313_7 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_10
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511075", "story_v_out_319511.awb") ~= 0 then
					local var_313_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511075", "story_v_out_319511.awb") / 1000

					if var_313_14 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_14 + var_313_6
					end

					if var_313_9.prefab_name ~= "" and arg_310_1.actors_[var_313_9.prefab_name] ~= nil then
						local var_313_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_9.prefab_name].transform, "story_v_out_319511", "319511075", "story_v_out_319511.awb")

						arg_310_1:RecordAudio("319511075", var_313_15)
						arg_310_1:RecordAudio("319511075", var_313_15)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_319511", "319511075", "story_v_out_319511.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_319511", "319511075", "story_v_out_319511.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_16 and arg_310_1.time_ < var_313_6 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319511076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319511076
		arg_314_1.duration_ = 1.43

		local var_314_0 = {
			zh = 1.433,
			ja = 1.333
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play319511077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1084ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1084ui_story == nil then
				arg_314_1.var_.characterEffect1084ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1084ui_story and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1084ui_story then
				arg_314_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_317_4 = arg_314_1.actors_["10050ui_story"]
			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect10050ui_story == nil then
				arg_314_1.var_.characterEffect10050ui_story = var_317_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_6 = 0.200000002980232

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_6 and not isNil(var_317_4) then
				local var_317_7 = (arg_314_1.time_ - var_317_5) / var_317_6

				if arg_314_1.var_.characterEffect10050ui_story and not isNil(var_317_4) then
					local var_317_8 = Mathf.Lerp(0, 0.5, var_317_7)

					arg_314_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10050ui_story.fillRatio = var_317_8
				end
			end

			if arg_314_1.time_ >= var_317_5 + var_317_6 and arg_314_1.time_ < var_317_5 + var_317_6 + arg_317_0 and not isNil(var_317_4) and arg_314_1.var_.characterEffect10050ui_story then
				local var_317_9 = 0.5

				arg_314_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10050ui_story.fillRatio = var_317_9
			end

			local var_317_10 = 0
			local var_317_11 = 0.1

			if var_317_10 < arg_314_1.time_ and arg_314_1.time_ <= var_317_10 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_12 = arg_314_1:FormatText(StoryNameCfg[6].name)

				arg_314_1.leftNameTxt_.text = var_317_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_13 = arg_314_1:GetWordFromCfg(319511076)
				local var_317_14 = arg_314_1:FormatText(var_317_13.content)

				arg_314_1.text_.text = var_317_14

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_15 = 4
				local var_317_16 = utf8.len(var_317_14)
				local var_317_17 = var_317_15 <= 0 and var_317_11 or var_317_11 * (var_317_16 / var_317_15)

				if var_317_17 > 0 and var_317_11 < var_317_17 then
					arg_314_1.talkMaxDuration = var_317_17

					if var_317_17 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_17 + var_317_10
					end
				end

				arg_314_1.text_.text = var_317_14
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511076", "story_v_out_319511.awb") ~= 0 then
					local var_317_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511076", "story_v_out_319511.awb") / 1000

					if var_317_18 + var_317_10 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_18 + var_317_10
					end

					if var_317_13.prefab_name ~= "" and arg_314_1.actors_[var_317_13.prefab_name] ~= nil then
						local var_317_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_13.prefab_name].transform, "story_v_out_319511", "319511076", "story_v_out_319511.awb")

						arg_314_1:RecordAudio("319511076", var_317_19)
						arg_314_1:RecordAudio("319511076", var_317_19)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319511", "319511076", "story_v_out_319511.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319511", "319511076", "story_v_out_319511.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_20 = math.max(var_317_11, arg_314_1.talkMaxDuration)

			if var_317_10 <= arg_314_1.time_ and arg_314_1.time_ < var_317_10 + var_317_20 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_10) / var_317_20

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_10 + var_317_20 and arg_314_1.time_ < var_317_10 + var_317_20 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play319511077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319511077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319511078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1084ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1084ui_story == nil then
				arg_318_1.var_.characterEffect1084ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1084ui_story and not isNil(var_321_0) then
					local var_321_4 = Mathf.Lerp(0, 0.5, var_321_3)

					arg_318_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1084ui_story.fillRatio = var_321_4
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1084ui_story then
				local var_321_5 = 0.5

				arg_318_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1084ui_story.fillRatio = var_321_5
			end

			local var_321_6 = 0
			local var_321_7 = 0.4

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_8 = arg_318_1:FormatText(StoryNameCfg[698].name)

				arg_318_1.leftNameTxt_.text = var_321_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_9 = arg_318_1:GetWordFromCfg(319511077)
				local var_321_10 = arg_318_1:FormatText(var_321_9.content)

				arg_318_1.text_.text = var_321_10

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_11 = 16
				local var_321_12 = utf8.len(var_321_10)
				local var_321_13 = var_321_11 <= 0 and var_321_7 or var_321_7 * (var_321_12 / var_321_11)

				if var_321_13 > 0 and var_321_7 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_10
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_14 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_14 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_14

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_14 and arg_318_1.time_ < var_321_6 + var_321_14 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319511078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319511078
		arg_322_1.duration_ = 4.53

		local var_322_0 = {
			zh = 2.166,
			ja = 4.533
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319511079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10050ui_story"].transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.moveOldPos10050ui_story = var_325_0.localPosition
			end

			local var_325_2 = 0.001

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2
				local var_325_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_325_0.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10050ui_story, var_325_4, var_325_3)

				local var_325_5 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_5.x, var_325_5.y, var_325_5.z)

				local var_325_6 = var_325_0.localEulerAngles

				var_325_6.z = 0
				var_325_6.x = 0
				var_325_0.localEulerAngles = var_325_6
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 then
				var_325_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_325_7 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_7.x, var_325_7.y, var_325_7.z)

				local var_325_8 = var_325_0.localEulerAngles

				var_325_8.z = 0
				var_325_8.x = 0
				var_325_0.localEulerAngles = var_325_8
			end

			local var_325_9 = arg_322_1.actors_["10050ui_story"]
			local var_325_10 = 0

			if var_325_10 < arg_322_1.time_ and arg_322_1.time_ <= var_325_10 + arg_325_0 and not isNil(var_325_9) and arg_322_1.var_.characterEffect10050ui_story == nil then
				arg_322_1.var_.characterEffect10050ui_story = var_325_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_11 = 0.200000002980232

			if var_325_10 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_11 and not isNil(var_325_9) then
				local var_325_12 = (arg_322_1.time_ - var_325_10) / var_325_11

				if arg_322_1.var_.characterEffect10050ui_story and not isNil(var_325_9) then
					arg_322_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_10 + var_325_11 and arg_322_1.time_ < var_325_10 + var_325_11 + arg_325_0 and not isNil(var_325_9) and arg_322_1.var_.characterEffect10050ui_story then
				arg_322_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_325_13 = 0

			if var_325_13 < arg_322_1.time_ and arg_322_1.time_ <= var_325_13 + arg_325_0 then
				arg_322_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_1")
			end

			local var_325_14 = 0

			if var_325_14 < arg_322_1.time_ and arg_322_1.time_ <= var_325_14 + arg_325_0 then
				arg_322_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_325_15 = 0
			local var_325_16 = 0.225

			if var_325_15 < arg_322_1.time_ and arg_322_1.time_ <= var_325_15 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_17 = arg_322_1:FormatText(StoryNameCfg[692].name)

				arg_322_1.leftNameTxt_.text = var_325_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_18 = arg_322_1:GetWordFromCfg(319511078)
				local var_325_19 = arg_322_1:FormatText(var_325_18.content)

				arg_322_1.text_.text = var_325_19

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_20 = 9
				local var_325_21 = utf8.len(var_325_19)
				local var_325_22 = var_325_20 <= 0 and var_325_16 or var_325_16 * (var_325_21 / var_325_20)

				if var_325_22 > 0 and var_325_16 < var_325_22 then
					arg_322_1.talkMaxDuration = var_325_22

					if var_325_22 + var_325_15 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_22 + var_325_15
					end
				end

				arg_322_1.text_.text = var_325_19
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511078", "story_v_out_319511.awb") ~= 0 then
					local var_325_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511078", "story_v_out_319511.awb") / 1000

					if var_325_23 + var_325_15 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_23 + var_325_15
					end

					if var_325_18.prefab_name ~= "" and arg_322_1.actors_[var_325_18.prefab_name] ~= nil then
						local var_325_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_18.prefab_name].transform, "story_v_out_319511", "319511078", "story_v_out_319511.awb")

						arg_322_1:RecordAudio("319511078", var_325_24)
						arg_322_1:RecordAudio("319511078", var_325_24)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_319511", "319511078", "story_v_out_319511.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_319511", "319511078", "story_v_out_319511.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_25 = math.max(var_325_16, arg_322_1.talkMaxDuration)

			if var_325_15 <= arg_322_1.time_ and arg_322_1.time_ < var_325_15 + var_325_25 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_15) / var_325_25

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_15 + var_325_25 and arg_322_1.time_ < var_325_15 + var_325_25 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play319511079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319511079
		arg_326_1.duration_ = 7.2

		local var_326_0 = {
			zh = 7.2,
			ja = 6.466
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319511080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_2")
			end

			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_329_2 = 0
			local var_329_3 = 0.875

			if var_329_2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_4 = arg_326_1:FormatText(StoryNameCfg[692].name)

				arg_326_1.leftNameTxt_.text = var_329_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_5 = arg_326_1:GetWordFromCfg(319511079)
				local var_329_6 = arg_326_1:FormatText(var_329_5.content)

				arg_326_1.text_.text = var_329_6

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 35
				local var_329_8 = utf8.len(var_329_6)
				local var_329_9 = var_329_7 <= 0 and var_329_3 or var_329_3 * (var_329_8 / var_329_7)

				if var_329_9 > 0 and var_329_3 < var_329_9 then
					arg_326_1.talkMaxDuration = var_329_9

					if var_329_9 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_9 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_6
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511079", "story_v_out_319511.awb") ~= 0 then
					local var_329_10 = manager.audio:GetVoiceLength("story_v_out_319511", "319511079", "story_v_out_319511.awb") / 1000

					if var_329_10 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_2
					end

					if var_329_5.prefab_name ~= "" and arg_326_1.actors_[var_329_5.prefab_name] ~= nil then
						local var_329_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_5.prefab_name].transform, "story_v_out_319511", "319511079", "story_v_out_319511.awb")

						arg_326_1:RecordAudio("319511079", var_329_11)
						arg_326_1:RecordAudio("319511079", var_329_11)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_319511", "319511079", "story_v_out_319511.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_319511", "319511079", "story_v_out_319511.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_12 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_12 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_12

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_12 and arg_326_1.time_ < var_329_2 + var_329_12 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319511080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319511080
		arg_330_1.duration_ = 9.77

		local var_330_0 = {
			zh = 9.766,
			ja = 8.4
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319511081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1.125

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[692].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:GetWordFromCfg(319511080)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 45
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511080", "story_v_out_319511.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511080", "story_v_out_319511.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_319511", "319511080", "story_v_out_319511.awb")

						arg_330_1:RecordAudio("319511080", var_333_9)
						arg_330_1:RecordAudio("319511080", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_319511", "319511080", "story_v_out_319511.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_319511", "319511080", "story_v_out_319511.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319511081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319511081
		arg_334_1.duration_ = 4.3

		local var_334_0 = {
			zh = 2.3,
			ja = 4.3
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319511082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1084ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = var_337_0.localPosition
			end

			local var_337_2 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2
				local var_337_4 = Vector3.New(0.7, -0.97, -6)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, var_337_4, var_337_3)

				local var_337_5 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_5.x, var_337_5.y, var_337_5.z)

				local var_337_6 = var_337_0.localEulerAngles

				var_337_6.z = 0
				var_337_6.x = 0
				var_337_0.localEulerAngles = var_337_6
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_337_7 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_7.x, var_337_7.y, var_337_7.z)

				local var_337_8 = var_337_0.localEulerAngles

				var_337_8.z = 0
				var_337_8.x = 0
				var_337_0.localEulerAngles = var_337_8
			end

			local var_337_9 = arg_334_1.actors_["1084ui_story"]
			local var_337_10 = 0

			if var_337_10 < arg_334_1.time_ and arg_334_1.time_ <= var_337_10 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_11 = 0.200000002980232

			if var_337_10 <= arg_334_1.time_ and arg_334_1.time_ < var_337_10 + var_337_11 and not isNil(var_337_9) then
				local var_337_12 = (arg_334_1.time_ - var_337_10) / var_337_11

				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_9) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_10 + var_337_11 and arg_334_1.time_ < var_337_10 + var_337_11 + arg_337_0 and not isNil(var_337_9) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_337_13 = 0

			if var_337_13 < arg_334_1.time_ and arg_334_1.time_ <= var_337_13 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_337_14 = 0

			if var_337_14 < arg_334_1.time_ and arg_334_1.time_ <= var_337_14 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_337_15 = arg_334_1.actors_["10050ui_story"]
			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 and not isNil(var_337_15) and arg_334_1.var_.characterEffect10050ui_story == nil then
				arg_334_1.var_.characterEffect10050ui_story = var_337_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_17 = 0.200000002980232

			if var_337_16 <= arg_334_1.time_ and arg_334_1.time_ < var_337_16 + var_337_17 and not isNil(var_337_15) then
				local var_337_18 = (arg_334_1.time_ - var_337_16) / var_337_17

				if arg_334_1.var_.characterEffect10050ui_story and not isNil(var_337_15) then
					local var_337_19 = Mathf.Lerp(0, 0.5, var_337_18)

					arg_334_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10050ui_story.fillRatio = var_337_19
				end
			end

			if arg_334_1.time_ >= var_337_16 + var_337_17 and arg_334_1.time_ < var_337_16 + var_337_17 + arg_337_0 and not isNil(var_337_15) and arg_334_1.var_.characterEffect10050ui_story then
				local var_337_20 = 0.5

				arg_334_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10050ui_story.fillRatio = var_337_20
			end

			local var_337_21 = 0
			local var_337_22 = 0.225

			if var_337_21 < arg_334_1.time_ and arg_334_1.time_ <= var_337_21 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_23 = arg_334_1:FormatText(StoryNameCfg[6].name)

				arg_334_1.leftNameTxt_.text = var_337_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_24 = arg_334_1:GetWordFromCfg(319511081)
				local var_337_25 = arg_334_1:FormatText(var_337_24.content)

				arg_334_1.text_.text = var_337_25

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_26 = 9
				local var_337_27 = utf8.len(var_337_25)
				local var_337_28 = var_337_26 <= 0 and var_337_22 or var_337_22 * (var_337_27 / var_337_26)

				if var_337_28 > 0 and var_337_22 < var_337_28 then
					arg_334_1.talkMaxDuration = var_337_28

					if var_337_28 + var_337_21 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_28 + var_337_21
					end
				end

				arg_334_1.text_.text = var_337_25
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511081", "story_v_out_319511.awb") ~= 0 then
					local var_337_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511081", "story_v_out_319511.awb") / 1000

					if var_337_29 + var_337_21 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_29 + var_337_21
					end

					if var_337_24.prefab_name ~= "" and arg_334_1.actors_[var_337_24.prefab_name] ~= nil then
						local var_337_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_24.prefab_name].transform, "story_v_out_319511", "319511081", "story_v_out_319511.awb")

						arg_334_1:RecordAudio("319511081", var_337_30)
						arg_334_1:RecordAudio("319511081", var_337_30)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_319511", "319511081", "story_v_out_319511.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_319511", "319511081", "story_v_out_319511.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_31 = math.max(var_337_22, arg_334_1.talkMaxDuration)

			if var_337_21 <= arg_334_1.time_ and arg_334_1.time_ < var_337_21 + var_337_31 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_21) / var_337_31

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_21 + var_337_31 and arg_334_1.time_ < var_337_21 + var_337_31 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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

		arg_334_1:InitPlayNodeList()
	end,
	Play319511082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 319511082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play319511083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1084ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1084ui_story and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1084ui_story.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1084ui_story then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1084ui_story.fillRatio = var_341_5
			end

			local var_341_6 = 0
			local var_341_7 = 0.525

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_8 = arg_338_1:FormatText(StoryNameCfg[698].name)

				arg_338_1.leftNameTxt_.text = var_341_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_9 = arg_338_1:GetWordFromCfg(319511082)
				local var_341_10 = arg_338_1:FormatText(var_341_9.content)

				arg_338_1.text_.text = var_341_10

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 21
				local var_341_12 = utf8.len(var_341_10)
				local var_341_13 = var_341_11 <= 0 and var_341_7 or var_341_7 * (var_341_12 / var_341_11)

				if var_341_13 > 0 and var_341_7 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_10
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play319511083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 319511083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play319511084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_345_2 = 0
			local var_345_3 = 0.575

			if var_345_2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_4 = arg_342_1:FormatText(StoryNameCfg[698].name)

				arg_342_1.leftNameTxt_.text = var_345_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_5 = arg_342_1:GetWordFromCfg(319511083)
				local var_345_6 = arg_342_1:FormatText(var_345_5.content)

				arg_342_1.text_.text = var_345_6

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 23
				local var_345_8 = utf8.len(var_345_6)
				local var_345_9 = var_345_7 <= 0 and var_345_3 or var_345_3 * (var_345_8 / var_345_7)

				if var_345_9 > 0 and var_345_3 < var_345_9 then
					arg_342_1.talkMaxDuration = var_345_9

					if var_345_9 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_6
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_10 and arg_342_1.time_ < var_345_2 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play319511084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 319511084
		arg_346_1.duration_ = 5.23

		local var_346_0 = {
			zh = 3.566,
			ja = 5.233
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play319511085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10050ui_story"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect10050ui_story == nil then
				arg_346_1.var_.characterEffect10050ui_story = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect10050ui_story and not isNil(var_349_0) then
					arg_346_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect10050ui_story then
				arg_346_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_349_4 = 0
			local var_349_5 = 0.45

			if var_349_4 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_6 = arg_346_1:FormatText(StoryNameCfg[692].name)

				arg_346_1.leftNameTxt_.text = var_349_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(319511084)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 18
				local var_349_10 = utf8.len(var_349_8)
				local var_349_11 = var_349_9 <= 0 and var_349_5 or var_349_5 * (var_349_10 / var_349_9)

				if var_349_11 > 0 and var_349_5 < var_349_11 then
					arg_346_1.talkMaxDuration = var_349_11

					if var_349_11 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511084", "story_v_out_319511.awb") ~= 0 then
					local var_349_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511084", "story_v_out_319511.awb") / 1000

					if var_349_12 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_4
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_319511", "319511084", "story_v_out_319511.awb")

						arg_346_1:RecordAudio("319511084", var_349_13)
						arg_346_1:RecordAudio("319511084", var_349_13)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_319511", "319511084", "story_v_out_319511.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_319511", "319511084", "story_v_out_319511.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_14 and arg_346_1.time_ < var_349_4 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play319511085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 319511085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play319511086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10050ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect10050ui_story == nil then
				arg_350_1.var_.characterEffect10050ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect10050ui_story and not isNil(var_353_0) then
					local var_353_4 = Mathf.Lerp(0, 0.5, var_353_3)

					arg_350_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_350_1.var_.characterEffect10050ui_story.fillRatio = var_353_4
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect10050ui_story then
				local var_353_5 = 0.5

				arg_350_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_350_1.var_.characterEffect10050ui_story.fillRatio = var_353_5
			end

			local var_353_6 = 0
			local var_353_7 = 0.425

			if var_353_6 < arg_350_1.time_ and arg_350_1.time_ <= var_353_6 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_8 = arg_350_1:FormatText(StoryNameCfg[698].name)

				arg_350_1.leftNameTxt_.text = var_353_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_9 = arg_350_1:GetWordFromCfg(319511085)
				local var_353_10 = arg_350_1:FormatText(var_353_9.content)

				arg_350_1.text_.text = var_353_10

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_11 = 17
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
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_14 = math.max(var_353_7, arg_350_1.talkMaxDuration)

			if var_353_6 <= arg_350_1.time_ and arg_350_1.time_ < var_353_6 + var_353_14 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_6) / var_353_14

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_6 + var_353_14 and arg_350_1.time_ < var_353_6 + var_353_14 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play319511086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 319511086
		arg_354_1.duration_ = 6.23

		local var_354_0 = {
			zh = 4.4,
			ja = 6.233
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play319511087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10050ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos10050ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10050ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["10050ui_story"]
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect10050ui_story == nil then
				arg_354_1.var_.characterEffect10050ui_story = var_357_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_11 = 0.200000002980232

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_11 and not isNil(var_357_9) then
				local var_357_12 = (arg_354_1.time_ - var_357_10) / var_357_11

				if arg_354_1.var_.characterEffect10050ui_story and not isNil(var_357_9) then
					arg_354_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_10 + var_357_11 and arg_354_1.time_ < var_357_10 + var_357_11 + arg_357_0 and not isNil(var_357_9) and arg_354_1.var_.characterEffect10050ui_story then
				arg_354_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_357_13 = 0

			if var_357_13 < arg_354_1.time_ and arg_354_1.time_ <= var_357_13 + arg_357_0 then
				arg_354_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_1")
			end

			local var_357_14 = 0

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_357_15 = 0
			local var_357_16 = 0.35

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_17 = arg_354_1:FormatText(StoryNameCfg[692].name)

				arg_354_1.leftNameTxt_.text = var_357_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_18 = arg_354_1:GetWordFromCfg(319511086)
				local var_357_19 = arg_354_1:FormatText(var_357_18.content)

				arg_354_1.text_.text = var_357_19

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_20 = 14
				local var_357_21 = utf8.len(var_357_19)
				local var_357_22 = var_357_20 <= 0 and var_357_16 or var_357_16 * (var_357_21 / var_357_20)

				if var_357_22 > 0 and var_357_16 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22

					if var_357_22 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_15
					end
				end

				arg_354_1.text_.text = var_357_19
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511086", "story_v_out_319511.awb") ~= 0 then
					local var_357_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511086", "story_v_out_319511.awb") / 1000

					if var_357_23 + var_357_15 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_15
					end

					if var_357_18.prefab_name ~= "" and arg_354_1.actors_[var_357_18.prefab_name] ~= nil then
						local var_357_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_18.prefab_name].transform, "story_v_out_319511", "319511086", "story_v_out_319511.awb")

						arg_354_1:RecordAudio("319511086", var_357_24)
						arg_354_1:RecordAudio("319511086", var_357_24)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_319511", "319511086", "story_v_out_319511.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_319511", "319511086", "story_v_out_319511.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_25 = math.max(var_357_16, arg_354_1.talkMaxDuration)

			if var_357_15 <= arg_354_1.time_ and arg_354_1.time_ < var_357_15 + var_357_25 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_15) / var_357_25

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_15 + var_357_25 and arg_354_1.time_ < var_357_15 + var_357_25 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play319511087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 319511087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play319511088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["10050ui_story"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect10050ui_story == nil then
				arg_358_1.var_.characterEffect10050ui_story = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect10050ui_story and not isNil(var_361_0) then
					local var_361_4 = Mathf.Lerp(0, 0.5, var_361_3)

					arg_358_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_358_1.var_.characterEffect10050ui_story.fillRatio = var_361_4
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect10050ui_story then
				local var_361_5 = 0.5

				arg_358_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_358_1.var_.characterEffect10050ui_story.fillRatio = var_361_5
			end

			local var_361_6 = 0
			local var_361_7 = 0.5

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_8 = arg_358_1:FormatText(StoryNameCfg[698].name)

				arg_358_1.leftNameTxt_.text = var_361_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_9 = arg_358_1:GetWordFromCfg(319511087)
				local var_361_10 = arg_358_1:FormatText(var_361_9.content)

				arg_358_1.text_.text = var_361_10

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_11 = 20
				local var_361_12 = utf8.len(var_361_10)
				local var_361_13 = var_361_11 <= 0 and var_361_7 or var_361_7 * (var_361_12 / var_361_11)

				if var_361_13 > 0 and var_361_7 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_6 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_6
					end
				end

				arg_358_1.text_.text = var_361_10
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_14 = math.max(var_361_7, arg_358_1.talkMaxDuration)

			if var_361_6 <= arg_358_1.time_ and arg_358_1.time_ < var_361_6 + var_361_14 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_6) / var_361_14

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_6 + var_361_14 and arg_358_1.time_ < var_361_6 + var_361_14 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play319511088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 319511088
		arg_362_1.duration_ = 6.17

		local var_362_0 = {
			zh = 1.999999999999,
			ja = 6.166
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play319511089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10050ui_story"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect10050ui_story == nil then
				arg_362_1.var_.characterEffect10050ui_story = var_365_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.characterEffect10050ui_story and not isNil(var_365_0) then
					arg_362_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.characterEffect10050ui_story then
				arg_362_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_365_4 = 0

			if var_365_4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_2")
			end

			local var_365_5 = 0

			if var_365_5 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_365_6 = 0
			local var_365_7 = 0.175

			if var_365_6 < arg_362_1.time_ and arg_362_1.time_ <= var_365_6 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_8 = arg_362_1:FormatText(StoryNameCfg[692].name)

				arg_362_1.leftNameTxt_.text = var_365_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_9 = arg_362_1:GetWordFromCfg(319511088)
				local var_365_10 = arg_362_1:FormatText(var_365_9.content)

				arg_362_1.text_.text = var_365_10

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 7
				local var_365_12 = utf8.len(var_365_10)
				local var_365_13 = var_365_11 <= 0 and var_365_7 or var_365_7 * (var_365_12 / var_365_11)

				if var_365_13 > 0 and var_365_7 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_6
					end
				end

				arg_362_1.text_.text = var_365_10
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511088", "story_v_out_319511.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511088", "story_v_out_319511.awb") / 1000

					if var_365_14 + var_365_6 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_6
					end

					if var_365_9.prefab_name ~= "" and arg_362_1.actors_[var_365_9.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_9.prefab_name].transform, "story_v_out_319511", "319511088", "story_v_out_319511.awb")

						arg_362_1:RecordAudio("319511088", var_365_15)
						arg_362_1:RecordAudio("319511088", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_319511", "319511088", "story_v_out_319511.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_319511", "319511088", "story_v_out_319511.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_7, arg_362_1.talkMaxDuration)

			if var_365_6 <= arg_362_1.time_ and arg_362_1.time_ < var_365_6 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_6) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_6 + var_365_16 and arg_362_1.time_ < var_365_6 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play319511089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 319511089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play319511090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10050ui_story"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect10050ui_story == nil then
				arg_366_1.var_.characterEffect10050ui_story = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect10050ui_story and not isNil(var_369_0) then
					local var_369_4 = Mathf.Lerp(0, 0.5, var_369_3)

					arg_366_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_366_1.var_.characterEffect10050ui_story.fillRatio = var_369_4
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect10050ui_story then
				local var_369_5 = 0.5

				arg_366_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_366_1.var_.characterEffect10050ui_story.fillRatio = var_369_5
			end

			local var_369_6 = 0
			local var_369_7 = 0.05

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[698].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_9 = arg_366_1:GetWordFromCfg(319511089)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 2
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_14 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_14 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_14

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_14 and arg_366_1.time_ < var_369_6 + var_369_14 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play319511090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 319511090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play319511091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10050ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos10050ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(0, 100, 0)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10050ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(0, 100, 0)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = arg_370_1.actors_["1084ui_story"].transform
			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1.var_.moveOldPos1084ui_story = var_373_9.localPosition
			end

			local var_373_11 = 0.001

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_11 then
				local var_373_12 = (arg_370_1.time_ - var_373_10) / var_373_11
				local var_373_13 = Vector3.New(0, 100, 0)

				var_373_9.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1084ui_story, var_373_13, var_373_12)

				local var_373_14 = manager.ui.mainCamera.transform.position - var_373_9.position

				var_373_9.forward = Vector3.New(var_373_14.x, var_373_14.y, var_373_14.z)

				local var_373_15 = var_373_9.localEulerAngles

				var_373_15.z = 0
				var_373_15.x = 0
				var_373_9.localEulerAngles = var_373_15
			end

			if arg_370_1.time_ >= var_373_10 + var_373_11 and arg_370_1.time_ < var_373_10 + var_373_11 + arg_373_0 then
				var_373_9.localPosition = Vector3.New(0, 100, 0)

				local var_373_16 = manager.ui.mainCamera.transform.position - var_373_9.position

				var_373_9.forward = Vector3.New(var_373_16.x, var_373_16.y, var_373_16.z)

				local var_373_17 = var_373_9.localEulerAngles

				var_373_17.z = 0
				var_373_17.x = 0
				var_373_9.localEulerAngles = var_373_17
			end

			local var_373_18 = 0
			local var_373_19 = 0.925

			if var_373_18 < arg_370_1.time_ and arg_370_1.time_ <= var_373_18 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_20 = arg_370_1:GetWordFromCfg(319511090)
				local var_373_21 = arg_370_1:FormatText(var_373_20.content)

				arg_370_1.text_.text = var_373_21

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_22 = 37
				local var_373_23 = utf8.len(var_373_21)
				local var_373_24 = var_373_22 <= 0 and var_373_19 or var_373_19 * (var_373_23 / var_373_22)

				if var_373_24 > 0 and var_373_19 < var_373_24 then
					arg_370_1.talkMaxDuration = var_373_24

					if var_373_24 + var_373_18 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_24 + var_373_18
					end
				end

				arg_370_1.text_.text = var_373_21
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_25 = math.max(var_373_19, arg_370_1.talkMaxDuration)

			if var_373_18 <= arg_370_1.time_ and arg_370_1.time_ < var_373_18 + var_373_25 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_18) / var_373_25

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_18 + var_373_25 and arg_370_1.time_ < var_373_18 + var_373_25 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play319511091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 319511091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play319511092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 1.175

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(319511091)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 47
				local var_377_5 = utf8.len(var_377_3)
				local var_377_6 = var_377_4 <= 0 and var_377_1 or var_377_1 * (var_377_5 / var_377_4)

				if var_377_6 > 0 and var_377_1 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_7 and arg_374_1.time_ < var_377_0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play319511092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 319511092
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play319511093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.825

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[698].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:GetWordFromCfg(319511092)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 33
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play319511093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 319511093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play319511094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.8

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[698].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(319511093)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 32
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
	Play319511094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 319511094
		arg_386_1.duration_ = 2.97

		local var_386_0 = {
			zh = 2.8,
			ja = 2.966
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play319511095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10050ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos10050ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos10050ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = arg_386_1.actors_["10050ui_story"]
			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect10050ui_story == nil then
				arg_386_1.var_.characterEffect10050ui_story = var_389_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_11 = 0.200000002980232

			if var_389_10 <= arg_386_1.time_ and arg_386_1.time_ < var_389_10 + var_389_11 and not isNil(var_389_9) then
				local var_389_12 = (arg_386_1.time_ - var_389_10) / var_389_11

				if arg_386_1.var_.characterEffect10050ui_story and not isNil(var_389_9) then
					arg_386_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_10 + var_389_11 and arg_386_1.time_ < var_389_10 + var_389_11 + arg_389_0 and not isNil(var_389_9) and arg_386_1.var_.characterEffect10050ui_story then
				arg_386_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_389_13 = 0

			if var_389_13 < arg_386_1.time_ and arg_386_1.time_ <= var_389_13 + arg_389_0 then
				arg_386_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_389_14 = 0

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_389_15 = 0
			local var_389_16 = 0.2

			if var_389_15 < arg_386_1.time_ and arg_386_1.time_ <= var_389_15 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_17 = arg_386_1:FormatText(StoryNameCfg[692].name)

				arg_386_1.leftNameTxt_.text = var_389_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_18 = arg_386_1:GetWordFromCfg(319511094)
				local var_389_19 = arg_386_1:FormatText(var_389_18.content)

				arg_386_1.text_.text = var_389_19

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_20 = 8
				local var_389_21 = utf8.len(var_389_19)
				local var_389_22 = var_389_20 <= 0 and var_389_16 or var_389_16 * (var_389_21 / var_389_20)

				if var_389_22 > 0 and var_389_16 < var_389_22 then
					arg_386_1.talkMaxDuration = var_389_22

					if var_389_22 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_22 + var_389_15
					end
				end

				arg_386_1.text_.text = var_389_19
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511094", "story_v_out_319511.awb") ~= 0 then
					local var_389_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511094", "story_v_out_319511.awb") / 1000

					if var_389_23 + var_389_15 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_15
					end

					if var_389_18.prefab_name ~= "" and arg_386_1.actors_[var_389_18.prefab_name] ~= nil then
						local var_389_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_18.prefab_name].transform, "story_v_out_319511", "319511094", "story_v_out_319511.awb")

						arg_386_1:RecordAudio("319511094", var_389_24)
						arg_386_1:RecordAudio("319511094", var_389_24)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_319511", "319511094", "story_v_out_319511.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_319511", "319511094", "story_v_out_319511.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_25 = math.max(var_389_16, arg_386_1.talkMaxDuration)

			if var_389_15 <= arg_386_1.time_ and arg_386_1.time_ < var_389_15 + var_389_25 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_15) / var_389_25

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_15 + var_389_25 and arg_386_1.time_ < var_389_15 + var_389_25 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play319511095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 319511095
		arg_390_1.duration_ = 2.63

		local var_390_0 = {
			zh = 2.6,
			ja = 2.633
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play319511096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1084ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1084ui_story = var_393_0.localPosition

				local var_393_2 = "1084ui_story"

				arg_390_1:ShowWeapon(arg_390_1.var_[var_393_2 .. "Animator"].transform, false)
			end

			local var_393_3 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_3 then
				local var_393_4 = (arg_390_1.time_ - var_393_1) / var_393_3
				local var_393_5 = Vector3.New(0.7, -0.97, -6)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1084ui_story, var_393_5, var_393_4)

				local var_393_6 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_6.x, var_393_6.y, var_393_6.z)

				local var_393_7 = var_393_0.localEulerAngles

				var_393_7.z = 0
				var_393_7.x = 0
				var_393_0.localEulerAngles = var_393_7
			end

			if arg_390_1.time_ >= var_393_1 + var_393_3 and arg_390_1.time_ < var_393_1 + var_393_3 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_393_8 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_8.x, var_393_8.y, var_393_8.z)

				local var_393_9 = var_393_0.localEulerAngles

				var_393_9.z = 0
				var_393_9.x = 0
				var_393_0.localEulerAngles = var_393_9
			end

			local var_393_10 = arg_390_1.actors_["1084ui_story"]
			local var_393_11 = 0

			if var_393_11 < arg_390_1.time_ and arg_390_1.time_ <= var_393_11 + arg_393_0 and not isNil(var_393_10) and arg_390_1.var_.characterEffect1084ui_story == nil then
				arg_390_1.var_.characterEffect1084ui_story = var_393_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_12 = 0.200000002980232

			if var_393_11 <= arg_390_1.time_ and arg_390_1.time_ < var_393_11 + var_393_12 and not isNil(var_393_10) then
				local var_393_13 = (arg_390_1.time_ - var_393_11) / var_393_12

				if arg_390_1.var_.characterEffect1084ui_story and not isNil(var_393_10) then
					arg_390_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_11 + var_393_12 and arg_390_1.time_ < var_393_11 + var_393_12 + arg_393_0 and not isNil(var_393_10) and arg_390_1.var_.characterEffect1084ui_story then
				arg_390_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_393_14 = 0

			if var_393_14 < arg_390_1.time_ and arg_390_1.time_ <= var_393_14 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_393_15 = 0

			if var_393_15 < arg_390_1.time_ and arg_390_1.time_ <= var_393_15 + arg_393_0 then
				arg_390_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_393_16 = arg_390_1.actors_["10050ui_story"]
			local var_393_17 = 0

			if var_393_17 < arg_390_1.time_ and arg_390_1.time_ <= var_393_17 + arg_393_0 and not isNil(var_393_16) and arg_390_1.var_.characterEffect10050ui_story == nil then
				arg_390_1.var_.characterEffect10050ui_story = var_393_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_18 = 0.200000002980232

			if var_393_17 <= arg_390_1.time_ and arg_390_1.time_ < var_393_17 + var_393_18 and not isNil(var_393_16) then
				local var_393_19 = (arg_390_1.time_ - var_393_17) / var_393_18

				if arg_390_1.var_.characterEffect10050ui_story and not isNil(var_393_16) then
					local var_393_20 = Mathf.Lerp(0, 0.5, var_393_19)

					arg_390_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10050ui_story.fillRatio = var_393_20
				end
			end

			if arg_390_1.time_ >= var_393_17 + var_393_18 and arg_390_1.time_ < var_393_17 + var_393_18 + arg_393_0 and not isNil(var_393_16) and arg_390_1.var_.characterEffect10050ui_story then
				local var_393_21 = 0.5

				arg_390_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10050ui_story.fillRatio = var_393_21
			end

			local var_393_22 = 0
			local var_393_23 = 0.225

			if var_393_22 < arg_390_1.time_ and arg_390_1.time_ <= var_393_22 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_24 = arg_390_1:FormatText(StoryNameCfg[6].name)

				arg_390_1.leftNameTxt_.text = var_393_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_25 = arg_390_1:GetWordFromCfg(319511095)
				local var_393_26 = arg_390_1:FormatText(var_393_25.content)

				arg_390_1.text_.text = var_393_26

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_27 = 9
				local var_393_28 = utf8.len(var_393_26)
				local var_393_29 = var_393_27 <= 0 and var_393_23 or var_393_23 * (var_393_28 / var_393_27)

				if var_393_29 > 0 and var_393_23 < var_393_29 then
					arg_390_1.talkMaxDuration = var_393_29

					if var_393_29 + var_393_22 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_29 + var_393_22
					end
				end

				arg_390_1.text_.text = var_393_26
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511095", "story_v_out_319511.awb") ~= 0 then
					local var_393_30 = manager.audio:GetVoiceLength("story_v_out_319511", "319511095", "story_v_out_319511.awb") / 1000

					if var_393_30 + var_393_22 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_30 + var_393_22
					end

					if var_393_25.prefab_name ~= "" and arg_390_1.actors_[var_393_25.prefab_name] ~= nil then
						local var_393_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_25.prefab_name].transform, "story_v_out_319511", "319511095", "story_v_out_319511.awb")

						arg_390_1:RecordAudio("319511095", var_393_31)
						arg_390_1:RecordAudio("319511095", var_393_31)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_319511", "319511095", "story_v_out_319511.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_319511", "319511095", "story_v_out_319511.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_32 = math.max(var_393_23, arg_390_1.talkMaxDuration)

			if var_393_22 <= arg_390_1.time_ and arg_390_1.time_ < var_393_22 + var_393_32 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_22) / var_393_32

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_22 + var_393_32 and arg_390_1.time_ < var_393_22 + var_393_32 + arg_393_0 then
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
	Play319511096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 319511096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play319511097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1084ui_story"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1084ui_story == nil then
				arg_394_1.var_.characterEffect1084ui_story = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1084ui_story and not isNil(var_397_0) then
					local var_397_4 = Mathf.Lerp(0, 0.5, var_397_3)

					arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1084ui_story.fillRatio = var_397_4
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1084ui_story then
				local var_397_5 = 0.5

				arg_394_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1084ui_story.fillRatio = var_397_5
			end

			local var_397_6 = 0
			local var_397_7 = 0.25

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[698].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_9 = arg_394_1:GetWordFromCfg(319511096)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 10
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_14 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_14 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_14

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_14 and arg_394_1.time_ < var_397_6 + var_397_14 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play319511097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 319511097
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play319511098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.425

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[698].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(319511097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 17
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
	Play319511098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 319511098
		arg_402_1.duration_ = 7

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play319511099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 2

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				local var_405_1 = manager.ui.mainCamera.transform.localPosition
				local var_405_2 = Vector3.New(0, 0, 10) + Vector3.New(var_405_1.x, var_405_1.y, 0)
				local var_405_3 = arg_402_1.bgs_.ST72

				var_405_3.transform.localPosition = var_405_2
				var_405_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_405_4 = var_405_3:GetComponent("SpriteRenderer")

				if var_405_4 and var_405_4.sprite then
					local var_405_5 = (var_405_3.transform.localPosition - var_405_1).z
					local var_405_6 = manager.ui.mainCameraCom_
					local var_405_7 = 2 * var_405_5 * Mathf.Tan(var_405_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_405_8 = var_405_7 * var_405_6.aspect
					local var_405_9 = var_405_4.sprite.bounds.size.x
					local var_405_10 = var_405_4.sprite.bounds.size.y
					local var_405_11 = var_405_8 / var_405_9
					local var_405_12 = var_405_7 / var_405_10
					local var_405_13 = var_405_12 < var_405_11 and var_405_11 or var_405_12

					var_405_3.transform.localScale = Vector3.New(var_405_13, var_405_13, 0)
				end

				for iter_405_0, iter_405_1 in pairs(arg_402_1.bgs_) do
					if iter_405_0 ~= "ST72" then
						iter_405_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_405_14 = 0

			if var_405_14 < arg_402_1.time_ and arg_402_1.time_ <= var_405_14 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_15 = 2

			if var_405_14 <= arg_402_1.time_ and arg_402_1.time_ < var_405_14 + var_405_15 then
				local var_405_16 = (arg_402_1.time_ - var_405_14) / var_405_15
				local var_405_17 = Color.New(0, 0, 0)

				var_405_17.a = Mathf.Lerp(0, 1, var_405_16)
				arg_402_1.mask_.color = var_405_17
			end

			if arg_402_1.time_ >= var_405_14 + var_405_15 and arg_402_1.time_ < var_405_14 + var_405_15 + arg_405_0 then
				local var_405_18 = Color.New(0, 0, 0)

				var_405_18.a = 1
				arg_402_1.mask_.color = var_405_18
			end

			local var_405_19 = 2

			if var_405_19 < arg_402_1.time_ and arg_402_1.time_ <= var_405_19 + arg_405_0 then
				arg_402_1.mask_.enabled = true
				arg_402_1.mask_.raycastTarget = true

				arg_402_1:SetGaussion(false)
			end

			local var_405_20 = 2

			if var_405_19 <= arg_402_1.time_ and arg_402_1.time_ < var_405_19 + var_405_20 then
				local var_405_21 = (arg_402_1.time_ - var_405_19) / var_405_20
				local var_405_22 = Color.New(0, 0, 0)

				var_405_22.a = Mathf.Lerp(1, 0, var_405_21)
				arg_402_1.mask_.color = var_405_22
			end

			if arg_402_1.time_ >= var_405_19 + var_405_20 and arg_402_1.time_ < var_405_19 + var_405_20 + arg_405_0 then
				local var_405_23 = Color.New(0, 0, 0)
				local var_405_24 = 0

				arg_402_1.mask_.enabled = false
				var_405_23.a = var_405_24
				arg_402_1.mask_.color = var_405_23
			end

			local var_405_25 = arg_402_1.actors_["1084ui_story"].transform
			local var_405_26 = 2

			if var_405_26 < arg_402_1.time_ and arg_402_1.time_ <= var_405_26 + arg_405_0 then
				arg_402_1.var_.moveOldPos1084ui_story = var_405_25.localPosition
			end

			local var_405_27 = 0.001

			if var_405_26 <= arg_402_1.time_ and arg_402_1.time_ < var_405_26 + var_405_27 then
				local var_405_28 = (arg_402_1.time_ - var_405_26) / var_405_27
				local var_405_29 = Vector3.New(0, 100, 0)

				var_405_25.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1084ui_story, var_405_29, var_405_28)

				local var_405_30 = manager.ui.mainCamera.transform.position - var_405_25.position

				var_405_25.forward = Vector3.New(var_405_30.x, var_405_30.y, var_405_30.z)

				local var_405_31 = var_405_25.localEulerAngles

				var_405_31.z = 0
				var_405_31.x = 0
				var_405_25.localEulerAngles = var_405_31
			end

			if arg_402_1.time_ >= var_405_26 + var_405_27 and arg_402_1.time_ < var_405_26 + var_405_27 + arg_405_0 then
				var_405_25.localPosition = Vector3.New(0, 100, 0)

				local var_405_32 = manager.ui.mainCamera.transform.position - var_405_25.position

				var_405_25.forward = Vector3.New(var_405_32.x, var_405_32.y, var_405_32.z)

				local var_405_33 = var_405_25.localEulerAngles

				var_405_33.z = 0
				var_405_33.x = 0
				var_405_25.localEulerAngles = var_405_33
			end

			local var_405_34 = arg_402_1.actors_["1084ui_story"]
			local var_405_35 = 2

			if var_405_35 < arg_402_1.time_ and arg_402_1.time_ <= var_405_35 + arg_405_0 and not isNil(var_405_34) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = var_405_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_36 = 0.200000002980232

			if var_405_35 <= arg_402_1.time_ and arg_402_1.time_ < var_405_35 + var_405_36 and not isNil(var_405_34) then
				local var_405_37 = (arg_402_1.time_ - var_405_35) / var_405_36

				if arg_402_1.var_.characterEffect1084ui_story and not isNil(var_405_34) then
					local var_405_38 = Mathf.Lerp(0, 0.5, var_405_37)

					arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1084ui_story.fillRatio = var_405_38
				end
			end

			if arg_402_1.time_ >= var_405_35 + var_405_36 and arg_402_1.time_ < var_405_35 + var_405_36 + arg_405_0 and not isNil(var_405_34) and arg_402_1.var_.characterEffect1084ui_story then
				local var_405_39 = 0.5

				arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1084ui_story.fillRatio = var_405_39
			end

			local var_405_40 = arg_402_1.actors_["10050ui_story"].transform
			local var_405_41 = 2

			if var_405_41 < arg_402_1.time_ and arg_402_1.time_ <= var_405_41 + arg_405_0 then
				arg_402_1.var_.moveOldPos10050ui_story = var_405_40.localPosition
			end

			local var_405_42 = 0.001

			if var_405_41 <= arg_402_1.time_ and arg_402_1.time_ < var_405_41 + var_405_42 then
				local var_405_43 = (arg_402_1.time_ - var_405_41) / var_405_42
				local var_405_44 = Vector3.New(0, 100, 0)

				var_405_40.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10050ui_story, var_405_44, var_405_43)

				local var_405_45 = manager.ui.mainCamera.transform.position - var_405_40.position

				var_405_40.forward = Vector3.New(var_405_45.x, var_405_45.y, var_405_45.z)

				local var_405_46 = var_405_40.localEulerAngles

				var_405_46.z = 0
				var_405_46.x = 0
				var_405_40.localEulerAngles = var_405_46
			end

			if arg_402_1.time_ >= var_405_41 + var_405_42 and arg_402_1.time_ < var_405_41 + var_405_42 + arg_405_0 then
				var_405_40.localPosition = Vector3.New(0, 100, 0)

				local var_405_47 = manager.ui.mainCamera.transform.position - var_405_40.position

				var_405_40.forward = Vector3.New(var_405_47.x, var_405_47.y, var_405_47.z)

				local var_405_48 = var_405_40.localEulerAngles

				var_405_48.z = 0
				var_405_48.x = 0
				var_405_40.localEulerAngles = var_405_48
			end

			local var_405_49 = arg_402_1.actors_["10050ui_story"]
			local var_405_50 = 2

			if var_405_50 < arg_402_1.time_ and arg_402_1.time_ <= var_405_50 + arg_405_0 and not isNil(var_405_49) and arg_402_1.var_.characterEffect10050ui_story == nil then
				arg_402_1.var_.characterEffect10050ui_story = var_405_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_51 = 0.200000002980232

			if var_405_50 <= arg_402_1.time_ and arg_402_1.time_ < var_405_50 + var_405_51 and not isNil(var_405_49) then
				local var_405_52 = (arg_402_1.time_ - var_405_50) / var_405_51

				if arg_402_1.var_.characterEffect10050ui_story and not isNil(var_405_49) then
					local var_405_53 = Mathf.Lerp(0, 0.5, var_405_52)

					arg_402_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_402_1.var_.characterEffect10050ui_story.fillRatio = var_405_53
				end
			end

			if arg_402_1.time_ >= var_405_50 + var_405_51 and arg_402_1.time_ < var_405_50 + var_405_51 + arg_405_0 and not isNil(var_405_49) and arg_402_1.var_.characterEffect10050ui_story then
				local var_405_54 = 0.5

				arg_402_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_402_1.var_.characterEffect10050ui_story.fillRatio = var_405_54
			end

			if arg_402_1.frameCnt_ <= 1 then
				arg_402_1.dialog_:SetActive(false)
			end

			local var_405_55 = 2
			local var_405_56 = 1.35

			if var_405_55 < arg_402_1.time_ and arg_402_1.time_ <= var_405_55 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0

				arg_402_1.dialog_:SetActive(true)

				arg_402_1.dialogCg_.alpha = 0

				local var_405_57 = LeanTween.value(arg_402_1.dialog_, 0, 1, 0.3)

				var_405_57:setOnUpdate(LuaHelper.FloatAction(function(arg_406_0)
					arg_402_1.dialogCg_.alpha = arg_406_0
				end))
				var_405_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_402_1.dialog_)
					var_405_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_402_1.duration_ = arg_402_1.duration_ + 0.3

				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_58 = arg_402_1:GetWordFromCfg(319511098)
				local var_405_59 = arg_402_1:FormatText(var_405_58.content)

				arg_402_1.text_.text = var_405_59

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_60 = 54
				local var_405_61 = utf8.len(var_405_59)
				local var_405_62 = var_405_60 <= 0 and var_405_56 or var_405_56 * (var_405_61 / var_405_60)

				if var_405_62 > 0 and var_405_56 < var_405_62 then
					arg_402_1.talkMaxDuration = var_405_62
					var_405_55 = var_405_55 + 0.3

					if var_405_62 + var_405_55 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_62 + var_405_55
					end
				end

				arg_402_1.text_.text = var_405_59
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_63 = var_405_55 + 0.3
			local var_405_64 = math.max(var_405_56, arg_402_1.talkMaxDuration)

			if var_405_63 <= arg_402_1.time_ and arg_402_1.time_ < var_405_63 + var_405_64 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_63) / var_405_64

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_63 + var_405_64 and arg_402_1.time_ < var_405_63 + var_405_64 + arg_405_0 then
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
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play319511099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 319511099
		arg_408_1.duration_ = 7.6

		local var_408_0 = {
			zh = 3.9,
			ja = 7.6
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play319511100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["10068ui_story"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos10068ui_story = var_411_0.localPosition
			end

			local var_411_2 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2
				local var_411_4 = Vector3.New(0, -0.75, -6.18)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10068ui_story, var_411_4, var_411_3)

				local var_411_5 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_5.x, var_411_5.y, var_411_5.z)

				local var_411_6 = var_411_0.localEulerAngles

				var_411_6.z = 0
				var_411_6.x = 0
				var_411_0.localEulerAngles = var_411_6
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_411_7 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_7.x, var_411_7.y, var_411_7.z)

				local var_411_8 = var_411_0.localEulerAngles

				var_411_8.z = 0
				var_411_8.x = 0
				var_411_0.localEulerAngles = var_411_8
			end

			local var_411_9 = arg_408_1.actors_["10068ui_story"]
			local var_411_10 = 0

			if var_411_10 < arg_408_1.time_ and arg_408_1.time_ <= var_411_10 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect10068ui_story == nil then
				arg_408_1.var_.characterEffect10068ui_story = var_411_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_11 = 0.200000002980232

			if var_411_10 <= arg_408_1.time_ and arg_408_1.time_ < var_411_10 + var_411_11 and not isNil(var_411_9) then
				local var_411_12 = (arg_408_1.time_ - var_411_10) / var_411_11

				if arg_408_1.var_.characterEffect10068ui_story and not isNil(var_411_9) then
					arg_408_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_10 + var_411_11 and arg_408_1.time_ < var_411_10 + var_411_11 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect10068ui_story then
				arg_408_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_411_13 = 0

			if var_411_13 < arg_408_1.time_ and arg_408_1.time_ <= var_411_13 + arg_411_0 then
				arg_408_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			local var_411_14 = 0

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 then
				arg_408_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_411_15 = 0
			local var_411_16 = 0.375

			if var_411_15 < arg_408_1.time_ and arg_408_1.time_ <= var_411_15 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_17 = arg_408_1:FormatText(StoryNameCfg[697].name)

				arg_408_1.leftNameTxt_.text = var_411_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_18 = arg_408_1:GetWordFromCfg(319511099)
				local var_411_19 = arg_408_1:FormatText(var_411_18.content)

				arg_408_1.text_.text = var_411_19

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_20 = 15
				local var_411_21 = utf8.len(var_411_19)
				local var_411_22 = var_411_20 <= 0 and var_411_16 or var_411_16 * (var_411_21 / var_411_20)

				if var_411_22 > 0 and var_411_16 < var_411_22 then
					arg_408_1.talkMaxDuration = var_411_22

					if var_411_22 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_22 + var_411_15
					end
				end

				arg_408_1.text_.text = var_411_19
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511099", "story_v_out_319511.awb") ~= 0 then
					local var_411_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511099", "story_v_out_319511.awb") / 1000

					if var_411_23 + var_411_15 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_23 + var_411_15
					end

					if var_411_18.prefab_name ~= "" and arg_408_1.actors_[var_411_18.prefab_name] ~= nil then
						local var_411_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_18.prefab_name].transform, "story_v_out_319511", "319511099", "story_v_out_319511.awb")

						arg_408_1:RecordAudio("319511099", var_411_24)
						arg_408_1:RecordAudio("319511099", var_411_24)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_319511", "319511099", "story_v_out_319511.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_319511", "319511099", "story_v_out_319511.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_25 = math.max(var_411_16, arg_408_1.talkMaxDuration)

			if var_411_15 <= arg_408_1.time_ and arg_408_1.time_ < var_411_15 + var_411_25 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_15) / var_411_25

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_15 + var_411_25 and arg_408_1.time_ < var_411_15 + var_411_25 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play319511100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 319511100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play319511101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["10068ui_story"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10068ui_story == nil then
				arg_412_1.var_.characterEffect10068ui_story = var_415_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.characterEffect10068ui_story and not isNil(var_415_0) then
					local var_415_4 = Mathf.Lerp(0, 0.5, var_415_3)

					arg_412_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_412_1.var_.characterEffect10068ui_story.fillRatio = var_415_4
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.characterEffect10068ui_story then
				local var_415_5 = 0.5

				arg_412_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_412_1.var_.characterEffect10068ui_story.fillRatio = var_415_5
			end

			local var_415_6 = 0
			local var_415_7 = 0.275

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_8 = arg_412_1:FormatText(StoryNameCfg[698].name)

				arg_412_1.leftNameTxt_.text = var_415_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_9 = arg_412_1:GetWordFromCfg(319511100)
				local var_415_10 = arg_412_1:FormatText(var_415_9.content)

				arg_412_1.text_.text = var_415_10

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_11 = 11
				local var_415_12 = utf8.len(var_415_10)
				local var_415_13 = var_415_11 <= 0 and var_415_7 or var_415_7 * (var_415_12 / var_415_11)

				if var_415_13 > 0 and var_415_7 < var_415_13 then
					arg_412_1.talkMaxDuration = var_415_13

					if var_415_13 + var_415_6 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_13 + var_415_6
					end
				end

				arg_412_1.text_.text = var_415_10
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_14 = math.max(var_415_7, arg_412_1.talkMaxDuration)

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_14 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_6) / var_415_14

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_6 + var_415_14 and arg_412_1.time_ < var_415_6 + var_415_14 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play319511101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 319511101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play319511102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.775

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[698].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(319511101)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 31
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play319511102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 319511102
		arg_420_1.duration_ = 10.8

		local var_420_0 = {
			zh = 5.7,
			ja = 10.8
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play319511103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10068ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10068ui_story == nil then
				arg_420_1.var_.characterEffect10068ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10068ui_story and not isNil(var_423_0) then
					arg_420_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10068ui_story then
				arg_420_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_423_4 = 0

			if var_423_4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			local var_423_5 = 0

			if var_423_5 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_423_6 = 0
			local var_423_7 = 0.5

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[697].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_9 = arg_420_1:GetWordFromCfg(319511102)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 20
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511102", "story_v_out_319511.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511102", "story_v_out_319511.awb") / 1000

					if var_423_14 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_6
					end

					if var_423_9.prefab_name ~= "" and arg_420_1.actors_[var_423_9.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_9.prefab_name].transform, "story_v_out_319511", "319511102", "story_v_out_319511.awb")

						arg_420_1:RecordAudio("319511102", var_423_15)
						arg_420_1:RecordAudio("319511102", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_319511", "319511102", "story_v_out_319511.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_319511", "319511102", "story_v_out_319511.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_16 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_16 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_16

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_16 and arg_420_1.time_ < var_423_6 + var_423_16 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play319511103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 319511103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play319511104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10068ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10068ui_story == nil then
				arg_424_1.var_.characterEffect10068ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect10068ui_story and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_424_1.var_.characterEffect10068ui_story.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect10068ui_story then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_424_1.var_.characterEffect10068ui_story.fillRatio = var_427_5
			end

			local var_427_6 = 0
			local var_427_7 = 0.05

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[698].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_9 = arg_424_1:GetWordFromCfg(319511103)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 2
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play319511104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 319511104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play319511105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.55

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[698].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(319511104)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 22
				local var_431_6 = utf8.len(var_431_4)
				local var_431_7 = var_431_5 <= 0 and var_431_1 or var_431_1 * (var_431_6 / var_431_5)

				if var_431_7 > 0 and var_431_1 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_8 and arg_428_1.time_ < var_431_0 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play319511105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 319511105
		arg_432_1.duration_ = 5.77

		local var_432_0 = {
			zh = 4.6,
			ja = 5.766
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play319511106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["10068ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect10068ui_story == nil then
				arg_432_1.var_.characterEffect10068ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect10068ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect10068ui_story then
				arg_432_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_435_4 = 0

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068actionlink/10068action425")
			end

			local var_435_5 = 0
			local var_435_6 = 0.45

			if var_435_5 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_7 = arg_432_1:FormatText(StoryNameCfg[697].name)

				arg_432_1.leftNameTxt_.text = var_435_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_8 = arg_432_1:GetWordFromCfg(319511105)
				local var_435_9 = arg_432_1:FormatText(var_435_8.content)

				arg_432_1.text_.text = var_435_9

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_10 = 18
				local var_435_11 = utf8.len(var_435_9)
				local var_435_12 = var_435_10 <= 0 and var_435_6 or var_435_6 * (var_435_11 / var_435_10)

				if var_435_12 > 0 and var_435_6 < var_435_12 then
					arg_432_1.talkMaxDuration = var_435_12

					if var_435_12 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_12 + var_435_5
					end
				end

				arg_432_1.text_.text = var_435_9
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511105", "story_v_out_319511.awb") ~= 0 then
					local var_435_13 = manager.audio:GetVoiceLength("story_v_out_319511", "319511105", "story_v_out_319511.awb") / 1000

					if var_435_13 + var_435_5 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_5
					end

					if var_435_8.prefab_name ~= "" and arg_432_1.actors_[var_435_8.prefab_name] ~= nil then
						local var_435_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_8.prefab_name].transform, "story_v_out_319511", "319511105", "story_v_out_319511.awb")

						arg_432_1:RecordAudio("319511105", var_435_14)
						arg_432_1:RecordAudio("319511105", var_435_14)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_319511", "319511105", "story_v_out_319511.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_319511", "319511105", "story_v_out_319511.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_15 = math.max(var_435_6, arg_432_1.talkMaxDuration)

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_15 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_5) / var_435_15

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_5 + var_435_15 and arg_432_1.time_ < var_435_5 + var_435_15 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play319511106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 319511106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play319511107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10068ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10068ui_story == nil then
				arg_436_1.var_.characterEffect10068ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect10068ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_436_1.var_.characterEffect10068ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10068ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_436_1.var_.characterEffect10068ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0
			local var_439_7 = 0.275

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_8 = arg_436_1:FormatText(StoryNameCfg[698].name)

				arg_436_1.leftNameTxt_.text = var_439_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_9 = arg_436_1:GetWordFromCfg(319511106)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 11
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_7 or var_439_7 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_7 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play319511107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 319511107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play319511108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.825

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[698].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:GetWordFromCfg(319511107)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 33
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play319511108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 319511108
		arg_444_1.duration_ = 5.5

		local var_444_0 = {
			zh = 2.566,
			ja = 5.5
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play319511109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10068ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos10068ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(0, -0.75, -6.18)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10068ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, -0.75, -6.18)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = arg_444_1.actors_["10068ui_story"]
			local var_447_10 = 0

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect10068ui_story == nil then
				arg_444_1.var_.characterEffect10068ui_story = var_447_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_11 = 0.200000002980232

			if var_447_10 <= arg_444_1.time_ and arg_444_1.time_ < var_447_10 + var_447_11 and not isNil(var_447_9) then
				local var_447_12 = (arg_444_1.time_ - var_447_10) / var_447_11

				if arg_444_1.var_.characterEffect10068ui_story and not isNil(var_447_9) then
					arg_444_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_10 + var_447_11 and arg_444_1.time_ < var_447_10 + var_447_11 + arg_447_0 and not isNil(var_447_9) and arg_444_1.var_.characterEffect10068ui_story then
				arg_444_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_447_13 = 0

			if var_447_13 < arg_444_1.time_ and arg_444_1.time_ <= var_447_13 + arg_447_0 then
				arg_444_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action5_2")
			end

			local var_447_14 = 0

			if var_447_14 < arg_444_1.time_ and arg_444_1.time_ <= var_447_14 + arg_447_0 then
				arg_444_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_447_15 = 0
			local var_447_16 = 0.275

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_17 = arg_444_1:FormatText(StoryNameCfg[697].name)

				arg_444_1.leftNameTxt_.text = var_447_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_18 = arg_444_1:GetWordFromCfg(319511108)
				local var_447_19 = arg_444_1:FormatText(var_447_18.content)

				arg_444_1.text_.text = var_447_19

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_20 = 11
				local var_447_21 = utf8.len(var_447_19)
				local var_447_22 = var_447_20 <= 0 and var_447_16 or var_447_16 * (var_447_21 / var_447_20)

				if var_447_22 > 0 and var_447_16 < var_447_22 then
					arg_444_1.talkMaxDuration = var_447_22

					if var_447_22 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_22 + var_447_15
					end
				end

				arg_444_1.text_.text = var_447_19
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511108", "story_v_out_319511.awb") ~= 0 then
					local var_447_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511108", "story_v_out_319511.awb") / 1000

					if var_447_23 + var_447_15 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_23 + var_447_15
					end

					if var_447_18.prefab_name ~= "" and arg_444_1.actors_[var_447_18.prefab_name] ~= nil then
						local var_447_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_18.prefab_name].transform, "story_v_out_319511", "319511108", "story_v_out_319511.awb")

						arg_444_1:RecordAudio("319511108", var_447_24)
						arg_444_1:RecordAudio("319511108", var_447_24)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_319511", "319511108", "story_v_out_319511.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_319511", "319511108", "story_v_out_319511.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_25 = math.max(var_447_16, arg_444_1.talkMaxDuration)

			if var_447_15 <= arg_444_1.time_ and arg_444_1.time_ < var_447_15 + var_447_25 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_15) / var_447_25

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_15 + var_447_25 and arg_444_1.time_ < var_447_15 + var_447_25 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play319511109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 319511109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play319511110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10068ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect10068ui_story == nil then
				arg_448_1.var_.characterEffect10068ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect10068ui_story and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_448_1.var_.characterEffect10068ui_story.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect10068ui_story then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_448_1.var_.characterEffect10068ui_story.fillRatio = var_451_5
			end

			local var_451_6 = 0
			local var_451_7 = 0.55

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_8 = arg_448_1:FormatText(StoryNameCfg[698].name)

				arg_448_1.leftNameTxt_.text = var_451_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_9 = arg_448_1:GetWordFromCfg(319511109)
				local var_451_10 = arg_448_1:FormatText(var_451_9.content)

				arg_448_1.text_.text = var_451_10

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_11 = 22
				local var_451_12 = utf8.len(var_451_10)
				local var_451_13 = var_451_11 <= 0 and var_451_7 or var_451_7 * (var_451_12 / var_451_11)

				if var_451_13 > 0 and var_451_7 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_6
					end
				end

				arg_448_1.text_.text = var_451_10
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_14 = math.max(var_451_7, arg_448_1.talkMaxDuration)

			if var_451_6 <= arg_448_1.time_ and arg_448_1.time_ < var_451_6 + var_451_14 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_6) / var_451_14

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_6 + var_451_14 and arg_448_1.time_ < var_451_6 + var_451_14 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play319511110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 319511110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play319511111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_455_1 = 0
			local var_455_2 = 0.55

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_3 = arg_452_1:FormatText(StoryNameCfg[698].name)

				arg_452_1.leftNameTxt_.text = var_455_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_4 = arg_452_1:GetWordFromCfg(319511110)
				local var_455_5 = arg_452_1:FormatText(var_455_4.content)

				arg_452_1.text_.text = var_455_5

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_6 = 22
				local var_455_7 = utf8.len(var_455_5)
				local var_455_8 = var_455_6 <= 0 and var_455_2 or var_455_2 * (var_455_7 / var_455_6)

				if var_455_8 > 0 and var_455_2 < var_455_8 then
					arg_452_1.talkMaxDuration = var_455_8

					if var_455_8 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_8 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_5
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_9 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_9 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_9

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_9 and arg_452_1.time_ < var_455_1 + var_455_9 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play319511111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 319511111
		arg_456_1.duration_ = 7

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play319511112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 2

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				local var_459_1 = manager.ui.mainCamera.transform.localPosition
				local var_459_2 = Vector3.New(0, 0, 10) + Vector3.New(var_459_1.x, var_459_1.y, 0)
				local var_459_3 = arg_456_1.bgs_.ST71

				var_459_3.transform.localPosition = var_459_2
				var_459_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_4 = var_459_3:GetComponent("SpriteRenderer")

				if var_459_4 and var_459_4.sprite then
					local var_459_5 = (var_459_3.transform.localPosition - var_459_1).z
					local var_459_6 = manager.ui.mainCameraCom_
					local var_459_7 = 2 * var_459_5 * Mathf.Tan(var_459_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_459_8 = var_459_7 * var_459_6.aspect
					local var_459_9 = var_459_4.sprite.bounds.size.x
					local var_459_10 = var_459_4.sprite.bounds.size.y
					local var_459_11 = var_459_8 / var_459_9
					local var_459_12 = var_459_7 / var_459_10
					local var_459_13 = var_459_12 < var_459_11 and var_459_11 or var_459_12

					var_459_3.transform.localScale = Vector3.New(var_459_13, var_459_13, 0)
				end

				for iter_459_0, iter_459_1 in pairs(arg_456_1.bgs_) do
					if iter_459_0 ~= "ST71" then
						iter_459_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_459_14 = 0

			if var_459_14 < arg_456_1.time_ and arg_456_1.time_ <= var_459_14 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_15 = 2

			if var_459_14 <= arg_456_1.time_ and arg_456_1.time_ < var_459_14 + var_459_15 then
				local var_459_16 = (arg_456_1.time_ - var_459_14) / var_459_15
				local var_459_17 = Color.New(0, 0, 0)

				var_459_17.a = Mathf.Lerp(0, 1, var_459_16)
				arg_456_1.mask_.color = var_459_17
			end

			if arg_456_1.time_ >= var_459_14 + var_459_15 and arg_456_1.time_ < var_459_14 + var_459_15 + arg_459_0 then
				local var_459_18 = Color.New(0, 0, 0)

				var_459_18.a = 1
				arg_456_1.mask_.color = var_459_18
			end

			local var_459_19 = 2

			if var_459_19 < arg_456_1.time_ and arg_456_1.time_ <= var_459_19 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_20 = 2

			if var_459_19 <= arg_456_1.time_ and arg_456_1.time_ < var_459_19 + var_459_20 then
				local var_459_21 = (arg_456_1.time_ - var_459_19) / var_459_20
				local var_459_22 = Color.New(0, 0, 0)

				var_459_22.a = Mathf.Lerp(1, 0, var_459_21)
				arg_456_1.mask_.color = var_459_22
			end

			if arg_456_1.time_ >= var_459_19 + var_459_20 and arg_456_1.time_ < var_459_19 + var_459_20 + arg_459_0 then
				local var_459_23 = Color.New(0, 0, 0)
				local var_459_24 = 0

				arg_456_1.mask_.enabled = false
				var_459_23.a = var_459_24
				arg_456_1.mask_.color = var_459_23
			end

			local var_459_25 = arg_456_1.actors_["10068ui_story"].transform
			local var_459_26 = 2

			if var_459_26 < arg_456_1.time_ and arg_456_1.time_ <= var_459_26 + arg_459_0 then
				arg_456_1.var_.moveOldPos10068ui_story = var_459_25.localPosition
			end

			local var_459_27 = 0.001

			if var_459_26 <= arg_456_1.time_ and arg_456_1.time_ < var_459_26 + var_459_27 then
				local var_459_28 = (arg_456_1.time_ - var_459_26) / var_459_27
				local var_459_29 = Vector3.New(0, 100, 0)

				var_459_25.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos10068ui_story, var_459_29, var_459_28)

				local var_459_30 = manager.ui.mainCamera.transform.position - var_459_25.position

				var_459_25.forward = Vector3.New(var_459_30.x, var_459_30.y, var_459_30.z)

				local var_459_31 = var_459_25.localEulerAngles

				var_459_31.z = 0
				var_459_31.x = 0
				var_459_25.localEulerAngles = var_459_31
			end

			if arg_456_1.time_ >= var_459_26 + var_459_27 and arg_456_1.time_ < var_459_26 + var_459_27 + arg_459_0 then
				var_459_25.localPosition = Vector3.New(0, 100, 0)

				local var_459_32 = manager.ui.mainCamera.transform.position - var_459_25.position

				var_459_25.forward = Vector3.New(var_459_32.x, var_459_32.y, var_459_32.z)

				local var_459_33 = var_459_25.localEulerAngles

				var_459_33.z = 0
				var_459_33.x = 0
				var_459_25.localEulerAngles = var_459_33
			end

			local var_459_34 = arg_456_1.actors_["10068ui_story"]
			local var_459_35 = 2

			if var_459_35 < arg_456_1.time_ and arg_456_1.time_ <= var_459_35 + arg_459_0 and not isNil(var_459_34) and arg_456_1.var_.characterEffect10068ui_story == nil then
				arg_456_1.var_.characterEffect10068ui_story = var_459_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_36 = 0.200000002980232

			if var_459_35 <= arg_456_1.time_ and arg_456_1.time_ < var_459_35 + var_459_36 and not isNil(var_459_34) then
				local var_459_37 = (arg_456_1.time_ - var_459_35) / var_459_36

				if arg_456_1.var_.characterEffect10068ui_story and not isNil(var_459_34) then
					local var_459_38 = Mathf.Lerp(0, 0.5, var_459_37)

					arg_456_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_456_1.var_.characterEffect10068ui_story.fillRatio = var_459_38
				end
			end

			if arg_456_1.time_ >= var_459_35 + var_459_36 and arg_456_1.time_ < var_459_35 + var_459_36 + arg_459_0 and not isNil(var_459_34) and arg_456_1.var_.characterEffect10068ui_story then
				local var_459_39 = 0.5

				arg_456_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_456_1.var_.characterEffect10068ui_story.fillRatio = var_459_39
			end

			if arg_456_1.frameCnt_ <= 1 then
				arg_456_1.dialog_:SetActive(false)
			end

			local var_459_40 = 2
			local var_459_41 = 1.625

			if var_459_40 < arg_456_1.time_ and arg_456_1.time_ <= var_459_40 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0

				arg_456_1.dialog_:SetActive(true)

				arg_456_1.dialogCg_.alpha = 0

				local var_459_42 = LeanTween.value(arg_456_1.dialog_, 0, 1, 0.3)

				var_459_42:setOnUpdate(LuaHelper.FloatAction(function(arg_460_0)
					arg_456_1.dialogCg_.alpha = arg_460_0
				end))
				var_459_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_456_1.dialog_)
					var_459_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_456_1.duration_ = arg_456_1.duration_ + 0.3

				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_43 = arg_456_1:GetWordFromCfg(319511111)
				local var_459_44 = arg_456_1:FormatText(var_459_43.content)

				arg_456_1.text_.text = var_459_44

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_45 = 65
				local var_459_46 = utf8.len(var_459_44)
				local var_459_47 = var_459_45 <= 0 and var_459_41 or var_459_41 * (var_459_46 / var_459_45)

				if var_459_47 > 0 and var_459_41 < var_459_47 then
					arg_456_1.talkMaxDuration = var_459_47
					var_459_40 = var_459_40 + 0.3

					if var_459_47 + var_459_40 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_47 + var_459_40
					end
				end

				arg_456_1.text_.text = var_459_44
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_48 = var_459_40 + 0.3
			local var_459_49 = math.max(var_459_41, arg_456_1.talkMaxDuration)

			if var_459_48 <= arg_456_1.time_ and arg_456_1.time_ < var_459_48 + var_459_49 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_48) / var_459_49

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_48 + var_459_49 and arg_456_1.time_ < var_459_48 + var_459_49 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play319511112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 319511112
		arg_462_1.duration_ = 5.8

		local var_462_0 = {
			zh = 2.4,
			ja = 5.8
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play319511113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["10050ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos10050ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, -0.715, -6.15)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10050ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, -0.715, -6.15)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = arg_462_1.actors_["10050ui_story"]
			local var_465_10 = 0

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect10050ui_story == nil then
				arg_462_1.var_.characterEffect10050ui_story = var_465_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_11 = 0.200000002980232

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_11 and not isNil(var_465_9) then
				local var_465_12 = (arg_462_1.time_ - var_465_10) / var_465_11

				if arg_462_1.var_.characterEffect10050ui_story and not isNil(var_465_9) then
					arg_462_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_10 + var_465_11 and arg_462_1.time_ < var_465_10 + var_465_11 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect10050ui_story then
				arg_462_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_465_13 = 0

			if var_465_13 < arg_462_1.time_ and arg_462_1.time_ <= var_465_13 + arg_465_0 then
				arg_462_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_465_14 = 0

			if var_465_14 < arg_462_1.time_ and arg_462_1.time_ <= var_465_14 + arg_465_0 then
				arg_462_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_465_15 = 0
			local var_465_16 = 0.3

			if var_465_15 < arg_462_1.time_ and arg_462_1.time_ <= var_465_15 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_17 = arg_462_1:FormatText(StoryNameCfg[692].name)

				arg_462_1.leftNameTxt_.text = var_465_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_18 = arg_462_1:GetWordFromCfg(319511112)
				local var_465_19 = arg_462_1:FormatText(var_465_18.content)

				arg_462_1.text_.text = var_465_19

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_20 = 12
				local var_465_21 = utf8.len(var_465_19)
				local var_465_22 = var_465_20 <= 0 and var_465_16 or var_465_16 * (var_465_21 / var_465_20)

				if var_465_22 > 0 and var_465_16 < var_465_22 then
					arg_462_1.talkMaxDuration = var_465_22

					if var_465_22 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_22 + var_465_15
					end
				end

				arg_462_1.text_.text = var_465_19
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511112", "story_v_out_319511.awb") ~= 0 then
					local var_465_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511112", "story_v_out_319511.awb") / 1000

					if var_465_23 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_23 + var_465_15
					end

					if var_465_18.prefab_name ~= "" and arg_462_1.actors_[var_465_18.prefab_name] ~= nil then
						local var_465_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_18.prefab_name].transform, "story_v_out_319511", "319511112", "story_v_out_319511.awb")

						arg_462_1:RecordAudio("319511112", var_465_24)
						arg_462_1:RecordAudio("319511112", var_465_24)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_319511", "319511112", "story_v_out_319511.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_319511", "319511112", "story_v_out_319511.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_25 = math.max(var_465_16, arg_462_1.talkMaxDuration)

			if var_465_15 <= arg_462_1.time_ and arg_462_1.time_ < var_465_15 + var_465_25 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_15) / var_465_25

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_15 + var_465_25 and arg_462_1.time_ < var_465_15 + var_465_25 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play319511113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 319511113
		arg_466_1.duration_ = 4.07

		local var_466_0 = {
			zh = 2.2,
			ja = 4.066
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play319511114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1084ui_story"].transform
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.var_.moveOldPos1084ui_story = var_469_0.localPosition
			end

			local var_469_2 = 0.001

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2
				local var_469_4 = Vector3.New(0.7, -0.97, -6)

				var_469_0.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos1084ui_story, var_469_4, var_469_3)

				local var_469_5 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_5.x, var_469_5.y, var_469_5.z)

				local var_469_6 = var_469_0.localEulerAngles

				var_469_6.z = 0
				var_469_6.x = 0
				var_469_0.localEulerAngles = var_469_6
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 then
				var_469_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_469_7 = manager.ui.mainCamera.transform.position - var_469_0.position

				var_469_0.forward = Vector3.New(var_469_7.x, var_469_7.y, var_469_7.z)

				local var_469_8 = var_469_0.localEulerAngles

				var_469_8.z = 0
				var_469_8.x = 0
				var_469_0.localEulerAngles = var_469_8
			end

			local var_469_9 = arg_466_1.actors_["1084ui_story"]
			local var_469_10 = 0

			if var_469_10 < arg_466_1.time_ and arg_466_1.time_ <= var_469_10 + arg_469_0 and not isNil(var_469_9) and arg_466_1.var_.characterEffect1084ui_story == nil then
				arg_466_1.var_.characterEffect1084ui_story = var_469_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_11 = 0.200000002980232

			if var_469_10 <= arg_466_1.time_ and arg_466_1.time_ < var_469_10 + var_469_11 and not isNil(var_469_9) then
				local var_469_12 = (arg_466_1.time_ - var_469_10) / var_469_11

				if arg_466_1.var_.characterEffect1084ui_story and not isNil(var_469_9) then
					arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_10 + var_469_11 and arg_466_1.time_ < var_469_10 + var_469_11 + arg_469_0 and not isNil(var_469_9) and arg_466_1.var_.characterEffect1084ui_story then
				arg_466_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_469_13 = 0

			if var_469_13 < arg_466_1.time_ and arg_466_1.time_ <= var_469_13 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_469_14 = 0

			if var_469_14 < arg_466_1.time_ and arg_466_1.time_ <= var_469_14 + arg_469_0 then
				arg_466_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_469_15 = arg_466_1.actors_["10050ui_story"].transform
			local var_469_16 = 0

			if var_469_16 < arg_466_1.time_ and arg_466_1.time_ <= var_469_16 + arg_469_0 then
				arg_466_1.var_.moveOldPos10050ui_story = var_469_15.localPosition
			end

			local var_469_17 = 0.001

			if var_469_16 <= arg_466_1.time_ and arg_466_1.time_ < var_469_16 + var_469_17 then
				local var_469_18 = (arg_466_1.time_ - var_469_16) / var_469_17
				local var_469_19 = Vector3.New(-0.7, -0.715, -6.15)

				var_469_15.localPosition = Vector3.Lerp(arg_466_1.var_.moveOldPos10050ui_story, var_469_19, var_469_18)

				local var_469_20 = manager.ui.mainCamera.transform.position - var_469_15.position

				var_469_15.forward = Vector3.New(var_469_20.x, var_469_20.y, var_469_20.z)

				local var_469_21 = var_469_15.localEulerAngles

				var_469_21.z = 0
				var_469_21.x = 0
				var_469_15.localEulerAngles = var_469_21
			end

			if arg_466_1.time_ >= var_469_16 + var_469_17 and arg_466_1.time_ < var_469_16 + var_469_17 + arg_469_0 then
				var_469_15.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_469_22 = manager.ui.mainCamera.transform.position - var_469_15.position

				var_469_15.forward = Vector3.New(var_469_22.x, var_469_22.y, var_469_22.z)

				local var_469_23 = var_469_15.localEulerAngles

				var_469_23.z = 0
				var_469_23.x = 0
				var_469_15.localEulerAngles = var_469_23
			end

			local var_469_24 = arg_466_1.actors_["10050ui_story"]
			local var_469_25 = 0

			if var_469_25 < arg_466_1.time_ and arg_466_1.time_ <= var_469_25 + arg_469_0 and not isNil(var_469_24) and arg_466_1.var_.characterEffect10050ui_story == nil then
				arg_466_1.var_.characterEffect10050ui_story = var_469_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_26 = 0.200000002980232

			if var_469_25 <= arg_466_1.time_ and arg_466_1.time_ < var_469_25 + var_469_26 and not isNil(var_469_24) then
				local var_469_27 = (arg_466_1.time_ - var_469_25) / var_469_26

				if arg_466_1.var_.characterEffect10050ui_story and not isNil(var_469_24) then
					local var_469_28 = Mathf.Lerp(0, 0.5, var_469_27)

					arg_466_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_466_1.var_.characterEffect10050ui_story.fillRatio = var_469_28
				end
			end

			if arg_466_1.time_ >= var_469_25 + var_469_26 and arg_466_1.time_ < var_469_25 + var_469_26 + arg_469_0 and not isNil(var_469_24) and arg_466_1.var_.characterEffect10050ui_story then
				local var_469_29 = 0.5

				arg_466_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_466_1.var_.characterEffect10050ui_story.fillRatio = var_469_29
			end

			local var_469_30 = 0
			local var_469_31 = 0.2

			if var_469_30 < arg_466_1.time_ and arg_466_1.time_ <= var_469_30 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_32 = arg_466_1:FormatText(StoryNameCfg[6].name)

				arg_466_1.leftNameTxt_.text = var_469_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_33 = arg_466_1:GetWordFromCfg(319511113)
				local var_469_34 = arg_466_1:FormatText(var_469_33.content)

				arg_466_1.text_.text = var_469_34

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_35 = 8
				local var_469_36 = utf8.len(var_469_34)
				local var_469_37 = var_469_35 <= 0 and var_469_31 or var_469_31 * (var_469_36 / var_469_35)

				if var_469_37 > 0 and var_469_31 < var_469_37 then
					arg_466_1.talkMaxDuration = var_469_37

					if var_469_37 + var_469_30 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_37 + var_469_30
					end
				end

				arg_466_1.text_.text = var_469_34
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511113", "story_v_out_319511.awb") ~= 0 then
					local var_469_38 = manager.audio:GetVoiceLength("story_v_out_319511", "319511113", "story_v_out_319511.awb") / 1000

					if var_469_38 + var_469_30 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_38 + var_469_30
					end

					if var_469_33.prefab_name ~= "" and arg_466_1.actors_[var_469_33.prefab_name] ~= nil then
						local var_469_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_33.prefab_name].transform, "story_v_out_319511", "319511113", "story_v_out_319511.awb")

						arg_466_1:RecordAudio("319511113", var_469_39)
						arg_466_1:RecordAudio("319511113", var_469_39)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_319511", "319511113", "story_v_out_319511.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_319511", "319511113", "story_v_out_319511.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_40 = math.max(var_469_31, arg_466_1.talkMaxDuration)

			if var_469_30 <= arg_466_1.time_ and arg_466_1.time_ < var_469_30 + var_469_40 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_30) / var_469_40

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_30 + var_469_40 and arg_466_1.time_ < var_469_30 + var_469_40 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_466_1:InitPlayNodeList()
	end,
	Play319511114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 319511114
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play319511115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1084ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1084ui_story == nil then
				arg_470_1.var_.characterEffect1084ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect1084ui_story and not isNil(var_473_0) then
					local var_473_4 = Mathf.Lerp(0, 0.5, var_473_3)

					arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1084ui_story.fillRatio = var_473_4
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1084ui_story then
				local var_473_5 = 0.5

				arg_470_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1084ui_story.fillRatio = var_473_5
			end

			local var_473_6 = 0

			if var_473_6 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_473_7 = 0

			if var_473_7 < arg_470_1.time_ and arg_470_1.time_ <= var_473_7 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_473_8 = 0
			local var_473_9 = 0.525

			if var_473_8 < arg_470_1.time_ and arg_470_1.time_ <= var_473_8 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_10 = arg_470_1:GetWordFromCfg(319511114)
				local var_473_11 = arg_470_1:FormatText(var_473_10.content)

				arg_470_1.text_.text = var_473_11

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_12 = 21
				local var_473_13 = utf8.len(var_473_11)
				local var_473_14 = var_473_12 <= 0 and var_473_9 or var_473_9 * (var_473_13 / var_473_12)

				if var_473_14 > 0 and var_473_9 < var_473_14 then
					arg_470_1.talkMaxDuration = var_473_14

					if var_473_14 + var_473_8 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_14 + var_473_8
					end
				end

				arg_470_1.text_.text = var_473_11
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_15 = math.max(var_473_9, arg_470_1.talkMaxDuration)

			if var_473_8 <= arg_470_1.time_ and arg_470_1.time_ < var_473_8 + var_473_15 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_8) / var_473_15

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_8 + var_473_15 and arg_470_1.time_ < var_473_8 + var_473_15 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play319511115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 319511115
		arg_474_1.duration_ = 4.5

		local var_474_0 = {
			zh = 4.033,
			ja = 4.5
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play319511116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["10050ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10050ui_story == nil then
				arg_474_1.var_.characterEffect10050ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect10050ui_story and not isNil(var_477_0) then
					arg_474_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10050ui_story then
				arg_474_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_477_4 = 0

			if var_477_4 < arg_474_1.time_ and arg_474_1.time_ <= var_477_4 + arg_477_0 then
				arg_474_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			local var_477_5 = 0

			if var_477_5 < arg_474_1.time_ and arg_474_1.time_ <= var_477_5 + arg_477_0 then
				arg_474_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_477_6 = 0
			local var_477_7 = 0.5

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_8 = arg_474_1:FormatText(StoryNameCfg[692].name)

				arg_474_1.leftNameTxt_.text = var_477_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_9 = arg_474_1:GetWordFromCfg(319511115)
				local var_477_10 = arg_474_1:FormatText(var_477_9.content)

				arg_474_1.text_.text = var_477_10

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 20
				local var_477_12 = utf8.len(var_477_10)
				local var_477_13 = var_477_11 <= 0 and var_477_7 or var_477_7 * (var_477_12 / var_477_11)

				if var_477_13 > 0 and var_477_7 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_10
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511115", "story_v_out_319511.awb") ~= 0 then
					local var_477_14 = manager.audio:GetVoiceLength("story_v_out_319511", "319511115", "story_v_out_319511.awb") / 1000

					if var_477_14 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_14 + var_477_6
					end

					if var_477_9.prefab_name ~= "" and arg_474_1.actors_[var_477_9.prefab_name] ~= nil then
						local var_477_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_9.prefab_name].transform, "story_v_out_319511", "319511115", "story_v_out_319511.awb")

						arg_474_1:RecordAudio("319511115", var_477_15)
						arg_474_1:RecordAudio("319511115", var_477_15)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_319511", "319511115", "story_v_out_319511.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_319511", "319511115", "story_v_out_319511.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_16 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_16 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_16

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_16 and arg_474_1.time_ < var_477_6 + var_477_16 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play319511116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 319511116
		arg_478_1.duration_ = 15.1

		local var_478_0 = {
			zh = 8.733,
			ja = 15.1
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play319511117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[692].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:GetWordFromCfg(319511116)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 40
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511116", "story_v_out_319511.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511116", "story_v_out_319511.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_out_319511", "319511116", "story_v_out_319511.awb")

						arg_478_1:RecordAudio("319511116", var_481_9)
						arg_478_1:RecordAudio("319511116", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_319511", "319511116", "story_v_out_319511.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_319511", "319511116", "story_v_out_319511.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play319511117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 319511117
		arg_482_1.duration_ = 18.17

		local var_482_0 = {
			zh = 13.3,
			ja = 18.166
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play319511118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_485_1 = 0
			local var_485_2 = 1.275

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_3 = arg_482_1:FormatText(StoryNameCfg[692].name)

				arg_482_1.leftNameTxt_.text = var_485_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_4 = arg_482_1:GetWordFromCfg(319511117)
				local var_485_5 = arg_482_1:FormatText(var_485_4.content)

				arg_482_1.text_.text = var_485_5

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_6 = 51
				local var_485_7 = utf8.len(var_485_5)
				local var_485_8 = var_485_6 <= 0 and var_485_2 or var_485_2 * (var_485_7 / var_485_6)

				if var_485_8 > 0 and var_485_2 < var_485_8 then
					arg_482_1.talkMaxDuration = var_485_8

					if var_485_8 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_5
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511117", "story_v_out_319511.awb") ~= 0 then
					local var_485_9 = manager.audio:GetVoiceLength("story_v_out_319511", "319511117", "story_v_out_319511.awb") / 1000

					if var_485_9 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_9 + var_485_1
					end

					if var_485_4.prefab_name ~= "" and arg_482_1.actors_[var_485_4.prefab_name] ~= nil then
						local var_485_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_4.prefab_name].transform, "story_v_out_319511", "319511117", "story_v_out_319511.awb")

						arg_482_1:RecordAudio("319511117", var_485_10)
						arg_482_1:RecordAudio("319511117", var_485_10)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_319511", "319511117", "story_v_out_319511.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_319511", "319511117", "story_v_out_319511.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_11 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_11 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_11

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_11 and arg_482_1.time_ < var_485_1 + var_485_11 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play319511118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 319511118
		arg_486_1.duration_ = 8.07

		local var_486_0 = {
			zh = 7.9,
			ja = 8.066
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play319511119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_489_1 = 0
			local var_489_2 = 0.75

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_3 = arg_486_1:FormatText(StoryNameCfg[692].name)

				arg_486_1.leftNameTxt_.text = var_489_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_4 = arg_486_1:GetWordFromCfg(319511118)
				local var_489_5 = arg_486_1:FormatText(var_489_4.content)

				arg_486_1.text_.text = var_489_5

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_6 = 30
				local var_489_7 = utf8.len(var_489_5)
				local var_489_8 = var_489_6 <= 0 and var_489_2 or var_489_2 * (var_489_7 / var_489_6)

				if var_489_8 > 0 and var_489_2 < var_489_8 then
					arg_486_1.talkMaxDuration = var_489_8

					if var_489_8 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_1
					end
				end

				arg_486_1.text_.text = var_489_5
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511118", "story_v_out_319511.awb") ~= 0 then
					local var_489_9 = manager.audio:GetVoiceLength("story_v_out_319511", "319511118", "story_v_out_319511.awb") / 1000

					if var_489_9 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_9 + var_489_1
					end

					if var_489_4.prefab_name ~= "" and arg_486_1.actors_[var_489_4.prefab_name] ~= nil then
						local var_489_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_4.prefab_name].transform, "story_v_out_319511", "319511118", "story_v_out_319511.awb")

						arg_486_1:RecordAudio("319511118", var_489_10)
						arg_486_1:RecordAudio("319511118", var_489_10)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_319511", "319511118", "story_v_out_319511.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_319511", "319511118", "story_v_out_319511.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_11 = math.max(var_489_2, arg_486_1.talkMaxDuration)

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_11 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_1) / var_489_11

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_1 + var_489_11 and arg_486_1.time_ < var_489_1 + var_489_11 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play319511119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 319511119
		arg_490_1.duration_ = 9.73

		local var_490_0 = {
			zh = 3.766,
			ja = 9.733
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play319511120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.425

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[692].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:GetWordFromCfg(319511119)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 17
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511119", "story_v_out_319511.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511119", "story_v_out_319511.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_out_319511", "319511119", "story_v_out_319511.awb")

						arg_490_1:RecordAudio("319511119", var_493_9)
						arg_490_1:RecordAudio("319511119", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_319511", "319511119", "story_v_out_319511.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_319511", "319511119", "story_v_out_319511.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play319511120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 319511120
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play319511121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["10050ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect10050ui_story == nil then
				arg_494_1.var_.characterEffect10050ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.2

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect10050ui_story and not isNil(var_497_0) then
					local var_497_4 = Mathf.Lerp(0, 0.5, var_497_3)

					arg_494_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_494_1.var_.characterEffect10050ui_story.fillRatio = var_497_4
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect10050ui_story then
				local var_497_5 = 0.5

				arg_494_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_494_1.var_.characterEffect10050ui_story.fillRatio = var_497_5
			end

			local var_497_6 = 0
			local var_497_7 = 0.75

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_8 = arg_494_1:GetWordFromCfg(319511120)
				local var_497_9 = arg_494_1:FormatText(var_497_8.content)

				arg_494_1.text_.text = var_497_9

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_10 = 30
				local var_497_11 = utf8.len(var_497_9)
				local var_497_12 = var_497_10 <= 0 and var_497_7 or var_497_7 * (var_497_11 / var_497_10)

				if var_497_12 > 0 and var_497_7 < var_497_12 then
					arg_494_1.talkMaxDuration = var_497_12

					if var_497_12 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_12 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_9
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_13 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_13 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_13

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_13 and arg_494_1.time_ < var_497_6 + var_497_13 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play319511121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 319511121
		arg_498_1.duration_ = 4.43

		local var_498_0 = {
			zh = 3.366,
			ja = 4.433
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play319511122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["10050ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10050ui_story == nil then
				arg_498_1.var_.characterEffect10050ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect10050ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10050ui_story then
				arg_498_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_501_4 = 0

			if var_501_4 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			local var_501_5 = 0

			if var_501_5 < arg_498_1.time_ and arg_498_1.time_ <= var_501_5 + arg_501_0 then
				arg_498_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_501_6 = arg_498_1.actors_["1084ui_story"]
			local var_501_7 = 0

			if var_501_7 < arg_498_1.time_ and arg_498_1.time_ <= var_501_7 + arg_501_0 and not isNil(var_501_6) and arg_498_1.var_.characterEffect1084ui_story == nil then
				arg_498_1.var_.characterEffect1084ui_story = var_501_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_8 = 0.200000002980232

			if var_501_7 <= arg_498_1.time_ and arg_498_1.time_ < var_501_7 + var_501_8 and not isNil(var_501_6) then
				local var_501_9 = (arg_498_1.time_ - var_501_7) / var_501_8

				if arg_498_1.var_.characterEffect1084ui_story and not isNil(var_501_6) then
					local var_501_10 = Mathf.Lerp(0, 0.5, var_501_9)

					arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1084ui_story.fillRatio = var_501_10
				end
			end

			if arg_498_1.time_ >= var_501_7 + var_501_8 and arg_498_1.time_ < var_501_7 + var_501_8 + arg_501_0 and not isNil(var_501_6) and arg_498_1.var_.characterEffect1084ui_story then
				local var_501_11 = 0.5

				arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1084ui_story.fillRatio = var_501_11
			end

			local var_501_12 = 0
			local var_501_13 = 0.3

			if var_501_12 < arg_498_1.time_ and arg_498_1.time_ <= var_501_12 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_14 = arg_498_1:FormatText(StoryNameCfg[692].name)

				arg_498_1.leftNameTxt_.text = var_501_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_15 = arg_498_1:GetWordFromCfg(319511121)
				local var_501_16 = arg_498_1:FormatText(var_501_15.content)

				arg_498_1.text_.text = var_501_16

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_17 = 12
				local var_501_18 = utf8.len(var_501_16)
				local var_501_19 = var_501_17 <= 0 and var_501_13 or var_501_13 * (var_501_18 / var_501_17)

				if var_501_19 > 0 and var_501_13 < var_501_19 then
					arg_498_1.talkMaxDuration = var_501_19

					if var_501_19 + var_501_12 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_19 + var_501_12
					end
				end

				arg_498_1.text_.text = var_501_16
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511121", "story_v_out_319511.awb") ~= 0 then
					local var_501_20 = manager.audio:GetVoiceLength("story_v_out_319511", "319511121", "story_v_out_319511.awb") / 1000

					if var_501_20 + var_501_12 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_20 + var_501_12
					end

					if var_501_15.prefab_name ~= "" and arg_498_1.actors_[var_501_15.prefab_name] ~= nil then
						local var_501_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_15.prefab_name].transform, "story_v_out_319511", "319511121", "story_v_out_319511.awb")

						arg_498_1:RecordAudio("319511121", var_501_21)
						arg_498_1:RecordAudio("319511121", var_501_21)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_319511", "319511121", "story_v_out_319511.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_319511", "319511121", "story_v_out_319511.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_22 = math.max(var_501_13, arg_498_1.talkMaxDuration)

			if var_501_12 <= arg_498_1.time_ and arg_498_1.time_ < var_501_12 + var_501_22 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_12) / var_501_22

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_12 + var_501_22 and arg_498_1.time_ < var_501_12 + var_501_22 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play319511122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 319511122
		arg_502_1.duration_ = 3.3

		local var_502_0 = {
			zh = 2.5,
			ja = 3.3
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play319511123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["10050ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect10050ui_story == nil then
				arg_502_1.var_.characterEffect10050ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect10050ui_story and not isNil(var_505_0) then
					local var_505_4 = Mathf.Lerp(0, 0.5, var_505_3)

					arg_502_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_502_1.var_.characterEffect10050ui_story.fillRatio = var_505_4
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect10050ui_story then
				local var_505_5 = 0.5

				arg_502_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_502_1.var_.characterEffect10050ui_story.fillRatio = var_505_5
			end

			local var_505_6 = arg_502_1.actors_["1084ui_story"]
			local var_505_7 = 0

			if var_505_7 < arg_502_1.time_ and arg_502_1.time_ <= var_505_7 + arg_505_0 and not isNil(var_505_6) and arg_502_1.var_.characterEffect1084ui_story == nil then
				arg_502_1.var_.characterEffect1084ui_story = var_505_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_8 = 0.200000002980232

			if var_505_7 <= arg_502_1.time_ and arg_502_1.time_ < var_505_7 + var_505_8 and not isNil(var_505_6) then
				local var_505_9 = (arg_502_1.time_ - var_505_7) / var_505_8

				if arg_502_1.var_.characterEffect1084ui_story and not isNil(var_505_6) then
					arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_7 + var_505_8 and arg_502_1.time_ < var_505_7 + var_505_8 + arg_505_0 and not isNil(var_505_6) and arg_502_1.var_.characterEffect1084ui_story then
				arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_505_10 = 0
			local var_505_11 = 0.225

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_12 = arg_502_1:FormatText(StoryNameCfg[6].name)

				arg_502_1.leftNameTxt_.text = var_505_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_13 = arg_502_1:GetWordFromCfg(319511122)
				local var_505_14 = arg_502_1:FormatText(var_505_13.content)

				arg_502_1.text_.text = var_505_14

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_15 = 9
				local var_505_16 = utf8.len(var_505_14)
				local var_505_17 = var_505_15 <= 0 and var_505_11 or var_505_11 * (var_505_16 / var_505_15)

				if var_505_17 > 0 and var_505_11 < var_505_17 then
					arg_502_1.talkMaxDuration = var_505_17

					if var_505_17 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_17 + var_505_10
					end
				end

				arg_502_1.text_.text = var_505_14
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511122", "story_v_out_319511.awb") ~= 0 then
					local var_505_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511122", "story_v_out_319511.awb") / 1000

					if var_505_18 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_18 + var_505_10
					end

					if var_505_13.prefab_name ~= "" and arg_502_1.actors_[var_505_13.prefab_name] ~= nil then
						local var_505_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_13.prefab_name].transform, "story_v_out_319511", "319511122", "story_v_out_319511.awb")

						arg_502_1:RecordAudio("319511122", var_505_19)
						arg_502_1:RecordAudio("319511122", var_505_19)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_319511", "319511122", "story_v_out_319511.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_319511", "319511122", "story_v_out_319511.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_20 = math.max(var_505_11, arg_502_1.talkMaxDuration)

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_20 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_10) / var_505_20

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_10 + var_505_20 and arg_502_1.time_ < var_505_10 + var_505_20 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play319511123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 319511123
		arg_506_1.duration_ = 17.13

		local var_506_0 = {
			zh = 9.433,
			ja = 17.133
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play319511124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1084ui_story"].transform
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.var_.moveOldPos1084ui_story = var_509_0.localPosition
			end

			local var_509_2 = 0.001

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2
				local var_509_4 = Vector3.New(0.7, -0.97, -6)

				var_509_0.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1084ui_story, var_509_4, var_509_3)

				local var_509_5 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_5.x, var_509_5.y, var_509_5.z)

				local var_509_6 = var_509_0.localEulerAngles

				var_509_6.z = 0
				var_509_6.x = 0
				var_509_0.localEulerAngles = var_509_6
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 then
				var_509_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_509_7 = manager.ui.mainCamera.transform.position - var_509_0.position

				var_509_0.forward = Vector3.New(var_509_7.x, var_509_7.y, var_509_7.z)

				local var_509_8 = var_509_0.localEulerAngles

				var_509_8.z = 0
				var_509_8.x = 0
				var_509_0.localEulerAngles = var_509_8
			end

			local var_509_9 = arg_506_1.actors_["1084ui_story"]
			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1084ui_story == nil then
				arg_506_1.var_.characterEffect1084ui_story = var_509_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_11 = 0.200000002980232

			if var_509_10 <= arg_506_1.time_ and arg_506_1.time_ < var_509_10 + var_509_11 and not isNil(var_509_9) then
				local var_509_12 = (arg_506_1.time_ - var_509_10) / var_509_11

				if arg_506_1.var_.characterEffect1084ui_story and not isNil(var_509_9) then
					local var_509_13 = Mathf.Lerp(0, 0.5, var_509_12)

					arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1084ui_story.fillRatio = var_509_13
				end
			end

			if arg_506_1.time_ >= var_509_10 + var_509_11 and arg_506_1.time_ < var_509_10 + var_509_11 + arg_509_0 and not isNil(var_509_9) and arg_506_1.var_.characterEffect1084ui_story then
				local var_509_14 = 0.5

				arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1084ui_story.fillRatio = var_509_14
			end

			local var_509_15 = arg_506_1.actors_["10050ui_story"]
			local var_509_16 = 0

			if var_509_16 < arg_506_1.time_ and arg_506_1.time_ <= var_509_16 + arg_509_0 and not isNil(var_509_15) and arg_506_1.var_.characterEffect10050ui_story == nil then
				arg_506_1.var_.characterEffect10050ui_story = var_509_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_17 = 0.200000002980232

			if var_509_16 <= arg_506_1.time_ and arg_506_1.time_ < var_509_16 + var_509_17 and not isNil(var_509_15) then
				local var_509_18 = (arg_506_1.time_ - var_509_16) / var_509_17

				if arg_506_1.var_.characterEffect10050ui_story and not isNil(var_509_15) then
					arg_506_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_16 + var_509_17 and arg_506_1.time_ < var_509_16 + var_509_17 + arg_509_0 and not isNil(var_509_15) and arg_506_1.var_.characterEffect10050ui_story then
				arg_506_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_509_19 = 0
			local var_509_20 = 0.925

			if var_509_19 < arg_506_1.time_ and arg_506_1.time_ <= var_509_19 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_21 = arg_506_1:FormatText(StoryNameCfg[692].name)

				arg_506_1.leftNameTxt_.text = var_509_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_22 = arg_506_1:GetWordFromCfg(319511123)
				local var_509_23 = arg_506_1:FormatText(var_509_22.content)

				arg_506_1.text_.text = var_509_23

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_24 = 37
				local var_509_25 = utf8.len(var_509_23)
				local var_509_26 = var_509_24 <= 0 and var_509_20 or var_509_20 * (var_509_25 / var_509_24)

				if var_509_26 > 0 and var_509_20 < var_509_26 then
					arg_506_1.talkMaxDuration = var_509_26

					if var_509_26 + var_509_19 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_26 + var_509_19
					end
				end

				arg_506_1.text_.text = var_509_23
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511123", "story_v_out_319511.awb") ~= 0 then
					local var_509_27 = manager.audio:GetVoiceLength("story_v_out_319511", "319511123", "story_v_out_319511.awb") / 1000

					if var_509_27 + var_509_19 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_27 + var_509_19
					end

					if var_509_22.prefab_name ~= "" and arg_506_1.actors_[var_509_22.prefab_name] ~= nil then
						local var_509_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_22.prefab_name].transform, "story_v_out_319511", "319511123", "story_v_out_319511.awb")

						arg_506_1:RecordAudio("319511123", var_509_28)
						arg_506_1:RecordAudio("319511123", var_509_28)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_319511", "319511123", "story_v_out_319511.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_319511", "319511123", "story_v_out_319511.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_29 = math.max(var_509_20, arg_506_1.talkMaxDuration)

			if var_509_19 <= arg_506_1.time_ and arg_506_1.time_ < var_509_19 + var_509_29 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_19) / var_509_29

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_19 + var_509_29 and arg_506_1.time_ < var_509_19 + var_509_29 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
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

		arg_506_1:InitPlayNodeList()
	end,
	Play319511124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 319511124
		arg_510_1.duration_ = 12.6

		local var_510_0 = {
			zh = 4.133,
			ja = 12.6
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play319511125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1084ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1084ui_story == nil then
				arg_510_1.var_.characterEffect1084ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1084ui_story and not isNil(var_513_0) then
					arg_510_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1084ui_story then
				arg_510_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_513_4 = arg_510_1.actors_["10050ui_story"]
			local var_513_5 = 0

			if var_513_5 < arg_510_1.time_ and arg_510_1.time_ <= var_513_5 + arg_513_0 and not isNil(var_513_4) and arg_510_1.var_.characterEffect10050ui_story == nil then
				arg_510_1.var_.characterEffect10050ui_story = var_513_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_6 = 0.200000002980232

			if var_513_5 <= arg_510_1.time_ and arg_510_1.time_ < var_513_5 + var_513_6 and not isNil(var_513_4) then
				local var_513_7 = (arg_510_1.time_ - var_513_5) / var_513_6

				if arg_510_1.var_.characterEffect10050ui_story and not isNil(var_513_4) then
					local var_513_8 = Mathf.Lerp(0, 0.5, var_513_7)

					arg_510_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_510_1.var_.characterEffect10050ui_story.fillRatio = var_513_8
				end
			end

			if arg_510_1.time_ >= var_513_5 + var_513_6 and arg_510_1.time_ < var_513_5 + var_513_6 + arg_513_0 and not isNil(var_513_4) and arg_510_1.var_.characterEffect10050ui_story then
				local var_513_9 = 0.5

				arg_510_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_510_1.var_.characterEffect10050ui_story.fillRatio = var_513_9
			end

			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 then
				arg_510_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_513_11 = 0

			if var_513_11 < arg_510_1.time_ and arg_510_1.time_ <= var_513_11 + arg_513_0 then
				arg_510_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_513_12 = 0
			local var_513_13 = 0.425

			if var_513_12 < arg_510_1.time_ and arg_510_1.time_ <= var_513_12 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_14 = arg_510_1:FormatText(StoryNameCfg[6].name)

				arg_510_1.leftNameTxt_.text = var_513_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_15 = arg_510_1:GetWordFromCfg(319511124)
				local var_513_16 = arg_510_1:FormatText(var_513_15.content)

				arg_510_1.text_.text = var_513_16

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_17 = 17
				local var_513_18 = utf8.len(var_513_16)
				local var_513_19 = var_513_17 <= 0 and var_513_13 or var_513_13 * (var_513_18 / var_513_17)

				if var_513_19 > 0 and var_513_13 < var_513_19 then
					arg_510_1.talkMaxDuration = var_513_19

					if var_513_19 + var_513_12 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_19 + var_513_12
					end
				end

				arg_510_1.text_.text = var_513_16
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511124", "story_v_out_319511.awb") ~= 0 then
					local var_513_20 = manager.audio:GetVoiceLength("story_v_out_319511", "319511124", "story_v_out_319511.awb") / 1000

					if var_513_20 + var_513_12 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_20 + var_513_12
					end

					if var_513_15.prefab_name ~= "" and arg_510_1.actors_[var_513_15.prefab_name] ~= nil then
						local var_513_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_15.prefab_name].transform, "story_v_out_319511", "319511124", "story_v_out_319511.awb")

						arg_510_1:RecordAudio("319511124", var_513_21)
						arg_510_1:RecordAudio("319511124", var_513_21)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_319511", "319511124", "story_v_out_319511.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_319511", "319511124", "story_v_out_319511.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_22 = math.max(var_513_13, arg_510_1.talkMaxDuration)

			if var_513_12 <= arg_510_1.time_ and arg_510_1.time_ < var_513_12 + var_513_22 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_12) / var_513_22

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_12 + var_513_22 and arg_510_1.time_ < var_513_12 + var_513_22 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play319511125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 319511125
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play319511126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1084ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1084ui_story == nil then
				arg_514_1.var_.characterEffect1084ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1084ui_story and not isNil(var_517_0) then
					local var_517_4 = Mathf.Lerp(0, 0.5, var_517_3)

					arg_514_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1084ui_story.fillRatio = var_517_4
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1084ui_story then
				local var_517_5 = 0.5

				arg_514_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1084ui_story.fillRatio = var_517_5
			end

			local var_517_6 = 0
			local var_517_7 = 0.8

			if var_517_6 < arg_514_1.time_ and arg_514_1.time_ <= var_517_6 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_8 = arg_514_1:GetWordFromCfg(319511125)
				local var_517_9 = arg_514_1:FormatText(var_517_8.content)

				arg_514_1.text_.text = var_517_9

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_10 = 32
				local var_517_11 = utf8.len(var_517_9)
				local var_517_12 = var_517_10 <= 0 and var_517_7 or var_517_7 * (var_517_11 / var_517_10)

				if var_517_12 > 0 and var_517_7 < var_517_12 then
					arg_514_1.talkMaxDuration = var_517_12

					if var_517_12 + var_517_6 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_6
					end
				end

				arg_514_1.text_.text = var_517_9
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_13 = math.max(var_517_7, arg_514_1.talkMaxDuration)

			if var_517_6 <= arg_514_1.time_ and arg_514_1.time_ < var_517_6 + var_517_13 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_6) / var_517_13

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_6 + var_517_13 and arg_514_1.time_ < var_517_6 + var_517_13 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play319511126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 319511126
		arg_518_1.duration_ = 10.6

		local var_518_0 = {
			zh = 2.6,
			ja = 10.6
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play319511127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1084ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1084ui_story == nil then
				arg_518_1.var_.characterEffect1084ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect1084ui_story and not isNil(var_521_0) then
					arg_518_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1084ui_story then
				arg_518_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_521_4 = 0
			local var_521_5 = 0.3

			if var_521_4 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_6 = arg_518_1:FormatText(StoryNameCfg[6].name)

				arg_518_1.leftNameTxt_.text = var_521_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_7 = arg_518_1:GetWordFromCfg(319511126)
				local var_521_8 = arg_518_1:FormatText(var_521_7.content)

				arg_518_1.text_.text = var_521_8

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 12
				local var_521_10 = utf8.len(var_521_8)
				local var_521_11 = var_521_9 <= 0 and var_521_5 or var_521_5 * (var_521_10 / var_521_9)

				if var_521_11 > 0 and var_521_5 < var_521_11 then
					arg_518_1.talkMaxDuration = var_521_11

					if var_521_11 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_11 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_8
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511126", "story_v_out_319511.awb") ~= 0 then
					local var_521_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511126", "story_v_out_319511.awb") / 1000

					if var_521_12 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_12 + var_521_4
					end

					if var_521_7.prefab_name ~= "" and arg_518_1.actors_[var_521_7.prefab_name] ~= nil then
						local var_521_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_7.prefab_name].transform, "story_v_out_319511", "319511126", "story_v_out_319511.awb")

						arg_518_1:RecordAudio("319511126", var_521_13)
						arg_518_1:RecordAudio("319511126", var_521_13)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_319511", "319511126", "story_v_out_319511.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_319511", "319511126", "story_v_out_319511.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_14 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_14 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_14

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_14 and arg_518_1.time_ < var_521_4 + var_521_14 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play319511127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 319511127
		arg_522_1.duration_ = 13.5

		local var_522_0 = {
			zh = 9.633,
			ja = 13.5
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play319511128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["10050ui_story"].transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.var_.moveOldPos10050ui_story = var_525_0.localPosition
			end

			local var_525_2 = 0.001

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2
				local var_525_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_525_0.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos10050ui_story, var_525_4, var_525_3)

				local var_525_5 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_5.x, var_525_5.y, var_525_5.z)

				local var_525_6 = var_525_0.localEulerAngles

				var_525_6.z = 0
				var_525_6.x = 0
				var_525_0.localEulerAngles = var_525_6
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 then
				var_525_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_525_7 = manager.ui.mainCamera.transform.position - var_525_0.position

				var_525_0.forward = Vector3.New(var_525_7.x, var_525_7.y, var_525_7.z)

				local var_525_8 = var_525_0.localEulerAngles

				var_525_8.z = 0
				var_525_8.x = 0
				var_525_0.localEulerAngles = var_525_8
			end

			local var_525_9 = arg_522_1.actors_["10050ui_story"]
			local var_525_10 = 0

			if var_525_10 < arg_522_1.time_ and arg_522_1.time_ <= var_525_10 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect10050ui_story == nil then
				arg_522_1.var_.characterEffect10050ui_story = var_525_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_11 = 0.200000002980232

			if var_525_10 <= arg_522_1.time_ and arg_522_1.time_ < var_525_10 + var_525_11 and not isNil(var_525_9) then
				local var_525_12 = (arg_522_1.time_ - var_525_10) / var_525_11

				if arg_522_1.var_.characterEffect10050ui_story and not isNil(var_525_9) then
					arg_522_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_10 + var_525_11 and arg_522_1.time_ < var_525_10 + var_525_11 + arg_525_0 and not isNil(var_525_9) and arg_522_1.var_.characterEffect10050ui_story then
				arg_522_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_525_13 = 0

			if var_525_13 < arg_522_1.time_ and arg_522_1.time_ <= var_525_13 + arg_525_0 then
				arg_522_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_1")
			end

			local var_525_14 = 0

			if var_525_14 < arg_522_1.time_ and arg_522_1.time_ <= var_525_14 + arg_525_0 then
				arg_522_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_525_15 = arg_522_1.actors_["1084ui_story"]
			local var_525_16 = 0

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 and not isNil(var_525_15) and arg_522_1.var_.characterEffect1084ui_story == nil then
				arg_522_1.var_.characterEffect1084ui_story = var_525_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_17 = 0.200000002980232

			if var_525_16 <= arg_522_1.time_ and arg_522_1.time_ < var_525_16 + var_525_17 and not isNil(var_525_15) then
				local var_525_18 = (arg_522_1.time_ - var_525_16) / var_525_17

				if arg_522_1.var_.characterEffect1084ui_story and not isNil(var_525_15) then
					local var_525_19 = Mathf.Lerp(0, 0.5, var_525_18)

					arg_522_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_522_1.var_.characterEffect1084ui_story.fillRatio = var_525_19
				end
			end

			if arg_522_1.time_ >= var_525_16 + var_525_17 and arg_522_1.time_ < var_525_16 + var_525_17 + arg_525_0 and not isNil(var_525_15) and arg_522_1.var_.characterEffect1084ui_story then
				local var_525_20 = 0.5

				arg_522_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_522_1.var_.characterEffect1084ui_story.fillRatio = var_525_20
			end

			local var_525_21 = 0
			local var_525_22 = 0.9

			if var_525_21 < arg_522_1.time_ and arg_522_1.time_ <= var_525_21 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_23 = arg_522_1:FormatText(StoryNameCfg[692].name)

				arg_522_1.leftNameTxt_.text = var_525_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_24 = arg_522_1:GetWordFromCfg(319511127)
				local var_525_25 = arg_522_1:FormatText(var_525_24.content)

				arg_522_1.text_.text = var_525_25

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_26 = 36
				local var_525_27 = utf8.len(var_525_25)
				local var_525_28 = var_525_26 <= 0 and var_525_22 or var_525_22 * (var_525_27 / var_525_26)

				if var_525_28 > 0 and var_525_22 < var_525_28 then
					arg_522_1.talkMaxDuration = var_525_28

					if var_525_28 + var_525_21 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_28 + var_525_21
					end
				end

				arg_522_1.text_.text = var_525_25
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511127", "story_v_out_319511.awb") ~= 0 then
					local var_525_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511127", "story_v_out_319511.awb") / 1000

					if var_525_29 + var_525_21 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_29 + var_525_21
					end

					if var_525_24.prefab_name ~= "" and arg_522_1.actors_[var_525_24.prefab_name] ~= nil then
						local var_525_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_24.prefab_name].transform, "story_v_out_319511", "319511127", "story_v_out_319511.awb")

						arg_522_1:RecordAudio("319511127", var_525_30)
						arg_522_1:RecordAudio("319511127", var_525_30)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_319511", "319511127", "story_v_out_319511.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_319511", "319511127", "story_v_out_319511.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_31 = math.max(var_525_22, arg_522_1.talkMaxDuration)

			if var_525_21 <= arg_522_1.time_ and arg_522_1.time_ < var_525_21 + var_525_31 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_21) / var_525_31

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_21 + var_525_31 and arg_522_1.time_ < var_525_21 + var_525_31 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play319511128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 319511128
		arg_526_1.duration_ = 6.03

		local var_526_0 = {
			zh = 6.033,
			ja = 2.766
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play319511129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["10050ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect10050ui_story == nil then
				arg_526_1.var_.characterEffect10050ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect10050ui_story and not isNil(var_529_0) then
					local var_529_4 = Mathf.Lerp(0, 0.5, var_529_3)

					arg_526_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_526_1.var_.characterEffect10050ui_story.fillRatio = var_529_4
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect10050ui_story then
				local var_529_5 = 0.5

				arg_526_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_526_1.var_.characterEffect10050ui_story.fillRatio = var_529_5
			end

			local var_529_6 = arg_526_1.actors_["1084ui_story"]
			local var_529_7 = 0

			if var_529_7 < arg_526_1.time_ and arg_526_1.time_ <= var_529_7 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect1084ui_story == nil then
				arg_526_1.var_.characterEffect1084ui_story = var_529_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_8 = 0.200000002980232

			if var_529_7 <= arg_526_1.time_ and arg_526_1.time_ < var_529_7 + var_529_8 and not isNil(var_529_6) then
				local var_529_9 = (arg_526_1.time_ - var_529_7) / var_529_8

				if arg_526_1.var_.characterEffect1084ui_story and not isNil(var_529_6) then
					arg_526_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= var_529_7 + var_529_8 and arg_526_1.time_ < var_529_7 + var_529_8 + arg_529_0 and not isNil(var_529_6) and arg_526_1.var_.characterEffect1084ui_story then
				arg_526_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_529_10 = 0
			local var_529_11 = 0.775

			if var_529_10 < arg_526_1.time_ and arg_526_1.time_ <= var_529_10 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_12 = arg_526_1:FormatText(StoryNameCfg[6].name)

				arg_526_1.leftNameTxt_.text = var_529_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_13 = arg_526_1:GetWordFromCfg(319511128)
				local var_529_14 = arg_526_1:FormatText(var_529_13.content)

				arg_526_1.text_.text = var_529_14

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_15 = 31
				local var_529_16 = utf8.len(var_529_14)
				local var_529_17 = var_529_15 <= 0 and var_529_11 or var_529_11 * (var_529_16 / var_529_15)

				if var_529_17 > 0 and var_529_11 < var_529_17 then
					arg_526_1.talkMaxDuration = var_529_17

					if var_529_17 + var_529_10 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_17 + var_529_10
					end
				end

				arg_526_1.text_.text = var_529_14
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511128", "story_v_out_319511.awb") ~= 0 then
					local var_529_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511128", "story_v_out_319511.awb") / 1000

					if var_529_18 + var_529_10 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_18 + var_529_10
					end

					if var_529_13.prefab_name ~= "" and arg_526_1.actors_[var_529_13.prefab_name] ~= nil then
						local var_529_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_13.prefab_name].transform, "story_v_out_319511", "319511128", "story_v_out_319511.awb")

						arg_526_1:RecordAudio("319511128", var_529_19)
						arg_526_1:RecordAudio("319511128", var_529_19)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_319511", "319511128", "story_v_out_319511.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_319511", "319511128", "story_v_out_319511.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_20 = math.max(var_529_11, arg_526_1.talkMaxDuration)

			if var_529_10 <= arg_526_1.time_ and arg_526_1.time_ < var_529_10 + var_529_20 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_10) / var_529_20

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_10 + var_529_20 and arg_526_1.time_ < var_529_10 + var_529_20 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play319511129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 319511129
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play319511130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1084ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1084ui_story == nil then
				arg_530_1.var_.characterEffect1084ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1084ui_story and not isNil(var_533_0) then
					local var_533_4 = Mathf.Lerp(0, 0.5, var_533_3)

					arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1084ui_story.fillRatio = var_533_4
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1084ui_story then
				local var_533_5 = 0.5

				arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1084ui_story.fillRatio = var_533_5
			end

			local var_533_6 = 0
			local var_533_7 = 1.425

			if var_533_6 < arg_530_1.time_ and arg_530_1.time_ <= var_533_6 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_8 = arg_530_1:GetWordFromCfg(319511129)
				local var_533_9 = arg_530_1:FormatText(var_533_8.content)

				arg_530_1.text_.text = var_533_9

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_10 = 57
				local var_533_11 = utf8.len(var_533_9)
				local var_533_12 = var_533_10 <= 0 and var_533_7 or var_533_7 * (var_533_11 / var_533_10)

				if var_533_12 > 0 and var_533_7 < var_533_12 then
					arg_530_1.talkMaxDuration = var_533_12

					if var_533_12 + var_533_6 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_12 + var_533_6
					end
				end

				arg_530_1.text_.text = var_533_9
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_13 = math.max(var_533_7, arg_530_1.talkMaxDuration)

			if var_533_6 <= arg_530_1.time_ and arg_530_1.time_ < var_533_6 + var_533_13 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_6) / var_533_13

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_6 + var_533_13 and arg_530_1.time_ < var_533_6 + var_533_13 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play319511130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 319511130
		arg_534_1.duration_ = 5.9

		local var_534_0 = {
			zh = 4.266,
			ja = 5.9
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play319511131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["10050ui_story"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect10050ui_story == nil then
				arg_534_1.var_.characterEffect10050ui_story = var_537_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.characterEffect10050ui_story and not isNil(var_537_0) then
					arg_534_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.characterEffect10050ui_story then
				arg_534_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_537_4 = 0

			if var_537_4 < arg_534_1.time_ and arg_534_1.time_ <= var_537_4 + arg_537_0 then
				arg_534_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_537_5 = 0
			local var_537_6 = 0.475

			if var_537_5 < arg_534_1.time_ and arg_534_1.time_ <= var_537_5 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_7 = arg_534_1:FormatText(StoryNameCfg[692].name)

				arg_534_1.leftNameTxt_.text = var_537_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_8 = arg_534_1:GetWordFromCfg(319511130)
				local var_537_9 = arg_534_1:FormatText(var_537_8.content)

				arg_534_1.text_.text = var_537_9

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_10 = 19
				local var_537_11 = utf8.len(var_537_9)
				local var_537_12 = var_537_10 <= 0 and var_537_6 or var_537_6 * (var_537_11 / var_537_10)

				if var_537_12 > 0 and var_537_6 < var_537_12 then
					arg_534_1.talkMaxDuration = var_537_12

					if var_537_12 + var_537_5 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_12 + var_537_5
					end
				end

				arg_534_1.text_.text = var_537_9
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511130", "story_v_out_319511.awb") ~= 0 then
					local var_537_13 = manager.audio:GetVoiceLength("story_v_out_319511", "319511130", "story_v_out_319511.awb") / 1000

					if var_537_13 + var_537_5 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_13 + var_537_5
					end

					if var_537_8.prefab_name ~= "" and arg_534_1.actors_[var_537_8.prefab_name] ~= nil then
						local var_537_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_8.prefab_name].transform, "story_v_out_319511", "319511130", "story_v_out_319511.awb")

						arg_534_1:RecordAudio("319511130", var_537_14)
						arg_534_1:RecordAudio("319511130", var_537_14)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_319511", "319511130", "story_v_out_319511.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_319511", "319511130", "story_v_out_319511.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_15 = math.max(var_537_6, arg_534_1.talkMaxDuration)

			if var_537_5 <= arg_534_1.time_ and arg_534_1.time_ < var_537_5 + var_537_15 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_5) / var_537_15

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_5 + var_537_15 and arg_534_1.time_ < var_537_5 + var_537_15 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play319511131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 319511131
		arg_538_1.duration_ = 6.97

		local var_538_0 = {
			zh = 5.4,
			ja = 6.966
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play319511132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1084ui_story"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1084ui_story == nil then
				arg_538_1.var_.characterEffect1084ui_story = var_541_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.characterEffect1084ui_story and not isNil(var_541_0) then
					arg_538_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1084ui_story then
				arg_538_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_541_4 = arg_538_1.actors_["10050ui_story"]
			local var_541_5 = 0

			if var_541_5 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 and not isNil(var_541_4) and arg_538_1.var_.characterEffect10050ui_story == nil then
				arg_538_1.var_.characterEffect10050ui_story = var_541_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_6 = 0.200000002980232

			if var_541_5 <= arg_538_1.time_ and arg_538_1.time_ < var_541_5 + var_541_6 and not isNil(var_541_4) then
				local var_541_7 = (arg_538_1.time_ - var_541_5) / var_541_6

				if arg_538_1.var_.characterEffect10050ui_story and not isNil(var_541_4) then
					local var_541_8 = Mathf.Lerp(0, 0.5, var_541_7)

					arg_538_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_538_1.var_.characterEffect10050ui_story.fillRatio = var_541_8
				end
			end

			if arg_538_1.time_ >= var_541_5 + var_541_6 and arg_538_1.time_ < var_541_5 + var_541_6 + arg_541_0 and not isNil(var_541_4) and arg_538_1.var_.characterEffect10050ui_story then
				local var_541_9 = 0.5

				arg_538_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_538_1.var_.characterEffect10050ui_story.fillRatio = var_541_9
			end

			local var_541_10 = 0
			local var_541_11 = 0.7

			if var_541_10 < arg_538_1.time_ and arg_538_1.time_ <= var_541_10 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_12 = arg_538_1:FormatText(StoryNameCfg[6].name)

				arg_538_1.leftNameTxt_.text = var_541_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_13 = arg_538_1:GetWordFromCfg(319511131)
				local var_541_14 = arg_538_1:FormatText(var_541_13.content)

				arg_538_1.text_.text = var_541_14

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_15 = 28
				local var_541_16 = utf8.len(var_541_14)
				local var_541_17 = var_541_15 <= 0 and var_541_11 or var_541_11 * (var_541_16 / var_541_15)

				if var_541_17 > 0 and var_541_11 < var_541_17 then
					arg_538_1.talkMaxDuration = var_541_17

					if var_541_17 + var_541_10 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_17 + var_541_10
					end
				end

				arg_538_1.text_.text = var_541_14
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511131", "story_v_out_319511.awb") ~= 0 then
					local var_541_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511131", "story_v_out_319511.awb") / 1000

					if var_541_18 + var_541_10 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_18 + var_541_10
					end

					if var_541_13.prefab_name ~= "" and arg_538_1.actors_[var_541_13.prefab_name] ~= nil then
						local var_541_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_13.prefab_name].transform, "story_v_out_319511", "319511131", "story_v_out_319511.awb")

						arg_538_1:RecordAudio("319511131", var_541_19)
						arg_538_1:RecordAudio("319511131", var_541_19)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_319511", "319511131", "story_v_out_319511.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_319511", "319511131", "story_v_out_319511.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_20 = math.max(var_541_11, arg_538_1.talkMaxDuration)

			if var_541_10 <= arg_538_1.time_ and arg_538_1.time_ < var_541_10 + var_541_20 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_10) / var_541_20

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_10 + var_541_20 and arg_538_1.time_ < var_541_10 + var_541_20 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play319511132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 319511132
		arg_542_1.duration_ = 8.17

		local var_542_0 = {
			zh = 3.833,
			ja = 8.166
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play319511133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_545_2 = 0
			local var_545_3 = 0.5

			if var_545_2 < arg_542_1.time_ and arg_542_1.time_ <= var_545_2 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_4 = arg_542_1:FormatText(StoryNameCfg[6].name)

				arg_542_1.leftNameTxt_.text = var_545_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_5 = arg_542_1:GetWordFromCfg(319511132)
				local var_545_6 = arg_542_1:FormatText(var_545_5.content)

				arg_542_1.text_.text = var_545_6

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_7 = 20
				local var_545_8 = utf8.len(var_545_6)
				local var_545_9 = var_545_7 <= 0 and var_545_3 or var_545_3 * (var_545_8 / var_545_7)

				if var_545_9 > 0 and var_545_3 < var_545_9 then
					arg_542_1.talkMaxDuration = var_545_9

					if var_545_9 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_9 + var_545_2
					end
				end

				arg_542_1.text_.text = var_545_6
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511132", "story_v_out_319511.awb") ~= 0 then
					local var_545_10 = manager.audio:GetVoiceLength("story_v_out_319511", "319511132", "story_v_out_319511.awb") / 1000

					if var_545_10 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_10 + var_545_2
					end

					if var_545_5.prefab_name ~= "" and arg_542_1.actors_[var_545_5.prefab_name] ~= nil then
						local var_545_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_5.prefab_name].transform, "story_v_out_319511", "319511132", "story_v_out_319511.awb")

						arg_542_1:RecordAudio("319511132", var_545_11)
						arg_542_1:RecordAudio("319511132", var_545_11)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_319511", "319511132", "story_v_out_319511.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_319511", "319511132", "story_v_out_319511.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_12 = math.max(var_545_3, arg_542_1.talkMaxDuration)

			if var_545_2 <= arg_542_1.time_ and arg_542_1.time_ < var_545_2 + var_545_12 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_2) / var_545_12

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_2 + var_545_12 and arg_542_1.time_ < var_545_2 + var_545_12 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play319511133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 319511133
		arg_546_1.duration_ = 2

		local var_546_0 = {
			zh = 2,
			ja = 1.999999999999
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play319511134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = arg_546_1.actors_["1084ui_story"]
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 and not isNil(var_549_0) and arg_546_1.var_.characterEffect1084ui_story == nil then
				arg_546_1.var_.characterEffect1084ui_story = var_549_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_2 = 0.200000002980232

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_2 and not isNil(var_549_0) then
				local var_549_3 = (arg_546_1.time_ - var_549_1) / var_549_2

				if arg_546_1.var_.characterEffect1084ui_story and not isNil(var_549_0) then
					local var_549_4 = Mathf.Lerp(0, 0.5, var_549_3)

					arg_546_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_546_1.var_.characterEffect1084ui_story.fillRatio = var_549_4
				end
			end

			if arg_546_1.time_ >= var_549_1 + var_549_2 and arg_546_1.time_ < var_549_1 + var_549_2 + arg_549_0 and not isNil(var_549_0) and arg_546_1.var_.characterEffect1084ui_story then
				local var_549_5 = 0.5

				arg_546_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_546_1.var_.characterEffect1084ui_story.fillRatio = var_549_5
			end

			local var_549_6 = arg_546_1.actors_["10050ui_story"]
			local var_549_7 = 0

			if var_549_7 < arg_546_1.time_ and arg_546_1.time_ <= var_549_7 + arg_549_0 and not isNil(var_549_6) and arg_546_1.var_.characterEffect10050ui_story == nil then
				arg_546_1.var_.characterEffect10050ui_story = var_549_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_8 = 0.200000002980232

			if var_549_7 <= arg_546_1.time_ and arg_546_1.time_ < var_549_7 + var_549_8 and not isNil(var_549_6) then
				local var_549_9 = (arg_546_1.time_ - var_549_7) / var_549_8

				if arg_546_1.var_.characterEffect10050ui_story and not isNil(var_549_6) then
					arg_546_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_546_1.time_ >= var_549_7 + var_549_8 and arg_546_1.time_ < var_549_7 + var_549_8 + arg_549_0 and not isNil(var_549_6) and arg_546_1.var_.characterEffect10050ui_story then
				arg_546_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_549_10 = 0

			if var_549_10 < arg_546_1.time_ and arg_546_1.time_ <= var_549_10 + arg_549_0 then
				arg_546_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action6_2")
			end

			local var_549_11 = 0

			if var_549_11 < arg_546_1.time_ and arg_546_1.time_ <= var_549_11 + arg_549_0 then
				arg_546_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_549_12 = 0
			local var_549_13 = 0.125

			if var_549_12 < arg_546_1.time_ and arg_546_1.time_ <= var_549_12 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_14 = arg_546_1:FormatText(StoryNameCfg[692].name)

				arg_546_1.leftNameTxt_.text = var_549_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_15 = arg_546_1:GetWordFromCfg(319511133)
				local var_549_16 = arg_546_1:FormatText(var_549_15.content)

				arg_546_1.text_.text = var_549_16

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_17 = 5
				local var_549_18 = utf8.len(var_549_16)
				local var_549_19 = var_549_17 <= 0 and var_549_13 or var_549_13 * (var_549_18 / var_549_17)

				if var_549_19 > 0 and var_549_13 < var_549_19 then
					arg_546_1.talkMaxDuration = var_549_19

					if var_549_19 + var_549_12 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_19 + var_549_12
					end
				end

				arg_546_1.text_.text = var_549_16
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511133", "story_v_out_319511.awb") ~= 0 then
					local var_549_20 = manager.audio:GetVoiceLength("story_v_out_319511", "319511133", "story_v_out_319511.awb") / 1000

					if var_549_20 + var_549_12 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_20 + var_549_12
					end

					if var_549_15.prefab_name ~= "" and arg_546_1.actors_[var_549_15.prefab_name] ~= nil then
						local var_549_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_15.prefab_name].transform, "story_v_out_319511", "319511133", "story_v_out_319511.awb")

						arg_546_1:RecordAudio("319511133", var_549_21)
						arg_546_1:RecordAudio("319511133", var_549_21)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_319511", "319511133", "story_v_out_319511.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_319511", "319511133", "story_v_out_319511.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_22 = math.max(var_549_13, arg_546_1.talkMaxDuration)

			if var_549_12 <= arg_546_1.time_ and arg_546_1.time_ < var_549_12 + var_549_22 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_12) / var_549_22

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_12 + var_549_22 and arg_546_1.time_ < var_549_12 + var_549_22 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play319511134 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 319511134
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play319511135(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["10050ui_story"]
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect10050ui_story == nil then
				arg_550_1.var_.characterEffect10050ui_story = var_553_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_2 = 0.200000002980232

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 and not isNil(var_553_0) then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2

				if arg_550_1.var_.characterEffect10050ui_story and not isNil(var_553_0) then
					local var_553_4 = Mathf.Lerp(0, 0.5, var_553_3)

					arg_550_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_550_1.var_.characterEffect10050ui_story.fillRatio = var_553_4
				end
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect10050ui_story then
				local var_553_5 = 0.5

				arg_550_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_550_1.var_.characterEffect10050ui_story.fillRatio = var_553_5
			end

			local var_553_6 = 0
			local var_553_7 = 0.575

			if var_553_6 < arg_550_1.time_ and arg_550_1.time_ <= var_553_6 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_8 = arg_550_1:GetWordFromCfg(319511134)
				local var_553_9 = arg_550_1:FormatText(var_553_8.content)

				arg_550_1.text_.text = var_553_9

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_10 = 23
				local var_553_11 = utf8.len(var_553_9)
				local var_553_12 = var_553_10 <= 0 and var_553_7 or var_553_7 * (var_553_11 / var_553_10)

				if var_553_12 > 0 and var_553_7 < var_553_12 then
					arg_550_1.talkMaxDuration = var_553_12

					if var_553_12 + var_553_6 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_12 + var_553_6
					end
				end

				arg_550_1.text_.text = var_553_9
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_13 = math.max(var_553_7, arg_550_1.talkMaxDuration)

			if var_553_6 <= arg_550_1.time_ and arg_550_1.time_ < var_553_6 + var_553_13 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_6) / var_553_13

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_6 + var_553_13 and arg_550_1.time_ < var_553_6 + var_553_13 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play319511135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 319511135
		arg_554_1.duration_ = 11.8

		local var_554_0 = {
			zh = 5.1,
			ja = 11.8
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play319511136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["10050ui_story"]
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.characterEffect10050ui_story == nil then
				arg_554_1.var_.characterEffect10050ui_story = var_557_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 and not isNil(var_557_0) then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2

				if arg_554_1.var_.characterEffect10050ui_story and not isNil(var_557_0) then
					arg_554_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 and not isNil(var_557_0) and arg_554_1.var_.characterEffect10050ui_story then
				arg_554_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_557_4 = 0
			local var_557_5 = 0.425

			if var_557_4 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_6 = arg_554_1:FormatText(StoryNameCfg[692].name)

				arg_554_1.leftNameTxt_.text = var_557_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_7 = arg_554_1:GetWordFromCfg(319511135)
				local var_557_8 = arg_554_1:FormatText(var_557_7.content)

				arg_554_1.text_.text = var_557_8

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_9 = 17
				local var_557_10 = utf8.len(var_557_8)
				local var_557_11 = var_557_9 <= 0 and var_557_5 or var_557_5 * (var_557_10 / var_557_9)

				if var_557_11 > 0 and var_557_5 < var_557_11 then
					arg_554_1.talkMaxDuration = var_557_11

					if var_557_11 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_11 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_8
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511135", "story_v_out_319511.awb") ~= 0 then
					local var_557_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511135", "story_v_out_319511.awb") / 1000

					if var_557_12 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_12 + var_557_4
					end

					if var_557_7.prefab_name ~= "" and arg_554_1.actors_[var_557_7.prefab_name] ~= nil then
						local var_557_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_7.prefab_name].transform, "story_v_out_319511", "319511135", "story_v_out_319511.awb")

						arg_554_1:RecordAudio("319511135", var_557_13)
						arg_554_1:RecordAudio("319511135", var_557_13)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_319511", "319511135", "story_v_out_319511.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_319511", "319511135", "story_v_out_319511.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_14 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_14 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_14

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_14 and arg_554_1.time_ < var_557_4 + var_557_14 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play319511136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 319511136
		arg_558_1.duration_ = 8.5

		local var_558_0 = {
			zh = 4.3,
			ja = 8.5
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play319511137(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.55

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[692].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_3 = arg_558_1:GetWordFromCfg(319511136)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 22
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511136", "story_v_out_319511.awb") ~= 0 then
					local var_561_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511136", "story_v_out_319511.awb") / 1000

					if var_561_8 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_8 + var_561_0
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_out_319511", "319511136", "story_v_out_319511.awb")

						arg_558_1:RecordAudio("319511136", var_561_9)
						arg_558_1:RecordAudio("319511136", var_561_9)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_319511", "319511136", "story_v_out_319511.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_319511", "319511136", "story_v_out_319511.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_10 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_10 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_10

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_10 and arg_558_1.time_ < var_561_0 + var_561_10 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play319511137 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 319511137
		arg_562_1.duration_ = 4.63

		local var_562_0 = {
			zh = 3.7,
			ja = 4.633
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play319511138(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["1084ui_story"]
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.characterEffect1084ui_story == nil then
				arg_562_1.var_.characterEffect1084ui_story = var_565_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_2 = 0.200000002980232

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 and not isNil(var_565_0) then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2

				if arg_562_1.var_.characterEffect1084ui_story and not isNil(var_565_0) then
					arg_562_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 and not isNil(var_565_0) and arg_562_1.var_.characterEffect1084ui_story then
				arg_562_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_565_4 = arg_562_1.actors_["10050ui_story"]
			local var_565_5 = 0

			if var_565_5 < arg_562_1.time_ and arg_562_1.time_ <= var_565_5 + arg_565_0 and not isNil(var_565_4) and arg_562_1.var_.characterEffect10050ui_story == nil then
				arg_562_1.var_.characterEffect10050ui_story = var_565_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_6 = 0.200000002980232

			if var_565_5 <= arg_562_1.time_ and arg_562_1.time_ < var_565_5 + var_565_6 and not isNil(var_565_4) then
				local var_565_7 = (arg_562_1.time_ - var_565_5) / var_565_6

				if arg_562_1.var_.characterEffect10050ui_story and not isNil(var_565_4) then
					local var_565_8 = Mathf.Lerp(0, 0.5, var_565_7)

					arg_562_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_562_1.var_.characterEffect10050ui_story.fillRatio = var_565_8
				end
			end

			if arg_562_1.time_ >= var_565_5 + var_565_6 and arg_562_1.time_ < var_565_5 + var_565_6 + arg_565_0 and not isNil(var_565_4) and arg_562_1.var_.characterEffect10050ui_story then
				local var_565_9 = 0.5

				arg_562_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_562_1.var_.characterEffect10050ui_story.fillRatio = var_565_9
			end

			local var_565_10 = 0

			if var_565_10 < arg_562_1.time_ and arg_562_1.time_ <= var_565_10 + arg_565_0 then
				arg_562_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_565_11 = 0
			local var_565_12 = 0.375

			if var_565_11 < arg_562_1.time_ and arg_562_1.time_ <= var_565_11 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_13 = arg_562_1:FormatText(StoryNameCfg[6].name)

				arg_562_1.leftNameTxt_.text = var_565_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_14 = arg_562_1:GetWordFromCfg(319511137)
				local var_565_15 = arg_562_1:FormatText(var_565_14.content)

				arg_562_1.text_.text = var_565_15

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_16 = 15
				local var_565_17 = utf8.len(var_565_15)
				local var_565_18 = var_565_16 <= 0 and var_565_12 or var_565_12 * (var_565_17 / var_565_16)

				if var_565_18 > 0 and var_565_12 < var_565_18 then
					arg_562_1.talkMaxDuration = var_565_18

					if var_565_18 + var_565_11 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_18 + var_565_11
					end
				end

				arg_562_1.text_.text = var_565_15
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511137", "story_v_out_319511.awb") ~= 0 then
					local var_565_19 = manager.audio:GetVoiceLength("story_v_out_319511", "319511137", "story_v_out_319511.awb") / 1000

					if var_565_19 + var_565_11 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_19 + var_565_11
					end

					if var_565_14.prefab_name ~= "" and arg_562_1.actors_[var_565_14.prefab_name] ~= nil then
						local var_565_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_14.prefab_name].transform, "story_v_out_319511", "319511137", "story_v_out_319511.awb")

						arg_562_1:RecordAudio("319511137", var_565_20)
						arg_562_1:RecordAudio("319511137", var_565_20)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_319511", "319511137", "story_v_out_319511.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_319511", "319511137", "story_v_out_319511.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_21 = math.max(var_565_12, arg_562_1.talkMaxDuration)

			if var_565_11 <= arg_562_1.time_ and arg_562_1.time_ < var_565_11 + var_565_21 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_11) / var_565_21

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_11 + var_565_21 and arg_562_1.time_ < var_565_11 + var_565_21 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play319511138 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 319511138
		arg_566_1.duration_ = 3.97

		local var_566_0 = {
			zh = 1.999999999999,
			ja = 3.966
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play319511139(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["10050ui_story"].transform
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.var_.moveOldPos10050ui_story = var_569_0.localPosition
			end

			local var_569_2 = 0.001

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_2 then
				local var_569_3 = (arg_566_1.time_ - var_569_1) / var_569_2
				local var_569_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_569_0.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos10050ui_story, var_569_4, var_569_3)

				local var_569_5 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_5.x, var_569_5.y, var_569_5.z)

				local var_569_6 = var_569_0.localEulerAngles

				var_569_6.z = 0
				var_569_6.x = 0
				var_569_0.localEulerAngles = var_569_6
			end

			if arg_566_1.time_ >= var_569_1 + var_569_2 and arg_566_1.time_ < var_569_1 + var_569_2 + arg_569_0 then
				var_569_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_569_7 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_7.x, var_569_7.y, var_569_7.z)

				local var_569_8 = var_569_0.localEulerAngles

				var_569_8.z = 0
				var_569_8.x = 0
				var_569_0.localEulerAngles = var_569_8
			end

			local var_569_9 = arg_566_1.actors_["10050ui_story"]
			local var_569_10 = 0

			if var_569_10 < arg_566_1.time_ and arg_566_1.time_ <= var_569_10 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect10050ui_story == nil then
				arg_566_1.var_.characterEffect10050ui_story = var_569_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_11 = 0.200000002980232

			if var_569_10 <= arg_566_1.time_ and arg_566_1.time_ < var_569_10 + var_569_11 and not isNil(var_569_9) then
				local var_569_12 = (arg_566_1.time_ - var_569_10) / var_569_11

				if arg_566_1.var_.characterEffect10050ui_story and not isNil(var_569_9) then
					arg_566_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_10 + var_569_11 and arg_566_1.time_ < var_569_10 + var_569_11 + arg_569_0 and not isNil(var_569_9) and arg_566_1.var_.characterEffect10050ui_story then
				arg_566_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_569_13 = 0

			if var_569_13 < arg_566_1.time_ and arg_566_1.time_ <= var_569_13 + arg_569_0 then
				arg_566_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_569_14 = 0

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_569_15 = arg_566_1.actors_["1084ui_story"]
			local var_569_16 = 0

			if var_569_16 < arg_566_1.time_ and arg_566_1.time_ <= var_569_16 + arg_569_0 and not isNil(var_569_15) and arg_566_1.var_.characterEffect1084ui_story == nil then
				arg_566_1.var_.characterEffect1084ui_story = var_569_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_17 = 0.200000002980232

			if var_569_16 <= arg_566_1.time_ and arg_566_1.time_ < var_569_16 + var_569_17 and not isNil(var_569_15) then
				local var_569_18 = (arg_566_1.time_ - var_569_16) / var_569_17

				if arg_566_1.var_.characterEffect1084ui_story and not isNil(var_569_15) then
					local var_569_19 = Mathf.Lerp(0, 0.5, var_569_18)

					arg_566_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_566_1.var_.characterEffect1084ui_story.fillRatio = var_569_19
				end
			end

			if arg_566_1.time_ >= var_569_16 + var_569_17 and arg_566_1.time_ < var_569_16 + var_569_17 + arg_569_0 and not isNil(var_569_15) and arg_566_1.var_.characterEffect1084ui_story then
				local var_569_20 = 0.5

				arg_566_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_566_1.var_.characterEffect1084ui_story.fillRatio = var_569_20
			end

			local var_569_21 = 0
			local var_569_22 = 0.125

			if var_569_21 < arg_566_1.time_ and arg_566_1.time_ <= var_569_21 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_23 = arg_566_1:FormatText(StoryNameCfg[692].name)

				arg_566_1.leftNameTxt_.text = var_569_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_24 = arg_566_1:GetWordFromCfg(319511138)
				local var_569_25 = arg_566_1:FormatText(var_569_24.content)

				arg_566_1.text_.text = var_569_25

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_26 = 5
				local var_569_27 = utf8.len(var_569_25)
				local var_569_28 = var_569_26 <= 0 and var_569_22 or var_569_22 * (var_569_27 / var_569_26)

				if var_569_28 > 0 and var_569_22 < var_569_28 then
					arg_566_1.talkMaxDuration = var_569_28

					if var_569_28 + var_569_21 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_28 + var_569_21
					end
				end

				arg_566_1.text_.text = var_569_25
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511138", "story_v_out_319511.awb") ~= 0 then
					local var_569_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511138", "story_v_out_319511.awb") / 1000

					if var_569_29 + var_569_21 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_29 + var_569_21
					end

					if var_569_24.prefab_name ~= "" and arg_566_1.actors_[var_569_24.prefab_name] ~= nil then
						local var_569_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_24.prefab_name].transform, "story_v_out_319511", "319511138", "story_v_out_319511.awb")

						arg_566_1:RecordAudio("319511138", var_569_30)
						arg_566_1:RecordAudio("319511138", var_569_30)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_319511", "319511138", "story_v_out_319511.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_319511", "319511138", "story_v_out_319511.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_31 = math.max(var_569_22, arg_566_1.talkMaxDuration)

			if var_569_21 <= arg_566_1.time_ and arg_566_1.time_ < var_569_21 + var_569_31 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_21) / var_569_31

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_21 + var_569_31 and arg_566_1.time_ < var_569_21 + var_569_31 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play319511139 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 319511139
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play319511140(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["10050ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect10050ui_story == nil then
				arg_570_1.var_.characterEffect10050ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect10050ui_story and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_570_1.var_.characterEffect10050ui_story.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect10050ui_story then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_570_1.var_.characterEffect10050ui_story.fillRatio = var_573_5
			end

			local var_573_6 = 0
			local var_573_7 = 1.475

			if var_573_6 < arg_570_1.time_ and arg_570_1.time_ <= var_573_6 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_8 = arg_570_1:GetWordFromCfg(319511139)
				local var_573_9 = arg_570_1:FormatText(var_573_8.content)

				arg_570_1.text_.text = var_573_9

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_10 = 59
				local var_573_11 = utf8.len(var_573_9)
				local var_573_12 = var_573_10 <= 0 and var_573_7 or var_573_7 * (var_573_11 / var_573_10)

				if var_573_12 > 0 and var_573_7 < var_573_12 then
					arg_570_1.talkMaxDuration = var_573_12

					if var_573_12 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_12 + var_573_6
					end
				end

				arg_570_1.text_.text = var_573_9
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_13 = math.max(var_573_7, arg_570_1.talkMaxDuration)

			if var_573_6 <= arg_570_1.time_ and arg_570_1.time_ < var_573_6 + var_573_13 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_6) / var_573_13

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_6 + var_573_13 and arg_570_1.time_ < var_573_6 + var_573_13 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play319511140 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 319511140
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play319511141(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0
			local var_577_1 = 1.2

			if var_577_0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, false)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_2 = arg_574_1:GetWordFromCfg(319511140)
				local var_577_3 = arg_574_1:FormatText(var_577_2.content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_4 = 48
				local var_577_5 = utf8.len(var_577_3)
				local var_577_6 = var_577_4 <= 0 and var_577_1 or var_577_1 * (var_577_5 / var_577_4)

				if var_577_6 > 0 and var_577_1 < var_577_6 then
					arg_574_1.talkMaxDuration = var_577_6

					if var_577_6 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_6 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_7 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_7 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_7

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_7 and arg_574_1.time_ < var_577_0 + var_577_7 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play319511141 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 319511141
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play319511142(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0
			local var_581_1 = 0.675

			if var_581_0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_2 = arg_578_1:GetWordFromCfg(319511141)
				local var_581_3 = arg_578_1:FormatText(var_581_2.content)

				arg_578_1.text_.text = var_581_3

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_4 = 28
				local var_581_5 = utf8.len(var_581_3)
				local var_581_6 = var_581_4 <= 0 and var_581_1 or var_581_1 * (var_581_5 / var_581_4)

				if var_581_6 > 0 and var_581_1 < var_581_6 then
					arg_578_1.talkMaxDuration = var_581_6

					if var_581_6 + var_581_0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_6 + var_581_0
					end
				end

				arg_578_1.text_.text = var_581_3
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_7 = math.max(var_581_1, arg_578_1.talkMaxDuration)

			if var_581_0 <= arg_578_1.time_ and arg_578_1.time_ < var_581_0 + var_581_7 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_0) / var_581_7

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_0 + var_581_7 and arg_578_1.time_ < var_581_0 + var_581_7 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play319511142 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 319511142
		arg_582_1.duration_ = 7.63

		local var_582_0 = {
			zh = 3.033,
			ja = 7.633
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play319511143(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1084ui_story"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1084ui_story == nil then
				arg_582_1.var_.characterEffect1084ui_story = var_585_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_2 = 0.200000002980232

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.characterEffect1084ui_story and not isNil(var_585_0) then
					arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.characterEffect1084ui_story then
				arg_582_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_585_4 = 0
			local var_585_5 = 0.375

			if var_585_4 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_6 = arg_582_1:FormatText(StoryNameCfg[6].name)

				arg_582_1.leftNameTxt_.text = var_585_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_7 = arg_582_1:GetWordFromCfg(319511142)
				local var_585_8 = arg_582_1:FormatText(var_585_7.content)

				arg_582_1.text_.text = var_585_8

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_9 = 15
				local var_585_10 = utf8.len(var_585_8)
				local var_585_11 = var_585_9 <= 0 and var_585_5 or var_585_5 * (var_585_10 / var_585_9)

				if var_585_11 > 0 and var_585_5 < var_585_11 then
					arg_582_1.talkMaxDuration = var_585_11

					if var_585_11 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_11 + var_585_4
					end
				end

				arg_582_1.text_.text = var_585_8
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511142", "story_v_out_319511.awb") ~= 0 then
					local var_585_12 = manager.audio:GetVoiceLength("story_v_out_319511", "319511142", "story_v_out_319511.awb") / 1000

					if var_585_12 + var_585_4 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_12 + var_585_4
					end

					if var_585_7.prefab_name ~= "" and arg_582_1.actors_[var_585_7.prefab_name] ~= nil then
						local var_585_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_7.prefab_name].transform, "story_v_out_319511", "319511142", "story_v_out_319511.awb")

						arg_582_1:RecordAudio("319511142", var_585_13)
						arg_582_1:RecordAudio("319511142", var_585_13)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_319511", "319511142", "story_v_out_319511.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_319511", "319511142", "story_v_out_319511.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_14 = math.max(var_585_5, arg_582_1.talkMaxDuration)

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_14 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_4) / var_585_14

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_4 + var_585_14 and arg_582_1.time_ < var_585_4 + var_585_14 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play319511143 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 319511143
		arg_586_1.duration_ = 9.3

		local var_586_0 = {
			zh = 5.133,
			ja = 9.3
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play319511144(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["10050ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect10050ui_story == nil then
				arg_586_1.var_.characterEffect10050ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.200000002980232

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect10050ui_story and not isNil(var_589_0) then
					arg_586_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect10050ui_story then
				arg_586_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_589_4 = arg_586_1.actors_["1084ui_story"]
			local var_589_5 = 0

			if var_589_5 < arg_586_1.time_ and arg_586_1.time_ <= var_589_5 + arg_589_0 and not isNil(var_589_4) and arg_586_1.var_.characterEffect1084ui_story == nil then
				arg_586_1.var_.characterEffect1084ui_story = var_589_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_6 = 0.200000002980232

			if var_589_5 <= arg_586_1.time_ and arg_586_1.time_ < var_589_5 + var_589_6 and not isNil(var_589_4) then
				local var_589_7 = (arg_586_1.time_ - var_589_5) / var_589_6

				if arg_586_1.var_.characterEffect1084ui_story and not isNil(var_589_4) then
					local var_589_8 = Mathf.Lerp(0, 0.5, var_589_7)

					arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1084ui_story.fillRatio = var_589_8
				end
			end

			if arg_586_1.time_ >= var_589_5 + var_589_6 and arg_586_1.time_ < var_589_5 + var_589_6 + arg_589_0 and not isNil(var_589_4) and arg_586_1.var_.characterEffect1084ui_story then
				local var_589_9 = 0.5

				arg_586_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1084ui_story.fillRatio = var_589_9
			end

			local var_589_10 = 0
			local var_589_11 = 0.475

			if var_589_10 < arg_586_1.time_ and arg_586_1.time_ <= var_589_10 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_12 = arg_586_1:FormatText(StoryNameCfg[692].name)

				arg_586_1.leftNameTxt_.text = var_589_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_13 = arg_586_1:GetWordFromCfg(319511143)
				local var_589_14 = arg_586_1:FormatText(var_589_13.content)

				arg_586_1.text_.text = var_589_14

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_15 = 19
				local var_589_16 = utf8.len(var_589_14)
				local var_589_17 = var_589_15 <= 0 and var_589_11 or var_589_11 * (var_589_16 / var_589_15)

				if var_589_17 > 0 and var_589_11 < var_589_17 then
					arg_586_1.talkMaxDuration = var_589_17

					if var_589_17 + var_589_10 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_17 + var_589_10
					end
				end

				arg_586_1.text_.text = var_589_14
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511143", "story_v_out_319511.awb") ~= 0 then
					local var_589_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511143", "story_v_out_319511.awb") / 1000

					if var_589_18 + var_589_10 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_18 + var_589_10
					end

					if var_589_13.prefab_name ~= "" and arg_586_1.actors_[var_589_13.prefab_name] ~= nil then
						local var_589_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_13.prefab_name].transform, "story_v_out_319511", "319511143", "story_v_out_319511.awb")

						arg_586_1:RecordAudio("319511143", var_589_19)
						arg_586_1:RecordAudio("319511143", var_589_19)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_319511", "319511143", "story_v_out_319511.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_319511", "319511143", "story_v_out_319511.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_20 = math.max(var_589_11, arg_586_1.talkMaxDuration)

			if var_589_10 <= arg_586_1.time_ and arg_586_1.time_ < var_589_10 + var_589_20 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_10) / var_589_20

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_10 + var_589_20 and arg_586_1.time_ < var_589_10 + var_589_20 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play319511144 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 319511144
		arg_590_1.duration_ = 19.37

		local var_590_0 = {
			zh = 10.766,
			ja = 19.366
		}
		local var_590_1 = manager.audio:GetLocalizationFlag()

		if var_590_0[var_590_1] ~= nil then
			arg_590_1.duration_ = var_590_0[var_590_1]
		end

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play319511145(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["10050ui_story"]
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect10050ui_story == nil then
				arg_590_1.var_.characterEffect10050ui_story = var_593_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_2 = 0.200000002980232

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_2 and not isNil(var_593_0) then
				local var_593_3 = (arg_590_1.time_ - var_593_1) / var_593_2

				if arg_590_1.var_.characterEffect10050ui_story and not isNil(var_593_0) then
					arg_590_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_590_1.time_ >= var_593_1 + var_593_2 and arg_590_1.time_ < var_593_1 + var_593_2 + arg_593_0 and not isNil(var_593_0) and arg_590_1.var_.characterEffect10050ui_story then
				arg_590_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_593_4 = arg_590_1.actors_["1084ui_story"]
			local var_593_5 = 0

			if var_593_5 < arg_590_1.time_ and arg_590_1.time_ <= var_593_5 + arg_593_0 and not isNil(var_593_4) and arg_590_1.var_.characterEffect1084ui_story == nil then
				arg_590_1.var_.characterEffect1084ui_story = var_593_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_6 = 0.200000002980232

			if var_593_5 <= arg_590_1.time_ and arg_590_1.time_ < var_593_5 + var_593_6 and not isNil(var_593_4) then
				local var_593_7 = (arg_590_1.time_ - var_593_5) / var_593_6

				if arg_590_1.var_.characterEffect1084ui_story and not isNil(var_593_4) then
					local var_593_8 = Mathf.Lerp(0, 0.5, var_593_7)

					arg_590_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_590_1.var_.characterEffect1084ui_story.fillRatio = var_593_8
				end
			end

			if arg_590_1.time_ >= var_593_5 + var_593_6 and arg_590_1.time_ < var_593_5 + var_593_6 + arg_593_0 and not isNil(var_593_4) and arg_590_1.var_.characterEffect1084ui_story then
				local var_593_9 = 0.5

				arg_590_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_590_1.var_.characterEffect1084ui_story.fillRatio = var_593_9
			end

			local var_593_10 = 0

			if var_593_10 < arg_590_1.time_ and arg_590_1.time_ <= var_593_10 + arg_593_0 then
				arg_590_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_1")
			end

			local var_593_11 = 0

			if var_593_11 < arg_590_1.time_ and arg_590_1.time_ <= var_593_11 + arg_593_0 then
				arg_590_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_593_12 = 0
			local var_593_13 = 1.1

			if var_593_12 < arg_590_1.time_ and arg_590_1.time_ <= var_593_12 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_14 = arg_590_1:FormatText(StoryNameCfg[692].name)

				arg_590_1.leftNameTxt_.text = var_593_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_15 = arg_590_1:GetWordFromCfg(319511144)
				local var_593_16 = arg_590_1:FormatText(var_593_15.content)

				arg_590_1.text_.text = var_593_16

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_17 = 44
				local var_593_18 = utf8.len(var_593_16)
				local var_593_19 = var_593_17 <= 0 and var_593_13 or var_593_13 * (var_593_18 / var_593_17)

				if var_593_19 > 0 and var_593_13 < var_593_19 then
					arg_590_1.talkMaxDuration = var_593_19

					if var_593_19 + var_593_12 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_19 + var_593_12
					end
				end

				arg_590_1.text_.text = var_593_16
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511144", "story_v_out_319511.awb") ~= 0 then
					local var_593_20 = manager.audio:GetVoiceLength("story_v_out_319511", "319511144", "story_v_out_319511.awb") / 1000

					if var_593_20 + var_593_12 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_20 + var_593_12
					end

					if var_593_15.prefab_name ~= "" and arg_590_1.actors_[var_593_15.prefab_name] ~= nil then
						local var_593_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_15.prefab_name].transform, "story_v_out_319511", "319511144", "story_v_out_319511.awb")

						arg_590_1:RecordAudio("319511144", var_593_21)
						arg_590_1:RecordAudio("319511144", var_593_21)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_319511", "319511144", "story_v_out_319511.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_319511", "319511144", "story_v_out_319511.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_22 = math.max(var_593_13, arg_590_1.talkMaxDuration)

			if var_593_12 <= arg_590_1.time_ and arg_590_1.time_ < var_593_12 + var_593_22 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_12) / var_593_22

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_12 + var_593_22 and arg_590_1.time_ < var_593_12 + var_593_22 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play319511145 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 319511145
		arg_594_1.duration_ = 18.3

		local var_594_0 = {
			zh = 8.1,
			ja = 18.3
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play319511146(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["10050ui_story"].transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPos10050ui_story = var_597_0.localPosition
			end

			local var_597_2 = 0.001

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos10050ui_story, var_597_4, var_597_3)

				local var_597_5 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_5.x, var_597_5.y, var_597_5.z)

				local var_597_6 = var_597_0.localEulerAngles

				var_597_6.z = 0
				var_597_6.x = 0
				var_597_0.localEulerAngles = var_597_6
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_597_7 = manager.ui.mainCamera.transform.position - var_597_0.position

				var_597_0.forward = Vector3.New(var_597_7.x, var_597_7.y, var_597_7.z)

				local var_597_8 = var_597_0.localEulerAngles

				var_597_8.z = 0
				var_597_8.x = 0
				var_597_0.localEulerAngles = var_597_8
			end

			local var_597_9 = arg_594_1.actors_["10050ui_story"]
			local var_597_10 = 0

			if var_597_10 < arg_594_1.time_ and arg_594_1.time_ <= var_597_10 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10050ui_story == nil then
				arg_594_1.var_.characterEffect10050ui_story = var_597_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_11 = 0.200000002980232

			if var_597_10 <= arg_594_1.time_ and arg_594_1.time_ < var_597_10 + var_597_11 and not isNil(var_597_9) then
				local var_597_12 = (arg_594_1.time_ - var_597_10) / var_597_11

				if arg_594_1.var_.characterEffect10050ui_story and not isNil(var_597_9) then
					arg_594_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= var_597_10 + var_597_11 and arg_594_1.time_ < var_597_10 + var_597_11 + arg_597_0 and not isNil(var_597_9) and arg_594_1.var_.characterEffect10050ui_story then
				arg_594_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_597_13 = 0

			if var_597_13 < arg_594_1.time_ and arg_594_1.time_ <= var_597_13 + arg_597_0 then
				arg_594_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_2")
			end

			local var_597_14 = 0

			if var_597_14 < arg_594_1.time_ and arg_594_1.time_ <= var_597_14 + arg_597_0 then
				arg_594_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_597_15 = 0
			local var_597_16 = 0.85

			if var_597_15 < arg_594_1.time_ and arg_594_1.time_ <= var_597_15 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_17 = arg_594_1:FormatText(StoryNameCfg[692].name)

				arg_594_1.leftNameTxt_.text = var_597_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_18 = arg_594_1:GetWordFromCfg(319511145)
				local var_597_19 = arg_594_1:FormatText(var_597_18.content)

				arg_594_1.text_.text = var_597_19

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_20 = 34
				local var_597_21 = utf8.len(var_597_19)
				local var_597_22 = var_597_20 <= 0 and var_597_16 or var_597_16 * (var_597_21 / var_597_20)

				if var_597_22 > 0 and var_597_16 < var_597_22 then
					arg_594_1.talkMaxDuration = var_597_22

					if var_597_22 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_22 + var_597_15
					end
				end

				arg_594_1.text_.text = var_597_19
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511145", "story_v_out_319511.awb") ~= 0 then
					local var_597_23 = manager.audio:GetVoiceLength("story_v_out_319511", "319511145", "story_v_out_319511.awb") / 1000

					if var_597_23 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_23 + var_597_15
					end

					if var_597_18.prefab_name ~= "" and arg_594_1.actors_[var_597_18.prefab_name] ~= nil then
						local var_597_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_18.prefab_name].transform, "story_v_out_319511", "319511145", "story_v_out_319511.awb")

						arg_594_1:RecordAudio("319511145", var_597_24)
						arg_594_1:RecordAudio("319511145", var_597_24)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_out_319511", "319511145", "story_v_out_319511.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_out_319511", "319511145", "story_v_out_319511.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_25 = math.max(var_597_16, arg_594_1.talkMaxDuration)

			if var_597_15 <= arg_594_1.time_ and arg_594_1.time_ < var_597_15 + var_597_25 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_15) / var_597_25

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_15 + var_597_25 and arg_594_1.time_ < var_597_15 + var_597_25 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play319511146 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 319511146
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play319511147(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = arg_598_1.actors_["10050ui_story"]
			local var_601_1 = 0

			if var_601_1 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect10050ui_story == nil then
				arg_598_1.var_.characterEffect10050ui_story = var_601_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_2 and not isNil(var_601_0) then
				local var_601_3 = (arg_598_1.time_ - var_601_1) / var_601_2

				if arg_598_1.var_.characterEffect10050ui_story and not isNil(var_601_0) then
					local var_601_4 = Mathf.Lerp(0, 0.5, var_601_3)

					arg_598_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_598_1.var_.characterEffect10050ui_story.fillRatio = var_601_4
				end
			end

			if arg_598_1.time_ >= var_601_1 + var_601_2 and arg_598_1.time_ < var_601_1 + var_601_2 + arg_601_0 and not isNil(var_601_0) and arg_598_1.var_.characterEffect10050ui_story then
				local var_601_5 = 0.5

				arg_598_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_598_1.var_.characterEffect10050ui_story.fillRatio = var_601_5
			end

			local var_601_6 = 0
			local var_601_7 = 0.566666666666667

			if var_601_6 < arg_598_1.time_ and arg_598_1.time_ <= var_601_6 + arg_601_0 then
				local var_601_8 = "play"
				local var_601_9 = "effect"

				arg_598_1:AudioAction(var_601_8, var_601_9, "se_story_130", "se_story_130_didi", "")
			end

			local var_601_10 = 0
			local var_601_11 = 0.925

			if var_601_10 < arg_598_1.time_ and arg_598_1.time_ <= var_601_10 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, false)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_12 = arg_598_1:GetWordFromCfg(319511146)
				local var_601_13 = arg_598_1:FormatText(var_601_12.content)

				arg_598_1.text_.text = var_601_13

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_14 = 37
				local var_601_15 = utf8.len(var_601_13)
				local var_601_16 = var_601_14 <= 0 and var_601_11 or var_601_11 * (var_601_15 / var_601_14)

				if var_601_16 > 0 and var_601_11 < var_601_16 then
					arg_598_1.talkMaxDuration = var_601_16

					if var_601_16 + var_601_10 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_16 + var_601_10
					end
				end

				arg_598_1.text_.text = var_601_13
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_17 = math.max(var_601_11, arg_598_1.talkMaxDuration)

			if var_601_10 <= arg_598_1.time_ and arg_598_1.time_ < var_601_10 + var_601_17 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_10) / var_601_17

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_10 + var_601_17 and arg_598_1.time_ < var_601_10 + var_601_17 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play319511147 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 319511147
		arg_602_1.duration_ = 2.4

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play319511148(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = 0

			if var_605_0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_0 + arg_605_0 then
				local var_605_1 = manager.ui.mainCamera.transform.localPosition
				local var_605_2 = Vector3.New(0, 0, 10) + Vector3.New(var_605_1.x, var_605_1.y, 0)
				local var_605_3 = arg_602_1.bgs_.STblack

				var_605_3.transform.localPosition = var_605_2
				var_605_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_605_4 = var_605_3:GetComponent("SpriteRenderer")

				if var_605_4 and var_605_4.sprite then
					local var_605_5 = (var_605_3.transform.localPosition - var_605_1).z
					local var_605_6 = manager.ui.mainCameraCom_
					local var_605_7 = 2 * var_605_5 * Mathf.Tan(var_605_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_605_8 = var_605_7 * var_605_6.aspect
					local var_605_9 = var_605_4.sprite.bounds.size.x
					local var_605_10 = var_605_4.sprite.bounds.size.y
					local var_605_11 = var_605_8 / var_605_9
					local var_605_12 = var_605_7 / var_605_10
					local var_605_13 = var_605_12 < var_605_11 and var_605_11 or var_605_12

					var_605_3.transform.localScale = Vector3.New(var_605_13, var_605_13, 0)
				end

				for iter_605_0, iter_605_1 in pairs(arg_602_1.bgs_) do
					if iter_605_0 ~= "STblack" then
						iter_605_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_605_14 = 0

			if var_605_14 < arg_602_1.time_ and arg_602_1.time_ <= var_605_14 + arg_605_0 then
				local var_605_15 = arg_602_1.fswbg_.transform:Find("textbox/adapt/content") or arg_602_1.fswbg_.transform:Find("textbox/content")
				local var_605_16 = arg_602_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_605_17 = var_605_15:GetComponent("Text")
				local var_605_18 = var_605_15:GetComponent("RectTransform")

				var_605_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_605_18.offsetMin = Vector2.New(0, 0)
				var_605_18.offsetMax = Vector2.New(0, 0)
			end

			local var_605_19 = 0

			if var_605_19 < arg_602_1.time_ and arg_602_1.time_ <= var_605_19 + arg_605_0 then
				arg_602_1.fswbg_:SetActive(true)
				arg_602_1.dialog_:SetActive(false)

				arg_602_1.fswtw_.percent = 0

				local var_605_20 = arg_602_1:GetWordFromCfg(319511147)
				local var_605_21 = arg_602_1:FormatText(var_605_20.content)

				arg_602_1.fswt_.text = var_605_21

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.fswt_)

				arg_602_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_602_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_602_1.fswtw_:SetDirty()

				arg_602_1.typewritterCharCountI18N = 0

				SetActive(arg_602_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_602_1:ShowNextGo(false)
			end

			local var_605_22 = 0.4

			if var_605_22 < arg_602_1.time_ and arg_602_1.time_ <= var_605_22 + arg_605_0 then
				arg_602_1.var_.oldValueTypewriter = arg_602_1.fswtw_.percent

				SetActive(arg_602_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_602_1:ShowNextGo(false)
			end

			local var_605_23 = 9
			local var_605_24 = 0.6
			local var_605_25 = arg_602_1:GetWordFromCfg(319511147)
			local var_605_26 = arg_602_1:FormatText(var_605_25.content)
			local var_605_27, var_605_28 = arg_602_1:GetPercentByPara(var_605_26, 1)

			if var_605_22 < arg_602_1.time_ and arg_602_1.time_ <= var_605_22 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0

				local var_605_29 = var_605_23 <= 0 and var_605_24 or var_605_24 * ((var_605_28 - arg_602_1.typewritterCharCountI18N) / var_605_23)

				if var_605_29 > 0 and var_605_24 < var_605_29 then
					arg_602_1.talkMaxDuration = var_605_29

					if var_605_29 + var_605_22 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_29 + var_605_22
					end
				end
			end

			local var_605_30 = 0.6
			local var_605_31 = math.max(var_605_30, arg_602_1.talkMaxDuration)

			if var_605_22 <= arg_602_1.time_ and arg_602_1.time_ < var_605_22 + var_605_31 then
				local var_605_32 = (arg_602_1.time_ - var_605_22) / var_605_31

				arg_602_1.fswtw_.percent = Mathf.Lerp(arg_602_1.var_.oldValueTypewriter, var_605_27, var_605_32)
				arg_602_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_602_1.fswtw_:SetDirty()
			end

			if arg_602_1.time_ >= var_605_22 + var_605_31 and arg_602_1.time_ < var_605_22 + var_605_31 + arg_605_0 then
				arg_602_1.fswtw_.percent = var_605_27

				arg_602_1.fswtw_:SetDirty()
				arg_602_1:ShowNextGo(true)

				arg_602_1.typewritterCharCountI18N = var_605_28
			end

			local var_605_33 = 0

			if var_605_33 < arg_602_1.time_ and arg_602_1.time_ <= var_605_33 + arg_605_0 then
				arg_602_1.cswbg_:SetActive(true)

				local var_605_34 = arg_602_1.cswt_:GetComponent("RectTransform")

				arg_602_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_605_34.offsetMin = Vector2.New(410, 330)
				var_605_34.offsetMax = Vector2.New(-400, -175)

				local var_605_35 = arg_602_1:GetWordFromCfg(419027)
				local var_605_36 = arg_602_1:FormatText(var_605_35.content)

				arg_602_1.cswt_.text = var_605_36

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.cswt_)

				arg_602_1.cswt_.fontSize = 180
				arg_602_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_602_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_602_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_605_37 = arg_602_1.actors_["10050ui_story"].transform
			local var_605_38 = 0

			if var_605_38 < arg_602_1.time_ and arg_602_1.time_ <= var_605_38 + arg_605_0 then
				arg_602_1.var_.moveOldPos10050ui_story = var_605_37.localPosition
			end

			local var_605_39 = 0.001

			if var_605_38 <= arg_602_1.time_ and arg_602_1.time_ < var_605_38 + var_605_39 then
				local var_605_40 = (arg_602_1.time_ - var_605_38) / var_605_39
				local var_605_41 = Vector3.New(0, 100, 0)

				var_605_37.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos10050ui_story, var_605_41, var_605_40)

				local var_605_42 = manager.ui.mainCamera.transform.position - var_605_37.position

				var_605_37.forward = Vector3.New(var_605_42.x, var_605_42.y, var_605_42.z)

				local var_605_43 = var_605_37.localEulerAngles

				var_605_43.z = 0
				var_605_43.x = 0
				var_605_37.localEulerAngles = var_605_43
			end

			if arg_602_1.time_ >= var_605_38 + var_605_39 and arg_602_1.time_ < var_605_38 + var_605_39 + arg_605_0 then
				var_605_37.localPosition = Vector3.New(0, 100, 0)

				local var_605_44 = manager.ui.mainCamera.transform.position - var_605_37.position

				var_605_37.forward = Vector3.New(var_605_44.x, var_605_44.y, var_605_44.z)

				local var_605_45 = var_605_37.localEulerAngles

				var_605_45.z = 0
				var_605_45.x = 0
				var_605_37.localEulerAngles = var_605_45
			end

			local var_605_46 = arg_602_1.actors_["1084ui_story"].transform
			local var_605_47 = 0

			if var_605_47 < arg_602_1.time_ and arg_602_1.time_ <= var_605_47 + arg_605_0 then
				arg_602_1.var_.moveOldPos1084ui_story = var_605_46.localPosition
			end

			local var_605_48 = 0.001

			if var_605_47 <= arg_602_1.time_ and arg_602_1.time_ < var_605_47 + var_605_48 then
				local var_605_49 = (arg_602_1.time_ - var_605_47) / var_605_48
				local var_605_50 = Vector3.New(0, 100, 0)

				var_605_46.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1084ui_story, var_605_50, var_605_49)

				local var_605_51 = manager.ui.mainCamera.transform.position - var_605_46.position

				var_605_46.forward = Vector3.New(var_605_51.x, var_605_51.y, var_605_51.z)

				local var_605_52 = var_605_46.localEulerAngles

				var_605_52.z = 0
				var_605_52.x = 0
				var_605_46.localEulerAngles = var_605_52
			end

			if arg_602_1.time_ >= var_605_47 + var_605_48 and arg_602_1.time_ < var_605_47 + var_605_48 + arg_605_0 then
				var_605_46.localPosition = Vector3.New(0, 100, 0)

				local var_605_53 = manager.ui.mainCamera.transform.position - var_605_46.position

				var_605_46.forward = Vector3.New(var_605_53.x, var_605_53.y, var_605_53.z)

				local var_605_54 = var_605_46.localEulerAngles

				var_605_54.z = 0
				var_605_54.x = 0
				var_605_46.localEulerAngles = var_605_54
			end

			local var_605_55 = 0.4
			local var_605_56 = 2
			local var_605_57 = manager.audio:GetVoiceLength("story_v_out_319511", "319511147", "story_v_out_319511.awb") / 1000

			if var_605_57 > 0 and var_605_56 < var_605_57 and var_605_57 + var_605_55 > arg_602_1.duration_ then
				local var_605_58 = var_605_57

				arg_602_1.duration_ = var_605_57 + var_605_55
			end

			if var_605_55 < arg_602_1.time_ and arg_602_1.time_ <= var_605_55 + arg_605_0 then
				local var_605_59 = "play"
				local var_605_60 = "voice"

				arg_602_1:AudioAction(var_605_59, var_605_60, "story_v_out_319511", "319511147", "story_v_out_319511.awb")
			end

			local var_605_61 = 0
			local var_605_62 = 0.566666666666667

			if var_605_61 < arg_602_1.time_ and arg_602_1.time_ <= var_605_61 + arg_605_0 then
				local var_605_63 = "stop"
				local var_605_64 = "effect"

				arg_602_1:AudioAction(var_605_63, var_605_64, "se_story_130", "se_story_130_didi", "")
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play319511148 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 319511148
		arg_606_1.duration_ = 2

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play319511149(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 0

			if var_609_0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_0 + arg_609_0 then
				arg_606_1.fswbg_:SetActive(true)
				arg_606_1.dialog_:SetActive(false)

				arg_606_1.fswtw_.percent = 0

				local var_609_1 = arg_606_1:GetWordFromCfg(319511148)
				local var_609_2 = arg_606_1:FormatText(var_609_1.content)

				arg_606_1.fswt_.text = var_609_2

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.fswt_)

				arg_606_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_606_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_606_1.fswtw_:SetDirty()

				arg_606_1.typewritterCharCountI18N = 0

				SetActive(arg_606_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_606_1:ShowNextGo(false)
			end

			local var_609_3 = 0.2

			if var_609_3 < arg_606_1.time_ and arg_606_1.time_ <= var_609_3 + arg_609_0 then
				arg_606_1.var_.oldValueTypewriter = arg_606_1.fswtw_.percent

				SetActive(arg_606_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_606_1:ShowNextGo(false)
			end

			local var_609_4 = 26
			local var_609_5 = 1.8
			local var_609_6 = arg_606_1:GetWordFromCfg(319511148)
			local var_609_7 = arg_606_1:FormatText(var_609_6.content)
			local var_609_8, var_609_9 = arg_606_1:GetPercentByPara(var_609_7, 1)

			if var_609_3 < arg_606_1.time_ and arg_606_1.time_ <= var_609_3 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0

				local var_609_10 = var_609_4 <= 0 and var_609_5 or var_609_5 * ((var_609_9 - arg_606_1.typewritterCharCountI18N) / var_609_4)

				if var_609_10 > 0 and var_609_5 < var_609_10 then
					arg_606_1.talkMaxDuration = var_609_10

					if var_609_10 + var_609_3 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_10 + var_609_3
					end
				end
			end

			local var_609_11 = 1.8
			local var_609_12 = math.max(var_609_11, arg_606_1.talkMaxDuration)

			if var_609_3 <= arg_606_1.time_ and arg_606_1.time_ < var_609_3 + var_609_12 then
				local var_609_13 = (arg_606_1.time_ - var_609_3) / var_609_12

				arg_606_1.fswtw_.percent = Mathf.Lerp(arg_606_1.var_.oldValueTypewriter, var_609_8, var_609_13)
				arg_606_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_606_1.fswtw_:SetDirty()
			end

			if arg_606_1.time_ >= var_609_3 + var_609_12 and arg_606_1.time_ < var_609_3 + var_609_12 + arg_609_0 then
				arg_606_1.fswtw_.percent = var_609_8

				arg_606_1.fswtw_:SetDirty()
				arg_606_1:ShowNextGo(true)

				arg_606_1.typewritterCharCountI18N = var_609_9
			end

			local var_609_14 = 0.2
			local var_609_15 = 0.266666666666667
			local var_609_16 = manager.audio:GetVoiceLength("story_v_out_319511", "319511148", "story_v_out_319511.awb") / 1000

			if var_609_16 > 0 and var_609_15 < var_609_16 and var_609_16 + var_609_14 > arg_606_1.duration_ then
				local var_609_17 = var_609_16

				arg_606_1.duration_ = var_609_16 + var_609_14
			end

			if var_609_14 < arg_606_1.time_ and arg_606_1.time_ <= var_609_14 + arg_609_0 then
				local var_609_18 = "play"
				local var_609_19 = "voice"

				arg_606_1:AudioAction(var_609_18, var_609_19, "story_v_out_319511", "319511148", "story_v_out_319511.awb")
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play319511149 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 319511149
		arg_610_1.duration_ = 1

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play319511150(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = 0

			if var_613_0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_0 + arg_613_0 then
				arg_610_1.fswbg_:SetActive(true)
				arg_610_1.dialog_:SetActive(false)

				arg_610_1.fswtw_.percent = 0

				local var_613_1 = arg_610_1:GetWordFromCfg(319511149)
				local var_613_2 = arg_610_1:FormatText(var_613_1.content)

				arg_610_1.fswt_.text = var_613_2

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.fswt_)

				arg_610_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_610_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_610_1.fswtw_:SetDirty()

				arg_610_1.typewritterCharCountI18N = 0

				SetActive(arg_610_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_610_1:ShowNextGo(false)
			end

			local var_613_3 = 0.2

			if var_613_3 < arg_610_1.time_ and arg_610_1.time_ <= var_613_3 + arg_613_0 then
				arg_610_1.var_.oldValueTypewriter = arg_610_1.fswtw_.percent

				SetActive(arg_610_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_610_1:ShowNextGo(false)
			end

			local var_613_4 = 5
			local var_613_5 = 0.333333333333333
			local var_613_6 = arg_610_1:GetWordFromCfg(319511149)
			local var_613_7 = arg_610_1:FormatText(var_613_6.content)
			local var_613_8, var_613_9 = arg_610_1:GetPercentByPara(var_613_7, 1)

			if var_613_3 < arg_610_1.time_ and arg_610_1.time_ <= var_613_3 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0

				local var_613_10 = var_613_4 <= 0 and var_613_5 or var_613_5 * ((var_613_9 - arg_610_1.typewritterCharCountI18N) / var_613_4)

				if var_613_10 > 0 and var_613_5 < var_613_10 then
					arg_610_1.talkMaxDuration = var_613_10

					if var_613_10 + var_613_3 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_10 + var_613_3
					end
				end
			end

			local var_613_11 = 0.333333333333333
			local var_613_12 = math.max(var_613_11, arg_610_1.talkMaxDuration)

			if var_613_3 <= arg_610_1.time_ and arg_610_1.time_ < var_613_3 + var_613_12 then
				local var_613_13 = (arg_610_1.time_ - var_613_3) / var_613_12

				arg_610_1.fswtw_.percent = Mathf.Lerp(arg_610_1.var_.oldValueTypewriter, var_613_8, var_613_13)
				arg_610_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_610_1.fswtw_:SetDirty()
			end

			if arg_610_1.time_ >= var_613_3 + var_613_12 and arg_610_1.time_ < var_613_3 + var_613_12 + arg_613_0 then
				arg_610_1.fswtw_.percent = var_613_8

				arg_610_1.fswtw_:SetDirty()
				arg_610_1:ShowNextGo(true)

				arg_610_1.typewritterCharCountI18N = var_613_9
			end

			local var_613_14 = 0.2
			local var_613_15 = 0.266666666666667
			local var_613_16 = manager.audio:GetVoiceLength("story_v_out_319511", "319511149", "story_v_out_319511.awb") / 1000

			if var_613_16 > 0 and var_613_15 < var_613_16 and var_613_16 + var_613_14 > arg_610_1.duration_ then
				local var_613_17 = var_613_16

				arg_610_1.duration_ = var_613_16 + var_613_14
			end

			if var_613_14 < arg_610_1.time_ and arg_610_1.time_ <= var_613_14 + arg_613_0 then
				local var_613_18 = "play"
				local var_613_19 = "voice"

				arg_610_1:AudioAction(var_613_18, var_613_19, "story_v_out_319511", "319511149", "story_v_out_319511.awb")
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play319511150 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 319511150
		arg_614_1.duration_ = 10

		local var_614_0 = {
			zh = 6,
			ja = 10
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play319511151(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0

			if var_617_0 < arg_614_1.time_ and arg_614_1.time_ <= var_617_0 + arg_617_0 then
				local var_617_1 = manager.ui.mainCamera.transform.localPosition
				local var_617_2 = Vector3.New(0, 0, 10) + Vector3.New(var_617_1.x, var_617_1.y, 0)
				local var_617_3 = arg_614_1.bgs_.ST71

				var_617_3.transform.localPosition = var_617_2
				var_617_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_617_4 = var_617_3:GetComponent("SpriteRenderer")

				if var_617_4 and var_617_4.sprite then
					local var_617_5 = (var_617_3.transform.localPosition - var_617_1).z
					local var_617_6 = manager.ui.mainCameraCom_
					local var_617_7 = 2 * var_617_5 * Mathf.Tan(var_617_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_617_8 = var_617_7 * var_617_6.aspect
					local var_617_9 = var_617_4.sprite.bounds.size.x
					local var_617_10 = var_617_4.sprite.bounds.size.y
					local var_617_11 = var_617_8 / var_617_9
					local var_617_12 = var_617_7 / var_617_10
					local var_617_13 = var_617_12 < var_617_11 and var_617_11 or var_617_12

					var_617_3.transform.localScale = Vector3.New(var_617_13, var_617_13, 0)
				end

				for iter_617_0, iter_617_1 in pairs(arg_614_1.bgs_) do
					if iter_617_0 ~= "ST71" then
						iter_617_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_617_14 = arg_614_1.actors_["1084ui_story"].transform
			local var_617_15 = 1

			if var_617_15 < arg_614_1.time_ and arg_614_1.time_ <= var_617_15 + arg_617_0 then
				arg_614_1.var_.moveOldPos1084ui_story = var_617_14.localPosition
			end

			local var_617_16 = 0.001

			if var_617_15 <= arg_614_1.time_ and arg_614_1.time_ < var_617_15 + var_617_16 then
				local var_617_17 = (arg_614_1.time_ - var_617_15) / var_617_16
				local var_617_18 = Vector3.New(0.7, -0.97, -6)

				var_617_14.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1084ui_story, var_617_18, var_617_17)

				local var_617_19 = manager.ui.mainCamera.transform.position - var_617_14.position

				var_617_14.forward = Vector3.New(var_617_19.x, var_617_19.y, var_617_19.z)

				local var_617_20 = var_617_14.localEulerAngles

				var_617_20.z = 0
				var_617_20.x = 0
				var_617_14.localEulerAngles = var_617_20
			end

			if arg_614_1.time_ >= var_617_15 + var_617_16 and arg_614_1.time_ < var_617_15 + var_617_16 + arg_617_0 then
				var_617_14.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_617_21 = manager.ui.mainCamera.transform.position - var_617_14.position

				var_617_14.forward = Vector3.New(var_617_21.x, var_617_21.y, var_617_21.z)

				local var_617_22 = var_617_14.localEulerAngles

				var_617_22.z = 0
				var_617_22.x = 0
				var_617_14.localEulerAngles = var_617_22
			end

			local var_617_23 = arg_614_1.actors_["1084ui_story"]
			local var_617_24 = 1

			if var_617_24 < arg_614_1.time_ and arg_614_1.time_ <= var_617_24 + arg_617_0 and not isNil(var_617_23) and arg_614_1.var_.characterEffect1084ui_story == nil then
				arg_614_1.var_.characterEffect1084ui_story = var_617_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_25 = 0.200000002980232

			if var_617_24 <= arg_614_1.time_ and arg_614_1.time_ < var_617_24 + var_617_25 and not isNil(var_617_23) then
				local var_617_26 = (arg_614_1.time_ - var_617_24) / var_617_25

				if arg_614_1.var_.characterEffect1084ui_story and not isNil(var_617_23) then
					arg_614_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_614_1.time_ >= var_617_24 + var_617_25 and arg_614_1.time_ < var_617_24 + var_617_25 + arg_617_0 and not isNil(var_617_23) and arg_614_1.var_.characterEffect1084ui_story then
				arg_614_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_617_27 = 1

			if var_617_27 < arg_614_1.time_ and arg_614_1.time_ <= var_617_27 + arg_617_0 then
				arg_614_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_617_28 = 1

			if var_617_28 < arg_614_1.time_ and arg_614_1.time_ <= var_617_28 + arg_617_0 then
				arg_614_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_617_29 = arg_614_1.actors_["10050ui_story"]
			local var_617_30 = 1

			if var_617_30 < arg_614_1.time_ and arg_614_1.time_ <= var_617_30 + arg_617_0 and not isNil(var_617_29) and arg_614_1.var_.characterEffect10050ui_story == nil then
				arg_614_1.var_.characterEffect10050ui_story = var_617_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_617_31 = 0.200000002980232

			if var_617_30 <= arg_614_1.time_ and arg_614_1.time_ < var_617_30 + var_617_31 and not isNil(var_617_29) then
				local var_617_32 = (arg_614_1.time_ - var_617_30) / var_617_31

				if arg_614_1.var_.characterEffect10050ui_story and not isNil(var_617_29) then
					local var_617_33 = Mathf.Lerp(0, 0.5, var_617_32)

					arg_614_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_614_1.var_.characterEffect10050ui_story.fillRatio = var_617_33
				end
			end

			if arg_614_1.time_ >= var_617_30 + var_617_31 and arg_614_1.time_ < var_617_30 + var_617_31 + arg_617_0 and not isNil(var_617_29) and arg_614_1.var_.characterEffect10050ui_story then
				local var_617_34 = 0.5

				arg_614_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_614_1.var_.characterEffect10050ui_story.fillRatio = var_617_34
			end

			local var_617_35 = 0

			if var_617_35 < arg_614_1.time_ and arg_614_1.time_ <= var_617_35 + arg_617_0 then
				arg_614_1.fswbg_:SetActive(false)
				arg_614_1.dialog_:SetActive(false)
				SetActive(arg_614_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_614_1:ShowNextGo(false)
			end

			local var_617_36 = 0

			if var_617_36 < arg_614_1.time_ and arg_614_1.time_ <= var_617_36 + arg_617_0 then
				arg_614_1.cswbg_:SetActive(false)
			end

			local var_617_37 = arg_614_1.actors_["10050ui_story"].transform
			local var_617_38 = 1

			if var_617_38 < arg_614_1.time_ and arg_614_1.time_ <= var_617_38 + arg_617_0 then
				arg_614_1.var_.moveOldPos10050ui_story = var_617_37.localPosition
			end

			local var_617_39 = 0.001

			if var_617_38 <= arg_614_1.time_ and arg_614_1.time_ < var_617_38 + var_617_39 then
				local var_617_40 = (arg_614_1.time_ - var_617_38) / var_617_39
				local var_617_41 = Vector3.New(-0.7, -0.715, -6.15)

				var_617_37.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos10050ui_story, var_617_41, var_617_40)

				local var_617_42 = manager.ui.mainCamera.transform.position - var_617_37.position

				var_617_37.forward = Vector3.New(var_617_42.x, var_617_42.y, var_617_42.z)

				local var_617_43 = var_617_37.localEulerAngles

				var_617_43.z = 0
				var_617_43.x = 0
				var_617_37.localEulerAngles = var_617_43
			end

			if arg_614_1.time_ >= var_617_38 + var_617_39 and arg_614_1.time_ < var_617_38 + var_617_39 + arg_617_0 then
				var_617_37.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_617_44 = manager.ui.mainCamera.transform.position - var_617_37.position

				var_617_37.forward = Vector3.New(var_617_44.x, var_617_44.y, var_617_44.z)

				local var_617_45 = var_617_37.localEulerAngles

				var_617_45.z = 0
				var_617_45.x = 0
				var_617_37.localEulerAngles = var_617_45
			end

			local var_617_46 = 1

			if var_617_46 < arg_614_1.time_ and arg_614_1.time_ <= var_617_46 + arg_617_0 then
				arg_614_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if arg_614_1.frameCnt_ <= 1 then
				arg_614_1.dialog_:SetActive(false)
			end

			local var_617_47 = 1
			local var_617_48 = 0.625

			if var_617_47 < arg_614_1.time_ and arg_614_1.time_ <= var_617_47 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0

				arg_614_1.dialog_:SetActive(true)

				arg_614_1.dialogCg_.alpha = 0

				local var_617_49 = LeanTween.value(arg_614_1.dialog_, 0, 1, 0.3)

				var_617_49:setOnUpdate(LuaHelper.FloatAction(function(arg_618_0)
					arg_614_1.dialogCg_.alpha = arg_618_0
				end))
				var_617_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_614_1.dialog_)
					var_617_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_614_1.duration_ = arg_614_1.duration_ + 0.3

				SetActive(arg_614_1.leftNameGo_, true)

				local var_617_50 = arg_614_1:FormatText(StoryNameCfg[6].name)

				arg_614_1.leftNameTxt_.text = var_617_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_51 = arg_614_1:GetWordFromCfg(319511150)
				local var_617_52 = arg_614_1:FormatText(var_617_51.content)

				arg_614_1.text_.text = var_617_52

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_53 = 25
				local var_617_54 = utf8.len(var_617_52)
				local var_617_55 = var_617_53 <= 0 and var_617_48 or var_617_48 * (var_617_54 / var_617_53)

				if var_617_55 > 0 and var_617_48 < var_617_55 then
					arg_614_1.talkMaxDuration = var_617_55
					var_617_47 = var_617_47 + 0.3

					if var_617_55 + var_617_47 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_55 + var_617_47
					end
				end

				arg_614_1.text_.text = var_617_52
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511150", "story_v_out_319511.awb") ~= 0 then
					local var_617_56 = manager.audio:GetVoiceLength("story_v_out_319511", "319511150", "story_v_out_319511.awb") / 1000

					if var_617_56 + var_617_47 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_56 + var_617_47
					end

					if var_617_51.prefab_name ~= "" and arg_614_1.actors_[var_617_51.prefab_name] ~= nil then
						local var_617_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_51.prefab_name].transform, "story_v_out_319511", "319511150", "story_v_out_319511.awb")

						arg_614_1:RecordAudio("319511150", var_617_57)
						arg_614_1:RecordAudio("319511150", var_617_57)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_out_319511", "319511150", "story_v_out_319511.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_out_319511", "319511150", "story_v_out_319511.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_58 = var_617_47 + 0.3
			local var_617_59 = math.max(var_617_48, arg_614_1.talkMaxDuration)

			if var_617_58 <= arg_614_1.time_ and arg_614_1.time_ < var_617_58 + var_617_59 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_58) / var_617_59

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_58 + var_617_59 and arg_614_1.time_ < var_617_58 + var_617_59 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play319511151 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 319511151
		arg_620_1.duration_ = 14.5

		local var_620_0 = {
			zh = 8.866,
			ja = 14.5
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play319511152(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_623_1 = 0

			if var_623_1 < arg_620_1.time_ and arg_620_1.time_ <= var_623_1 + arg_623_0 then
				arg_620_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_623_2 = 0
			local var_623_3 = 1.125

			if var_623_2 < arg_620_1.time_ and arg_620_1.time_ <= var_623_2 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_4 = arg_620_1:FormatText(StoryNameCfg[6].name)

				arg_620_1.leftNameTxt_.text = var_623_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_5 = arg_620_1:GetWordFromCfg(319511151)
				local var_623_6 = arg_620_1:FormatText(var_623_5.content)

				arg_620_1.text_.text = var_623_6

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_7 = 45
				local var_623_8 = utf8.len(var_623_6)
				local var_623_9 = var_623_7 <= 0 and var_623_3 or var_623_3 * (var_623_8 / var_623_7)

				if var_623_9 > 0 and var_623_3 < var_623_9 then
					arg_620_1.talkMaxDuration = var_623_9

					if var_623_9 + var_623_2 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_9 + var_623_2
					end
				end

				arg_620_1.text_.text = var_623_6
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511151", "story_v_out_319511.awb") ~= 0 then
					local var_623_10 = manager.audio:GetVoiceLength("story_v_out_319511", "319511151", "story_v_out_319511.awb") / 1000

					if var_623_10 + var_623_2 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_10 + var_623_2
					end

					if var_623_5.prefab_name ~= "" and arg_620_1.actors_[var_623_5.prefab_name] ~= nil then
						local var_623_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_5.prefab_name].transform, "story_v_out_319511", "319511151", "story_v_out_319511.awb")

						arg_620_1:RecordAudio("319511151", var_623_11)
						arg_620_1:RecordAudio("319511151", var_623_11)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_319511", "319511151", "story_v_out_319511.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_319511", "319511151", "story_v_out_319511.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_12 = math.max(var_623_3, arg_620_1.talkMaxDuration)

			if var_623_2 <= arg_620_1.time_ and arg_620_1.time_ < var_623_2 + var_623_12 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_2) / var_623_12

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_2 + var_623_12 and arg_620_1.time_ < var_623_2 + var_623_12 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play319511152 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 319511152
		arg_624_1.duration_ = 6.9

		local var_624_0 = {
			zh = 5.1,
			ja = 6.9
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play319511153(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.7

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[6].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_3 = arg_624_1:GetWordFromCfg(319511152)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 28
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511152", "story_v_out_319511.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511152", "story_v_out_319511.awb") / 1000

					if var_627_8 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_0
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_out_319511", "319511152", "story_v_out_319511.awb")

						arg_624_1:RecordAudio("319511152", var_627_9)
						arg_624_1:RecordAudio("319511152", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_319511", "319511152", "story_v_out_319511.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_319511", "319511152", "story_v_out_319511.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_10 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_10 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_10

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_10 and arg_624_1.time_ < var_627_0 + var_627_10 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play319511153 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 319511153
		arg_628_1.duration_ = 9.03

		local var_628_0 = {
			zh = 7.266,
			ja = 9.033
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play319511154(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 0

			if var_631_0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_0 + arg_631_0 then
				arg_628_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_631_2 = 0
			local var_631_3 = 1.1

			if var_631_2 < arg_628_1.time_ and arg_628_1.time_ <= var_631_2 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_4 = arg_628_1:FormatText(StoryNameCfg[6].name)

				arg_628_1.leftNameTxt_.text = var_631_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_5 = arg_628_1:GetWordFromCfg(319511153)
				local var_631_6 = arg_628_1:FormatText(var_631_5.content)

				arg_628_1.text_.text = var_631_6

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_7 = 44
				local var_631_8 = utf8.len(var_631_6)
				local var_631_9 = var_631_7 <= 0 and var_631_3 or var_631_3 * (var_631_8 / var_631_7)

				if var_631_9 > 0 and var_631_3 < var_631_9 then
					arg_628_1.talkMaxDuration = var_631_9

					if var_631_9 + var_631_2 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_9 + var_631_2
					end
				end

				arg_628_1.text_.text = var_631_6
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511153", "story_v_out_319511.awb") ~= 0 then
					local var_631_10 = manager.audio:GetVoiceLength("story_v_out_319511", "319511153", "story_v_out_319511.awb") / 1000

					if var_631_10 + var_631_2 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_10 + var_631_2
					end

					if var_631_5.prefab_name ~= "" and arg_628_1.actors_[var_631_5.prefab_name] ~= nil then
						local var_631_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_5.prefab_name].transform, "story_v_out_319511", "319511153", "story_v_out_319511.awb")

						arg_628_1:RecordAudio("319511153", var_631_11)
						arg_628_1:RecordAudio("319511153", var_631_11)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_out_319511", "319511153", "story_v_out_319511.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_out_319511", "319511153", "story_v_out_319511.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_12 = math.max(var_631_3, arg_628_1.talkMaxDuration)

			if var_631_2 <= arg_628_1.time_ and arg_628_1.time_ < var_631_2 + var_631_12 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_2) / var_631_12

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_2 + var_631_12 and arg_628_1.time_ < var_631_2 + var_631_12 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play319511154 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 319511154
		arg_632_1.duration_ = 2.4

		local var_632_0 = {
			zh = 2.4,
			ja = 2.166
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play319511155(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["10050ui_story"].transform
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.var_.moveOldPos10050ui_story = var_635_0.localPosition
			end

			local var_635_2 = 0.001

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2
				local var_635_4 = Vector3.New(-0.7, -0.715, -6.15)

				var_635_0.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos10050ui_story, var_635_4, var_635_3)

				local var_635_5 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_5.x, var_635_5.y, var_635_5.z)

				local var_635_6 = var_635_0.localEulerAngles

				var_635_6.z = 0
				var_635_6.x = 0
				var_635_0.localEulerAngles = var_635_6
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 then
				var_635_0.localPosition = Vector3.New(-0.7, -0.715, -6.15)

				local var_635_7 = manager.ui.mainCamera.transform.position - var_635_0.position

				var_635_0.forward = Vector3.New(var_635_7.x, var_635_7.y, var_635_7.z)

				local var_635_8 = var_635_0.localEulerAngles

				var_635_8.z = 0
				var_635_8.x = 0
				var_635_0.localEulerAngles = var_635_8
			end

			local var_635_9 = arg_632_1.actors_["10050ui_story"]
			local var_635_10 = 0

			if var_635_10 < arg_632_1.time_ and arg_632_1.time_ <= var_635_10 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect10050ui_story == nil then
				arg_632_1.var_.characterEffect10050ui_story = var_635_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_11 = 0.200000002980232

			if var_635_10 <= arg_632_1.time_ and arg_632_1.time_ < var_635_10 + var_635_11 and not isNil(var_635_9) then
				local var_635_12 = (arg_632_1.time_ - var_635_10) / var_635_11

				if arg_632_1.var_.characterEffect10050ui_story and not isNil(var_635_9) then
					arg_632_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_632_1.time_ >= var_635_10 + var_635_11 and arg_632_1.time_ < var_635_10 + var_635_11 + arg_635_0 and not isNil(var_635_9) and arg_632_1.var_.characterEffect10050ui_story then
				arg_632_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_635_13 = 0

			if var_635_13 < arg_632_1.time_ and arg_632_1.time_ <= var_635_13 + arg_635_0 then
				arg_632_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			local var_635_14 = 0

			if var_635_14 < arg_632_1.time_ and arg_632_1.time_ <= var_635_14 + arg_635_0 then
				arg_632_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_635_15 = arg_632_1.actors_["1084ui_story"]
			local var_635_16 = 0

			if var_635_16 < arg_632_1.time_ and arg_632_1.time_ <= var_635_16 + arg_635_0 and not isNil(var_635_15) and arg_632_1.var_.characterEffect1084ui_story == nil then
				arg_632_1.var_.characterEffect1084ui_story = var_635_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_17 = 0.200000002980232

			if var_635_16 <= arg_632_1.time_ and arg_632_1.time_ < var_635_16 + var_635_17 and not isNil(var_635_15) then
				local var_635_18 = (arg_632_1.time_ - var_635_16) / var_635_17

				if arg_632_1.var_.characterEffect1084ui_story and not isNil(var_635_15) then
					local var_635_19 = Mathf.Lerp(0, 0.5, var_635_18)

					arg_632_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1084ui_story.fillRatio = var_635_19
				end
			end

			if arg_632_1.time_ >= var_635_16 + var_635_17 and arg_632_1.time_ < var_635_16 + var_635_17 + arg_635_0 and not isNil(var_635_15) and arg_632_1.var_.characterEffect1084ui_story then
				local var_635_20 = 0.5

				arg_632_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1084ui_story.fillRatio = var_635_20
			end

			local var_635_21 = 0
			local var_635_22 = 0.325

			if var_635_21 < arg_632_1.time_ and arg_632_1.time_ <= var_635_21 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_23 = arg_632_1:FormatText(StoryNameCfg[692].name)

				arg_632_1.leftNameTxt_.text = var_635_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_24 = arg_632_1:GetWordFromCfg(319511154)
				local var_635_25 = arg_632_1:FormatText(var_635_24.content)

				arg_632_1.text_.text = var_635_25

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_26 = 13
				local var_635_27 = utf8.len(var_635_25)
				local var_635_28 = var_635_26 <= 0 and var_635_22 or var_635_22 * (var_635_27 / var_635_26)

				if var_635_28 > 0 and var_635_22 < var_635_28 then
					arg_632_1.talkMaxDuration = var_635_28

					if var_635_28 + var_635_21 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_28 + var_635_21
					end
				end

				arg_632_1.text_.text = var_635_25
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511154", "story_v_out_319511.awb") ~= 0 then
					local var_635_29 = manager.audio:GetVoiceLength("story_v_out_319511", "319511154", "story_v_out_319511.awb") / 1000

					if var_635_29 + var_635_21 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_29 + var_635_21
					end

					if var_635_24.prefab_name ~= "" and arg_632_1.actors_[var_635_24.prefab_name] ~= nil then
						local var_635_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_24.prefab_name].transform, "story_v_out_319511", "319511154", "story_v_out_319511.awb")

						arg_632_1:RecordAudio("319511154", var_635_30)
						arg_632_1:RecordAudio("319511154", var_635_30)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_out_319511", "319511154", "story_v_out_319511.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_out_319511", "319511154", "story_v_out_319511.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_31 = math.max(var_635_22, arg_632_1.talkMaxDuration)

			if var_635_21 <= arg_632_1.time_ and arg_632_1.time_ < var_635_21 + var_635_31 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_21) / var_635_31

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_21 + var_635_31 and arg_632_1.time_ < var_635_21 + var_635_31 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play319511155 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 319511155
		arg_636_1.duration_ = 9.83

		local var_636_0 = {
			zh = 7.266,
			ja = 9.833
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play319511156(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = arg_636_1.actors_["10050ui_story"]
			local var_639_1 = 0

			if var_639_1 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect10050ui_story == nil then
				arg_636_1.var_.characterEffect10050ui_story = var_639_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_2 = 0.200000002980232

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_2 and not isNil(var_639_0) then
				local var_639_3 = (arg_636_1.time_ - var_639_1) / var_639_2

				if arg_636_1.var_.characterEffect10050ui_story and not isNil(var_639_0) then
					local var_639_4 = Mathf.Lerp(0, 0.5, var_639_3)

					arg_636_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_636_1.var_.characterEffect10050ui_story.fillRatio = var_639_4
				end
			end

			if arg_636_1.time_ >= var_639_1 + var_639_2 and arg_636_1.time_ < var_639_1 + var_639_2 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect10050ui_story then
				local var_639_5 = 0.5

				arg_636_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_636_1.var_.characterEffect10050ui_story.fillRatio = var_639_5
			end

			local var_639_6 = arg_636_1.actors_["1084ui_story"]
			local var_639_7 = 0

			if var_639_7 < arg_636_1.time_ and arg_636_1.time_ <= var_639_7 + arg_639_0 and not isNil(var_639_6) and arg_636_1.var_.characterEffect1084ui_story == nil then
				arg_636_1.var_.characterEffect1084ui_story = var_639_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_8 = 0.200000002980232

			if var_639_7 <= arg_636_1.time_ and arg_636_1.time_ < var_639_7 + var_639_8 and not isNil(var_639_6) then
				local var_639_9 = (arg_636_1.time_ - var_639_7) / var_639_8

				if arg_636_1.var_.characterEffect1084ui_story and not isNil(var_639_6) then
					arg_636_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= var_639_7 + var_639_8 and arg_636_1.time_ < var_639_7 + var_639_8 + arg_639_0 and not isNil(var_639_6) and arg_636_1.var_.characterEffect1084ui_story then
				arg_636_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_639_10 = 0

			if var_639_10 < arg_636_1.time_ and arg_636_1.time_ <= var_639_10 + arg_639_0 then
				arg_636_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_639_11 = 0

			if var_639_11 < arg_636_1.time_ and arg_636_1.time_ <= var_639_11 + arg_639_0 then
				arg_636_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_639_12 = 0
			local var_639_13 = 0.85

			if var_639_12 < arg_636_1.time_ and arg_636_1.time_ <= var_639_12 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_14 = arg_636_1:FormatText(StoryNameCfg[6].name)

				arg_636_1.leftNameTxt_.text = var_639_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_15 = arg_636_1:GetWordFromCfg(319511155)
				local var_639_16 = arg_636_1:FormatText(var_639_15.content)

				arg_636_1.text_.text = var_639_16

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_17 = 34
				local var_639_18 = utf8.len(var_639_16)
				local var_639_19 = var_639_17 <= 0 and var_639_13 or var_639_13 * (var_639_18 / var_639_17)

				if var_639_19 > 0 and var_639_13 < var_639_19 then
					arg_636_1.talkMaxDuration = var_639_19

					if var_639_19 + var_639_12 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_19 + var_639_12
					end
				end

				arg_636_1.text_.text = var_639_16
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511155", "story_v_out_319511.awb") ~= 0 then
					local var_639_20 = manager.audio:GetVoiceLength("story_v_out_319511", "319511155", "story_v_out_319511.awb") / 1000

					if var_639_20 + var_639_12 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_20 + var_639_12
					end

					if var_639_15.prefab_name ~= "" and arg_636_1.actors_[var_639_15.prefab_name] ~= nil then
						local var_639_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_15.prefab_name].transform, "story_v_out_319511", "319511155", "story_v_out_319511.awb")

						arg_636_1:RecordAudio("319511155", var_639_21)
						arg_636_1:RecordAudio("319511155", var_639_21)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_out_319511", "319511155", "story_v_out_319511.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_out_319511", "319511155", "story_v_out_319511.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_22 = math.max(var_639_13, arg_636_1.talkMaxDuration)

			if var_639_12 <= arg_636_1.time_ and arg_636_1.time_ < var_639_12 + var_639_22 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_12) / var_639_22

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_12 + var_639_22 and arg_636_1.time_ < var_639_12 + var_639_22 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play319511156 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 319511156
		arg_640_1.duration_ = 13.13

		local var_640_0 = {
			zh = 5.566,
			ja = 13.133
		}
		local var_640_1 = manager.audio:GetLocalizationFlag()

		if var_640_0[var_640_1] ~= nil then
			arg_640_1.duration_ = var_640_0[var_640_1]
		end

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play319511157(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1084ui_story"]
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1084ui_story == nil then
				arg_640_1.var_.characterEffect1084ui_story = var_643_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_2 = 0.200000002980232

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 and not isNil(var_643_0) then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2

				if arg_640_1.var_.characterEffect1084ui_story and not isNil(var_643_0) then
					local var_643_4 = Mathf.Lerp(0, 0.5, var_643_3)

					arg_640_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1084ui_story.fillRatio = var_643_4
				end
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1084ui_story then
				local var_643_5 = 0.5

				arg_640_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1084ui_story.fillRatio = var_643_5
			end

			local var_643_6 = arg_640_1.actors_["10050ui_story"]
			local var_643_7 = 0

			if var_643_7 < arg_640_1.time_ and arg_640_1.time_ <= var_643_7 + arg_643_0 and not isNil(var_643_6) and arg_640_1.var_.characterEffect10050ui_story == nil then
				arg_640_1.var_.characterEffect10050ui_story = var_643_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_8 = 0.200000002980232

			if var_643_7 <= arg_640_1.time_ and arg_640_1.time_ < var_643_7 + var_643_8 and not isNil(var_643_6) then
				local var_643_9 = (arg_640_1.time_ - var_643_7) / var_643_8

				if arg_640_1.var_.characterEffect10050ui_story and not isNil(var_643_6) then
					arg_640_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_640_1.time_ >= var_643_7 + var_643_8 and arg_640_1.time_ < var_643_7 + var_643_8 + arg_643_0 and not isNil(var_643_6) and arg_640_1.var_.characterEffect10050ui_story then
				arg_640_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_643_10 = 0
			local var_643_11 = 0.65

			if var_643_10 < arg_640_1.time_ and arg_640_1.time_ <= var_643_10 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_12 = arg_640_1:FormatText(StoryNameCfg[692].name)

				arg_640_1.leftNameTxt_.text = var_643_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_13 = arg_640_1:GetWordFromCfg(319511156)
				local var_643_14 = arg_640_1:FormatText(var_643_13.content)

				arg_640_1.text_.text = var_643_14

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_15 = 26
				local var_643_16 = utf8.len(var_643_14)
				local var_643_17 = var_643_15 <= 0 and var_643_11 or var_643_11 * (var_643_16 / var_643_15)

				if var_643_17 > 0 and var_643_11 < var_643_17 then
					arg_640_1.talkMaxDuration = var_643_17

					if var_643_17 + var_643_10 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_17 + var_643_10
					end
				end

				arg_640_1.text_.text = var_643_14
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511156", "story_v_out_319511.awb") ~= 0 then
					local var_643_18 = manager.audio:GetVoiceLength("story_v_out_319511", "319511156", "story_v_out_319511.awb") / 1000

					if var_643_18 + var_643_10 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_18 + var_643_10
					end

					if var_643_13.prefab_name ~= "" and arg_640_1.actors_[var_643_13.prefab_name] ~= nil then
						local var_643_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_640_1.actors_[var_643_13.prefab_name].transform, "story_v_out_319511", "319511156", "story_v_out_319511.awb")

						arg_640_1:RecordAudio("319511156", var_643_19)
						arg_640_1:RecordAudio("319511156", var_643_19)
					else
						arg_640_1:AudioAction("play", "voice", "story_v_out_319511", "319511156", "story_v_out_319511.awb")
					end

					arg_640_1:RecordHistoryTalkVoice("story_v_out_319511", "319511156", "story_v_out_319511.awb")
				end

				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_20 = math.max(var_643_11, arg_640_1.talkMaxDuration)

			if var_643_10 <= arg_640_1.time_ and arg_640_1.time_ < var_643_10 + var_643_20 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_10) / var_643_20

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_10 + var_643_20 and arg_640_1.time_ < var_643_10 + var_643_20 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play319511157 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 319511157
		arg_644_1.duration_ = 9

		local var_644_0 = {
			zh = 9,
			ja = 8.366
		}
		local var_644_1 = manager.audio:GetLocalizationFlag()

		if var_644_0[var_644_1] ~= nil then
			arg_644_1.duration_ = var_644_0[var_644_1]
		end

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play319511158(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0
			local var_647_1 = 0.875

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_2 = arg_644_1:FormatText(StoryNameCfg[692].name)

				arg_644_1.leftNameTxt_.text = var_647_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_3 = arg_644_1:GetWordFromCfg(319511157)
				local var_647_4 = arg_644_1:FormatText(var_647_3.content)

				arg_644_1.text_.text = var_647_4

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 35
				local var_647_6 = utf8.len(var_647_4)
				local var_647_7 = var_647_5 <= 0 and var_647_1 or var_647_1 * (var_647_6 / var_647_5)

				if var_647_7 > 0 and var_647_1 < var_647_7 then
					arg_644_1.talkMaxDuration = var_647_7

					if var_647_7 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_7 + var_647_0
					end
				end

				arg_644_1.text_.text = var_647_4
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511157", "story_v_out_319511.awb") ~= 0 then
					local var_647_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511157", "story_v_out_319511.awb") / 1000

					if var_647_8 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_8 + var_647_0
					end

					if var_647_3.prefab_name ~= "" and arg_644_1.actors_[var_647_3.prefab_name] ~= nil then
						local var_647_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_644_1.actors_[var_647_3.prefab_name].transform, "story_v_out_319511", "319511157", "story_v_out_319511.awb")

						arg_644_1:RecordAudio("319511157", var_647_9)
						arg_644_1:RecordAudio("319511157", var_647_9)
					else
						arg_644_1:AudioAction("play", "voice", "story_v_out_319511", "319511157", "story_v_out_319511.awb")
					end

					arg_644_1:RecordHistoryTalkVoice("story_v_out_319511", "319511157", "story_v_out_319511.awb")
				end

				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_10 = math.max(var_647_1, arg_644_1.talkMaxDuration)

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_10 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_0) / var_647_10

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_0 + var_647_10 and arg_644_1.time_ < var_647_0 + var_647_10 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play319511158 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 319511158
		arg_648_1.duration_ = 10.03

		local var_648_0 = {
			zh = 5.366,
			ja = 10.033
		}
		local var_648_1 = manager.audio:GetLocalizationFlag()

		if var_648_0[var_648_1] ~= nil then
			arg_648_1.duration_ = var_648_0[var_648_1]
		end

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play319511159(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0
			local var_651_1 = 0.475

			if var_651_0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_2 = arg_648_1:FormatText(StoryNameCfg[692].name)

				arg_648_1.leftNameTxt_.text = var_651_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_3 = arg_648_1:GetWordFromCfg(319511158)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 19
				local var_651_6 = utf8.len(var_651_4)
				local var_651_7 = var_651_5 <= 0 and var_651_1 or var_651_1 * (var_651_6 / var_651_5)

				if var_651_7 > 0 and var_651_1 < var_651_7 then
					arg_648_1.talkMaxDuration = var_651_7

					if var_651_7 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_0
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511158", "story_v_out_319511.awb") ~= 0 then
					local var_651_8 = manager.audio:GetVoiceLength("story_v_out_319511", "319511158", "story_v_out_319511.awb") / 1000

					if var_651_8 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_8 + var_651_0
					end

					if var_651_3.prefab_name ~= "" and arg_648_1.actors_[var_651_3.prefab_name] ~= nil then
						local var_651_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_3.prefab_name].transform, "story_v_out_319511", "319511158", "story_v_out_319511.awb")

						arg_648_1:RecordAudio("319511158", var_651_9)
						arg_648_1:RecordAudio("319511158", var_651_9)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_out_319511", "319511158", "story_v_out_319511.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_out_319511", "319511158", "story_v_out_319511.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_10 = math.max(var_651_1, arg_648_1.talkMaxDuration)

			if var_651_0 <= arg_648_1.time_ and arg_648_1.time_ < var_651_0 + var_651_10 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_0) / var_651_10

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_0 + var_651_10 and arg_648_1.time_ < var_651_0 + var_651_10 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play319511159 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 319511159
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play319511160(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = arg_652_1.actors_["10050ui_story"]
			local var_655_1 = 0

			if var_655_1 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect10050ui_story == nil then
				arg_652_1.var_.characterEffect10050ui_story = var_655_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_2 = 0.200000002980232

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_2 and not isNil(var_655_0) then
				local var_655_3 = (arg_652_1.time_ - var_655_1) / var_655_2

				if arg_652_1.var_.characterEffect10050ui_story and not isNil(var_655_0) then
					local var_655_4 = Mathf.Lerp(0, 0.5, var_655_3)

					arg_652_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_652_1.var_.characterEffect10050ui_story.fillRatio = var_655_4
				end
			end

			if arg_652_1.time_ >= var_655_1 + var_655_2 and arg_652_1.time_ < var_655_1 + var_655_2 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect10050ui_story then
				local var_655_5 = 0.5

				arg_652_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_652_1.var_.characterEffect10050ui_story.fillRatio = var_655_5
			end

			local var_655_6 = 0
			local var_655_7 = 1.125

			if var_655_6 < arg_652_1.time_ and arg_652_1.time_ <= var_655_6 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_8 = arg_652_1:GetWordFromCfg(319511159)
				local var_655_9 = arg_652_1:FormatText(var_655_8.content)

				arg_652_1.text_.text = var_655_9

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_10 = 45
				local var_655_11 = utf8.len(var_655_9)
				local var_655_12 = var_655_10 <= 0 and var_655_7 or var_655_7 * (var_655_11 / var_655_10)

				if var_655_12 > 0 and var_655_7 < var_655_12 then
					arg_652_1.talkMaxDuration = var_655_12

					if var_655_12 + var_655_6 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_12 + var_655_6
					end
				end

				arg_652_1.text_.text = var_655_9
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_13 = math.max(var_655_7, arg_652_1.talkMaxDuration)

			if var_655_6 <= arg_652_1.time_ and arg_652_1.time_ < var_655_6 + var_655_13 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_6) / var_655_13

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_6 + var_655_13 and arg_652_1.time_ < var_655_6 + var_655_13 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play319511160 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 319511160
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play319511161(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0
			local var_659_1 = 1.275

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, false)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_2 = arg_656_1:GetWordFromCfg(319511160)
				local var_659_3 = arg_656_1:FormatText(var_659_2.content)

				arg_656_1.text_.text = var_659_3

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_4 = 51
				local var_659_5 = utf8.len(var_659_3)
				local var_659_6 = var_659_4 <= 0 and var_659_1 or var_659_1 * (var_659_5 / var_659_4)

				if var_659_6 > 0 and var_659_1 < var_659_6 then
					arg_656_1.talkMaxDuration = var_659_6

					if var_659_6 + var_659_0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_6 + var_659_0
					end
				end

				arg_656_1.text_.text = var_659_3
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_7 = math.max(var_659_1, arg_656_1.talkMaxDuration)

			if var_659_0 <= arg_656_1.time_ and arg_656_1.time_ < var_659_0 + var_659_7 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_0) / var_659_7

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_0 + var_659_7 and arg_656_1.time_ < var_659_0 + var_659_7 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play319511161 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 319511161
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play319511162(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.8

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_2 = arg_660_1:GetWordFromCfg(319511161)
				local var_663_3 = arg_660_1:FormatText(var_663_2.content)

				arg_660_1.text_.text = var_663_3

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_4 = 32
				local var_663_5 = utf8.len(var_663_3)
				local var_663_6 = var_663_4 <= 0 and var_663_1 or var_663_1 * (var_663_5 / var_663_4)

				if var_663_6 > 0 and var_663_1 < var_663_6 then
					arg_660_1.talkMaxDuration = var_663_6

					if var_663_6 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_6 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_3
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_7 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_7 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_7

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_7 and arg_660_1.time_ < var_663_0 + var_663_7 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play319511162 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 319511162
		arg_664_1.duration_ = 13.53

		local var_664_0 = {
			zh = 3.6,
			ja = 13.533
		}
		local var_664_1 = manager.audio:GetLocalizationFlag()

		if var_664_0[var_664_1] ~= nil then
			arg_664_1.duration_ = var_664_0[var_664_1]
		end

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
			arg_664_1.auto_ = false
		end

		function arg_664_1.playNext_(arg_666_0)
			arg_664_1.onStoryFinished_()
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = arg_664_1.actors_["1084ui_story"]
			local var_667_1 = 0

			if var_667_1 < arg_664_1.time_ and arg_664_1.time_ <= var_667_1 + arg_667_0 and not isNil(var_667_0) and arg_664_1.var_.characterEffect1084ui_story == nil then
				arg_664_1.var_.characterEffect1084ui_story = var_667_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_667_2 = 0.200000002980232

			if var_667_1 <= arg_664_1.time_ and arg_664_1.time_ < var_667_1 + var_667_2 and not isNil(var_667_0) then
				local var_667_3 = (arg_664_1.time_ - var_667_1) / var_667_2

				if arg_664_1.var_.characterEffect1084ui_story and not isNil(var_667_0) then
					arg_664_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_664_1.time_ >= var_667_1 + var_667_2 and arg_664_1.time_ < var_667_1 + var_667_2 + arg_667_0 and not isNil(var_667_0) and arg_664_1.var_.characterEffect1084ui_story then
				arg_664_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_667_4 = 0

			if var_667_4 < arg_664_1.time_ and arg_664_1.time_ <= var_667_4 + arg_667_0 then
				arg_664_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_667_5 = 0
			local var_667_6 = 0.45

			if var_667_5 < arg_664_1.time_ and arg_664_1.time_ <= var_667_5 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_7 = arg_664_1:FormatText(StoryNameCfg[6].name)

				arg_664_1.leftNameTxt_.text = var_667_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_8 = arg_664_1:GetWordFromCfg(319511162)
				local var_667_9 = arg_664_1:FormatText(var_667_8.content)

				arg_664_1.text_.text = var_667_9

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_10 = 18
				local var_667_11 = utf8.len(var_667_9)
				local var_667_12 = var_667_10 <= 0 and var_667_6 or var_667_6 * (var_667_11 / var_667_10)

				if var_667_12 > 0 and var_667_6 < var_667_12 then
					arg_664_1.talkMaxDuration = var_667_12

					if var_667_12 + var_667_5 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_12 + var_667_5
					end
				end

				arg_664_1.text_.text = var_667_9
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319511", "319511162", "story_v_out_319511.awb") ~= 0 then
					local var_667_13 = manager.audio:GetVoiceLength("story_v_out_319511", "319511162", "story_v_out_319511.awb") / 1000

					if var_667_13 + var_667_5 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_13 + var_667_5
					end

					if var_667_8.prefab_name ~= "" and arg_664_1.actors_[var_667_8.prefab_name] ~= nil then
						local var_667_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_8.prefab_name].transform, "story_v_out_319511", "319511162", "story_v_out_319511.awb")

						arg_664_1:RecordAudio("319511162", var_667_14)
						arg_664_1:RecordAudio("319511162", var_667_14)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_out_319511", "319511162", "story_v_out_319511.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_out_319511", "319511162", "story_v_out_319511.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_15 = math.max(var_667_6, arg_664_1.talkMaxDuration)

			if var_667_5 <= arg_664_1.time_ and arg_664_1.time_ < var_667_5 + var_667_15 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_5) / var_667_15

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_5 + var_667_15 and arg_664_1.time_ < var_667_5 + var_667_15 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1031951.usm",
		"TextureConfig/Background/ST71"
	},
	voices = {
		"story_v_out_319511.awb"
	},
	skipMarkers = {
		319511058
	}
}
