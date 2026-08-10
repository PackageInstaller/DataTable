return {
	Play112033001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112033001
		arg_1_1.duration_ = 5.27

		local var_1_0 = {
			ja = 4.3,
			ko = 5.266,
			zh = 4.366,
			en = 4.933
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
				arg_1_0:Play112033002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "1039ui_story"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_1_1.stage_.transform)

					var_4_2.name = var_4_0
					var_4_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_0] = var_4_2

					local var_4_3 = var_4_2:GetComponentInChildren(typeof(CharacterEffect))

					var_4_3.enabled = true

					local var_4_4 = GameObjectTools.GetOrAddComponent(var_4_2, typeof(DynamicBoneHelper))

					if var_4_4 then
						var_4_4:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_3.transform, false)

					arg_1_1.var_[var_4_0 .. "Animator"] = var_4_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_0 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_0 .. "LipSync"] = var_4_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_5 = arg_1_1.actors_["1039ui_story"].transform
			local var_4_6 = 0

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.var_.moveOldPos1039ui_story = var_4_5.localPosition
			end

			local var_4_7 = 0.001

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7
				local var_4_9 = Vector3.New(-0.7, -1.01, -5.9)

				var_4_5.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1039ui_story, var_4_9, var_4_8)

				local var_4_10 = manager.ui.mainCamera.transform.position - var_4_5.position

				var_4_5.forward = Vector3.New(var_4_10.x, var_4_10.y, var_4_10.z)

				local var_4_11 = var_4_5.localEulerAngles

				var_4_11.z = 0
				var_4_11.x = 0
				var_4_5.localEulerAngles = var_4_11
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				var_4_5.localPosition = Vector3.New(-0.7, -1.01, -5.9)

				local var_4_12 = manager.ui.mainCamera.transform.position - var_4_5.position

				var_4_5.forward = Vector3.New(var_4_12.x, var_4_12.y, var_4_12.z)

				local var_4_13 = var_4_5.localEulerAngles

				var_4_13.z = 0
				var_4_13.x = 0
				var_4_5.localEulerAngles = var_4_13
			end

			local var_4_14 = 0

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_4_15 = 0

			if var_4_15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_4_16 = arg_1_1.actors_["1039ui_story"]
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 and not isNil(var_4_16) and arg_1_1.var_.characterEffect1039ui_story == nil then
				arg_1_1.var_.characterEffect1039ui_story = var_4_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.2

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 and not isNil(var_4_16) then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / var_4_18

				if arg_1_1.var_.characterEffect1039ui_story and not isNil(var_4_16) then
					arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 and not isNil(var_4_16) and arg_1_1.var_.characterEffect1039ui_story then
				arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_4_20 = 0
			local var_4_21 = 0.425

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_22 = arg_1_1:FormatText(StoryNameCfg[9].name)

				arg_1_1.leftNameTxt_.text = var_4_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(112033001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 17
				local var_4_26 = utf8.len(var_4_24)
				local var_4_27 = var_4_25 <= 0 and var_4_21 or var_4_21 * (var_4_26 / var_4_25)

				if var_4_27 > 0 and var_4_21 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033001", "story_v_out_112033.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_112033", "112033001", "story_v_out_112033.awb") / 1000

					if var_4_28 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_112033", "112033001", "story_v_out_112033.awb")

						arg_1_1:RecordAudio("112033001", var_4_29)
						arg_1_1:RecordAudio("112033001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_112033", "112033001", "story_v_out_112033.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_112033", "112033001", "story_v_out_112033.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_30 and arg_1_1.time_ < var_4_20 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play112033002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 112033002
		arg_5_1.duration_ = 5.6

		local var_5_0 = {
			ja = 4.3,
			ko = 4.366,
			zh = 5.6,
			en = 4.666
		}
		local var_5_1 = manager.audio:GetLocalizationFlag()

		if var_5_0[var_5_1] ~= nil then
			arg_5_1.duration_ = var_5_0[var_5_1]
		end

		SetActive(arg_5_1.tipsGo_, false)

		function arg_5_1.onSingleLineFinish_()
			arg_5_1.onSingleLineUpdate_ = nil
			arg_5_1.onSingleLineFinish_ = nil
			arg_5_1.state_ = "waiting"
		end

		function arg_5_1.playNext_(arg_7_0)
			if arg_7_0 == 1 then
				arg_5_0:Play112033003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_0 = "1084ui_story"

			if arg_5_1.actors_[var_8_0] == nil then
				local var_8_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_8_1) then
					local var_8_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_5_1.stage_.transform)

					var_8_2.name = var_8_0
					var_8_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_5_1.actors_[var_8_0] = var_8_2

					local var_8_3 = var_8_2:GetComponentInChildren(typeof(CharacterEffect))

					var_8_3.enabled = true

					local var_8_4 = GameObjectTools.GetOrAddComponent(var_8_2, typeof(DynamicBoneHelper))

					if var_8_4 then
						var_8_4:EnableDynamicBone(false)
					end

					arg_5_1:ShowWeapon(var_8_3.transform, false)

					arg_5_1.var_[var_8_0 .. "Animator"] = var_8_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_5_1.var_[var_8_0 .. "Animator"].applyRootMotion = true
					arg_5_1.var_[var_8_0 .. "LipSync"] = var_8_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_8_5 = arg_5_1.actors_["1084ui_story"].transform
			local var_8_6 = 0

			if var_8_6 < arg_5_1.time_ and arg_5_1.time_ <= var_8_6 + arg_8_0 then
				arg_5_1.var_.moveOldPos1084ui_story = var_8_5.localPosition
			end

			local var_8_7 = 0.001

			if var_8_6 <= arg_5_1.time_ and arg_5_1.time_ < var_8_6 + var_8_7 then
				local var_8_8 = (arg_5_1.time_ - var_8_6) / var_8_7
				local var_8_9 = Vector3.New(0.7, -0.97, -6)

				var_8_5.localPosition = Vector3.Lerp(arg_5_1.var_.moveOldPos1084ui_story, var_8_9, var_8_8)

				local var_8_10 = manager.ui.mainCamera.transform.position - var_8_5.position

				var_8_5.forward = Vector3.New(var_8_10.x, var_8_10.y, var_8_10.z)

				local var_8_11 = var_8_5.localEulerAngles

				var_8_11.z = 0
				var_8_11.x = 0
				var_8_5.localEulerAngles = var_8_11
			end

			if arg_5_1.time_ >= var_8_6 + var_8_7 and arg_5_1.time_ < var_8_6 + var_8_7 + arg_8_0 then
				var_8_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_8_12 = manager.ui.mainCamera.transform.position - var_8_5.position

				var_8_5.forward = Vector3.New(var_8_12.x, var_8_12.y, var_8_12.z)

				local var_8_13 = var_8_5.localEulerAngles

				var_8_13.z = 0
				var_8_13.x = 0
				var_8_5.localEulerAngles = var_8_13
			end

			local var_8_14 = 0

			if var_8_14 < arg_5_1.time_ and arg_5_1.time_ <= var_8_14 + arg_8_0 then
				arg_5_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_8_15 = 0

			if var_8_15 < arg_5_1.time_ and arg_5_1.time_ <= var_8_15 + arg_8_0 then
				arg_5_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_8_16 = arg_5_1.actors_["1084ui_story"]
			local var_8_17 = 0

			if var_8_17 < arg_5_1.time_ and arg_5_1.time_ <= var_8_17 + arg_8_0 and not isNil(var_8_16) and arg_5_1.var_.characterEffect1084ui_story == nil then
				arg_5_1.var_.characterEffect1084ui_story = var_8_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_8_18 = 0.2

			if var_8_17 <= arg_5_1.time_ and arg_5_1.time_ < var_8_17 + var_8_18 and not isNil(var_8_16) then
				local var_8_19 = (arg_5_1.time_ - var_8_17) / var_8_18

				if arg_5_1.var_.characterEffect1084ui_story and not isNil(var_8_16) then
					arg_5_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_5_1.time_ >= var_8_17 + var_8_18 and arg_5_1.time_ < var_8_17 + var_8_18 + arg_8_0 and not isNil(var_8_16) and arg_5_1.var_.characterEffect1084ui_story then
				arg_5_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_8_20 = arg_5_1.actors_["1039ui_story"]
			local var_8_21 = 0

			if var_8_21 < arg_5_1.time_ and arg_5_1.time_ <= var_8_21 + arg_8_0 and not isNil(var_8_20) and arg_5_1.var_.characterEffect1039ui_story == nil then
				arg_5_1.var_.characterEffect1039ui_story = var_8_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_8_22 = 0.2

			if var_8_21 <= arg_5_1.time_ and arg_5_1.time_ < var_8_21 + var_8_22 and not isNil(var_8_20) then
				local var_8_23 = (arg_5_1.time_ - var_8_21) / var_8_22

				if arg_5_1.var_.characterEffect1039ui_story and not isNil(var_8_20) then
					local var_8_24 = Mathf.Lerp(0, 0.5, var_8_23)

					arg_5_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_5_1.var_.characterEffect1039ui_story.fillRatio = var_8_24
				end
			end

			if arg_5_1.time_ >= var_8_21 + var_8_22 and arg_5_1.time_ < var_8_21 + var_8_22 + arg_8_0 and not isNil(var_8_20) and arg_5_1.var_.characterEffect1039ui_story then
				local var_8_25 = 0.5

				arg_5_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_5_1.var_.characterEffect1039ui_story.fillRatio = var_8_25
			end

			local var_8_26 = 0
			local var_8_27 = 0.4

			if var_8_26 < arg_5_1.time_ and arg_5_1.time_ <= var_8_26 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				local var_8_28 = arg_5_1:FormatText(StoryNameCfg[6].name)

				arg_5_1.leftNameTxt_.text = var_8_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_29 = arg_5_1:GetWordFromCfg(112033002)
				local var_8_30 = arg_5_1:FormatText(var_8_29.content)

				arg_5_1.text_.text = var_8_30

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_31 = 16
				local var_8_32 = utf8.len(var_8_30)
				local var_8_33 = var_8_31 <= 0 and var_8_27 or var_8_27 * (var_8_32 / var_8_31)

				if var_8_33 > 0 and var_8_27 < var_8_33 then
					arg_5_1.talkMaxDuration = var_8_33

					if var_8_33 + var_8_26 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_33 + var_8_26
					end
				end

				arg_5_1.text_.text = var_8_30
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033002", "story_v_out_112033.awb") ~= 0 then
					local var_8_34 = manager.audio:GetVoiceLength("story_v_out_112033", "112033002", "story_v_out_112033.awb") / 1000

					if var_8_34 + var_8_26 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_34 + var_8_26
					end

					if var_8_29.prefab_name ~= "" and arg_5_1.actors_[var_8_29.prefab_name] ~= nil then
						local var_8_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_5_1.actors_[var_8_29.prefab_name].transform, "story_v_out_112033", "112033002", "story_v_out_112033.awb")

						arg_5_1:RecordAudio("112033002", var_8_35)
						arg_5_1:RecordAudio("112033002", var_8_35)
					else
						arg_5_1:AudioAction("play", "voice", "story_v_out_112033", "112033002", "story_v_out_112033.awb")
					end

					arg_5_1:RecordHistoryTalkVoice("story_v_out_112033", "112033002", "story_v_out_112033.awb")
				end

				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_36 = math.max(var_8_27, arg_5_1.talkMaxDuration)

			if var_8_26 <= arg_5_1.time_ and arg_5_1.time_ < var_8_26 + var_8_36 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_26) / var_8_36

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_26 + var_8_36 and arg_5_1.time_ < var_8_26 + var_8_36 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {
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

		arg_5_1:InitPlayNodeList()
	end,
	Play112033003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 112033003
		arg_9_1.duration_ = 6.07

		local var_9_0 = {
			ja = 6.066,
			ko = 4.333,
			zh = 3.866,
			en = 3.733
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
				arg_9_0:Play112033004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = "1027ui_story"

			if arg_9_1.actors_[var_12_9] == nil then
				local var_12_10 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_12_10) then
					local var_12_11 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_9_1.stage_.transform)

					var_12_11.name = var_12_9
					var_12_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_9] = var_12_11

					local var_12_12 = var_12_11:GetComponentInChildren(typeof(CharacterEffect))

					var_12_12.enabled = true

					local var_12_13 = GameObjectTools.GetOrAddComponent(var_12_11, typeof(DynamicBoneHelper))

					if var_12_13 then
						var_12_13:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_12.transform, false)

					arg_9_1.var_[var_12_9 .. "Animator"] = var_12_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_9 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_9 .. "LipSync"] = var_12_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_12_16 = arg_9_1.actors_["1027ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1027ui_story == nil then
				arg_9_1.var_.characterEffect1027ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1027ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1027ui_story then
				arg_9_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_12_20 = arg_9_1.actors_["1027ui_story"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos1027ui_story = var_12_20.localPosition
			end

			local var_12_22 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22
				local var_12_24 = Vector3.New(0.7, -0.81, -5.8)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1027ui_story, var_12_24, var_12_23)

				local var_12_25 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_25.x, var_12_25.y, var_12_25.z)

				local var_12_26 = var_12_20.localEulerAngles

				var_12_26.z = 0
				var_12_26.x = 0
				var_12_20.localEulerAngles = var_12_26
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(0.7, -0.81, -5.8)

				local var_12_27 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_27.x, var_12_27.y, var_12_27.z)

				local var_12_28 = var_12_20.localEulerAngles

				var_12_28.z = 0
				var_12_28.x = 0
				var_12_20.localEulerAngles = var_12_28
			end

			local var_12_29 = 0
			local var_12_30 = 0.425

			if var_12_29 < arg_9_1.time_ and arg_9_1.time_ <= var_12_29 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_31 = arg_9_1:FormatText(StoryNameCfg[56].name)

				arg_9_1.leftNameTxt_.text = var_12_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_32 = arg_9_1:GetWordFromCfg(112033003)
				local var_12_33 = arg_9_1:FormatText(var_12_32.content)

				arg_9_1.text_.text = var_12_33

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_34 = 17
				local var_12_35 = utf8.len(var_12_33)
				local var_12_36 = var_12_34 <= 0 and var_12_30 or var_12_30 * (var_12_35 / var_12_34)

				if var_12_36 > 0 and var_12_30 < var_12_36 then
					arg_9_1.talkMaxDuration = var_12_36

					if var_12_36 + var_12_29 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_36 + var_12_29
					end
				end

				arg_9_1.text_.text = var_12_33
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033003", "story_v_out_112033.awb") ~= 0 then
					local var_12_37 = manager.audio:GetVoiceLength("story_v_out_112033", "112033003", "story_v_out_112033.awb") / 1000

					if var_12_37 + var_12_29 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_37 + var_12_29
					end

					if var_12_32.prefab_name ~= "" and arg_9_1.actors_[var_12_32.prefab_name] ~= nil then
						local var_12_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_32.prefab_name].transform, "story_v_out_112033", "112033003", "story_v_out_112033.awb")

						arg_9_1:RecordAudio("112033003", var_12_38)
						arg_9_1:RecordAudio("112033003", var_12_38)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_112033", "112033003", "story_v_out_112033.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_112033", "112033003", "story_v_out_112033.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_39 = math.max(var_12_30, arg_9_1.talkMaxDuration)

			if var_12_29 <= arg_9_1.time_ and arg_9_1.time_ < var_12_29 + var_12_39 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_29) / var_12_39

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_29 + var_12_39 and arg_9_1.time_ < var_12_29 + var_12_39 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play112033004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 112033004
		arg_13_1.duration_ = 8.87

		local var_13_0 = {
			ja = 8.866,
			ko = 5.9,
			zh = 4.133,
			en = 6.033
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
				arg_13_0:Play112033005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1027ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1027ui_story == nil then
				arg_13_1.var_.characterEffect1027ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1027ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1027ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1027ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1027ui_story.fillRatio = var_16_5
			end

			local var_16_6 = arg_13_1.actors_["1039ui_story"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1039ui_story == nil then
				arg_13_1.var_.characterEffect1039ui_story = var_16_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.2

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 and not isNil(var_16_6) then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8

				if arg_13_1.var_.characterEffect1039ui_story and not isNil(var_16_6) then
					arg_13_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1039ui_story then
				arg_13_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_16_11 = 0
			local var_16_12 = 1

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_13 = arg_13_1:FormatText(StoryNameCfg[9].name)

				arg_13_1.leftNameTxt_.text = var_16_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(112033004)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 21
				local var_16_17 = utf8.len(var_16_15)
				local var_16_18 = var_16_16 <= 0 and var_16_12 or var_16_12 * (var_16_17 / var_16_16)

				if var_16_18 > 0 and var_16_12 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18

					if var_16_18 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033004", "story_v_out_112033.awb") ~= 0 then
					local var_16_19 = manager.audio:GetVoiceLength("story_v_out_112033", "112033004", "story_v_out_112033.awb") / 1000

					if var_16_19 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_11
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_112033", "112033004", "story_v_out_112033.awb")

						arg_13_1:RecordAudio("112033004", var_16_20)
						arg_13_1:RecordAudio("112033004", var_16_20)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_112033", "112033004", "story_v_out_112033.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_112033", "112033004", "story_v_out_112033.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_21 and arg_13_1.time_ < var_16_11 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play112033005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 112033005
		arg_17_1.duration_ = 7.57

		local var_17_0 = {
			ja = 6.533,
			ko = 6.2,
			zh = 4.266,
			en = 7.566
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
				arg_17_0:Play112033006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1027ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1027ui_story == nil then
				arg_17_1.var_.characterEffect1027ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1027ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1027ui_story then
				arg_17_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["1039ui_story"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1039ui_story == nil then
				arg_17_1.var_.characterEffect1039ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.characterEffect1039ui_story and not isNil(var_20_4) then
					local var_20_8 = Mathf.Lerp(0, 0.5, var_20_7)

					arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1039ui_story.fillRatio = var_20_8
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1039ui_story then
				local var_20_9 = 0.5

				arg_17_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1039ui_story.fillRatio = var_20_9
			end

			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_20_11 = 0
			local var_20_12 = 1

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_13 = arg_17_1:FormatText(StoryNameCfg[56].name)

				arg_17_1.leftNameTxt_.text = var_20_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(112033005)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_16 = 16
				local var_20_17 = utf8.len(var_20_15)
				local var_20_18 = var_20_16 <= 0 and var_20_12 or var_20_12 * (var_20_17 / var_20_16)

				if var_20_18 > 0 and var_20_12 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18

					if var_20_18 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_11
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033005", "story_v_out_112033.awb") ~= 0 then
					local var_20_19 = manager.audio:GetVoiceLength("story_v_out_112033", "112033005", "story_v_out_112033.awb") / 1000

					if var_20_19 + var_20_11 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_11
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_112033", "112033005", "story_v_out_112033.awb")

						arg_17_1:RecordAudio("112033005", var_20_20)
						arg_17_1:RecordAudio("112033005", var_20_20)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_112033", "112033005", "story_v_out_112033.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_112033", "112033005", "story_v_out_112033.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_21 = math.max(var_20_12, arg_17_1.talkMaxDuration)

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_21 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_11) / var_20_21

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_11 + var_20_21 and arg_17_1.time_ < var_20_11 + var_20_21 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play112033006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 112033006
		arg_21_1.duration_ = 4.83

		local var_21_0 = {
			ja = 4.833,
			ko = 3.7,
			zh = 4.766,
			en = 3.7
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
			arg_21_1.auto_ = false
		end

		function arg_21_1.playNext_(arg_23_0)
			arg_21_1.onStoryFinished_()
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1148ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["1148ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1148ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.8, -6.2)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1148ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_16 = arg_21_1.actors_["1148ui_story"]
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect1148ui_story == nil then
				arg_21_1.var_.characterEffect1148ui_story = var_24_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_18 = 0.2

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_18 and not isNil(var_24_16) then
				local var_24_19 = (arg_21_1.time_ - var_24_17) / var_24_18

				if arg_21_1.var_.characterEffect1148ui_story and not isNil(var_24_16) then
					arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_17 + var_24_18 and arg_21_1.time_ < var_24_17 + var_24_18 + arg_24_0 and not isNil(var_24_16) and arg_21_1.var_.characterEffect1148ui_story then
				arg_21_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_24_20 = arg_21_1.actors_["1027ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos1027ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(0, 100, 0)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1027ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(0, 100, 0)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = 0
			local var_24_30 = 1

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_31 = arg_21_1:FormatText(StoryNameCfg[8].name)

				arg_21_1.leftNameTxt_.text = var_24_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(112033006)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 20
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_30 or var_24_30 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_30 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_29
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112033", "112033006", "story_v_out_112033.awb") ~= 0 then
					local var_24_37 = manager.audio:GetVoiceLength("story_v_out_112033", "112033006", "story_v_out_112033.awb") / 1000

					if var_24_37 + var_24_29 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_29
					end

					if var_24_32.prefab_name ~= "" and arg_21_1.actors_[var_24_32.prefab_name] ~= nil then
						local var_24_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_32.prefab_name].transform, "story_v_out_112033", "112033006", "story_v_out_112033.awb")

						arg_21_1:RecordAudio("112033006", var_24_38)
						arg_21_1:RecordAudio("112033006", var_24_38)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_112033", "112033006", "story_v_out_112033.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_112033", "112033006", "story_v_out_112033.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_39 = math.max(var_24_30, arg_21_1.talkMaxDuration)

			if var_24_29 <= arg_21_1.time_ and arg_21_1.time_ < var_24_29 + var_24_39 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_29) / var_24_39

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_29 + var_24_39 and arg_21_1.time_ < var_24_29 + var_24_39 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_112033.awb"
	}
}
