return {
	Play111023001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111023001
		arg_1_1.duration_ = 5.8

		local var_1_0 = {
			ja = 5.8,
			ko = 5.3,
			zh = 4.4,
			en = 4.666
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
				arg_1_0:Play111023002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "1039ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["1039ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["1039ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["1039ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["1039ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1039ui_story = var_4_3.localPosition
			end

			local var_4_4 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 then
				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_1_1.time_ - 0) / var_4_4)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_5 = arg_1_1.actors_["1039ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1039ui_story == nil then
				arg_1_1.var_.characterEffect1039ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_6 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 and not isNil(var_4_5) then
				if arg_1_1.var_.characterEffect1039ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1039ui_story then
				arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_4_8 = 0
			local var_4_9 = manager.audio:GetVoiceLength("story_v_out_111023", "111023001", "story_v_out_111023.awb") / 1000

			if var_4_9 > 0 and 3.831 < var_4_9 and var_4_9 + var_4_8 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_9 + var_4_8
			end

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_111023", "111023001", "story_v_out_111023.awb")
			end

			local var_4_11 = 0
			local var_4_12 = 0.475

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_13 = arg_1_1:GetWordFromCfg(111023001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 19 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 19)

				if (19 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 19)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023001", "story_v_out_111023.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_111023", "111023001", "story_v_out_111023.awb") / 1000

					if var_4_17 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_11
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_111023", "111023001", "story_v_out_111023.awb")

						arg_1_1:RecordAudio("111023001", var_4_18)
						arg_1_1:RecordAudio("111023001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_111023", "111023001", "story_v_out_111023.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_111023", "111023001", "story_v_out_111023.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_11) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_11 + var_4_19 and arg_1_1.time_ < var_4_11 + var_4_19 + arg_4_0 then
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
	Play111023002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 111023002
		arg_5_1.duration_ = 5.03

		local var_5_0 = {
			ja = 4.666,
			ko = 4.471999999999,
			zh = 5.033,
			en = 4.471999999999
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
				arg_5_0:Play111023003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 and not isNil(arg_5_1.actors_["1039ui_story"]) and arg_5_1.var_.characterEffect1039ui_story == nil then
				arg_5_1.var_.characterEffect1039ui_story = arg_5_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_8_0 = 0.2

			if 0 <= arg_5_1.time_ and arg_5_1.time_ < 0 + var_8_0 and not isNil(arg_5_1.actors_["1039ui_story"]) then
				if arg_5_1.var_.characterEffect1039ui_story and not isNil(arg_5_1.actors_["1039ui_story"]) then
					arg_5_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_5_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_5_1.time_ - 0) / var_8_0)
				end
			end

			if arg_5_1.time_ >= 0 + var_8_0 and arg_5_1.time_ < 0 + var_8_0 + arg_8_0 and not isNil(arg_5_1.actors_["1039ui_story"]) and arg_5_1.var_.characterEffect1039ui_story then
				arg_5_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_5_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_8_1 = 0
			local var_8_2 = manager.audio:GetVoiceLength("story_v_out_111023", "111023002", "story_v_out_111023.awb") / 1000

			if var_8_2 > 0 and 4.472 < var_8_2 and var_8_2 + var_8_1 > arg_5_1.duration_ then
				arg_5_1.duration_ = var_8_2 + var_8_1
			end

			if var_8_1 < arg_5_1.time_ and arg_5_1.time_ <= var_8_1 + arg_8_0 then
				arg_5_1:AudioAction("play", "voice", "story_v_out_111023", "111023002", "story_v_out_111023.awb")
			end

			local var_8_4 = 0
			local var_8_5 = 0.275

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_4 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				arg_5_1.leftNameTxt_.text = arg_5_1:FormatText(StoryNameCfg[180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, true)
				arg_5_1.iconController_:SetSelectedState("hero")

				arg_5_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_5_1.callingController_:SetSelectedState("normal")

				arg_5_1.keyicon_.color = Color.New(1, 1, 1)
				arg_5_1.icon_.color = Color.New(1, 1, 1)

				local var_8_6 = arg_5_1:GetWordFromCfg(111023002)
				local var_8_7 = arg_5_1:FormatText(var_8_6.content)

				arg_5_1.text_.text = var_8_7

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_9 = 11 <= 0 and var_8_5 or var_8_5 * (utf8.len(var_8_7) / 11)

				if (11 <= 0 and var_8_5 or var_8_5 * (utf8.len(var_8_7) / 11)) > 0 and var_8_5 < var_8_9 then
					arg_5_1.talkMaxDuration = var_8_9

					if var_8_9 + var_8_4 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_9 + var_8_4
					end
				end

				arg_5_1.text_.text = var_8_7
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023002", "story_v_out_111023.awb") ~= 0 then
					local var_8_10 = manager.audio:GetVoiceLength("story_v_out_111023", "111023002", "story_v_out_111023.awb") / 1000

					if var_8_10 + var_8_4 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_10 + var_8_4
					end

					if var_8_6.prefab_name ~= "" and arg_5_1.actors_[var_8_6.prefab_name] ~= nil then
						local var_8_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_5_1.actors_[var_8_6.prefab_name].transform, "story_v_out_111023", "111023002", "story_v_out_111023.awb")

						arg_5_1:RecordAudio("111023002", var_8_11)
						arg_5_1:RecordAudio("111023002", var_8_11)
					else
						arg_5_1:AudioAction("play", "voice", "story_v_out_111023", "111023002", "story_v_out_111023.awb")
					end

					arg_5_1:RecordHistoryTalkVoice("story_v_out_111023", "111023002", "story_v_out_111023.awb")
				end

				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_12 = math.max(var_8_5, arg_5_1.talkMaxDuration)

			if var_8_4 <= arg_5_1.time_ and arg_5_1.time_ < var_8_4 + var_8_12 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_4) / var_8_12

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_4 + var_8_12 and arg_5_1.time_ < var_8_4 + var_8_12 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	Play111023003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 111023003
		arg_9_1.duration_ = 5.63

		local var_9_0 = {
			ja = 5.633,
			ko = 3.233,
			zh = 3.045999999999,
			en = 3.266
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
				arg_9_0:Play111023004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1084ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1084ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1084ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1084ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1084ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_8 = arg_9_1.actors_["1039ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1039ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = 0
			local var_12_11 = manager.audio:GetVoiceLength("story_v_out_111023", "111023003", "story_v_out_111023.awb") / 1000

			if var_12_11 > 0 and 3.046 < var_12_11 and var_12_11 + var_12_10 > arg_9_1.duration_ then
				arg_9_1.duration_ = var_12_11 + var_12_10
			end

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1:AudioAction("play", "voice", "story_v_out_111023", "111023003", "story_v_out_111023.awb")
			end

			local var_12_13 = 0
			local var_12_14 = 0.4

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_15 = arg_9_1:GetWordFromCfg(111023003)
				local var_12_16 = arg_9_1:FormatText(var_12_15.content)

				arg_9_1.text_.text = var_12_16

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_18 = 17 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 17)

				if (17 <= 0 and var_12_14 or var_12_14 * (utf8.len(var_12_16) / 17)) > 0 and var_12_14 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_13
					end
				end

				arg_9_1.text_.text = var_12_16
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023003", "story_v_out_111023.awb") ~= 0 then
					local var_12_19 = manager.audio:GetVoiceLength("story_v_out_111023", "111023003", "story_v_out_111023.awb") / 1000

					if var_12_19 + var_12_13 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_13
					end

					if var_12_15.prefab_name ~= "" and arg_9_1.actors_[var_12_15.prefab_name] ~= nil then
						local var_12_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_15.prefab_name].transform, "story_v_out_111023", "111023003", "story_v_out_111023.awb")

						arg_9_1:RecordAudio("111023003", var_12_20)
						arg_9_1:RecordAudio("111023003", var_12_20)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_111023", "111023003", "story_v_out_111023.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_111023", "111023003", "story_v_out_111023.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_21 = math.max(var_12_14, arg_9_1.talkMaxDuration)

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_21 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_13) / var_12_21

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_13 + var_12_21 and arg_9_1.time_ < var_12_13 + var_12_21 + arg_12_0 then
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play111023004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 111023004
		arg_13_1.duration_ = 8.63

		local var_13_0 = {
			ja = 8.105999999999,
			ko = 8.105999999999,
			zh = 8.633,
			en = 8.105999999999
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
				arg_13_0:Play111023005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(arg_13_1.actors_["1084ui_story"]) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = manager.audio:GetVoiceLength("story_v_out_111023", "111023004", "story_v_out_111023.awb") / 1000

			if var_16_2 > 0 and 8.106 < var_16_2 and var_16_2 + var_16_1 > arg_13_1.duration_ then
				arg_13_1.duration_ = var_16_2 + var_16_1
			end

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1:AudioAction("play", "voice", "story_v_out_111023", "111023004", "story_v_out_111023.awb")
			end

			local var_16_4 = 0
			local var_16_5 = 0.775

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_6 = arg_13_1:GetWordFromCfg(111023004)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 29 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 29)

				if (29 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 29)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023004", "story_v_out_111023.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_111023", "111023004", "story_v_out_111023.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_111023", "111023004", "story_v_out_111023.awb")

						arg_13_1:RecordAudio("111023004", var_16_11)
						arg_13_1:RecordAudio("111023004", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_111023", "111023004", "story_v_out_111023.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_111023", "111023004", "story_v_out_111023.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play111023005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 111023005
		arg_17_1.duration_ = 10.53

		local var_17_0 = {
			ja = 10.132999999999,
			ko = 10.132999999999,
			zh = 10.533,
			en = 10.132999999999
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
				arg_17_0:Play111023006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = manager.audio:GetVoiceLength("story_v_out_111023", "111023005", "story_v_out_111023.awb") / 1000

			if var_20_0 > 0 and 10.133 < var_20_0 and var_20_0 + 0 > arg_17_1.duration_ then
				arg_17_1.duration_ = var_20_0 + 0
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:AudioAction("play", "voice", "story_v_out_111023", "111023005", "story_v_out_111023.awb")
			end

			local var_20_2 = 0
			local var_20_3 = 1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:GetWordFromCfg(111023005)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 39 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 39)

				if (39 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 39)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023005", "story_v_out_111023.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_111023", "111023005", "story_v_out_111023.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_111023", "111023005", "story_v_out_111023.awb")

						arg_17_1:RecordAudio("111023005", var_20_9)
						arg_17_1:RecordAudio("111023005", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_111023", "111023005", "story_v_out_111023.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_111023", "111023005", "story_v_out_111023.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play111023006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 111023006
		arg_21_1.duration_ = 9.23

		local var_21_0 = {
			ja = 7.763999999999,
			ko = 7.763999999999,
			zh = 8.166,
			en = 9.233
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
				arg_21_0:Play111023007(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = manager.audio:GetVoiceLength("story_v_out_111023", "111023006", "story_v_out_111023.awb") / 1000

			if var_24_0 > 0 and 7.764 < var_24_0 and var_24_0 + 0 > arg_21_1.duration_ then
				arg_21_1.duration_ = var_24_0 + 0
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "voice", "story_v_out_111023", "111023006", "story_v_out_111023.awb")
			end

			local var_24_2 = 0
			local var_24_3 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(111023006)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 21 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 21)

				if (21 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 21)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023006", "story_v_out_111023.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_111023", "111023006", "story_v_out_111023.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_111023", "111023006", "story_v_out_111023.awb")

						arg_21_1:RecordAudio("111023006", var_24_9)
						arg_21_1:RecordAudio("111023006", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_111023", "111023006", "story_v_out_111023.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_111023", "111023006", "story_v_out_111023.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play111023007 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 111023007
		arg_25_1.duration_ = 9.3

		local var_25_0 = {
			ja = 9.3,
			ko = 5.866,
			zh = 4.833,
			en = 4.266
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
				arg_25_0:Play111023008(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_28_0 = arg_25_1.actors_["1039ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1039ui_story == nil then
				arg_25_1.var_.characterEffect1039ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_1 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(var_28_0) then
				if arg_25_1.var_.characterEffect1039ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1039ui_story then
				arg_25_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_28_3 = 0
			local var_28_4 = manager.audio:GetVoiceLength("story_v_out_111023", "111023007", "story_v_out_111023.awb") / 1000

			if var_28_4 > 0 and 4.199 < var_28_4 and var_28_4 + var_28_3 > arg_25_1.duration_ then
				arg_25_1.duration_ = var_28_4 + var_28_3
			end

			if var_28_3 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1:AudioAction("play", "voice", "story_v_out_111023", "111023007", "story_v_out_111023.awb")
			end

			local var_28_6 = 0
			local var_28_7 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(111023007)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 21 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 21)

				if (21 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 21)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023007", "story_v_out_111023.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_111023", "111023007", "story_v_out_111023.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_111023", "111023007", "story_v_out_111023.awb")

						arg_25_1:RecordAudio("111023007", var_28_13)
						arg_25_1:RecordAudio("111023007", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_111023", "111023007", "story_v_out_111023.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_111023", "111023007", "story_v_out_111023.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play111023008 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 111023008
		arg_29_1.duration_ = 10.2

		local var_29_0 = {
			ja = 9.957999999999,
			ko = 9.957999999999,
			zh = 10.2,
			en = 9.957999999999
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play111023009(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) and arg_29_1.var_.characterEffect1039ui_story == nil then
				arg_29_1.var_.characterEffect1039ui_story = arg_29_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) then
				if arg_29_1.var_.characterEffect1039ui_story and not isNil(arg_29_1.actors_["1039ui_story"]) then
					arg_29_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) and arg_29_1.var_.characterEffect1039ui_story then
				arg_29_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = manager.audio:GetVoiceLength("story_v_out_111023", "111023008", "story_v_out_111023.awb") / 1000

			if var_32_2 > 0 and 9.958 < var_32_2 and var_32_2 + var_32_1 > arg_29_1.duration_ then
				arg_29_1.duration_ = var_32_2 + var_32_1
			end

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1:AudioAction("play", "voice", "story_v_out_111023", "111023008", "story_v_out_111023.awb")
			end

			local var_32_4 = 0
			local var_32_5 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[180].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_6 = arg_29_1:GetWordFromCfg(111023008)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 11 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 11)

				if (11 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 11)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023008", "story_v_out_111023.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_111023", "111023008", "story_v_out_111023.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_111023", "111023008", "story_v_out_111023.awb")

						arg_29_1:RecordAudio("111023008", var_32_11)
						arg_29_1:RecordAudio("111023008", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_111023", "111023008", "story_v_out_111023.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_111023", "111023008", "story_v_out_111023.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play111023009 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 111023009
		arg_33_1.duration_ = 7.7

		local var_33_0 = {
			ja = 7.7,
			ko = 5.866,
			zh = 5,
			en = 5.1
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play111023010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_0 = arg_33_1.actors_["1039ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1039ui_story == nil then
				arg_33_1.var_.characterEffect1039ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_1 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(var_36_0) then
				if arg_33_1.var_.characterEffect1039ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1039ui_story then
				arg_33_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_36_3 = 0
			local var_36_4 = manager.audio:GetVoiceLength("story_v_out_111023", "111023009", "story_v_out_111023.awb") / 1000

			if var_36_4 > 0 and 4.456 < var_36_4 and var_36_4 + var_36_3 > arg_33_1.duration_ then
				arg_33_1.duration_ = var_36_4 + var_36_3
			end

			if var_36_3 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1:AudioAction("play", "voice", "story_v_out_111023", "111023009", "story_v_out_111023.awb")
			end

			local var_36_6 = 0
			local var_36_7 = 0.65

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(111023009)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 27 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 27)

				if (27 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 27)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023009", "story_v_out_111023.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_111023", "111023009", "story_v_out_111023.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_111023", "111023009", "story_v_out_111023.awb")

						arg_33_1:RecordAudio("111023009", var_36_13)
						arg_33_1:RecordAudio("111023009", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_111023", "111023009", "story_v_out_111023.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_111023", "111023009", "story_v_out_111023.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play111023010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 111023010
		arg_37_1.duration_ = 9.3

		local var_37_0 = {
			ja = 9.3,
			ko = 6.8,
			zh = 7.166,
			en = 9
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
			arg_37_1.auto_ = false
		end

		function arg_37_1.playNext_(arg_39_0)
			arg_37_1.onStoryFinished_()
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_40_0 = arg_37_1.actors_["1084ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_40_3 = 0
			local var_40_4 = manager.audio:GetVoiceLength("story_v_out_111023", "111023010", "story_v_out_111023.awb") / 1000

			if var_40_4 > 0 and 3.831 < var_40_4 and var_40_4 + var_40_3 > arg_37_1.duration_ then
				arg_37_1.duration_ = var_40_4 + var_40_3
			end

			if var_40_3 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1:AudioAction("play", "voice", "story_v_out_111023", "111023010", "story_v_out_111023.awb")
			end

			local var_40_6 = 0
			local var_40_7 = 0.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(111023010)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 32 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 32)

				if (32 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 32)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111023", "111023010", "story_v_out_111023.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_111023", "111023010", "story_v_out_111023.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_111023", "111023010", "story_v_out_111023.awb")

						arg_37_1:RecordAudio("111023010", var_40_13)
						arg_37_1:RecordAudio("111023010", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_111023", "111023010", "story_v_out_111023.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_111023", "111023010", "story_v_out_111023.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_111023.awb"
	}
}
