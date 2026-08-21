return {
	Play319291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319291001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = 0
			local var_4_7 = 0.2

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_11 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 1.7
			local var_4_13 = 1

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				local var_4_14 = "play"
				local var_4_15 = "music"

				arg_1_1:AudioAction(var_4_14, var_4_15, "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_4_16 = ""
				local var_4_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

				if var_4_17 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 1.999999999999
			local var_4_19 = 0.975

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:GetWordFromCfg(319291001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 39
				local var_4_24 = utf8.len(var_4_22)
				local var_4_25 = var_4_23 <= 0 and var_4_19 or var_4_19 * (var_4_24 / var_4_23)

				if var_4_25 > 0 and var_4_19 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_18 = var_4_18 + 0.3

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_18 + 0.3
			local var_4_27 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319291002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.475

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(319291002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 59
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319291003
		arg_13_1.duration_ = 5.73

		local var_13_0 = {
			zh = 5.733,
			ja = 5.2
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
				arg_13_0:Play319291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10079ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_13_1.stage_.transform)

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

			local var_16_5 = arg_13_1.actors_["10079ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos10079ui_story = var_16_5.localPosition

				local var_16_7 = "10079ui_story"

				arg_13_1:ShowWeapon(arg_13_1.var_[var_16_7 .. "Animator"].transform, false)
			end

			local var_16_8 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_6) / var_16_8
				local var_16_10 = Vector3.New(0, -0.95, -6.05)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10079ui_story, var_16_10, var_16_9)

				local var_16_11 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_11.x, var_16_11.y, var_16_11.z)

				local var_16_12 = var_16_5.localEulerAngles

				var_16_12.z = 0
				var_16_12.x = 0
				var_16_5.localEulerAngles = var_16_12
			end

			if arg_13_1.time_ >= var_16_6 + var_16_8 and arg_13_1.time_ < var_16_6 + var_16_8 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_16_13 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_13.x, var_16_13.y, var_16_13.z)

				local var_16_14 = var_16_5.localEulerAngles

				var_16_14.z = 0
				var_16_14.x = 0
				var_16_5.localEulerAngles = var_16_14
			end

			local var_16_15 = arg_13_1.actors_["10079ui_story"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_17 = 0.200000002980232

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_15) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_16_21 = 0
			local var_16_22 = 0.475

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_23 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_24 = arg_13_1:GetWordFromCfg(319291003)
				local var_16_25 = arg_13_1:FormatText(var_16_24.content)

				arg_13_1.text_.text = var_16_25

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_26 = 19
				local var_16_27 = utf8.len(var_16_25)
				local var_16_28 = var_16_26 <= 0 and var_16_22 or var_16_22 * (var_16_27 / var_16_26)

				if var_16_28 > 0 and var_16_22 < var_16_28 then
					arg_13_1.talkMaxDuration = var_16_28

					if var_16_28 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_21
					end
				end

				arg_13_1.text_.text = var_16_25
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291003", "story_v_out_319291.awb") ~= 0 then
					local var_16_29 = manager.audio:GetVoiceLength("story_v_out_319291", "319291003", "story_v_out_319291.awb") / 1000

					if var_16_29 + var_16_21 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_29 + var_16_21
					end

					if var_16_24.prefab_name ~= "" and arg_13_1.actors_[var_16_24.prefab_name] ~= nil then
						local var_16_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_24.prefab_name].transform, "story_v_out_319291", "319291003", "story_v_out_319291.awb")

						arg_13_1:RecordAudio("319291003", var_16_30)
						arg_13_1:RecordAudio("319291003", var_16_30)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319291", "319291003", "story_v_out_319291.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319291", "319291003", "story_v_out_319291.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_31 = math.max(var_16_22, arg_13_1.talkMaxDuration)

			if var_16_21 <= arg_13_1.time_ and arg_13_1.time_ < var_16_21 + var_16_31 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_21) / var_16_31

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_21 + var_16_31 and arg_13_1.time_ < var_16_21 + var_16_31 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319291004
		arg_17_1.duration_ = 6.13

		local var_17_0 = {
			zh = 4,
			ja = 6.133
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
				arg_17_0:Play319291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.325

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(319291004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 13
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291004", "story_v_out_319291.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319291", "319291004", "story_v_out_319291.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_319291", "319291004", "story_v_out_319291.awb")

						arg_17_1:RecordAudio("319291004", var_20_9)
						arg_17_1:RecordAudio("319291004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319291", "319291004", "story_v_out_319291.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319291", "319291004", "story_v_out_319291.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319291005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319291005
		arg_21_1.duration_ = 7.63

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319291006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "I10f"

			if arg_21_1.bgs_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_24_0)
				var_24_1.name = var_24_0
				var_24_1.transform.parent = arg_21_1.stage_.transform
				var_24_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_[var_24_0] = var_24_1
			end

			local var_24_2 = 1

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				local var_24_3 = manager.ui.mainCamera.transform.localPosition
				local var_24_4 = Vector3.New(0, 0, 10) + Vector3.New(var_24_3.x, var_24_3.y, 0)
				local var_24_5 = arg_21_1.bgs_.I10f

				var_24_5.transform.localPosition = var_24_4
				var_24_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_6 = var_24_5:GetComponent("SpriteRenderer")

				if var_24_6 and var_24_6.sprite then
					local var_24_7 = (var_24_5.transform.localPosition - var_24_3).z
					local var_24_8 = manager.ui.mainCameraCom_
					local var_24_9 = 2 * var_24_7 * Mathf.Tan(var_24_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_10 = var_24_9 * var_24_8.aspect
					local var_24_11 = var_24_6.sprite.bounds.size.x
					local var_24_12 = var_24_6.sprite.bounds.size.y
					local var_24_13 = var_24_10 / var_24_11
					local var_24_14 = var_24_9 / var_24_12
					local var_24_15 = var_24_14 < var_24_13 and var_24_13 or var_24_14

					var_24_5.transform.localScale = Vector3.New(var_24_15, var_24_15, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "I10f" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_17 = 1

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Color.New(0, 0, 0)

				var_24_19.a = Mathf.Lerp(0, 1, var_24_18)
				arg_21_1.mask_.color = var_24_19
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				local var_24_20 = Color.New(0, 0, 0)

				var_24_20.a = 1
				arg_21_1.mask_.color = var_24_20
			end

			local var_24_21 = 1

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_22 = 1.63333333333333

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Color.New(0, 0, 0)

				var_24_24.a = Mathf.Lerp(1, 0, var_24_23)
				arg_21_1.mask_.color = var_24_24
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				local var_24_25 = Color.New(0, 0, 0)
				local var_24_26 = 0

				arg_21_1.mask_.enabled = false
				var_24_25.a = var_24_26
				arg_21_1.mask_.color = var_24_25
			end

			local var_24_27 = arg_21_1.actors_["10079ui_story"].transform
			local var_24_28 = 1

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = var_24_27.localPosition

				local var_24_29 = "10079ui_story"

				arg_21_1:ShowWeapon(arg_21_1.var_[var_24_29 .. "Animator"].transform, false)
			end

			local var_24_30 = 0.001

			if var_24_28 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_30 then
				local var_24_31 = (arg_21_1.time_ - var_24_28) / var_24_30
				local var_24_32 = Vector3.New(0, 100, 0)

				var_24_27.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, var_24_32, var_24_31)

				local var_24_33 = manager.ui.mainCamera.transform.position - var_24_27.position

				var_24_27.forward = Vector3.New(var_24_33.x, var_24_33.y, var_24_33.z)

				local var_24_34 = var_24_27.localEulerAngles

				var_24_34.z = 0
				var_24_34.x = 0
				var_24_27.localEulerAngles = var_24_34
			end

			if arg_21_1.time_ >= var_24_28 + var_24_30 and arg_21_1.time_ < var_24_28 + var_24_30 + arg_24_0 then
				var_24_27.localPosition = Vector3.New(0, 100, 0)

				local var_24_35 = manager.ui.mainCamera.transform.position - var_24_27.position

				var_24_27.forward = Vector3.New(var_24_35.x, var_24_35.y, var_24_35.z)

				local var_24_36 = var_24_27.localEulerAngles

				var_24_36.z = 0
				var_24_36.x = 0
				var_24_27.localEulerAngles = var_24_36
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_37 = 2.63333333333333
			local var_24_38 = 1.2

			if var_24_37 < arg_21_1.time_ and arg_21_1.time_ <= var_24_37 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_39 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_39:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_40 = arg_21_1:GetWordFromCfg(319291005)
				local var_24_41 = arg_21_1:FormatText(var_24_40.content)

				arg_21_1.text_.text = var_24_41

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_42 = 48
				local var_24_43 = utf8.len(var_24_41)
				local var_24_44 = var_24_42 <= 0 and var_24_38 or var_24_38 * (var_24_43 / var_24_42)

				if var_24_44 > 0 and var_24_38 < var_24_44 then
					arg_21_1.talkMaxDuration = var_24_44
					var_24_37 = var_24_37 + 0.3

					if var_24_44 + var_24_37 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_44 + var_24_37
					end
				end

				arg_21_1.text_.text = var_24_41
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = var_24_37 + 0.3
			local var_24_46 = math.max(var_24_38, arg_21_1.talkMaxDuration)

			if var_24_45 <= arg_21_1.time_ and arg_21_1.time_ < var_24_45 + var_24_46 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_45) / var_24_46

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_45 + var_24_46 and arg_21_1.time_ < var_24_45 + var_24_46 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319291006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 319291006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play319291007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 1.475

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_2 = arg_27_1:GetWordFromCfg(319291006)
				local var_30_3 = arg_27_1:FormatText(var_30_2.content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 59
				local var_30_5 = utf8.len(var_30_3)
				local var_30_6 = var_30_4 <= 0 and var_30_1 or var_30_1 * (var_30_5 / var_30_4)

				if var_30_6 > 0 and var_30_1 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_7 and arg_27_1.time_ < var_30_0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play319291007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319291007
		arg_31_1.duration_ = 4.93

		local var_31_0 = {
			zh = 3.266,
			ja = 4.933
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play319291008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10079ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos10079ui_story = var_34_0.localPosition

				local var_34_2 = "10079ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_2 .. "Animator"].transform, false)
			end

			local var_34_3 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_3 then
				local var_34_4 = (arg_31_1.time_ - var_34_1) / var_34_3
				local var_34_5 = Vector3.New(0, -0.95, -6.05)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10079ui_story, var_34_5, var_34_4)

				local var_34_6 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_6.x, var_34_6.y, var_34_6.z)

				local var_34_7 = var_34_0.localEulerAngles

				var_34_7.z = 0
				var_34_7.x = 0
				var_34_0.localEulerAngles = var_34_7
			end

			if arg_31_1.time_ >= var_34_1 + var_34_3 and arg_31_1.time_ < var_34_1 + var_34_3 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_34_8 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_8.x, var_34_8.y, var_34_8.z)

				local var_34_9 = var_34_0.localEulerAngles

				var_34_9.z = 0
				var_34_9.x = 0
				var_34_0.localEulerAngles = var_34_9
			end

			local var_34_10 = arg_31_1.actors_["10079ui_story"]
			local var_34_11 = 0

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 and not isNil(var_34_10) and arg_31_1.var_.characterEffect10079ui_story == nil then
				arg_31_1.var_.characterEffect10079ui_story = var_34_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_12 = 0.200000002980232

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_12 and not isNil(var_34_10) then
				local var_34_13 = (arg_31_1.time_ - var_34_11) / var_34_12

				if arg_31_1.var_.characterEffect10079ui_story and not isNil(var_34_10) then
					arg_31_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_11 + var_34_12 and arg_31_1.time_ < var_34_11 + var_34_12 + arg_34_0 and not isNil(var_34_10) and arg_31_1.var_.characterEffect10079ui_story then
				arg_31_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_34_15 = 0

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_16 = 0
			local var_34_17 = 0.25

			if var_34_16 < arg_31_1.time_ and arg_31_1.time_ <= var_34_16 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_18 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_19 = arg_31_1:GetWordFromCfg(319291007)
				local var_34_20 = arg_31_1:FormatText(var_34_19.content)

				arg_31_1.text_.text = var_34_20

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_21 = 10
				local var_34_22 = utf8.len(var_34_20)
				local var_34_23 = var_34_21 <= 0 and var_34_17 or var_34_17 * (var_34_22 / var_34_21)

				if var_34_23 > 0 and var_34_17 < var_34_23 then
					arg_31_1.talkMaxDuration = var_34_23

					if var_34_23 + var_34_16 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_16
					end
				end

				arg_31_1.text_.text = var_34_20
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291007", "story_v_out_319291.awb") ~= 0 then
					local var_34_24 = manager.audio:GetVoiceLength("story_v_out_319291", "319291007", "story_v_out_319291.awb") / 1000

					if var_34_24 + var_34_16 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_24 + var_34_16
					end

					if var_34_19.prefab_name ~= "" and arg_31_1.actors_[var_34_19.prefab_name] ~= nil then
						local var_34_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_19.prefab_name].transform, "story_v_out_319291", "319291007", "story_v_out_319291.awb")

						arg_31_1:RecordAudio("319291007", var_34_25)
						arg_31_1:RecordAudio("319291007", var_34_25)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319291", "319291007", "story_v_out_319291.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319291", "319291007", "story_v_out_319291.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_26 = math.max(var_34_17, arg_31_1.talkMaxDuration)

			if var_34_16 <= arg_31_1.time_ and arg_31_1.time_ < var_34_16 + var_34_26 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_16) / var_34_26

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_16 + var_34_26 and arg_31_1.time_ < var_34_16 + var_34_26 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play319291008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319291008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319291009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10079ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10079ui_story == nil then
				arg_35_1.var_.characterEffect10079ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect10079ui_story and not isNil(var_38_0) then
					local var_38_4 = Mathf.Lerp(0, 0.5, var_38_3)

					arg_35_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10079ui_story.fillRatio = var_38_4
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect10079ui_story then
				local var_38_5 = 0.5

				arg_35_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10079ui_story.fillRatio = var_38_5
			end

			local var_38_6 = 0
			local var_38_7 = 1.55

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(319291008)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 62
				local var_38_11 = utf8.len(var_38_9)
				local var_38_12 = var_38_10 <= 0 and var_38_7 or var_38_7 * (var_38_11 / var_38_10)

				if var_38_12 > 0 and var_38_7 < var_38_12 then
					arg_35_1.talkMaxDuration = var_38_12

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_13 and arg_35_1.time_ < var_38_6 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319291009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319291009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319291010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.7

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(319291009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 68
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319291010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319291010
		arg_43_1.duration_ = 2.33

		local var_43_0 = {
			zh = 1.999999999999,
			ja = 2.333
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
				arg_43_0:Play319291011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10079ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10079ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -0.95, -6.05)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10079ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["10079ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10079ui_story == nil then
				arg_43_1.var_.characterEffect10079ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect10079ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect10079ui_story then
				arg_43_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_15 = 0
			local var_46_16 = 0.25

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[6].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(319291010)
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

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291010", "story_v_out_319291.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_319291", "319291010", "story_v_out_319291.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_319291", "319291010", "story_v_out_319291.awb")

						arg_43_1:RecordAudio("319291010", var_46_24)
						arg_43_1:RecordAudio("319291010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319291", "319291010", "story_v_out_319291.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319291", "319291010", "story_v_out_319291.awb")
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
				actorName = "10079ui_story",
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
	Play319291011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319291011
		arg_47_1.duration_ = 5.6

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319291012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10079ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10079ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, 100, 0)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10079ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, 100, 0)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = manager.ui.mainCamera.transform
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				local var_50_11 = arg_47_1.var_.effect110
				local var_50_12
				local var_50_13 = var_50_9

				if not var_50_11 then
					var_50_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_50_13)
					var_50_11.name = "110"
					arg_47_1.var_.effect110 = var_50_11
				else
					var_50_11.transform:SetParent(var_50_13)
				end

				var_50_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_50_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_50_14 = manager.ui.mainCamera.transform
			local var_50_15 = 0

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.var_.shakeOldPos = var_50_14.localPosition
			end

			local var_50_16 = 0.725

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_16 then
				local var_50_17 = (arg_47_1.time_ - var_50_15) / 0.066
				local var_50_18, var_50_19 = math.modf(var_50_17)

				var_50_14.localPosition = Vector3.New(var_50_19 * 0.13, var_50_19 * 0.13, var_50_19 * 0.13) + arg_47_1.var_.shakeOldPos
			end

			if arg_47_1.time_ >= var_50_15 + var_50_16 and arg_47_1.time_ < var_50_15 + var_50_16 + arg_50_0 then
				var_50_14.localPosition = arg_47_1.var_.shakeOldPos
			end

			local var_50_20 = 0

			if var_50_20 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			local var_50_21 = 1.5

			if arg_47_1.time_ >= var_50_20 + var_50_21 and arg_47_1.time_ < var_50_20 + var_50_21 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_22 = 0.6
			local var_50_23 = 0.125

			if var_50_22 < arg_47_1.time_ and arg_47_1.time_ <= var_50_22 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_24 = arg_47_1:FormatText(StoryNameCfg[36].name)

				arg_47_1.leftNameTxt_.text = var_50_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_25 = arg_47_1:GetWordFromCfg(319291011)
				local var_50_26 = arg_47_1:FormatText(var_50_25.content)

				arg_47_1.text_.text = var_50_26

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_27 = 5
				local var_50_28 = utf8.len(var_50_26)
				local var_50_29 = var_50_27 <= 0 and var_50_23 or var_50_23 * (var_50_28 / var_50_27)

				if var_50_29 > 0 and var_50_23 < var_50_29 then
					arg_47_1.talkMaxDuration = var_50_29

					if var_50_29 + var_50_22 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_29 + var_50_22
					end
				end

				arg_47_1.text_.text = var_50_26
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_30 = math.max(var_50_23, arg_47_1.talkMaxDuration)

			if var_50_22 <= arg_47_1.time_ and arg_47_1.time_ < var_50_22 + var_50_30 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_22) / var_50_30

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_22 + var_50_30 and arg_47_1.time_ < var_50_22 + var_50_30 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319291012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319291012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319291013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = manager.ui.mainCamera.transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				local var_54_2 = arg_51_1.var_.effect110

				if var_54_2 then
					Object.Destroy(var_54_2)

					arg_51_1.var_.effect110 = nil
				end
			end

			local var_54_3 = 0
			local var_54_4 = 1.45

			if var_54_3 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:GetWordFromCfg(319291012)
				local var_54_6 = arg_51_1:FormatText(var_54_5.content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 58
				local var_54_8 = utf8.len(var_54_6)
				local var_54_9 = var_54_7 <= 0 and var_54_4 or var_54_4 * (var_54_8 / var_54_7)

				if var_54_9 > 0 and var_54_4 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_10 and arg_51_1.time_ < var_54_3 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319291013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319291013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319291014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 1.525

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(319291013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 61
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play319291014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319291014
		arg_59_1.duration_ = 5.63

		local var_59_0 = {
			zh = 4.133,
			ja = 5.633
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319291015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10079ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10079ui_story == nil then
				arg_59_1.var_.characterEffect10079ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect10079ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10079ui_story then
				arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["10079ui_story"].transform
			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.var_.moveOldPos10079ui_story = var_62_4.localPosition

				local var_62_6 = "10079ui_story"

				arg_59_1:ShowWeapon(arg_59_1.var_[var_62_6 .. "Animator"].transform, false)
			end

			local var_62_7 = 0.001

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_7 then
				local var_62_8 = (arg_59_1.time_ - var_62_5) / var_62_7
				local var_62_9 = Vector3.New(0, -0.95, -6.05)

				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10079ui_story, var_62_9, var_62_8)

				local var_62_10 = manager.ui.mainCamera.transform.position - var_62_4.position

				var_62_4.forward = Vector3.New(var_62_10.x, var_62_10.y, var_62_10.z)

				local var_62_11 = var_62_4.localEulerAngles

				var_62_11.z = 0
				var_62_11.x = 0
				var_62_4.localEulerAngles = var_62_11
			end

			if arg_59_1.time_ >= var_62_5 + var_62_7 and arg_59_1.time_ < var_62_5 + var_62_7 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_62_12 = manager.ui.mainCamera.transform.position - var_62_4.position

				var_62_4.forward = Vector3.New(var_62_12.x, var_62_12.y, var_62_12.z)

				local var_62_13 = var_62_4.localEulerAngles

				var_62_13.z = 0
				var_62_13.x = 0
				var_62_4.localEulerAngles = var_62_13
			end

			local var_62_14 = arg_59_1.actors_["10079ui_story"]
			local var_62_15 = 0

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10079ui_story == nil then
				arg_59_1.var_.characterEffect10079ui_story = var_62_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_16 = 0.200000002980232

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_16 and not isNil(var_62_14) then
				local var_62_17 = (arg_59_1.time_ - var_62_15) / var_62_16

				if arg_59_1.var_.characterEffect10079ui_story and not isNil(var_62_14) then
					arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_15 + var_62_16 and arg_59_1.time_ < var_62_15 + var_62_16 + arg_62_0 and not isNil(var_62_14) and arg_59_1.var_.characterEffect10079ui_story then
				arg_59_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_62_18 = 0

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 then
				arg_59_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_20 = 0
			local var_62_21 = 0.45

			if var_62_20 < arg_59_1.time_ and arg_59_1.time_ <= var_62_20 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_22 = arg_59_1:FormatText(StoryNameCfg[6].name)

				arg_59_1.leftNameTxt_.text = var_62_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_23 = arg_59_1:GetWordFromCfg(319291014)
				local var_62_24 = arg_59_1:FormatText(var_62_23.content)

				arg_59_1.text_.text = var_62_24

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_25 = 18
				local var_62_26 = utf8.len(var_62_24)
				local var_62_27 = var_62_25 <= 0 and var_62_21 or var_62_21 * (var_62_26 / var_62_25)

				if var_62_27 > 0 and var_62_21 < var_62_27 then
					arg_59_1.talkMaxDuration = var_62_27

					if var_62_27 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_27 + var_62_20
					end
				end

				arg_59_1.text_.text = var_62_24
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291014", "story_v_out_319291.awb") ~= 0 then
					local var_62_28 = manager.audio:GetVoiceLength("story_v_out_319291", "319291014", "story_v_out_319291.awb") / 1000

					if var_62_28 + var_62_20 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_28 + var_62_20
					end

					if var_62_23.prefab_name ~= "" and arg_59_1.actors_[var_62_23.prefab_name] ~= nil then
						local var_62_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_23.prefab_name].transform, "story_v_out_319291", "319291014", "story_v_out_319291.awb")

						arg_59_1:RecordAudio("319291014", var_62_29)
						arg_59_1:RecordAudio("319291014", var_62_29)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319291", "319291014", "story_v_out_319291.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319291", "319291014", "story_v_out_319291.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_30 = math.max(var_62_21, arg_59_1.talkMaxDuration)

			if var_62_20 <= arg_59_1.time_ and arg_59_1.time_ < var_62_20 + var_62_30 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_20) / var_62_30

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_20 + var_62_30 and arg_59_1.time_ < var_62_20 + var_62_30 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319291015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319291015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319291016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10079ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10079ui_story == nil then
				arg_63_1.var_.characterEffect10079ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10079ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10079ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10079ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10079ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 1.075

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(319291015)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 43
				local var_66_11 = utf8.len(var_66_9)
				local var_66_12 = var_66_10 <= 0 and var_66_7 or var_66_7 * (var_66_11 / var_66_10)

				if var_66_12 > 0 and var_66_7 < var_66_12 then
					arg_63_1.talkMaxDuration = var_66_12

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_13 and arg_63_1.time_ < var_66_6 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319291016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319291016
		arg_67_1.duration_ = 3.17

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319291017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 1

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				local var_70_2 = "play"
				local var_70_3 = "effect"

				arg_67_1:AudioAction(var_70_2, var_70_3, "se_story_9", "se_story_9_monster03", "")
			end

			local var_70_4 = 0
			local var_70_5 = 0.1

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_6 = arg_67_1:FormatText(StoryNameCfg[68].name)

				arg_67_1.leftNameTxt_.text = var_70_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2017")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_7 = arg_67_1:GetWordFromCfg(319291016)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 4
				local var_70_10 = utf8.len(var_70_8)
				local var_70_11 = var_70_9 <= 0 and var_70_5 or var_70_5 * (var_70_10 / var_70_9)

				if var_70_11 > 0 and var_70_5 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291016", "story_v_out_319291.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_319291", "319291016", "story_v_out_319291.awb") / 1000

					if var_70_12 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_4
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_319291", "319291016", "story_v_out_319291.awb")

						arg_67_1:RecordAudio("319291016", var_70_13)
						arg_67_1:RecordAudio("319291016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_319291", "319291016", "story_v_out_319291.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_319291", "319291016", "story_v_out_319291.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_14 and arg_67_1.time_ < var_70_4 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319291017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319291017
		arg_71_1.duration_ = 4.1

		local var_71_0 = {
			zh = 2.166,
			ja = 4.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319291018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10079ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10079ui_story == nil then
				arg_71_1.var_.characterEffect10079ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10079ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10079ui_story then
				arg_71_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_74_4 = 0

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action456")
			end

			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_6 = 0
			local var_74_7 = 0.225

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_9 = arg_71_1:GetWordFromCfg(319291017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 9
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291017", "story_v_out_319291.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_319291", "319291017", "story_v_out_319291.awb") / 1000

					if var_74_14 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_6
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_out_319291", "319291017", "story_v_out_319291.awb")

						arg_71_1:RecordAudio("319291017", var_74_15)
						arg_71_1:RecordAudio("319291017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319291", "319291017", "story_v_out_319291.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319291", "319291017", "story_v_out_319291.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_16 and arg_71_1.time_ < var_74_6 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319291018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319291018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319291019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10079ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10079ui_story == nil then
				arg_75_1.var_.characterEffect10079ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect10079ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10079ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10079ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10079ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 1.4

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(319291018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 56
				local var_78_11 = utf8.len(var_78_9)
				local var_78_12 = var_78_10 <= 0 and var_78_7 or var_78_7 * (var_78_11 / var_78_10)

				if var_78_12 > 0 and var_78_7 < var_78_12 then
					arg_75_1.talkMaxDuration = var_78_12

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_13 and arg_75_1.time_ < var_78_6 + var_78_13 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319291019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319291019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319291020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.35

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[36].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:GetWordFromCfg(319291019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 14
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319291020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319291020
		arg_83_1.duration_ = 8.03

		local var_83_0 = {
			zh = 4.433,
			ja = 8.033
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
				arg_83_0:Play319291021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10079ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10079ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, -0.95, -6.05)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10079ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["10079ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect10079ui_story == nil then
				arg_83_1.var_.characterEffect10079ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect10079ui_story and not isNil(var_86_9) then
					arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect10079ui_story then
				arg_83_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_86_13 = 0

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				arg_83_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_86_14 = 0

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_15 = 0
			local var_86_16 = 0.375

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_17 = arg_83_1:FormatText(StoryNameCfg[6].name)

				arg_83_1.leftNameTxt_.text = var_86_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_18 = arg_83_1:GetWordFromCfg(319291020)
				local var_86_19 = arg_83_1:FormatText(var_86_18.content)

				arg_83_1.text_.text = var_86_19

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_20 = 15
				local var_86_21 = utf8.len(var_86_19)
				local var_86_22 = var_86_20 <= 0 and var_86_16 or var_86_16 * (var_86_21 / var_86_20)

				if var_86_22 > 0 and var_86_16 < var_86_22 then
					arg_83_1.talkMaxDuration = var_86_22

					if var_86_22 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_22 + var_86_15
					end
				end

				arg_83_1.text_.text = var_86_19
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291020", "story_v_out_319291.awb") ~= 0 then
					local var_86_23 = manager.audio:GetVoiceLength("story_v_out_319291", "319291020", "story_v_out_319291.awb") / 1000

					if var_86_23 + var_86_15 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_23 + var_86_15
					end

					if var_86_18.prefab_name ~= "" and arg_83_1.actors_[var_86_18.prefab_name] ~= nil then
						local var_86_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_18.prefab_name].transform, "story_v_out_319291", "319291020", "story_v_out_319291.awb")

						arg_83_1:RecordAudio("319291020", var_86_24)
						arg_83_1:RecordAudio("319291020", var_86_24)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319291", "319291020", "story_v_out_319291.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319291", "319291020", "story_v_out_319291.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_16, arg_83_1.talkMaxDuration)

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_15) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_15 + var_86_25 and arg_83_1.time_ < var_86_15 + var_86_25 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319291021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319291021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319291022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["10079ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10079ui_story == nil then
				arg_87_1.var_.characterEffect10079ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect10079ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10079ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect10079ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10079ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 1.025

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

				local var_90_8 = arg_87_1:GetWordFromCfg(319291021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 41
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
	Play319291022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319291022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319291023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.15

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[36].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(319291022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 6
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319291023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319291023
		arg_95_1.duration_ = 6.15

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319291024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = "STblack"

			if arg_95_1.bgs_[var_98_0] == nil then
				local var_98_1 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_98_0)
				var_98_1.name = var_98_0
				var_98_1.transform.parent = arg_95_1.stage_.transform
				var_98_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_[var_98_0] = var_98_1
			end

			local var_98_2 = 0

			if var_98_2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				local var_98_3 = manager.ui.mainCamera.transform.localPosition
				local var_98_4 = Vector3.New(0, 0, 10) + Vector3.New(var_98_3.x, var_98_3.y, 0)
				local var_98_5 = arg_95_1.bgs_.STblack

				var_98_5.transform.localPosition = var_98_4
				var_98_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_6 = var_98_5:GetComponent("SpriteRenderer")

				if var_98_6 and var_98_6.sprite then
					local var_98_7 = (var_98_5.transform.localPosition - var_98_3).z
					local var_98_8 = manager.ui.mainCameraCom_
					local var_98_9 = 2 * var_98_7 * Mathf.Tan(var_98_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_98_10 = var_98_9 * var_98_8.aspect
					local var_98_11 = var_98_6.sprite.bounds.size.x
					local var_98_12 = var_98_6.sprite.bounds.size.y
					local var_98_13 = var_98_10 / var_98_11
					local var_98_14 = var_98_9 / var_98_12
					local var_98_15 = var_98_14 < var_98_13 and var_98_13 or var_98_14

					var_98_5.transform.localScale = Vector3.New(var_98_15, var_98_15, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "STblack" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_16 = arg_95_1.actors_["10079ui_story"].transform
			local var_98_17 = 0

			if var_98_17 < arg_95_1.time_ and arg_95_1.time_ <= var_98_17 + arg_98_0 then
				arg_95_1.var_.moveOldPos10079ui_story = var_98_16.localPosition
			end

			local var_98_18 = 0.001

			if var_98_17 <= arg_95_1.time_ and arg_95_1.time_ < var_98_17 + var_98_18 then
				local var_98_19 = (arg_95_1.time_ - var_98_17) / var_98_18
				local var_98_20 = Vector3.New(0, 100, 0)

				var_98_16.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10079ui_story, var_98_20, var_98_19)

				local var_98_21 = manager.ui.mainCamera.transform.position - var_98_16.position

				var_98_16.forward = Vector3.New(var_98_21.x, var_98_21.y, var_98_21.z)

				local var_98_22 = var_98_16.localEulerAngles

				var_98_22.z = 0
				var_98_22.x = 0
				var_98_16.localEulerAngles = var_98_22
			end

			if arg_95_1.time_ >= var_98_17 + var_98_18 and arg_95_1.time_ < var_98_17 + var_98_18 + arg_98_0 then
				var_98_16.localPosition = Vector3.New(0, 100, 0)

				local var_98_23 = manager.ui.mainCamera.transform.position - var_98_16.position

				var_98_16.forward = Vector3.New(var_98_23.x, var_98_23.y, var_98_23.z)

				local var_98_24 = var_98_16.localEulerAngles

				var_98_24.z = 0
				var_98_24.x = 0
				var_98_16.localEulerAngles = var_98_24
			end

			local var_98_25 = 0

			if var_98_25 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 then
				local var_98_26 = arg_95_1.fswbg_.transform:Find("textbox/adapt/content") or arg_95_1.fswbg_.transform:Find("textbox/content")
				local var_98_27 = arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_98_28 = var_98_26:GetComponent("Text")
				local var_98_29 = var_98_26:GetComponent("RectTransform")

				var_98_28.alignment = UnityEngine.TextAnchor.LowerCenter
				var_98_29.offsetMin = Vector2.New(0, 0)
				var_98_29.offsetMax = Vector2.New(0, 0)
			end

			local var_98_30 = 0

			if var_98_30 < arg_95_1.time_ and arg_95_1.time_ <= var_98_30 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0

				local var_98_31 = arg_95_1:GetWordFromCfg(319291023)
				local var_98_32 = arg_95_1:FormatText(var_98_31.content)

				arg_95_1.fswt_.text = var_98_32

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_33 = 0.218802510580911

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_34 = 30
			local var_98_35 = 2
			local var_98_36 = arg_95_1:GetWordFromCfg(319291023)
			local var_98_37 = arg_95_1:FormatText(var_98_36.content)
			local var_98_38, var_98_39 = arg_95_1:GetPercentByPara(var_98_37, 1)

			if var_98_33 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_40 = var_98_34 <= 0 and var_98_35 or var_98_35 * ((var_98_39 - arg_95_1.typewritterCharCountI18N) / var_98_34)

				if var_98_40 > 0 and var_98_35 < var_98_40 then
					arg_95_1.talkMaxDuration = var_98_40

					if var_98_40 + var_98_33 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_40 + var_98_33
					end
				end
			end

			local var_98_41 = 2
			local var_98_42 = math.max(var_98_41, arg_95_1.talkMaxDuration)

			if var_98_33 <= arg_95_1.time_ and arg_95_1.time_ < var_98_33 + var_98_42 then
				local var_98_43 = (arg_95_1.time_ - var_98_33) / var_98_42

				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_38, var_98_43)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_33 + var_98_42 and arg_95_1.time_ < var_98_33 + var_98_42 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_38

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_39
			end

			local var_98_44 = 0

			if var_98_44 < arg_95_1.time_ and arg_95_1.time_ <= var_98_44 + arg_98_0 then
				arg_95_1.cswbg_:SetActive(true)

				local var_98_45 = arg_95_1.cswt_:GetComponent("RectTransform")

				arg_95_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_98_45.offsetMin = Vector2.New(410, 330)
				var_98_45.offsetMax = Vector2.New(-400, -175)

				local var_98_46 = arg_95_1:GetWordFromCfg(419006)
				local var_98_47 = arg_95_1:FormatText(var_98_46.content)

				arg_95_1.cswt_.text = var_98_47

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.cswt_)

				arg_95_1.cswt_.fontSize = 180
				arg_95_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_95_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_98_48 = 0.218802510580911
			local var_98_49 = 5.933
			local var_98_50 = manager.audio:GetVoiceLength("story_v_out_319291", "319291023", "story_v_out_319291.awb") / 1000

			if var_98_50 > 0 and var_98_49 < var_98_50 and var_98_50 + var_98_48 > arg_95_1.duration_ then
				local var_98_51 = var_98_50

				arg_95_1.duration_ = var_98_50 + var_98_48
			end

			if var_98_48 < arg_95_1.time_ and arg_95_1.time_ <= var_98_48 + arg_98_0 then
				local var_98_52 = "play"
				local var_98_53 = "voice"

				arg_95_1:AudioAction(var_98_52, var_98_53, "story_v_out_319291", "319291023", "story_v_out_319291.awb")
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319291024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319291024
		arg_99_1.duration_ = 6

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319291025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				local var_102_1 = arg_99_1.fswbg_.transform:Find("textbox/adapt/content") or arg_99_1.fswbg_.transform:Find("textbox/content")
				local var_102_2 = arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_102_3 = var_102_1:GetComponent("Text")
				local var_102_4 = var_102_1:GetComponent("RectTransform")

				var_102_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_102_4.offsetMin = Vector2.New(0, 0)
				var_102_4.offsetMax = Vector2.New(0, 0)
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0

				local var_102_6 = arg_99_1:GetWordFromCfg(319291024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.fswt_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_8 = 0.1

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_9 = 29
			local var_102_10 = 1.93333333333333
			local var_102_11 = arg_99_1:GetWordFromCfg(319291024)
			local var_102_12 = arg_99_1:FormatText(var_102_11.content)
			local var_102_13, var_102_14 = arg_99_1:GetPercentByPara(var_102_12, 1)

			if var_102_8 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_15 = var_102_9 <= 0 and var_102_10 or var_102_10 * ((var_102_14 - arg_99_1.typewritterCharCountI18N) / var_102_9)

				if var_102_15 > 0 and var_102_10 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_8
					end
				end
			end

			local var_102_16 = 1.93333333333333
			local var_102_17 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_17 then
				local var_102_18 = (arg_99_1.time_ - var_102_8) / var_102_17

				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_13, var_102_18)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_17 and arg_99_1.time_ < var_102_8 + var_102_17 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_13

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_14
			end

			local var_102_19 = 0.1
			local var_102_20 = 5.9
			local var_102_21 = manager.audio:GetVoiceLength("story_v_out_319291", "319291024", "story_v_out_319291.awb") / 1000

			if var_102_21 > 0 and var_102_20 < var_102_21 and var_102_21 + var_102_19 > arg_99_1.duration_ then
				local var_102_22 = var_102_21

				arg_99_1.duration_ = var_102_21 + var_102_19
			end

			if var_102_19 < arg_99_1.time_ and arg_99_1.time_ <= var_102_19 + arg_102_0 then
				local var_102_23 = "play"
				local var_102_24 = "voice"

				arg_99_1:AudioAction(var_102_23, var_102_24, "story_v_out_319291", "319291024", "story_v_out_319291.awb")
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319291025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319291025
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319291026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.fswbg_:SetActive(true)
				arg_103_1.dialog_:SetActive(false)

				arg_103_1.fswtw_.percent = 0

				local var_106_1 = arg_103_1:GetWordFromCfg(319291025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.fswt_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.fswt_)

				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_103_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_103_1.fswtw_:SetDirty()

				arg_103_1.typewritterCharCountI18N = 0

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_3 = 0.1

			if var_106_3 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_4 = 2
			local var_106_5 = 0.133333333333333
			local var_106_6 = arg_103_1:GetWordFromCfg(319291025)
			local var_106_7 = arg_103_1:FormatText(var_106_6.content)
			local var_106_8, var_106_9 = arg_103_1:GetPercentByPara(var_106_7, 1)

			if var_106_3 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_10 = var_106_4 <= 0 and var_106_5 or var_106_5 * ((var_106_9 - arg_103_1.typewritterCharCountI18N) / var_106_4)

				if var_106_10 > 0 and var_106_5 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_3
					end
				end
			end

			local var_106_11 = 0.133333333333333
			local var_106_12 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_3) / var_106_12

				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_8, var_106_13)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_12 and arg_103_1.time_ < var_106_3 + var_106_12 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_8

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_9
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319291026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319291026
		arg_107_1.duration_ = 3.7

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319291027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.fswbg_:SetActive(true)
				arg_107_1.dialog_:SetActive(false)

				arg_107_1.fswtw_.percent = 0

				local var_110_1 = arg_107_1:GetWordFromCfg(319291026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.fswt_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.fswt_)

				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_107_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_107_1.fswtw_:SetDirty()

				arg_107_1.typewritterCharCountI18N = 0

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_3 = 0.1

			if var_110_3 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_4 = 16
			local var_110_5 = 1.06666666666667
			local var_110_6 = arg_107_1:GetWordFromCfg(319291026)
			local var_110_7 = arg_107_1:FormatText(var_110_6.content)
			local var_110_8, var_110_9 = arg_107_1:GetPercentByPara(var_110_7, 1)

			if var_110_3 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_10 = var_110_4 <= 0 and var_110_5 or var_110_5 * ((var_110_9 - arg_107_1.typewritterCharCountI18N) / var_110_4)

				if var_110_10 > 0 and var_110_5 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_3
					end
				end
			end

			local var_110_11 = 1.06666666666667
			local var_110_12 = math.max(var_110_11, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_12 then
				local var_110_13 = (arg_107_1.time_ - var_110_3) / var_110_12

				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_8, var_110_13)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_12 and arg_107_1.time_ < var_110_3 + var_110_12 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_8

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_9
			end

			local var_110_14 = 0.1
			local var_110_15 = 3.6
			local var_110_16 = manager.audio:GetVoiceLength("story_v_out_319291", "319291026", "story_v_out_319291.awb") / 1000

			if var_110_16 > 0 and var_110_15 < var_110_16 and var_110_16 + var_110_14 > arg_107_1.duration_ then
				local var_110_17 = var_110_16

				arg_107_1.duration_ = var_110_16 + var_110_14
			end

			if var_110_14 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				local var_110_18 = "play"
				local var_110_19 = "voice"

				arg_107_1:AudioAction(var_110_18, var_110_19, "story_v_out_319291", "319291026", "story_v_out_319291.awb")
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319291027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319291027
		arg_111_1.duration_ = 5.62

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319291028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				local var_114_1 = manager.ui.mainCamera.transform.localPosition
				local var_114_2 = Vector3.New(0, 0, 10) + Vector3.New(var_114_1.x, var_114_1.y, 0)
				local var_114_3 = arg_111_1.bgs_.I10f

				var_114_3.transform.localPosition = var_114_2
				var_114_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_4 = var_114_3:GetComponent("SpriteRenderer")

				if var_114_4 and var_114_4.sprite then
					local var_114_5 = (var_114_3.transform.localPosition - var_114_1).z
					local var_114_6 = manager.ui.mainCameraCom_
					local var_114_7 = 2 * var_114_5 * Mathf.Tan(var_114_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_114_8 = var_114_7 * var_114_6.aspect
					local var_114_9 = var_114_4.sprite.bounds.size.x
					local var_114_10 = var_114_4.sprite.bounds.size.y
					local var_114_11 = var_114_8 / var_114_9
					local var_114_12 = var_114_7 / var_114_10
					local var_114_13 = var_114_12 < var_114_11 and var_114_11 or var_114_12

					var_114_3.transform.localScale = Vector3.New(var_114_13, var_114_13, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "I10f" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(false)
				arg_111_1.dialog_:SetActive(false)
				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_15 = 0.0333333333333332

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(false)
				arg_111_1.dialog_:SetActive(false)
				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_16 = 0

			if var_114_16 < arg_111_1.time_ and arg_111_1.time_ <= var_114_16 + arg_114_0 then
				arg_111_1.cswbg_:SetActive(false)
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_17 = 0.625
			local var_114_18 = 1.375

			if var_114_17 < arg_111_1.time_ and arg_111_1.time_ <= var_114_17 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_19 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_19:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_20 = arg_111_1:GetWordFromCfg(319291027)
				local var_114_21 = arg_111_1:FormatText(var_114_20.content)

				arg_111_1.text_.text = var_114_21

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_22 = 53
				local var_114_23 = utf8.len(var_114_21)
				local var_114_24 = var_114_22 <= 0 and var_114_18 or var_114_18 * (var_114_23 / var_114_22)

				if var_114_24 > 0 and var_114_18 < var_114_24 then
					arg_111_1.talkMaxDuration = var_114_24
					var_114_17 = var_114_17 + 0.3

					if var_114_24 + var_114_17 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_24 + var_114_17
					end
				end

				arg_111_1.text_.text = var_114_21
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = var_114_17 + 0.3
			local var_114_26 = math.max(var_114_18, arg_111_1.talkMaxDuration)

			if var_114_25 <= arg_111_1.time_ and arg_111_1.time_ < var_114_25 + var_114_26 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_25) / var_114_26

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_25 + var_114_26 and arg_111_1.time_ < var_114_25 + var_114_26 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319291028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319291028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319291029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.6

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[36].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(319291028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 24
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319291029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319291029
		arg_121_1.duration_ = 4.07

		local var_121_0 = {
			zh = 2.6,
			ja = 4.066
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319291030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10079ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10079ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -0.95, -6.05)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10079ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10079ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10079ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10079ui_story then
				arg_121_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_15 = 0
			local var_124_16 = 0.225

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(319291029)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 9
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291029", "story_v_out_319291.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_319291", "319291029", "story_v_out_319291.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_319291", "319291029", "story_v_out_319291.awb")

						arg_121_1:RecordAudio("319291029", var_124_24)
						arg_121_1:RecordAudio("319291029", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319291", "319291029", "story_v_out_319291.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319291", "319291029", "story_v_out_319291.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play319291030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319291030
		arg_125_1.duration_ = 9.53

		local var_125_0 = {
			zh = 5.733,
			ja = 9.533
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319291031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.65

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(319291030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 26
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291030", "story_v_out_319291.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_319291", "319291030", "story_v_out_319291.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_319291", "319291030", "story_v_out_319291.awb")

						arg_125_1:RecordAudio("319291030", var_128_9)
						arg_125_1:RecordAudio("319291030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319291", "319291030", "story_v_out_319291.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319291", "319291030", "story_v_out_319291.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319291031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319291031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319291032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10079ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10079ui_story == nil then
				arg_129_1.var_.characterEffect10079ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10079ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10079ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10079ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10079ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.55

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[36].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:GetWordFromCfg(319291031)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 22
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319291032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319291032
		arg_133_1.duration_ = 9.37

		local var_133_0 = {
			zh = 5.466,
			ja = 9.366
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319291033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10079ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10079ui_story == nil then
				arg_133_1.var_.characterEffect10079ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10079ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10079ui_story then
				arg_133_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_6 = 0
			local var_136_7 = 0.5

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(319291032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 20
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291032", "story_v_out_319291.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_319291", "319291032", "story_v_out_319291.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_319291", "319291032", "story_v_out_319291.awb")

						arg_133_1:RecordAudio("319291032", var_136_15)
						arg_133_1:RecordAudio("319291032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319291", "319291032", "story_v_out_319291.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319291", "319291032", "story_v_out_319291.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play319291033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319291033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319291034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10079ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10079ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10079ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10079ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10079ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.275

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[36].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(319291033)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 11
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319291034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319291034
		arg_141_1.duration_ = 5.63

		local var_141_0 = {
			zh = 5.633,
			ja = 3.366
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319291035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10079ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story == nil then
				arg_141_1.var_.characterEffect10079ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10079ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10079ui_story then
				arg_141_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_144_4 = 0
			local var_144_5 = 0.675

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_6 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(319291034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 27
				local var_144_10 = utf8.len(var_144_8)
				local var_144_11 = var_144_9 <= 0 and var_144_5 or var_144_5 * (var_144_10 / var_144_9)

				if var_144_11 > 0 and var_144_5 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291034", "story_v_out_319291.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_319291", "319291034", "story_v_out_319291.awb") / 1000

					if var_144_12 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_4
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_319291", "319291034", "story_v_out_319291.awb")

						arg_141_1:RecordAudio("319291034", var_144_13)
						arg_141_1:RecordAudio("319291034", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_319291", "319291034", "story_v_out_319291.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_319291", "319291034", "story_v_out_319291.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_14 and arg_141_1.time_ < var_144_4 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319291035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319291035
		arg_145_1.duration_ = 5.97

		local var_145_0 = {
			zh = 3.6,
			ja = 5.966
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play319291036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.3

			if var_148_2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_4 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:GetWordFromCfg(319291035)
				local var_148_6 = arg_145_1:FormatText(var_148_5.content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 12
				local var_148_8 = utf8.len(var_148_6)
				local var_148_9 = var_148_7 <= 0 and var_148_3 or var_148_3 * (var_148_8 / var_148_7)

				if var_148_9 > 0 and var_148_3 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291035", "story_v_out_319291.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_319291", "319291035", "story_v_out_319291.awb") / 1000

					if var_148_10 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_2
					end

					if var_148_5.prefab_name ~= "" and arg_145_1.actors_[var_148_5.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_5.prefab_name].transform, "story_v_out_319291", "319291035", "story_v_out_319291.awb")

						arg_145_1:RecordAudio("319291035", var_148_11)
						arg_145_1:RecordAudio("319291035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319291", "319291035", "story_v_out_319291.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319291", "319291035", "story_v_out_319291.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_12 and arg_145_1.time_ < var_148_2 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319291036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319291036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play319291037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10079ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10079ui_story == nil then
				arg_149_1.var_.characterEffect10079ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10079ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10079ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10079ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10079ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.3

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[36].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:GetWordFromCfg(319291036)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 12
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319291037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319291037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play319291038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.725

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[36].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:GetWordFromCfg(319291037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 29
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319291038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319291038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play319291039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.475

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[36].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(319291038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 19
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319291039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319291039
		arg_161_1.duration_ = 13.93

		local var_161_0 = {
			zh = 5,
			ja = 13.933
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319291040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10079ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10079ui_story == nil then
				arg_161_1.var_.characterEffect10079ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect10079ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10079ui_story then
				arg_161_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_164_4 = 0
			local var_164_5 = 0.525

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_6 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(319291039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 21
				local var_164_10 = utf8.len(var_164_8)
				local var_164_11 = var_164_9 <= 0 and var_164_5 or var_164_5 * (var_164_10 / var_164_9)

				if var_164_11 > 0 and var_164_5 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291039", "story_v_out_319291.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_319291", "319291039", "story_v_out_319291.awb") / 1000

					if var_164_12 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_4
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_319291", "319291039", "story_v_out_319291.awb")

						arg_161_1:RecordAudio("319291039", var_164_13)
						arg_161_1:RecordAudio("319291039", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319291", "319291039", "story_v_out_319291.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319291", "319291039", "story_v_out_319291.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_14 and arg_161_1.time_ < var_164_4 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319291040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319291040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319291041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10079ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10079ui_story == nil then
				arg_165_1.var_.characterEffect10079ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10079ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10079ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10079ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10079ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.8

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(319291040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 32
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319291041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319291041
		arg_169_1.duration_ = 3.6

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 3.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319291042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10079ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10079ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, -0.95, -6.05)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10079ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["10079ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect10079ui_story == nil then
				arg_169_1.var_.characterEffect10079ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect10079ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect10079ui_story then
				arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_172_15 = 0
			local var_172_16 = 0.15

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[6].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(319291041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 6
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291041", "story_v_out_319291.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_319291", "319291041", "story_v_out_319291.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_319291", "319291041", "story_v_out_319291.awb")

						arg_169_1:RecordAudio("319291041", var_172_24)
						arg_169_1:RecordAudio("319291041", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319291", "319291041", "story_v_out_319291.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319291", "319291041", "story_v_out_319291.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319291042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319291042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319291043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10079ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10079ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect10079ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10079ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.15

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[36].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_9 = arg_173_1:GetWordFromCfg(319291042)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 6
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319291043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319291043
		arg_177_1.duration_ = 11.93

		local var_177_0 = {
			zh = 9.1,
			ja = 11.933
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319291044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10079ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_180_5 = 0
			local var_180_6 = 1.4

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_7 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(319291043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 40
				local var_180_11 = utf8.len(var_180_9)
				local var_180_12 = var_180_10 <= 0 and var_180_6 or var_180_6 * (var_180_11 / var_180_10)

				if var_180_12 > 0 and var_180_6 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291043", "story_v_out_319291.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_out_319291", "319291043", "story_v_out_319291.awb") / 1000

					if var_180_13 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_5
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_319291", "319291043", "story_v_out_319291.awb")

						arg_177_1:RecordAudio("319291043", var_180_14)
						arg_177_1:RecordAudio("319291043", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319291", "319291043", "story_v_out_319291.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319291", "319291043", "story_v_out_319291.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_15 and arg_177_1.time_ < var_180_5 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319291044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319291044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319291045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10079ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10079ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 1.175

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(319291044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 40
				local var_184_11 = utf8.len(var_184_9)
				local var_184_12 = var_184_10 <= 0 and var_184_7 or var_184_7 * (var_184_11 / var_184_10)

				if var_184_12 > 0 and var_184_7 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_13 and arg_181_1.time_ < var_184_6 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319291045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319291045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319291046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.6

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[36].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(319291045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 24
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319291046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319291046
		arg_189_1.duration_ = 9.43

		local var_189_0 = {
			zh = 3.466,
			ja = 9.433
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319291047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10079ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10079ui_story == nil then
				arg_189_1.var_.characterEffect10079ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10079ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10079ui_story then
				arg_189_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_192_4 = 0
			local var_192_5 = 0.325

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_6 = arg_189_1:FormatText(StoryNameCfg[6].name)

				arg_189_1.leftNameTxt_.text = var_192_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(319291046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 13
				local var_192_10 = utf8.len(var_192_8)
				local var_192_11 = var_192_9 <= 0 and var_192_5 or var_192_5 * (var_192_10 / var_192_9)

				if var_192_11 > 0 and var_192_5 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291046", "story_v_out_319291.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_319291", "319291046", "story_v_out_319291.awb") / 1000

					if var_192_12 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_4
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_319291", "319291046", "story_v_out_319291.awb")

						arg_189_1:RecordAudio("319291046", var_192_13)
						arg_189_1:RecordAudio("319291046", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319291", "319291046", "story_v_out_319291.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319291", "319291046", "story_v_out_319291.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_14 and arg_189_1.time_ < var_192_4 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319291047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319291047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319291048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10079ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10079ui_story == nil then
				arg_193_1.var_.characterEffect10079ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect10079ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10079ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10079ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10079ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 0.1

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[36].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_9 = arg_193_1:GetWordFromCfg(319291047)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 4
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319291048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319291048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play319291049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10079ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10079ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10079ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = 0
			local var_200_10 = 0.95

			if var_200_9 < arg_197_1.time_ and arg_197_1.time_ <= var_200_9 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_11 = arg_197_1:GetWordFromCfg(319291048)
				local var_200_12 = arg_197_1:FormatText(var_200_11.content)

				arg_197_1.text_.text = var_200_12

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 38
				local var_200_14 = utf8.len(var_200_12)
				local var_200_15 = var_200_13 <= 0 and var_200_10 or var_200_10 * (var_200_14 / var_200_13)

				if var_200_15 > 0 and var_200_10 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_9 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_9
					end
				end

				arg_197_1.text_.text = var_200_12
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_10, arg_197_1.talkMaxDuration)

			if var_200_9 <= arg_197_1.time_ and arg_197_1.time_ < var_200_9 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_9) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_9 + var_200_16 and arg_197_1.time_ < var_200_9 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play319291049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319291049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319291050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.525

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(319291049)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 61
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319291050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319291050
		arg_205_1.duration_ = 5.7

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 5.7
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10079ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10079ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, -0.95, -6.05)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10079ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["10079ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10079ui_story == nil then
				arg_205_1.var_.characterEffect10079ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect10079ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect10079ui_story then
				arg_205_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_208_15 = 0
			local var_208_16 = 0.125

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[6].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(319291050)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 5
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319291", "319291050", "story_v_out_319291.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_319291", "319291050", "story_v_out_319291.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_319291", "319291050", "story_v_out_319291.awb")

						arg_205_1:RecordAudio("319291050", var_208_24)
						arg_205_1:RecordAudio("319291050", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319291", "319291050", "story_v_out_319291.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319291", "319291050", "story_v_out_319291.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I10f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319291.awb"
	}
}
