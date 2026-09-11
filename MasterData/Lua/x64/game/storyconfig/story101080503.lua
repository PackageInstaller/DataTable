return {
	Play108053001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108053001
		arg_1_1.duration_ = 3.8

		local var_1_0 = {
			ja = 3.2,
			ko = 3.8,
			zh = 2.433,
			en = 2.766
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
				arg_1_0:Play108053002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "1050ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["1050ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["1050ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["1050ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["1050ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["1050ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_3.localPosition
			end

			local var_4_4 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 then
				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_1_1.time_ - 0) / var_4_4)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			local var_4_5 = arg_1_1.actors_["1050ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_6 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 and not isNil(var_4_5) then
				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_4_8 = 0
			local var_4_9 = 0.3

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_10 = arg_1_1:GetWordFromCfg(108053001)
				local var_4_11 = arg_1_1:FormatText(var_4_10.content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 12 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 12)

				if (12 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 12)) > 0 and var_4_9 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_11
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053001", "story_v_out_108053.awb") ~= 0 then
					local var_4_14 = manager.audio:GetVoiceLength("story_v_out_108053", "108053001", "story_v_out_108053.awb") / 1000

					if var_4_14 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_8
					end

					if var_4_10.prefab_name ~= "" and arg_1_1.actors_[var_4_10.prefab_name] ~= nil then
						local var_4_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_10.prefab_name].transform, "story_v_out_108053", "108053001", "story_v_out_108053.awb")

						arg_1_1:RecordAudio("108053001", var_4_15)
						arg_1_1:RecordAudio("108053001", var_4_15)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108053", "108053001", "story_v_out_108053.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108053", "108053001", "story_v_out_108053.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_16 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_8) / var_4_16

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_8 + var_4_16 and arg_1_1.time_ < var_4_8 + var_4_16 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play108053002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 108053002
		arg_5_1.duration_ = 7.07

		local var_5_0 = {
			ja = 7.066,
			ko = 4.633,
			zh = 4.866,
			en = 4.266
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
				arg_5_0:Play108053003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			if 0 < arg_5_1.time_ and arg_5_1.time_ <= 0 + arg_8_0 then
				arg_5_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_8_0 = 0
			local var_8_1 = 0.575

			if 0 < arg_5_1.time_ and arg_5_1.time_ <= var_8_0 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				arg_5_1.leftNameTxt_.text = arg_5_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, false)
				arg_5_1.callingController_:SetSelectedState("normal")

				local var_8_2 = arg_5_1:GetWordFromCfg(108053002)
				local var_8_3 = arg_5_1:FormatText(var_8_2.content)

				arg_5_1.text_.text = var_8_3

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_5 = 23 <= 0 and var_8_1 or var_8_1 * (utf8.len(var_8_3) / 23)

				if (23 <= 0 and var_8_1 or var_8_1 * (utf8.len(var_8_3) / 23)) > 0 and var_8_1 < var_8_5 then
					arg_5_1.talkMaxDuration = var_8_5

					if var_8_5 + var_8_0 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_5 + var_8_0
					end
				end

				arg_5_1.text_.text = var_8_3
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053002", "story_v_out_108053.awb") ~= 0 then
					local var_8_6 = manager.audio:GetVoiceLength("story_v_out_108053", "108053002", "story_v_out_108053.awb") / 1000

					if var_8_6 + var_8_0 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_6 + var_8_0
					end

					if var_8_2.prefab_name ~= "" and arg_5_1.actors_[var_8_2.prefab_name] ~= nil then
						local var_8_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_5_1.actors_[var_8_2.prefab_name].transform, "story_v_out_108053", "108053002", "story_v_out_108053.awb")

						arg_5_1:RecordAudio("108053002", var_8_7)
						arg_5_1:RecordAudio("108053002", var_8_7)
					else
						arg_5_1:AudioAction("play", "voice", "story_v_out_108053", "108053002", "story_v_out_108053.awb")
					end

					arg_5_1:RecordHistoryTalkVoice("story_v_out_108053", "108053002", "story_v_out_108053.awb")
				end

				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_8 = math.max(var_8_1, arg_5_1.talkMaxDuration)

			if var_8_0 <= arg_5_1.time_ and arg_5_1.time_ < var_8_0 + var_8_8 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_0) / var_8_8

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_0 + var_8_8 and arg_5_1.time_ < var_8_0 + var_8_8 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	Play108053003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 108053003
		arg_9_1.duration_ = 8.57

		local var_9_0 = {
			ja = 8.566,
			ko = 6.233,
			zh = 6.2,
			en = 5.3
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
				arg_9_0:Play108053004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1099ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1099ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1099ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1099ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1099ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1099ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1099ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1099ui_story == nil then
				arg_9_1.var_.characterEffect1099ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1099ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1099ui_story then
				arg_9_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_12_8 = arg_9_1.actors_["1050ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1050ui_story == nil then
				arg_9_1.var_.characterEffect1050ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1050ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1050ui_story then
				arg_9_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_12_10 = 0
			local var_12_11 = 0.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(108053003)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 29 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 29)

				if (29 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 29)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053003", "story_v_out_108053.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_108053", "108053003", "story_v_out_108053.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_108053", "108053003", "story_v_out_108053.awb")

						arg_9_1:RecordAudio("108053003", var_12_17)
						arg_9_1:RecordAudio("108053003", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_108053", "108053003", "story_v_out_108053.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_108053", "108053003", "story_v_out_108053.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play108053004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 108053004
		arg_13_1.duration_ = 7.3

		local var_13_0 = {
			ja = 7.3,
			ko = 5.866,
			zh = 7.2,
			en = 6.366
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
				arg_13_0:Play108053005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_16_0 = 0
			local var_16_1 = 0.925

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(108053004)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 33 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 33)

				if (33 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 33)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053004", "story_v_out_108053.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_out_108053", "108053004", "story_v_out_108053.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_out_108053", "108053004", "story_v_out_108053.awb")

						arg_13_1:RecordAudio("108053004", var_16_7)
						arg_13_1:RecordAudio("108053004", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_108053", "108053004", "story_v_out_108053.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_108053", "108053004", "story_v_out_108053.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play108053005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 108053005
		arg_17_1.duration_ = 6.37

		local var_17_0 = {
			ja = 6.366,
			ko = 4.2,
			zh = 3.7,
			en = 5.266
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
				arg_17_0:Play108053006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) and arg_17_1.var_.characterEffect1099ui_story == nil then
				arg_17_1.var_.characterEffect1099ui_story = arg_17_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) then
				if arg_17_1.var_.characterEffect1099ui_story and not isNil(arg_17_1.actors_["1099ui_story"]) then
					arg_17_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1099ui_story"]) and arg_17_1.var_.characterEffect1099ui_story then
				arg_17_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(108053005)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 17 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 17)

				if (17 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 17)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053005", "story_v_out_108053.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_108053", "108053005", "story_v_out_108053.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_108053", "108053005", "story_v_out_108053.awb")

						arg_17_1:RecordAudio("108053005", var_20_8)
						arg_17_1:RecordAudio("108053005", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_108053", "108053005", "story_v_out_108053.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_108053", "108053005", "story_v_out_108053.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play108053006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 108053006
		arg_21_1.duration_ = 7.67

		local var_21_0 = {
			ja = 7.666,
			ko = 3.833,
			zh = 2.7,
			en = 4.733
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
				arg_21_0:Play108053007(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1050ui_story"]) and arg_21_1.var_.characterEffect1050ui_story == nil then
				arg_21_1.var_.characterEffect1050ui_story = arg_21_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1050ui_story"]) then
				if arg_21_1.var_.characterEffect1050ui_story and not isNil(arg_21_1.actors_["1050ui_story"]) then
					arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1050ui_story"]) and arg_21_1.var_.characterEffect1050ui_story then
				arg_21_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050actionlink/1050action452")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(108053006)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)

				if (17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053006", "story_v_out_108053.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_108053", "108053006", "story_v_out_108053.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_108053", "108053006", "story_v_out_108053.awb")

						arg_21_1:RecordAudio("108053006", var_24_9)
						arg_21_1:RecordAudio("108053006", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_108053", "108053006", "story_v_out_108053.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_108053", "108053006", "story_v_out_108053.awb")
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
	Play108053007 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 108053007
		arg_25_1.duration_ = 5.77

		local var_25_0 = {
			ja = 5.766,
			ko = 5,
			zh = 4.933,
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
			arg_25_1.auto_ = false
		end

		function arg_25_1.playNext_(arg_27_0)
			arg_25_1.onStoryFinished_()
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) and arg_25_1.var_.characterEffect1099ui_story == nil then
				arg_25_1.var_.characterEffect1099ui_story = arg_25_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) then
				if arg_25_1.var_.characterEffect1099ui_story and not isNil(arg_25_1.actors_["1099ui_story"]) then
					arg_25_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1099ui_story"]) and arg_25_1.var_.characterEffect1099ui_story then
				arg_25_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["1050ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1050ui_story == nil then
				arg_25_1.var_.characterEffect1050ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1050ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1050ui_story then
				arg_25_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_28_4 = 0
			local var_28_5 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(108053007)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 26 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 26)

				if (26 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 26)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108053", "108053007", "story_v_out_108053.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_108053", "108053007", "story_v_out_108053.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_108053", "108053007", "story_v_out_108053.awb")

						arg_25_1:RecordAudio("108053007", var_28_11)
						arg_25_1:RecordAudio("108053007", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_108053", "108053007", "story_v_out_108053.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_108053", "108053007", "story_v_out_108053.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_108053.awb"
	}
}
