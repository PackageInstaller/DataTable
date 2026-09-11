return {
	Play107041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107041001
		arg_1_1.duration_ = 2.53

		local var_1_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.066,
			en = 2.533
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
				arg_1_0:Play107041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "1099ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["1099ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["1099ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["1099ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["1099ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1099ui_story == nil then
				arg_1_1.var_.characterEffect1099ui_story = var_4_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_4 = 0.1

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 and not isNil(var_4_3) then
				if arg_1_1.var_.characterEffect1099ui_story and not isNil(var_4_3) then
					arg_1_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1099ui_story then
				arg_1_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_4_6 = arg_1_1.actors_["1099ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1099ui_story = var_4_6.localPosition
			end

			local var_4_7 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1099ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_1_1.time_ - 0) / var_4_7)
				var_4_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_6.position).x, (manager.ui.mainCamera.transform.position - var_4_6.position).y, (manager.ui.mainCamera.transform.position - var_4_6.position).z)
				var_4_6.localEulerAngles.z = 0
				var_4_6.localEulerAngles.x = 0
				var_4_6.localEulerAngles = var_4_6.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_4_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_6.position).x, (manager.ui.mainCamera.transform.position - var_4_6.position).y, (manager.ui.mainCamera.transform.position - var_4_6.position).z)
				var_4_6.localEulerAngles.z = 0
				var_4_6.localEulerAngles.x = 0
				var_4_6.localEulerAngles = var_4_6.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_4_8 = "1050ui_story"

			if arg_1_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1050ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_1_1.time_ - 0) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0.7, -1, -6.1)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action7_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_4_14 = 0
			local var_4_15 = 0.225

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(107041001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 9)

				if (9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 9)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041001", "story_v_out_107041.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_107041", "107041001", "story_v_out_107041.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_107041", "107041001", "story_v_out_107041.awb")

						arg_1_1:RecordAudio("107041001", var_4_22)
						arg_1_1:RecordAudio("107041001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107041", "107041001", "story_v_out_107041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107041", "107041001", "story_v_out_107041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play107041002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 107041002
		arg_7_1.duration_ = 4.27

		local var_7_0 = {
			ja = 4.266,
			ko = 4,
			zh = 4.1,
			en = 4.233
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play107041003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1050ui_story"]) and arg_7_1.var_.characterEffect1050ui_story == nil then
				arg_7_1.var_.characterEffect1050ui_story = arg_7_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1050ui_story"]) then
				if arg_7_1.var_.characterEffect1050ui_story and not isNil(arg_7_1.actors_["1050ui_story"]) then
					arg_7_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1050ui_story"]) and arg_7_1.var_.characterEffect1050ui_story then
				arg_7_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_10_2 = arg_7_1.actors_["1099ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.characterEffect1099ui_story == nil then
				arg_7_1.var_.characterEffect1099ui_story = var_10_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_3 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 and not isNil(var_10_2) then
				if arg_7_1.var_.characterEffect1099ui_story and not isNil(var_10_2) then
					arg_7_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_3)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.characterEffect1099ui_story then
				arg_7_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_10_4 = 0
			local var_10_5 = 0.35

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_6 = arg_7_1:GetWordFromCfg(107041002)
				local var_10_7 = arg_7_1:FormatText(var_10_6.content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 14 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 14)

				if (14 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 14)) > 0 and var_10_5 < var_10_9 then
					arg_7_1.talkMaxDuration = var_10_9

					if var_10_9 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_9 + var_10_4
					end
				end

				arg_7_1.text_.text = var_10_7
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041002", "story_v_out_107041.awb") ~= 0 then
					local var_10_10 = manager.audio:GetVoiceLength("story_v_out_107041", "107041002", "story_v_out_107041.awb") / 1000

					if var_10_10 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_10 + var_10_4
					end

					if var_10_6.prefab_name ~= "" and arg_7_1.actors_[var_10_6.prefab_name] ~= nil then
						local var_10_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_6.prefab_name].transform, "story_v_out_107041", "107041002", "story_v_out_107041.awb")

						arg_7_1:RecordAudio("107041002", var_10_11)
						arg_7_1:RecordAudio("107041002", var_10_11)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_107041", "107041002", "story_v_out_107041.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_107041", "107041002", "story_v_out_107041.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_12 = math.max(var_10_5, arg_7_1.talkMaxDuration)

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_12 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_4) / var_10_12

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_4 + var_10_12 and arg_7_1.time_ < var_10_4 + var_10_12 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play107041003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 107041003
		arg_11_1.duration_ = 1.83

		local var_11_0 = {
			ja = 1.833,
			ko = 1.133,
			zh = 1.266,
			en = 1.5
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play107041004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1099ui_story"]) and arg_11_1.var_.characterEffect1099ui_story == nil then
				arg_11_1.var_.characterEffect1099ui_story = arg_11_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1099ui_story"]) then
				if arg_11_1.var_.characterEffect1099ui_story and not isNil(arg_11_1.actors_["1099ui_story"]) then
					arg_11_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1099ui_story"]) and arg_11_1.var_.characterEffect1099ui_story then
				arg_11_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_14_2 = arg_11_1.actors_["1050ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.characterEffect1050ui_story == nil then
				arg_11_1.var_.characterEffect1050ui_story = var_14_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_3 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 and not isNil(var_14_2) then
				if arg_11_1.var_.characterEffect1050ui_story and not isNil(var_14_2) then
					arg_11_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_3)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.characterEffect1050ui_story then
				arg_11_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_14_4 = 0
			local var_14_5 = 0.1

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:GetWordFromCfg(107041003)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 4 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 4)

				if (4 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 4)) > 0 and var_14_5 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041003", "story_v_out_107041.awb") ~= 0 then
					local var_14_10 = manager.audio:GetVoiceLength("story_v_out_107041", "107041003", "story_v_out_107041.awb") / 1000

					if var_14_10 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_4
					end

					if var_14_6.prefab_name ~= "" and arg_11_1.actors_[var_14_6.prefab_name] ~= nil then
						local var_14_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_6.prefab_name].transform, "story_v_out_107041", "107041003", "story_v_out_107041.awb")

						arg_11_1:RecordAudio("107041003", var_14_11)
						arg_11_1:RecordAudio("107041003", var_14_11)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_107041", "107041003", "story_v_out_107041.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_107041", "107041003", "story_v_out_107041.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_12 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_12 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_12

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_12 and arg_11_1.time_ < var_14_4 + var_14_12 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play107041004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 107041004
		arg_15_1.duration_ = 6.73

		local var_15_0 = {
			ja = 6.733,
			ko = 5.466,
			zh = 5.066,
			en = 6.433
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play107041005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) and arg_15_1.var_.characterEffect1099ui_story == nil then
				arg_15_1.var_.characterEffect1099ui_story = arg_15_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) then
				if arg_15_1.var_.characterEffect1099ui_story and not isNil(arg_15_1.actors_["1099ui_story"]) then
					arg_15_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) and arg_15_1.var_.characterEffect1099ui_story then
				arg_15_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 0.6

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(107041004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 24 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_4) / 24)

				if (24 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_4) / 24)) > 0 and var_18_2 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041004", "story_v_out_107041.awb") ~= 0 then
					local var_18_7 = manager.audio:GetVoiceLength("story_v_out_107041", "107041004", "story_v_out_107041.awb") / 1000

					if var_18_7 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_1
					end

					if var_18_3.prefab_name ~= "" and arg_15_1.actors_[var_18_3.prefab_name] ~= nil then
						local var_18_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_3.prefab_name].transform, "story_v_out_107041", "107041004", "story_v_out_107041.awb")

						arg_15_1:RecordAudio("107041004", var_18_8)
						arg_15_1:RecordAudio("107041004", var_18_8)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_107041", "107041004", "story_v_out_107041.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_107041", "107041004", "story_v_out_107041.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_9 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_9 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_9

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_9 and arg_15_1.time_ < var_18_1 + var_18_9 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play107041005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 107041005
		arg_19_1.duration_ = 3.2

		local var_19_0 = {
			ja = 1.7,
			ko = 3.2,
			zh = 2.533,
			en = 2.4
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play107041006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1099ui_story"]) and arg_19_1.var_.characterEffect1099ui_story == nil then
				arg_19_1.var_.characterEffect1099ui_story = arg_19_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.1

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1099ui_story"]) then
				if arg_19_1.var_.characterEffect1099ui_story and not isNil(arg_19_1.actors_["1099ui_story"]) then
					arg_19_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1099ui_story"]) and arg_19_1.var_.characterEffect1099ui_story then
				arg_19_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_22_2 = 0
			local var_22_3 = 0.3

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(107041005)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 12 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 12)

				if (12 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 12)) > 0 and var_22_3 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041005", "story_v_out_107041.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_107041", "107041005", "story_v_out_107041.awb") / 1000

					if var_22_8 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_2
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_107041", "107041005", "story_v_out_107041.awb")

						arg_19_1:RecordAudio("107041005", var_22_9)
						arg_19_1:RecordAudio("107041005", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_107041", "107041005", "story_v_out_107041.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_107041", "107041005", "story_v_out_107041.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_10 and arg_19_1.time_ < var_22_2 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play107041006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 107041006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play107041007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1099ui_story"]) and arg_23_1.var_.characterEffect1099ui_story == nil then
				arg_23_1.var_.characterEffect1099ui_story = arg_23_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1099ui_story"]) then
				if arg_23_1.var_.characterEffect1099ui_story and not isNil(arg_23_1.actors_["1099ui_story"]) then
					arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1099ui_story"]) and arg_23_1.var_.characterEffect1099ui_story then
				arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_26_1 = manager.ui.mainCamera.transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.shakeOldPos = var_26_1.localPosition
			end

			local var_26_2 = 0.6

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				local var_26_3, var_26_4 = math.modf((arg_23_1.time_ - 0) / 0.066)

				var_26_1.localPosition = Vector3.New(var_26_4 * 0.13, var_26_4 * 0.13, var_26_4 * 0.13) + arg_23_1.var_.shakeOldPos
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = arg_23_1.var_.shakeOldPos
			end

			local var_26_5 = 0
			local var_26_6 = 0.1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3016")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_7 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(107041006).content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 4 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 4)

				if (4 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_7) / 4)) > 0 and var_26_6 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_5
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_10 = math.max(var_26_6, arg_23_1.talkMaxDuration)

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_10 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_5) / var_26_10

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_5 + var_26_10 and arg_23_1.time_ < var_26_5 + var_26_10 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play107041007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 107041007
		arg_27_1.duration_ = 2.83

		local var_27_0 = {
			ja = 2.333,
			ko = 2.766,
			zh = 2.833,
			en = 2.433
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
			arg_27_1.auto_ = false
		end

		function arg_27_1.playNext_(arg_29_0)
			arg_27_1.onStoryFinished_()
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1099ui_story"]) and arg_27_1.var_.characterEffect1099ui_story == nil then
				arg_27_1.var_.characterEffect1099ui_story = arg_27_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1099ui_story"]) then
				if arg_27_1.var_.characterEffect1099ui_story and not isNil(arg_27_1.actors_["1099ui_story"]) then
					arg_27_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1099ui_story"]) and arg_27_1.var_.characterEffect1099ui_story then
				arg_27_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_30_2 = 0
			local var_30_3 = 0.225

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:GetWordFromCfg(107041007)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 9 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 9)

				if (9 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 9)) > 0 and var_30_3 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107041", "107041007", "story_v_out_107041.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_107041", "107041007", "story_v_out_107041.awb") / 1000

					if var_30_8 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_2
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_out_107041", "107041007", "story_v_out_107041.awb")

						arg_27_1:RecordAudio("107041007", var_30_9)
						arg_27_1:RecordAudio("107041007", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_107041", "107041007", "story_v_out_107041.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_107041", "107041007", "story_v_out_107041.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_10 and arg_27_1.time_ < var_30_2 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_107041.awb"
	}
}
