return {
	Play107051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 107051001
		arg_1_1.duration_ = 3.53

		local var_1_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 3.533,
			en = 1.999999999999
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
				arg_1_0:Play107051002(arg_1_1)
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

			local var_4_3 = arg_1_1.actors_["1050ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_4 = 0.1

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 and not isNil(var_4_3) then
				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_3) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 and not isNil(var_4_3) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_4_6 = arg_1_1.actors_["1050ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_6.localPosition
			end

			local var_4_7 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_1_1.time_ - 0) / var_4_7)
				var_4_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_6.position).x, (manager.ui.mainCamera.transform.position - var_4_6.position).y, (manager.ui.mainCamera.transform.position - var_4_6.position).z)
				var_4_6.localEulerAngles.z = 0
				var_4_6.localEulerAngles.x = 0
				var_4_6.localEulerAngles = var_4_6.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_4_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_6.position).x, (manager.ui.mainCamera.transform.position - var_4_6.position).y, (manager.ui.mainCamera.transform.position - var_4_6.position).z)
				var_4_6.localEulerAngles.z = 0
				var_4_6.localEulerAngles.x = 0
				var_4_6.localEulerAngles = var_4_6.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action7_1")
			end

			local var_4_8 = "1099ui_story"

			if arg_1_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1099ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos1099ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_1_1.time_ - 0) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_4_14 = 0
			local var_4_15 = 0.15

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:GetWordFromCfg(107051001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 6 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 6)

				if (6 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 6)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051001", "story_v_out_107051.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_107051", "107051001", "story_v_out_107051.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_107051", "107051001", "story_v_out_107051.awb")

						arg_1_1:RecordAudio("107051001", var_4_22)
						arg_1_1:RecordAudio("107051001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107051", "107051001", "story_v_out_107051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107051", "107051001", "story_v_out_107051.awb")
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
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
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
	Play107051002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 107051002
		arg_7_1.duration_ = 3.3

		local var_7_0 = {
			ja = 2.1,
			ko = 3.3,
			zh = 3.066,
			en = 3.1
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
				arg_7_0:Play107051003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1099ui_story"]) and arg_7_1.var_.characterEffect1099ui_story == nil then
				arg_7_1.var_.characterEffect1099ui_story = arg_7_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1099ui_story"]) then
				if arg_7_1.var_.characterEffect1099ui_story and not isNil(arg_7_1.actors_["1099ui_story"]) then
					arg_7_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1099ui_story"]) and arg_7_1.var_.characterEffect1099ui_story then
				arg_7_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_10_2 = arg_7_1.actors_["1050ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.characterEffect1050ui_story == nil then
				arg_7_1.var_.characterEffect1050ui_story = var_10_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_3 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_3 and not isNil(var_10_2) then
				if arg_7_1.var_.characterEffect1050ui_story and not isNil(var_10_2) then
					arg_7_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_3)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_3 and arg_7_1.time_ < 0 + var_10_3 + arg_10_0 and not isNil(var_10_2) and arg_7_1.var_.characterEffect1050ui_story then
				arg_7_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_10_4 = 0
			local var_10_5 = 0.3

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_6 = arg_7_1:GetWordFromCfg(107051002)
				local var_10_7 = arg_7_1:FormatText(var_10_6.content)

				arg_7_1.text_.text = var_10_7

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_9 = 12 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 12)

				if (12 <= 0 and var_10_5 or var_10_5 * (utf8.len(var_10_7) / 12)) > 0 and var_10_5 < var_10_9 then
					arg_7_1.talkMaxDuration = var_10_9

					if var_10_9 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_9 + var_10_4
					end
				end

				arg_7_1.text_.text = var_10_7
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051002", "story_v_out_107051.awb") ~= 0 then
					local var_10_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051002", "story_v_out_107051.awb") / 1000

					if var_10_10 + var_10_4 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_10 + var_10_4
					end

					if var_10_6.prefab_name ~= "" and arg_7_1.actors_[var_10_6.prefab_name] ~= nil then
						local var_10_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_6.prefab_name].transform, "story_v_out_107051", "107051002", "story_v_out_107051.awb")

						arg_7_1:RecordAudio("107051002", var_10_11)
						arg_7_1:RecordAudio("107051002", var_10_11)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_107051", "107051002", "story_v_out_107051.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_107051", "107051002", "story_v_out_107051.awb")
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
	Play107051003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 107051003
		arg_11_1.duration_ = 5.37

		local var_11_0 = {
			ja = 3.8,
			ko = 3.866,
			zh = 5.366,
			en = 4.166
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
				arg_11_0:Play107051004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1050ui_story"]) and arg_11_1.var_.characterEffect1050ui_story == nil then
				arg_11_1.var_.characterEffect1050ui_story = arg_11_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1050ui_story"]) then
				if arg_11_1.var_.characterEffect1050ui_story and not isNil(arg_11_1.actors_["1050ui_story"]) then
					arg_11_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1050ui_story"]) and arg_11_1.var_.characterEffect1050ui_story then
				arg_11_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_14_2 = arg_11_1.actors_["1099ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.characterEffect1099ui_story == nil then
				arg_11_1.var_.characterEffect1099ui_story = var_14_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_3 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_3 and not isNil(var_14_2) then
				if arg_11_1.var_.characterEffect1099ui_story and not isNil(var_14_2) then
					arg_11_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_3)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_3 and arg_11_1.time_ < 0 + var_14_3 + arg_14_0 and not isNil(var_14_2) and arg_11_1.var_.characterEffect1099ui_story then
				arg_11_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_14_4 = 0
			local var_14_5 = 0.3

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:GetWordFromCfg(107051003)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 12 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 12)

				if (12 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_7) / 12)) > 0 and var_14_5 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051003", "story_v_out_107051.awb") ~= 0 then
					local var_14_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051003", "story_v_out_107051.awb") / 1000

					if var_14_10 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_4
					end

					if var_14_6.prefab_name ~= "" and arg_11_1.actors_[var_14_6.prefab_name] ~= nil then
						local var_14_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_6.prefab_name].transform, "story_v_out_107051", "107051003", "story_v_out_107051.awb")

						arg_11_1:RecordAudio("107051003", var_14_11)
						arg_11_1:RecordAudio("107051003", var_14_11)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_107051", "107051003", "story_v_out_107051.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_107051", "107051003", "story_v_out_107051.awb")
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
	Play107051004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 107051004
		arg_15_1.duration_ = 4.93

		local var_15_0 = {
			ja = 4.466,
			ko = 4.266,
			zh = 4.066,
			en = 4.933
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
				arg_15_0:Play107051005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) and arg_15_1.var_.characterEffect1099ui_story == nil then
				arg_15_1.var_.characterEffect1099ui_story = arg_15_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) then
				if arg_15_1.var_.characterEffect1099ui_story and not isNil(arg_15_1.actors_["1099ui_story"]) then
					arg_15_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1099ui_story"]) and arg_15_1.var_.characterEffect1099ui_story then
				arg_15_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_18_2 = arg_15_1.actors_["1050ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.characterEffect1050ui_story == nil then
				arg_15_1.var_.characterEffect1050ui_story = var_18_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_3 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_3 and not isNil(var_18_2) then
				if arg_15_1.var_.characterEffect1050ui_story and not isNil(var_18_2) then
					arg_15_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_3)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_3 and arg_15_1.time_ < 0 + var_18_3 + arg_18_0 and not isNil(var_18_2) and arg_15_1.var_.characterEffect1050ui_story then
				arg_15_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_18_4 = 0
			local var_18_5 = 0.575

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_6 = arg_15_1:GetWordFromCfg(107051004)
				local var_18_7 = arg_15_1:FormatText(var_18_6.content)

				arg_15_1.text_.text = var_18_7

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 23 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_7) / 23)

				if (23 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_7) / 23)) > 0 and var_18_5 < var_18_9 then
					arg_15_1.talkMaxDuration = var_18_9

					if var_18_9 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_9 + var_18_4
					end
				end

				arg_15_1.text_.text = var_18_7
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051004", "story_v_out_107051.awb") ~= 0 then
					local var_18_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051004", "story_v_out_107051.awb") / 1000

					if var_18_10 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_4
					end

					if var_18_6.prefab_name ~= "" and arg_15_1.actors_[var_18_6.prefab_name] ~= nil then
						local var_18_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_6.prefab_name].transform, "story_v_out_107051", "107051004", "story_v_out_107051.awb")

						arg_15_1:RecordAudio("107051004", var_18_11)
						arg_15_1:RecordAudio("107051004", var_18_11)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_107051", "107051004", "story_v_out_107051.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_107051", "107051004", "story_v_out_107051.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_12 = math.max(var_18_5, arg_15_1.talkMaxDuration)

			if var_18_4 <= arg_15_1.time_ and arg_15_1.time_ < var_18_4 + var_18_12 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_4) / var_18_12

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_4 + var_18_12 and arg_15_1.time_ < var_18_4 + var_18_12 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play107051005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 107051005
		arg_19_1.duration_ = 3.8

		local var_19_0 = {
			ja = 3.8,
			ko = 3.2,
			zh = 2.666,
			en = 2.433
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
				arg_19_0:Play107051006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_22_0 = 0
			local var_22_1 = 0.325

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
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

				local var_22_2 = arg_19_1:GetWordFromCfg(107051005)
				local var_22_3 = arg_19_1:FormatText(var_22_2.content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 13 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 13)

				if (13 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_3) / 13)) > 0 and var_22_1 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051005", "story_v_out_107051.awb") ~= 0 then
					local var_22_6 = manager.audio:GetVoiceLength("story_v_out_107051", "107051005", "story_v_out_107051.awb") / 1000

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end

					if var_22_2.prefab_name ~= "" and arg_19_1.actors_[var_22_2.prefab_name] ~= nil then
						local var_22_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_2.prefab_name].transform, "story_v_out_107051", "107051005", "story_v_out_107051.awb")

						arg_19_1:RecordAudio("107051005", var_22_7)
						arg_19_1:RecordAudio("107051005", var_22_7)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_107051", "107051005", "story_v_out_107051.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_107051", "107051005", "story_v_out_107051.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_8 and arg_19_1.time_ < var_22_0 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play107051006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 107051006
		arg_23_1.duration_ = 7.2

		local var_23_0 = {
			ja = 1.8,
			ko = 6.433,
			zh = 7.2,
			en = 3.966
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play107051007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1050ui_story"]) and arg_23_1.var_.characterEffect1050ui_story == nil then
				arg_23_1.var_.characterEffect1050ui_story = arg_23_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1050ui_story"]) then
				if arg_23_1.var_.characterEffect1050ui_story and not isNil(arg_23_1.actors_["1050ui_story"]) then
					arg_23_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1050ui_story"]) and arg_23_1.var_.characterEffect1050ui_story then
				arg_23_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_26_2 = arg_23_1.actors_["1099ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.characterEffect1099ui_story == nil then
				arg_23_1.var_.characterEffect1099ui_story = var_26_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_3 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 and not isNil(var_26_2) then
				if arg_23_1.var_.characterEffect1099ui_story and not isNil(var_26_2) then
					arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_3)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 and not isNil(var_26_2) and arg_23_1.var_.characterEffect1099ui_story then
				arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_26_4 = 0
			local var_26_5 = 0.275

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(107051006)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 11 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 11)

				if (11 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 11)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051006", "story_v_out_107051.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051006", "story_v_out_107051.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_107051", "107051006", "story_v_out_107051.awb")

						arg_23_1:RecordAudio("107051006", var_26_11)
						arg_23_1:RecordAudio("107051006", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_107051", "107051006", "story_v_out_107051.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_107051", "107051006", "story_v_out_107051.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play107051007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 107051007
		arg_27_1.duration_ = 8.3

		local var_27_0 = {
			ja = 7.4,
			ko = 7.966,
			zh = 7,
			en = 8.3
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
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play107051008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1050ui_story"]) and arg_27_1.var_.characterEffect1050ui_story == nil then
				arg_27_1.var_.characterEffect1050ui_story = arg_27_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1050ui_story"]) then
				if arg_27_1.var_.characterEffect1050ui_story and not isNil(arg_27_1.actors_["1050ui_story"]) then
					arg_27_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1050ui_story"]) and arg_27_1.var_.characterEffect1050ui_story then
				arg_27_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_30_1 = arg_27_1.actors_["1099ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1099ui_story = var_30_1.localPosition
			end

			local var_30_2 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 then
				var_30_1.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_2)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 then
				var_30_1.localPosition = Vector3.New(0, 100, 0)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			local var_30_3 = arg_27_1.actors_["1050ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1050ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0, 100, 0)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = 0
			local var_30_6 = 0.825

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_7 = arg_27_1:GetWordFromCfg(107051007)
				local var_30_8 = arg_27_1:FormatText(var_30_7.content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 33 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 33)

				if (33 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 33)) > 0 and var_30_6 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051007", "story_v_out_107051.awb") ~= 0 then
					local var_30_11 = manager.audio:GetVoiceLength("story_v_out_107051", "107051007", "story_v_out_107051.awb") / 1000

					if var_30_11 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_5
					end

					if var_30_7.prefab_name ~= "" and arg_27_1.actors_[var_30_7.prefab_name] ~= nil then
						local var_30_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_7.prefab_name].transform, "story_v_out_107051", "107051007", "story_v_out_107051.awb")

						arg_27_1:RecordAudio("107051007", var_30_12)
						arg_27_1:RecordAudio("107051007", var_30_12)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_107051", "107051007", "story_v_out_107051.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_107051", "107051007", "story_v_out_107051.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_13 and arg_27_1.time_ < var_30_5 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play107051008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 107051008
		arg_31_1.duration_ = 5.47

		local var_31_0 = {
			ja = 5.466,
			ko = 3.833,
			zh = 3.2,
			en = 3.2
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
				arg_31_0:Play107051009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1050ui_story"]) and arg_31_1.var_.characterEffect1050ui_story == nil then
				arg_31_1.var_.characterEffect1050ui_story = arg_31_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.1

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1050ui_story"]) then
				if arg_31_1.var_.characterEffect1050ui_story and not isNil(arg_31_1.actors_["1050ui_story"]) then
					arg_31_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1050ui_story"]) and arg_31_1.var_.characterEffect1050ui_story then
				arg_31_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_34_2 = arg_31_1.actors_["1050ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1050ui_story = var_34_2.localPosition
			end

			local var_34_3 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 then
				var_34_2.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_31_1.time_ - 0) / var_34_3)
				var_34_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_2.position).x, (manager.ui.mainCamera.transform.position - var_34_2.position).y, (manager.ui.mainCamera.transform.position - var_34_2.position).z)
				var_34_2.localEulerAngles.z = 0
				var_34_2.localEulerAngles.x = 0
				var_34_2.localEulerAngles = var_34_2.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 then
				var_34_2.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_34_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_2.position).x, (manager.ui.mainCamera.transform.position - var_34_2.position).y, (manager.ui.mainCamera.transform.position - var_34_2.position).z)
				var_34_2.localEulerAngles.z = 0
				var_34_2.localEulerAngles.x = 0
				var_34_2.localEulerAngles = var_34_2.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_34_4 = arg_31_1.actors_["1099ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1099ui_story = var_34_4.localPosition
			end

			local var_34_5 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 then
				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_31_1.time_ - 0) / var_34_5)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_34_6 = 0
			local var_34_7 = 0.3

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(107051008)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 12 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 12)

				if (12 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_9) / 12)) > 0 and var_34_7 < var_34_11 then
					arg_31_1.talkMaxDuration = var_34_11

					if var_34_11 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051008", "story_v_out_107051.awb") ~= 0 then
					local var_34_12 = manager.audio:GetVoiceLength("story_v_out_107051", "107051008", "story_v_out_107051.awb") / 1000

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end

					if var_34_8.prefab_name ~= "" and arg_31_1.actors_[var_34_8.prefab_name] ~= nil then
						local var_34_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_8.prefab_name].transform, "story_v_out_107051", "107051008", "story_v_out_107051.awb")

						arg_31_1:RecordAudio("107051008", var_34_13)
						arg_31_1:RecordAudio("107051008", var_34_13)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_107051", "107051008", "story_v_out_107051.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_107051", "107051008", "story_v_out_107051.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_14 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_14 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_14

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_14 and arg_31_1.time_ < var_34_6 + var_34_14 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play107051009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 107051009
		arg_35_1.duration_ = 8.27

		local var_35_0 = {
			ja = 7.2,
			ko = 6.466,
			zh = 7,
			en = 8.266
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play107051010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1099ui_story"]) and arg_35_1.var_.characterEffect1099ui_story == nil then
				arg_35_1.var_.characterEffect1099ui_story = arg_35_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1099ui_story"]) then
				if arg_35_1.var_.characterEffect1099ui_story and not isNil(arg_35_1.actors_["1099ui_story"]) then
					arg_35_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1099ui_story"]) and arg_35_1.var_.characterEffect1099ui_story then
				arg_35_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_38_2 = arg_35_1.actors_["1050ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1050ui_story == nil then
				arg_35_1.var_.characterEffect1050ui_story = var_38_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_3 = 0.1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.characterEffect1050ui_story and not isNil(var_38_2) then
					arg_35_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_3)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1050ui_story then
				arg_35_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.925

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(107051009)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 37 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 37)

				if (37 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 37)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051009", "story_v_out_107051.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051009", "story_v_out_107051.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_107051", "107051009", "story_v_out_107051.awb")

						arg_35_1:RecordAudio("107051009", var_38_11)
						arg_35_1:RecordAudio("107051009", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_107051", "107051009", "story_v_out_107051.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_107051", "107051009", "story_v_out_107051.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play107051010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 107051010
		arg_39_1.duration_ = 11.83

		local var_39_0 = {
			ja = 9.6,
			ko = 10.5,
			zh = 11.833,
			en = 10.566
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play107051011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.actors_["3014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3014_tpose"))) then
				local var_42_0 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_39_1.stage_.transform)

				var_42_0.name = "3014_tpose"
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["3014_tpose"] = var_42_0

				local var_42_1 = var_42_0:GetComponentInChildren(typeof(CharacterEffect))

				var_42_1.enabled = true

				local var_42_2 = GameObjectTools.GetOrAddComponent(var_42_0, typeof(DynamicBoneHelper))

				if var_42_2 then
					var_42_2:EnableDynamicBone(false)
				end

				arg_39_1:ShowWeapon(var_42_1.transform, false)

				arg_39_1.var_["3014_tpose" .. "Animator"] = var_42_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_39_1.var_["3014_tpose" .. "Animator"].applyRootMotion = true
				arg_39_1.var_["3014_tpose" .. "LipSync"] = var_42_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_42_3 = arg_39_1.actors_["3014_tpose"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect3014_tpose == nil then
				arg_39_1.var_.characterEffect3014_tpose = var_42_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_4 = 0.1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 and not isNil(var_42_3) then
				if arg_39_1.var_.characterEffect3014_tpose and not isNil(var_42_3) then
					arg_39_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 and not isNil(var_42_3) and arg_39_1.var_.characterEffect3014_tpose then
				arg_39_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_42_6 = arg_39_1.actors_["1099ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1099ui_story == nil then
				arg_39_1.var_.characterEffect1099ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 and not isNil(var_42_6) then
				if arg_39_1.var_.characterEffect1099ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_7)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1099ui_story then
				arg_39_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_42_8 = arg_39_1.actors_["1050ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1050ui_story = var_42_8.localPosition
			end

			local var_42_9 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 then
				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_9)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(0, 100, 0)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			local var_42_10 = arg_39_1.actors_["3014_tpose"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos3014_tpose = var_42_10.localPosition

				local var_42_11 = GameObjectTools.GetOrAddComponent(var_42_10.gameObject, typeof(DynamicBoneHelper))

				if var_42_11 then
					var_42_11:EnableDynamicBone(false)
				end
			end

			local var_42_12 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_12 then
				var_42_10.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos3014_tpose, Vector3.New(-0.7, -2.35, -2.9), (arg_39_1.time_ - 0) / var_42_12)
				var_42_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_10.position).x, (manager.ui.mainCamera.transform.position - var_42_10.position).y, (manager.ui.mainCamera.transform.position - var_42_10.position).z)
				var_42_10.localEulerAngles.z = 0
				var_42_10.localEulerAngles.x = 0
				var_42_10.localEulerAngles = var_42_10.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_12 and arg_39_1.time_ < 0 + var_42_12 + arg_42_0 then
				var_42_10.localPosition = Vector3.New(-0.7, -2.35, -2.9)
				var_42_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_10.position).x, (manager.ui.mainCamera.transform.position - var_42_10.position).y, (manager.ui.mainCamera.transform.position - var_42_10.position).z)
				var_42_10.localEulerAngles.z = 0
				var_42_10.localEulerAngles.x = 0
				var_42_10.localEulerAngles = var_42_10.localEulerAngles

				local var_42_13 = GameObjectTools.GetOrAddComponent(var_42_10.gameObject, typeof(DynamicBoneHelper))

				if var_42_13 then
					var_42_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_42_14 = 0
			local var_42_15 = 0.85

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_16 = arg_39_1:GetWordFromCfg(107051010)
				local var_42_17 = arg_39_1:FormatText(var_42_16.content)

				arg_39_1.text_.text = var_42_17

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_19 = 34 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 34)

				if (34 <= 0 and var_42_15 or var_42_15 * (utf8.len(var_42_17) / 34)) > 0 and var_42_15 < var_42_19 then
					arg_39_1.talkMaxDuration = var_42_19

					if var_42_19 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_14
					end
				end

				arg_39_1.text_.text = var_42_17
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051010", "story_v_out_107051.awb") ~= 0 then
					local var_42_20 = manager.audio:GetVoiceLength("story_v_out_107051", "107051010", "story_v_out_107051.awb") / 1000

					if var_42_20 + var_42_14 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_14
					end

					if var_42_16.prefab_name ~= "" and arg_39_1.actors_[var_42_16.prefab_name] ~= nil then
						local var_42_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_16.prefab_name].transform, "story_v_out_107051", "107051010", "story_v_out_107051.awb")

						arg_39_1:RecordAudio("107051010", var_42_21)
						arg_39_1:RecordAudio("107051010", var_42_21)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_107051", "107051010", "story_v_out_107051.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_107051", "107051010", "story_v_out_107051.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_15, arg_39_1.talkMaxDuration)

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_14) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_14 + var_42_22 and arg_39_1.time_ < var_42_14 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play107051011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 107051011
		arg_43_1.duration_ = 5.87

		local var_43_0 = {
			ja = 3.266,
			ko = 5.733,
			zh = 5.633,
			en = 5.866
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
				arg_43_0:Play107051012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1099ui_story"]) and arg_43_1.var_.characterEffect1099ui_story == nil then
				arg_43_1.var_.characterEffect1099ui_story = arg_43_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.1

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1099ui_story"]) then
				if arg_43_1.var_.characterEffect1099ui_story and not isNil(arg_43_1.actors_["1099ui_story"]) then
					arg_43_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1099ui_story"]) and arg_43_1.var_.characterEffect1099ui_story then
				arg_43_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["3014_tpose"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect3014_tpose == nil then
				arg_43_1.var_.characterEffect3014_tpose = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.1

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect3014_tpose and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_43_1.var_.characterEffect3014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect3014_tpose then
				arg_43_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_43_1.var_.characterEffect3014_tpose.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action465")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.55

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(107051011)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 22 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 22)

				if (22 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 22)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051011", "story_v_out_107051.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051011", "story_v_out_107051.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_107051", "107051011", "story_v_out_107051.awb")

						arg_43_1:RecordAudio("107051011", var_46_11)
						arg_43_1:RecordAudio("107051011", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_107051", "107051011", "story_v_out_107051.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_107051", "107051011", "story_v_out_107051.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play107051012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 107051012
		arg_47_1.duration_ = 10.4

		local var_47_0 = {
			ja = 5.2,
			ko = 5.966,
			zh = 9.333,
			en = 10.4
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
				arg_47_0:Play107051013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["3014_tpose"]) and arg_47_1.var_.characterEffect3014_tpose == nil then
				arg_47_1.var_.characterEffect3014_tpose = arg_47_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.1

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["3014_tpose"]) then
				if arg_47_1.var_.characterEffect3014_tpose and not isNil(arg_47_1.actors_["3014_tpose"]) then
					arg_47_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["3014_tpose"]) and arg_47_1.var_.characterEffect3014_tpose then
				arg_47_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["1099ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1099ui_story == nil then
				arg_47_1.var_.characterEffect1099ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.1

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect1099ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1099ui_story then
				arg_47_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 0.55

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(107051012)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 22 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 22)

				if (22 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 22)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051012", "story_v_out_107051.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051012", "story_v_out_107051.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_107051", "107051012", "story_v_out_107051.awb")

						arg_47_1:RecordAudio("107051012", var_50_11)
						arg_47_1:RecordAudio("107051012", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_107051", "107051012", "story_v_out_107051.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_107051", "107051012", "story_v_out_107051.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play107051013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 107051013
		arg_51_1.duration_ = 12.07

		local var_51_0 = {
			ja = 12.066,
			ko = 9.233,
			zh = 11.7,
			en = 10.2
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
				arg_51_0:Play107051014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.9

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(107051013)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 34 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 34)

				if (34 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 34)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051013", "story_v_out_107051.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_107051", "107051013", "story_v_out_107051.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_107051", "107051013", "story_v_out_107051.awb")

						arg_51_1:RecordAudio("107051013", var_54_6)
						arg_51_1:RecordAudio("107051013", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_107051", "107051013", "story_v_out_107051.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_107051", "107051013", "story_v_out_107051.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play107051014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 107051014
		arg_55_1.duration_ = 4.37

		local var_55_0 = {
			ja = 3.533,
			ko = 4.266,
			zh = 4.366,
			en = 3.666
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
				arg_55_0:Play107051015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1099ui_story"]) and arg_55_1.var_.characterEffect1099ui_story == nil then
				arg_55_1.var_.characterEffect1099ui_story = arg_55_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.1

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1099ui_story"]) then
				if arg_55_1.var_.characterEffect1099ui_story and not isNil(arg_55_1.actors_["1099ui_story"]) then
					arg_55_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1099ui_story"]) and arg_55_1.var_.characterEffect1099ui_story then
				arg_55_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["3014_tpose"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect3014_tpose == nil then
				arg_55_1.var_.characterEffect3014_tpose = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.1

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect3014_tpose and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_55_1.var_.characterEffect3014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect3014_tpose then
				arg_55_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_55_1.var_.characterEffect3014_tpose.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.275

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(107051014)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 11 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 11)

				if (11 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 11)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051014", "story_v_out_107051.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051014", "story_v_out_107051.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_107051", "107051014", "story_v_out_107051.awb")

						arg_55_1:RecordAudio("107051014", var_58_11)
						arg_55_1:RecordAudio("107051014", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_107051", "107051014", "story_v_out_107051.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_107051", "107051014", "story_v_out_107051.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play107051015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 107051015
		arg_59_1.duration_ = 6.73

		local var_59_0 = {
			ja = 5.9,
			ko = 6.733,
			zh = 5.233,
			en = 5.733
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
				arg_59_0:Play107051016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1099ui_story"]) and arg_59_1.var_.characterEffect1099ui_story == nil then
				arg_59_1.var_.characterEffect1099ui_story = arg_59_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.1

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1099ui_story"]) then
				if arg_59_1.var_.characterEffect1099ui_story and not isNil(arg_59_1.actors_["1099ui_story"]) then
					arg_59_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1099ui_story"]) and arg_59_1.var_.characterEffect1099ui_story then
				arg_59_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_62_1 = arg_59_1.actors_["1099ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1099ui_story = var_62_1.localPosition
			end

			local var_62_2 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 then
				var_62_1.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_2)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 then
				var_62_1.localPosition = Vector3.New(0, 100, 0)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			local var_62_3 = arg_59_1.actors_["3014_tpose"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos3014_tpose = var_62_3.localPosition

				local var_62_4 = GameObjectTools.GetOrAddComponent(var_62_3.gameObject, typeof(DynamicBoneHelper))

				if var_62_4 then
					var_62_4:EnableDynamicBone(false)
				end
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_3.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_5)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_3.localPosition = Vector3.New(0, 100, 0)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles

				local var_62_6 = GameObjectTools.GetOrAddComponent(var_62_3.gameObject, typeof(DynamicBoneHelper))

				if var_62_6 then
					var_62_6:EnableDynamicBone(true)
				end
			end

			local var_62_7 = 0
			local var_62_8 = 0.625

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_9 = arg_59_1:GetWordFromCfg(107051015)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 25 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 25)

				if (25 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 25)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051015", "story_v_out_107051.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_107051", "107051015", "story_v_out_107051.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_107051", "107051015", "story_v_out_107051.awb")

						arg_59_1:RecordAudio("107051015", var_62_14)
						arg_59_1:RecordAudio("107051015", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_107051", "107051015", "story_v_out_107051.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_107051", "107051015", "story_v_out_107051.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_7) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_7 + var_62_15 and arg_59_1.time_ < var_62_7 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play107051016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 107051016
		arg_63_1.duration_ = 8.5

		local var_63_0 = {
			ja = 5.633,
			ko = 6.9,
			zh = 8.5,
			en = 5.866
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play107051017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["3014_tpose"]) and arg_63_1.var_.characterEffect3014_tpose == nil then
				arg_63_1.var_.characterEffect3014_tpose = arg_63_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["3014_tpose"]) then
				if arg_63_1.var_.characterEffect3014_tpose and not isNil(arg_63_1.actors_["3014_tpose"]) then
					arg_63_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["3014_tpose"]) and arg_63_1.var_.characterEffect3014_tpose then
				arg_63_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["3014_tpose"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos3014_tpose = var_66_2.localPosition

				local var_66_3 = GameObjectTools.GetOrAddComponent(var_66_2.gameObject, typeof(DynamicBoneHelper))

				if var_66_3 then
					var_66_3:EnableDynamicBone(false)
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_63_1.time_ - 0) / var_66_4)
				var_66_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_2.position).x, (manager.ui.mainCamera.transform.position - var_66_2.position).y, (manager.ui.mainCamera.transform.position - var_66_2.position).z)
				var_66_2.localEulerAngles.z = 0
				var_66_2.localEulerAngles.x = 0
				var_66_2.localEulerAngles = var_66_2.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -2.35, -2.9)
				var_66_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_2.position).x, (manager.ui.mainCamera.transform.position - var_66_2.position).y, (manager.ui.mainCamera.transform.position - var_66_2.position).z)
				var_66_2.localEulerAngles.z = 0
				var_66_2.localEulerAngles.x = 0
				var_66_2.localEulerAngles = var_66_2.localEulerAngles

				local var_66_5 = GameObjectTools.GetOrAddComponent(var_66_2.gameObject, typeof(DynamicBoneHelper))

				if var_66_5 then
					var_66_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_66_6 = 0
			local var_66_7 = 0.675

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(107051016)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 27 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 27)

				if (27 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 27)) > 0 and var_66_7 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051016", "story_v_out_107051.awb") ~= 0 then
					local var_66_12 = manager.audio:GetVoiceLength("story_v_out_107051", "107051016", "story_v_out_107051.awb") / 1000

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end

					if var_66_8.prefab_name ~= "" and arg_63_1.actors_[var_66_8.prefab_name] ~= nil then
						local var_66_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_8.prefab_name].transform, "story_v_out_107051", "107051016", "story_v_out_107051.awb")

						arg_63_1:RecordAudio("107051016", var_66_13)
						arg_63_1:RecordAudio("107051016", var_66_13)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_107051", "107051016", "story_v_out_107051.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_107051", "107051016", "story_v_out_107051.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play107051017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 107051017
		arg_67_1.duration_ = 3

		local var_67_0 = {
			ja = 1.766,
			ko = 2.366,
			zh = 3,
			en = 1.5
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play107051018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.15

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(107051017)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 6 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 6)

				if (6 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 6)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051017", "story_v_out_107051.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_107051", "107051017", "story_v_out_107051.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_107051", "107051017", "story_v_out_107051.awb")

						arg_67_1:RecordAudio("107051017", var_70_6)
						arg_67_1:RecordAudio("107051017", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_107051", "107051017", "story_v_out_107051.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_107051", "107051017", "story_v_out_107051.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play107051018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 107051018
		arg_71_1.duration_ = 7.07

		local var_71_0 = {
			ja = 5.333,
			ko = 4.366,
			zh = 7.066,
			en = 4.8
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
				arg_71_0:Play107051019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.5

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(107051018)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 20 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 20)

				if (20 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 20)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051018", "story_v_out_107051.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_107051", "107051018", "story_v_out_107051.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_107051", "107051018", "story_v_out_107051.awb")

						arg_71_1:RecordAudio("107051018", var_74_6)
						arg_71_1:RecordAudio("107051018", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_107051", "107051018", "story_v_out_107051.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_107051", "107051018", "story_v_out_107051.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play107051019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 107051019
		arg_75_1.duration_ = 14.73

		local var_75_0 = {
			ja = 5.9,
			ko = 7.333,
			zh = 9.166,
			en = 14.733
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play107051020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(107051019)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)

				if (17 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 17)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051019", "story_v_out_107051.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_107051", "107051019", "story_v_out_107051.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_107051", "107051019", "story_v_out_107051.awb")

						arg_75_1:RecordAudio("107051019", var_78_6)
						arg_75_1:RecordAudio("107051019", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_107051", "107051019", "story_v_out_107051.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_107051", "107051019", "story_v_out_107051.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play107051020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 107051020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play107051021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["3014_tpose"]) and arg_79_1.var_.characterEffect3014_tpose == nil then
				arg_79_1.var_.characterEffect3014_tpose = arg_79_1.actors_["3014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.1

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["3014_tpose"]) then
				if arg_79_1.var_.characterEffect3014_tpose and not isNil(arg_79_1.actors_["3014_tpose"]) then
					arg_79_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_79_1.var_.characterEffect3014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["3014_tpose"]) and arg_79_1.var_.characterEffect3014_tpose then
				arg_79_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_79_1.var_.characterEffect3014_tpose.fillRatio = 0.5
			end

			local var_82_1 = arg_79_1.actors_["3014_tpose"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos3014_tpose = var_82_1.localPosition

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_1.gameObject, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end
			end

			local var_82_3 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 then
				var_82_1.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_3)
				var_82_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_1.position).x, (manager.ui.mainCamera.transform.position - var_82_1.position).y, (manager.ui.mainCamera.transform.position - var_82_1.position).z)
				var_82_1.localEulerAngles.z = 0
				var_82_1.localEulerAngles.x = 0
				var_82_1.localEulerAngles = var_82_1.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 then
				var_82_1.localPosition = Vector3.New(0, 100, 0)
				var_82_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_1.position).x, (manager.ui.mainCamera.transform.position - var_82_1.position).y, (manager.ui.mainCamera.transform.position - var_82_1.position).z)
				var_82_1.localEulerAngles.z = 0
				var_82_1.localEulerAngles.x = 0
				var_82_1.localEulerAngles = var_82_1.localEulerAngles

				local var_82_4 = GameObjectTools.GetOrAddComponent(var_82_1.gameObject, typeof(DynamicBoneHelper))

				if var_82_4 then
					var_82_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_7", "se_story_7_manufacture", "")
			end

			local var_82_6 = 0
			local var_82_7 = 1.15

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(107051020).content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 46 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_8) / 46)

				if (46 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_8) / 46)) > 0 and var_82_7 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_11 and arg_79_1.time_ < var_82_6 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play107051021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 107051021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play107051022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["3016_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3016_tpose"))) then
				local var_86_0 = Object.Instantiate(Asset.Load("Char/" .. "3016_tpose"), arg_83_1.stage_.transform)

				var_86_0.name = "3016_tpose"
				var_86_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["3016_tpose"] = var_86_0

				local var_86_1 = var_86_0:GetComponentInChildren(typeof(CharacterEffect))

				var_86_1.enabled = true

				local var_86_2 = GameObjectTools.GetOrAddComponent(var_86_0, typeof(DynamicBoneHelper))

				if var_86_2 then
					var_86_2:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_1.transform, false)

				arg_83_1.var_["3016_tpose" .. "Animator"] = var_86_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_["3016_tpose" .. "Animator"].applyRootMotion = true
				arg_83_1.var_["3016_tpose" .. "LipSync"] = var_86_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_3 = arg_83_1.actors_["3016_tpose"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect3016_tpose == nil then
				arg_83_1.var_.characterEffect3016_tpose = var_86_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.1

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.characterEffect3016_tpose and not isNil(var_86_3) then
					arg_83_1.var_.characterEffect3016_tpose.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect3016_tpose then
				arg_83_1.var_.characterEffect3016_tpose.fillFlat = false
			end

			local var_86_6 = arg_83_1.actors_["3014_tpose"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos3014_tpose = var_86_6.localPosition

				local var_86_7 = GameObjectTools.GetOrAddComponent(var_86_6.gameObject, typeof(DynamicBoneHelper))

				if var_86_7 then
					var_86_7:EnableDynamicBone(false)
				end
			end

			local var_86_8 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_8 then
				var_86_6.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos3014_tpose, Vector3.New(0, -2.35, -2.9), (arg_83_1.time_ - 0) / var_86_8)
				var_86_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_6.position).x, (manager.ui.mainCamera.transform.position - var_86_6.position).y, (manager.ui.mainCamera.transform.position - var_86_6.position).z)
				var_86_6.localEulerAngles.z = 0
				var_86_6.localEulerAngles.x = 0
				var_86_6.localEulerAngles = var_86_6.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_8 and arg_83_1.time_ < 0 + var_86_8 + arg_86_0 then
				var_86_6.localPosition = Vector3.New(0, -2.35, -2.9)
				var_86_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_6.position).x, (manager.ui.mainCamera.transform.position - var_86_6.position).y, (manager.ui.mainCamera.transform.position - var_86_6.position).z)
				var_86_6.localEulerAngles.z = 0
				var_86_6.localEulerAngles.x = 0
				var_86_6.localEulerAngles = var_86_6.localEulerAngles

				local var_86_9 = GameObjectTools.GetOrAddComponent(var_86_6.gameObject, typeof(DynamicBoneHelper))

				if var_86_9 then
					var_86_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_7", "se_story_7_monster", "")
			end

			local var_86_11 = 0
			local var_86_12 = 0.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_11 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3016")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_13 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(107051021).content)

				arg_83_1.text_.text = var_86_13

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_15 = 4 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_13) / 4)

				if (4 <= 0 and var_86_12 or var_86_12 * (utf8.len(var_86_13) / 4)) > 0 and var_86_12 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_11 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_11
					end
				end

				arg_83_1.text_.text = var_86_13
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_12, arg_83_1.talkMaxDuration)

			if var_86_11 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_11) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_11 + var_86_16 and arg_83_1.time_ < var_86_11 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play107051022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 107051022
		arg_87_1.duration_ = 4.63

		local var_87_0 = {
			ja = 4.633,
			ko = 4.366,
			zh = 3.666,
			en = 4.2
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play107051023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["3016_tpose"]) and arg_87_1.var_.characterEffect3016_tpose == nil then
				arg_87_1.var_.characterEffect3016_tpose = arg_87_1.actors_["3016_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["3016_tpose"]) then
				if arg_87_1.var_.characterEffect3016_tpose and not isNil(arg_87_1.actors_["3016_tpose"]) then
					arg_87_1.var_.characterEffect3016_tpose.fillFlat = true
					arg_87_1.var_.characterEffect3016_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["3016_tpose"]) and arg_87_1.var_.characterEffect3016_tpose then
				arg_87_1.var_.characterEffect3016_tpose.fillFlat = true
				arg_87_1.var_.characterEffect3016_tpose.fillRatio = 0.5
			end

			local var_90_1 = arg_87_1.actors_["3014_tpose"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos3014_tpose = var_90_1.localPosition

				local var_90_2 = GameObjectTools.GetOrAddComponent(var_90_1.gameObject, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(false)
				end
			end

			local var_90_3 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				var_90_1.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos3014_tpose, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_3)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 then
				var_90_1.localPosition = Vector3.New(0, 100, 0)
				var_90_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_1.position).x, (manager.ui.mainCamera.transform.position - var_90_1.position).y, (manager.ui.mainCamera.transform.position - var_90_1.position).z)
				var_90_1.localEulerAngles.z = 0
				var_90_1.localEulerAngles.x = 0
				var_90_1.localEulerAngles = var_90_1.localEulerAngles

				local var_90_4 = GameObjectTools.GetOrAddComponent(var_90_1.gameObject, typeof(DynamicBoneHelper))

				if var_90_4 then
					var_90_4:EnableDynamicBone(true)
				end
			end

			local var_90_5 = 0
			local var_90_6 = 0.35

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_7 = arg_87_1:GetWordFromCfg(107051022)
				local var_90_8 = arg_87_1:FormatText(var_90_7.content)

				arg_87_1.text_.text = var_90_8

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_10 = 14 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 14)

				if (14 <= 0 and var_90_6 or var_90_6 * (utf8.len(var_90_8) / 14)) > 0 and var_90_6 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_5
					end
				end

				arg_87_1.text_.text = var_90_8
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051022", "story_v_out_107051.awb") ~= 0 then
					local var_90_11 = manager.audio:GetVoiceLength("story_v_out_107051", "107051022", "story_v_out_107051.awb") / 1000

					if var_90_11 + var_90_5 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_5
					end

					if var_90_7.prefab_name ~= "" and arg_87_1.actors_[var_90_7.prefab_name] ~= nil then
						local var_90_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_7.prefab_name].transform, "story_v_out_107051", "107051022", "story_v_out_107051.awb")

						arg_87_1:RecordAudio("107051022", var_90_12)
						arg_87_1:RecordAudio("107051022", var_90_12)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_107051", "107051022", "story_v_out_107051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_107051", "107051022", "story_v_out_107051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_6, arg_87_1.talkMaxDuration)

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_5) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_5 + var_90_13 and arg_87_1.time_ < var_90_5 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play107051023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 107051023
		arg_91_1.duration_ = 4.43

		local var_91_0 = {
			ja = 2.6,
			ko = 3.1,
			zh = 4.433,
			en = 1.999999999999
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
				arg_91_0:Play107051024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1050ui_story"]) and arg_91_1.var_.characterEffect1050ui_story == nil then
				arg_91_1.var_.characterEffect1050ui_story = arg_91_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.1

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1050ui_story"]) then
				if arg_91_1.var_.characterEffect1050ui_story and not isNil(arg_91_1.actors_["1050ui_story"]) then
					arg_91_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1050ui_story"]) and arg_91_1.var_.characterEffect1050ui_story then
				arg_91_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_94_2 = arg_91_1.actors_["1050ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1050ui_story = var_94_2.localPosition

				arg_91_1:ShowWeapon(arg_91_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_94_3 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_91_1.time_ - 0) / var_94_3)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_94_4 = arg_91_1.actors_["1099ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1099ui_story = var_94_4.localPosition
			end

			local var_94_5 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 then
				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_91_1.time_ - 0) / var_94_5)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_94_6 = 0
			local var_94_7 = 0.225

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[75].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(107051023)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 9 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 9)

				if (9 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 9)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051023", "story_v_out_107051.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_107051", "107051023", "story_v_out_107051.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_107051", "107051023", "story_v_out_107051.awb")

						arg_91_1:RecordAudio("107051023", var_94_13)
						arg_91_1:RecordAudio("107051023", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_107051", "107051023", "story_v_out_107051.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_107051", "107051023", "story_v_out_107051.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play107051024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 107051024
		arg_95_1.duration_ = 4.03

		local var_95_0 = {
			ja = 4.033,
			ko = 2.833,
			zh = 3.4,
			en = 4.033
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
				arg_95_0:Play107051025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1099ui_story"]) and arg_95_1.var_.characterEffect1099ui_story == nil then
				arg_95_1.var_.characterEffect1099ui_story = arg_95_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.1

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1099ui_story"]) then
				if arg_95_1.var_.characterEffect1099ui_story and not isNil(arg_95_1.actors_["1099ui_story"]) then
					arg_95_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1099ui_story"]) and arg_95_1.var_.characterEffect1099ui_story then
				arg_95_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_98_2 = arg_95_1.actors_["1050ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1050ui_story == nil then
				arg_95_1.var_.characterEffect1050ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.1

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.characterEffect1050ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_3)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1050ui_story then
				arg_95_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action445")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.425

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(107051024)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 17 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 17)

				if (17 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 17)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051024", "story_v_out_107051.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_107051", "107051024", "story_v_out_107051.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_107051", "107051024", "story_v_out_107051.awb")

						arg_95_1:RecordAudio("107051024", var_98_11)
						arg_95_1:RecordAudio("107051024", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_107051", "107051024", "story_v_out_107051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_107051", "107051024", "story_v_out_107051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play107051025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 107051025
		arg_99_1.duration_ = 2.87

		local var_99_0 = {
			ja = 2.866,
			ko = 1.933,
			zh = 2.166,
			en = 1.7
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
			arg_99_1.auto_ = false
		end

		function arg_99_1.playNext_(arg_101_0)
			arg_99_1.onStoryFinished_()
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_102_0 = 0
			local var_102_1 = 0.2

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(107051025)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 8 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_3) / 8)

				if (8 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_3) / 8)) > 0 and var_102_1 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051025", "story_v_out_107051.awb") ~= 0 then
					local var_102_6 = manager.audio:GetVoiceLength("story_v_out_107051", "107051025", "story_v_out_107051.awb") / 1000

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end

					if var_102_2.prefab_name ~= "" and arg_99_1.actors_[var_102_2.prefab_name] ~= nil then
						local var_102_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_2.prefab_name].transform, "story_v_out_107051", "107051025", "story_v_out_107051.awb")

						arg_99_1:RecordAudio("107051025", var_102_7)
						arg_99_1:RecordAudio("107051025", var_102_7)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_107051", "107051025", "story_v_out_107051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_107051", "107051025", "story_v_out_107051.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_107051.awb"
	}
}
