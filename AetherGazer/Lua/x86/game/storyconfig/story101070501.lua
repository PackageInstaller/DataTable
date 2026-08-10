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
			local var_4_0 = "1050ui_story"

			if arg_1_1.actors_[var_4_0] == nil then
				local var_4_1 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_4_1) then
					local var_4_2 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_1_1.stage_.transform)

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

			local var_4_5 = arg_1_1.actors_["1050ui_story"]
			local var_4_6 = 0

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_7 = 0.1

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 and not isNil(var_4_5) then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7

				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_4_9 = arg_1_1.actors_["1050ui_story"].transform
			local var_4_10 = 0

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_9.localPosition
			end

			local var_4_11 = 0.001

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_10) / var_4_11
				local var_4_13 = Vector3.New(-0.7, -1, -6.1)

				var_4_9.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, var_4_13, var_4_12)

				local var_4_14 = manager.ui.mainCamera.transform.position - var_4_9.position

				var_4_9.forward = Vector3.New(var_4_14.x, var_4_14.y, var_4_14.z)

				local var_4_15 = var_4_9.localEulerAngles

				var_4_15.z = 0
				var_4_15.x = 0
				var_4_9.localEulerAngles = var_4_15
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				var_4_9.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_4_16 = manager.ui.mainCamera.transform.position - var_4_9.position

				var_4_9.forward = Vector3.New(var_4_16.x, var_4_16.y, var_4_16.z)

				local var_4_17 = var_4_9.localEulerAngles

				var_4_17.z = 0
				var_4_17.x = 0
				var_4_9.localEulerAngles = var_4_17
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action7_1")
			end

			local var_4_19 = "1099ui_story"

			if arg_1_1.actors_[var_4_19] == nil then
				local var_4_20 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_4_20) then
					local var_4_21 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_1_1.stage_.transform)

					var_4_21.name = var_4_19
					var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_19] = var_4_21

					local var_4_22 = var_4_21:GetComponentInChildren(typeof(CharacterEffect))

					var_4_22.enabled = true

					local var_4_23 = GameObjectTools.GetOrAddComponent(var_4_21, typeof(DynamicBoneHelper))

					if var_4_23 then
						var_4_23:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_22.transform, false)

					arg_1_1.var_[var_4_19 .. "Animator"] = var_4_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_19 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_19 .. "LipSync"] = var_4_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_24 = arg_1_1.actors_["1099ui_story"].transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.moveOldPos1099ui_story = var_4_24.localPosition
			end

			local var_4_26 = 0.001

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_25) / var_4_26
				local var_4_28 = Vector3.New(0.7, -1.08, -5.9)

				var_4_24.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1099ui_story, var_4_28, var_4_27)

				local var_4_29 = manager.ui.mainCamera.transform.position - var_4_24.position

				var_4_24.forward = Vector3.New(var_4_29.x, var_4_29.y, var_4_29.z)

				local var_4_30 = var_4_24.localEulerAngles

				var_4_30.z = 0
				var_4_30.x = 0
				var_4_24.localEulerAngles = var_4_30
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				var_4_24.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_4_31 = manager.ui.mainCamera.transform.position - var_4_24.position

				var_4_24.forward = Vector3.New(var_4_31.x, var_4_31.y, var_4_31.z)

				local var_4_32 = var_4_24.localEulerAngles

				var_4_32.z = 0
				var_4_32.x = 0
				var_4_24.localEulerAngles = var_4_32
			end

			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_4_35 = 0
			local var_4_36 = 0.15

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_37 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_37:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_38 = arg_1_1:FormatText(StoryNameCfg[74].name)

				arg_1_1.leftNameTxt_.text = var_4_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(107051001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 6
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_36 or var_4_36 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_36 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_35 = var_4_35 + 0.3

					if var_4_43 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_35
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051001", "story_v_out_107051.awb") ~= 0 then
					local var_4_44 = manager.audio:GetVoiceLength("story_v_out_107051", "107051001", "story_v_out_107051.awb") / 1000

					if var_4_44 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_35
					end

					if var_4_39.prefab_name ~= "" and arg_1_1.actors_[var_4_39.prefab_name] ~= nil then
						local var_4_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_39.prefab_name].transform, "story_v_out_107051", "107051001", "story_v_out_107051.awb")

						arg_1_1:RecordAudio("107051001", var_4_45)
						arg_1_1:RecordAudio("107051001", var_4_45)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_107051", "107051001", "story_v_out_107051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_107051", "107051001", "story_v_out_107051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_35 + 0.3
			local var_4_47 = math.max(var_4_36, arg_1_1.talkMaxDuration)

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
			local var_10_0 = arg_7_1.actors_["1099ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1099ui_story == nil then
				arg_7_1.var_.characterEffect1099ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.1

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 and not isNil(var_10_0) then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect1099ui_story and not isNil(var_10_0) then
					arg_7_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1099ui_story then
				arg_7_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_10_4 = arg_7_1.actors_["1050ui_story"]
			local var_10_5 = 0

			if var_10_5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_5 + arg_10_0 and not isNil(var_10_4) and arg_7_1.var_.characterEffect1050ui_story == nil then
				arg_7_1.var_.characterEffect1050ui_story = var_10_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.1

			if var_10_5 <= arg_7_1.time_ and arg_7_1.time_ < var_10_5 + var_10_6 and not isNil(var_10_4) then
				local var_10_7 = (arg_7_1.time_ - var_10_5) / var_10_6

				if arg_7_1.var_.characterEffect1050ui_story and not isNil(var_10_4) then
					local var_10_8 = Mathf.Lerp(0, 0.5, var_10_7)

					arg_7_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1050ui_story.fillRatio = var_10_8
				end
			end

			if arg_7_1.time_ >= var_10_5 + var_10_6 and arg_7_1.time_ < var_10_5 + var_10_6 + arg_10_0 and not isNil(var_10_4) and arg_7_1.var_.characterEffect1050ui_story then
				local var_10_9 = 0.5

				arg_7_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1050ui_story.fillRatio = var_10_9
			end

			local var_10_10 = 0

			if var_10_10 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 then
				arg_7_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_10_11 = 0
			local var_10_12 = 0.3

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_13 = arg_7_1:FormatText(StoryNameCfg[84].name)

				arg_7_1.leftNameTxt_.text = var_10_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_14 = arg_7_1:GetWordFromCfg(107051002)
				local var_10_15 = arg_7_1:FormatText(var_10_14.content)

				arg_7_1.text_.text = var_10_15

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_16 = 12
				local var_10_17 = utf8.len(var_10_15)
				local var_10_18 = var_10_16 <= 0 and var_10_12 or var_10_12 * (var_10_17 / var_10_16)

				if var_10_18 > 0 and var_10_12 < var_10_18 then
					arg_7_1.talkMaxDuration = var_10_18

					if var_10_18 + var_10_11 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_18 + var_10_11
					end
				end

				arg_7_1.text_.text = var_10_15
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051002", "story_v_out_107051.awb") ~= 0 then
					local var_10_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051002", "story_v_out_107051.awb") / 1000

					if var_10_19 + var_10_11 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_19 + var_10_11
					end

					if var_10_14.prefab_name ~= "" and arg_7_1.actors_[var_10_14.prefab_name] ~= nil then
						local var_10_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_14.prefab_name].transform, "story_v_out_107051", "107051002", "story_v_out_107051.awb")

						arg_7_1:RecordAudio("107051002", var_10_20)
						arg_7_1:RecordAudio("107051002", var_10_20)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_107051", "107051002", "story_v_out_107051.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_107051", "107051002", "story_v_out_107051.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_21 = math.max(var_10_12, arg_7_1.talkMaxDuration)

			if var_10_11 <= arg_7_1.time_ and arg_7_1.time_ < var_10_11 + var_10_21 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_11) / var_10_21

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_11 + var_10_21 and arg_7_1.time_ < var_10_11 + var_10_21 + arg_10_0 then
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
			local var_14_0 = arg_11_1.actors_["1050ui_story"]
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1050ui_story == nil then
				arg_11_1.var_.characterEffect1050ui_story = var_14_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.1

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 and not isNil(var_14_0) then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2

				if arg_11_1.var_.characterEffect1050ui_story and not isNil(var_14_0) then
					arg_11_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1050ui_story then
				arg_11_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_14_4 = arg_11_1.actors_["1099ui_story"]
			local var_14_5 = 0

			if var_14_5 < arg_11_1.time_ and arg_11_1.time_ <= var_14_5 + arg_14_0 and not isNil(var_14_4) and arg_11_1.var_.characterEffect1099ui_story == nil then
				arg_11_1.var_.characterEffect1099ui_story = var_14_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.1

			if var_14_5 <= arg_11_1.time_ and arg_11_1.time_ < var_14_5 + var_14_6 and not isNil(var_14_4) then
				local var_14_7 = (arg_11_1.time_ - var_14_5) / var_14_6

				if arg_11_1.var_.characterEffect1099ui_story and not isNil(var_14_4) then
					local var_14_8 = Mathf.Lerp(0, 0.5, var_14_7)

					arg_11_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1099ui_story.fillRatio = var_14_8
				end
			end

			if arg_11_1.time_ >= var_14_5 + var_14_6 and arg_11_1.time_ < var_14_5 + var_14_6 + arg_14_0 and not isNil(var_14_4) and arg_11_1.var_.characterEffect1099ui_story then
				local var_14_9 = 0.5

				arg_11_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1099ui_story.fillRatio = var_14_9
			end

			local var_14_10 = 0

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 then
				arg_11_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_14_11 = 0
			local var_14_12 = 0.3

			if var_14_11 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_13 = arg_11_1:FormatText(StoryNameCfg[74].name)

				arg_11_1.leftNameTxt_.text = var_14_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_14 = arg_11_1:GetWordFromCfg(107051003)
				local var_14_15 = arg_11_1:FormatText(var_14_14.content)

				arg_11_1.text_.text = var_14_15

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_16 = 12
				local var_14_17 = utf8.len(var_14_15)
				local var_14_18 = var_14_16 <= 0 and var_14_12 or var_14_12 * (var_14_17 / var_14_16)

				if var_14_18 > 0 and var_14_12 < var_14_18 then
					arg_11_1.talkMaxDuration = var_14_18

					if var_14_18 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_18 + var_14_11
					end
				end

				arg_11_1.text_.text = var_14_15
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051003", "story_v_out_107051.awb") ~= 0 then
					local var_14_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051003", "story_v_out_107051.awb") / 1000

					if var_14_19 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_11
					end

					if var_14_14.prefab_name ~= "" and arg_11_1.actors_[var_14_14.prefab_name] ~= nil then
						local var_14_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_14.prefab_name].transform, "story_v_out_107051", "107051003", "story_v_out_107051.awb")

						arg_11_1:RecordAudio("107051003", var_14_20)
						arg_11_1:RecordAudio("107051003", var_14_20)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_107051", "107051003", "story_v_out_107051.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_107051", "107051003", "story_v_out_107051.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_12, arg_11_1.talkMaxDuration)

			if var_14_11 <= arg_11_1.time_ and arg_11_1.time_ < var_14_11 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_11) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_11 + var_14_21 and arg_11_1.time_ < var_14_11 + var_14_21 + arg_14_0 then
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
			local var_18_0 = arg_15_1.actors_["1099ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1099ui_story == nil then
				arg_15_1.var_.characterEffect1099ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.1

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 and not isNil(var_18_0) then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect1099ui_story and not isNil(var_18_0) then
					arg_15_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1099ui_story then
				arg_15_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_18_4 = arg_15_1.actors_["1050ui_story"]
			local var_18_5 = 0

			if var_18_5 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1050ui_story == nil then
				arg_15_1.var_.characterEffect1050ui_story = var_18_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.1

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_6 and not isNil(var_18_4) then
				local var_18_7 = (arg_15_1.time_ - var_18_5) / var_18_6

				if arg_15_1.var_.characterEffect1050ui_story and not isNil(var_18_4) then
					local var_18_8 = Mathf.Lerp(0, 0.5, var_18_7)

					arg_15_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1050ui_story.fillRatio = var_18_8
				end
			end

			if arg_15_1.time_ >= var_18_5 + var_18_6 and arg_15_1.time_ < var_18_5 + var_18_6 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1050ui_story then
				local var_18_9 = 0.5

				arg_15_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1050ui_story.fillRatio = var_18_9
			end

			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_18_11 = 0
			local var_18_12 = 0.575

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_13 = arg_15_1:FormatText(StoryNameCfg[84].name)

				arg_15_1.leftNameTxt_.text = var_18_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_14 = arg_15_1:GetWordFromCfg(107051004)
				local var_18_15 = arg_15_1:FormatText(var_18_14.content)

				arg_15_1.text_.text = var_18_15

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_16 = 23
				local var_18_17 = utf8.len(var_18_15)
				local var_18_18 = var_18_16 <= 0 and var_18_12 or var_18_12 * (var_18_17 / var_18_16)

				if var_18_18 > 0 and var_18_12 < var_18_18 then
					arg_15_1.talkMaxDuration = var_18_18

					if var_18_18 + var_18_11 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_18 + var_18_11
					end
				end

				arg_15_1.text_.text = var_18_15
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051004", "story_v_out_107051.awb") ~= 0 then
					local var_18_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051004", "story_v_out_107051.awb") / 1000

					if var_18_19 + var_18_11 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_19 + var_18_11
					end

					if var_18_14.prefab_name ~= "" and arg_15_1.actors_[var_18_14.prefab_name] ~= nil then
						local var_18_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_14.prefab_name].transform, "story_v_out_107051", "107051004", "story_v_out_107051.awb")

						arg_15_1:RecordAudio("107051004", var_18_20)
						arg_15_1:RecordAudio("107051004", var_18_20)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_107051", "107051004", "story_v_out_107051.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_107051", "107051004", "story_v_out_107051.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_21 = math.max(var_18_12, arg_15_1.talkMaxDuration)

			if var_18_11 <= arg_15_1.time_ and arg_15_1.time_ < var_18_11 + var_18_21 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_11) / var_18_21

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_11 + var_18_21 and arg_15_1.time_ < var_18_11 + var_18_21 + arg_18_0 then
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
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_22_1 = 0
			local var_22_2 = 0.325

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_3 = arg_19_1:FormatText(StoryNameCfg[84].name)

				arg_19_1.leftNameTxt_.text = var_22_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(107051005)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 13
				local var_22_7 = utf8.len(var_22_5)
				local var_22_8 = var_22_6 <= 0 and var_22_2 or var_22_2 * (var_22_7 / var_22_6)

				if var_22_8 > 0 and var_22_2 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051005", "story_v_out_107051.awb") ~= 0 then
					local var_22_9 = manager.audio:GetVoiceLength("story_v_out_107051", "107051005", "story_v_out_107051.awb") / 1000

					if var_22_9 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_1
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_107051", "107051005", "story_v_out_107051.awb")

						arg_19_1:RecordAudio("107051005", var_22_10)
						arg_19_1:RecordAudio("107051005", var_22_10)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_107051", "107051005", "story_v_out_107051.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_107051", "107051005", "story_v_out_107051.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_11 and arg_19_1.time_ < var_22_1 + var_22_11 + arg_22_0 then
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
			local var_26_0 = arg_23_1.actors_["1050ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1050ui_story == nil then
				arg_23_1.var_.characterEffect1050ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.1

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1050ui_story and not isNil(var_26_0) then
					arg_23_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1050ui_story then
				arg_23_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_26_4 = arg_23_1.actors_["1099ui_story"]
			local var_26_5 = 0

			if var_26_5 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect1099ui_story == nil then
				arg_23_1.var_.characterEffect1099ui_story = var_26_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.1

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_6 and not isNil(var_26_4) then
				local var_26_7 = (arg_23_1.time_ - var_26_5) / var_26_6

				if arg_23_1.var_.characterEffect1099ui_story and not isNil(var_26_4) then
					local var_26_8 = Mathf.Lerp(0, 0.5, var_26_7)

					arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1099ui_story.fillRatio = var_26_8
				end
			end

			if arg_23_1.time_ >= var_26_5 + var_26_6 and arg_23_1.time_ < var_26_5 + var_26_6 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect1099ui_story then
				local var_26_9 = 0.5

				arg_23_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1099ui_story.fillRatio = var_26_9
			end

			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_26_11 = 0
			local var_26_12 = 0.275

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_13 = arg_23_1:FormatText(StoryNameCfg[74].name)

				arg_23_1.leftNameTxt_.text = var_26_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_14 = arg_23_1:GetWordFromCfg(107051006)
				local var_26_15 = arg_23_1:FormatText(var_26_14.content)

				arg_23_1.text_.text = var_26_15

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 11
				local var_26_17 = utf8.len(var_26_15)
				local var_26_18 = var_26_16 <= 0 and var_26_12 or var_26_12 * (var_26_17 / var_26_16)

				if var_26_18 > 0 and var_26_12 < var_26_18 then
					arg_23_1.talkMaxDuration = var_26_18

					if var_26_18 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_18 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_15
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051006", "story_v_out_107051.awb") ~= 0 then
					local var_26_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051006", "story_v_out_107051.awb") / 1000

					if var_26_19 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_19 + var_26_11
					end

					if var_26_14.prefab_name ~= "" and arg_23_1.actors_[var_26_14.prefab_name] ~= nil then
						local var_26_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_14.prefab_name].transform, "story_v_out_107051", "107051006", "story_v_out_107051.awb")

						arg_23_1:RecordAudio("107051006", var_26_20)
						arg_23_1:RecordAudio("107051006", var_26_20)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_107051", "107051006", "story_v_out_107051.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_107051", "107051006", "story_v_out_107051.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_21 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_21 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_21

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_21 and arg_23_1.time_ < var_26_11 + var_26_21 + arg_26_0 then
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
			local var_30_0 = arg_27_1.actors_["1050ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1050ui_story == nil then
				arg_27_1.var_.characterEffect1050ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.1

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1050ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1050ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1050ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1050ui_story.fillRatio = var_30_5
			end

			local var_30_6 = arg_27_1.actors_["1099ui_story"].transform
			local var_30_7 = 0

			if var_30_7 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.var_.moveOldPos1099ui_story = var_30_6.localPosition
			end

			local var_30_8 = 0.001

			if var_30_7 <= arg_27_1.time_ and arg_27_1.time_ < var_30_7 + var_30_8 then
				local var_30_9 = (arg_27_1.time_ - var_30_7) / var_30_8
				local var_30_10 = Vector3.New(0, 100, 0)

				var_30_6.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1099ui_story, var_30_10, var_30_9)

				local var_30_11 = manager.ui.mainCamera.transform.position - var_30_6.position

				var_30_6.forward = Vector3.New(var_30_11.x, var_30_11.y, var_30_11.z)

				local var_30_12 = var_30_6.localEulerAngles

				var_30_12.z = 0
				var_30_12.x = 0
				var_30_6.localEulerAngles = var_30_12
			end

			if arg_27_1.time_ >= var_30_7 + var_30_8 and arg_27_1.time_ < var_30_7 + var_30_8 + arg_30_0 then
				var_30_6.localPosition = Vector3.New(0, 100, 0)

				local var_30_13 = manager.ui.mainCamera.transform.position - var_30_6.position

				var_30_6.forward = Vector3.New(var_30_13.x, var_30_13.y, var_30_13.z)

				local var_30_14 = var_30_6.localEulerAngles

				var_30_14.z = 0
				var_30_14.x = 0
				var_30_6.localEulerAngles = var_30_14
			end

			local var_30_15 = arg_27_1.actors_["1050ui_story"].transform
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				arg_27_1.var_.moveOldPos1050ui_story = var_30_15.localPosition
			end

			local var_30_17 = 0.001

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17
				local var_30_19 = Vector3.New(0, 100, 0)

				var_30_15.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1050ui_story, var_30_19, var_30_18)

				local var_30_20 = manager.ui.mainCamera.transform.position - var_30_15.position

				var_30_15.forward = Vector3.New(var_30_20.x, var_30_20.y, var_30_20.z)

				local var_30_21 = var_30_15.localEulerAngles

				var_30_21.z = 0
				var_30_21.x = 0
				var_30_15.localEulerAngles = var_30_21
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 then
				var_30_15.localPosition = Vector3.New(0, 100, 0)

				local var_30_22 = manager.ui.mainCamera.transform.position - var_30_15.position

				var_30_15.forward = Vector3.New(var_30_22.x, var_30_22.y, var_30_22.z)

				local var_30_23 = var_30_15.localEulerAngles

				var_30_23.z = 0
				var_30_23.x = 0
				var_30_15.localEulerAngles = var_30_23
			end

			local var_30_24 = 0
			local var_30_25 = 0.825

			if var_30_24 < arg_27_1.time_ and arg_27_1.time_ <= var_30_24 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_26 = arg_27_1:FormatText(StoryNameCfg[76].name)

				arg_27_1.leftNameTxt_.text = var_30_26

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

				local var_30_27 = arg_27_1:GetWordFromCfg(107051007)
				local var_30_28 = arg_27_1:FormatText(var_30_27.content)

				arg_27_1.text_.text = var_30_28

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_29 = 33
				local var_30_30 = utf8.len(var_30_28)
				local var_30_31 = var_30_29 <= 0 and var_30_25 or var_30_25 * (var_30_30 / var_30_29)

				if var_30_31 > 0 and var_30_25 < var_30_31 then
					arg_27_1.talkMaxDuration = var_30_31

					if var_30_31 + var_30_24 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_31 + var_30_24
					end
				end

				arg_27_1.text_.text = var_30_28
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051007", "story_v_out_107051.awb") ~= 0 then
					local var_30_32 = manager.audio:GetVoiceLength("story_v_out_107051", "107051007", "story_v_out_107051.awb") / 1000

					if var_30_32 + var_30_24 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_32 + var_30_24
					end

					if var_30_27.prefab_name ~= "" and arg_27_1.actors_[var_30_27.prefab_name] ~= nil then
						local var_30_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_27.prefab_name].transform, "story_v_out_107051", "107051007", "story_v_out_107051.awb")

						arg_27_1:RecordAudio("107051007", var_30_33)
						arg_27_1:RecordAudio("107051007", var_30_33)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_107051", "107051007", "story_v_out_107051.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_107051", "107051007", "story_v_out_107051.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_34 = math.max(var_30_25, arg_27_1.talkMaxDuration)

			if var_30_24 <= arg_27_1.time_ and arg_27_1.time_ < var_30_24 + var_30_34 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_24) / var_30_34

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_24 + var_30_34 and arg_27_1.time_ < var_30_24 + var_30_34 + arg_30_0 then
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
			local var_34_0 = arg_31_1.actors_["1050ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1050ui_story == nil then
				arg_31_1.var_.characterEffect1050ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.1

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1050ui_story and not isNil(var_34_0) then
					arg_31_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1050ui_story then
				arg_31_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_34_4 = arg_31_1.actors_["1050ui_story"].transform
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.var_.moveOldPos1050ui_story = var_34_4.localPosition
			end

			local var_34_6 = 0.001

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6
				local var_34_8 = Vector3.New(-0.7, -1, -6.1)

				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1050ui_story, var_34_8, var_34_7)

				local var_34_9 = manager.ui.mainCamera.transform.position - var_34_4.position

				var_34_4.forward = Vector3.New(var_34_9.x, var_34_9.y, var_34_9.z)

				local var_34_10 = var_34_4.localEulerAngles

				var_34_10.z = 0
				var_34_10.x = 0
				var_34_4.localEulerAngles = var_34_10
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_34_11 = manager.ui.mainCamera.transform.position - var_34_4.position

				var_34_4.forward = Vector3.New(var_34_11.x, var_34_11.y, var_34_11.z)

				local var_34_12 = var_34_4.localEulerAngles

				var_34_12.z = 0
				var_34_12.x = 0
				var_34_4.localEulerAngles = var_34_12
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_34_14 = arg_31_1.actors_["1099ui_story"].transform
			local var_34_15 = 0

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.var_.moveOldPos1099ui_story = var_34_14.localPosition
			end

			local var_34_16 = 0.001

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_16 then
				local var_34_17 = (arg_31_1.time_ - var_34_15) / var_34_16
				local var_34_18 = Vector3.New(0.7, -1.08, -5.9)

				var_34_14.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1099ui_story, var_34_18, var_34_17)

				local var_34_19 = manager.ui.mainCamera.transform.position - var_34_14.position

				var_34_14.forward = Vector3.New(var_34_19.x, var_34_19.y, var_34_19.z)

				local var_34_20 = var_34_14.localEulerAngles

				var_34_20.z = 0
				var_34_20.x = 0
				var_34_14.localEulerAngles = var_34_20
			end

			if arg_31_1.time_ >= var_34_15 + var_34_16 and arg_31_1.time_ < var_34_15 + var_34_16 + arg_34_0 then
				var_34_14.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_34_21 = manager.ui.mainCamera.transform.position - var_34_14.position

				var_34_14.forward = Vector3.New(var_34_21.x, var_34_21.y, var_34_21.z)

				local var_34_22 = var_34_14.localEulerAngles

				var_34_22.z = 0
				var_34_22.x = 0
				var_34_14.localEulerAngles = var_34_22
			end

			local var_34_23 = 0

			if var_34_23 < arg_31_1.time_ and arg_31_1.time_ <= var_34_23 + arg_34_0 then
				arg_31_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_34_24 = 0
			local var_34_25 = 0.3

			if var_34_24 < arg_31_1.time_ and arg_31_1.time_ <= var_34_24 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_26 = arg_31_1:FormatText(StoryNameCfg[74].name)

				arg_31_1.leftNameTxt_.text = var_34_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_27 = arg_31_1:GetWordFromCfg(107051008)
				local var_34_28 = arg_31_1:FormatText(var_34_27.content)

				arg_31_1.text_.text = var_34_28

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_29 = 12
				local var_34_30 = utf8.len(var_34_28)
				local var_34_31 = var_34_29 <= 0 and var_34_25 or var_34_25 * (var_34_30 / var_34_29)

				if var_34_31 > 0 and var_34_25 < var_34_31 then
					arg_31_1.talkMaxDuration = var_34_31

					if var_34_31 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_31 + var_34_24
					end
				end

				arg_31_1.text_.text = var_34_28
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051008", "story_v_out_107051.awb") ~= 0 then
					local var_34_32 = manager.audio:GetVoiceLength("story_v_out_107051", "107051008", "story_v_out_107051.awb") / 1000

					if var_34_32 + var_34_24 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_32 + var_34_24
					end

					if var_34_27.prefab_name ~= "" and arg_31_1.actors_[var_34_27.prefab_name] ~= nil then
						local var_34_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_27.prefab_name].transform, "story_v_out_107051", "107051008", "story_v_out_107051.awb")

						arg_31_1:RecordAudio("107051008", var_34_33)
						arg_31_1:RecordAudio("107051008", var_34_33)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_107051", "107051008", "story_v_out_107051.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_107051", "107051008", "story_v_out_107051.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_34 = math.max(var_34_25, arg_31_1.talkMaxDuration)

			if var_34_24 <= arg_31_1.time_ and arg_31_1.time_ < var_34_24 + var_34_34 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_24) / var_34_34

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_24 + var_34_34 and arg_31_1.time_ < var_34_24 + var_34_34 + arg_34_0 then
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
			local var_38_0 = arg_35_1.actors_["1099ui_story"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1099ui_story == nil then
				arg_35_1.var_.characterEffect1099ui_story = var_38_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.1

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.characterEffect1099ui_story and not isNil(var_38_0) then
					arg_35_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.characterEffect1099ui_story then
				arg_35_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_38_4 = arg_35_1.actors_["1050ui_story"]
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1050ui_story == nil then
				arg_35_1.var_.characterEffect1050ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.1

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 and not isNil(var_38_4) then
				local var_38_7 = (arg_35_1.time_ - var_38_5) / var_38_6

				if arg_35_1.var_.characterEffect1050ui_story and not isNil(var_38_4) then
					local var_38_8 = Mathf.Lerp(0, 0.5, var_38_7)

					arg_35_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1050ui_story.fillRatio = var_38_8
				end
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1050ui_story then
				local var_38_9 = 0.5

				arg_35_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1050ui_story.fillRatio = var_38_9
			end

			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_11 = 0
			local var_38_12 = 0.925

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_13 = arg_35_1:FormatText(StoryNameCfg[84].name)

				arg_35_1.leftNameTxt_.text = var_38_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:GetWordFromCfg(107051009)
				local var_38_15 = arg_35_1:FormatText(var_38_14.content)

				arg_35_1.text_.text = var_38_15

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 37
				local var_38_17 = utf8.len(var_38_15)
				local var_38_18 = var_38_16 <= 0 and var_38_12 or var_38_12 * (var_38_17 / var_38_16)

				if var_38_18 > 0 and var_38_12 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18

					if var_38_18 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_11
					end
				end

				arg_35_1.text_.text = var_38_15
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051009", "story_v_out_107051.awb") ~= 0 then
					local var_38_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051009", "story_v_out_107051.awb") / 1000

					if var_38_19 + var_38_11 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_19 + var_38_11
					end

					if var_38_14.prefab_name ~= "" and arg_35_1.actors_[var_38_14.prefab_name] ~= nil then
						local var_38_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_14.prefab_name].transform, "story_v_out_107051", "107051009", "story_v_out_107051.awb")

						arg_35_1:RecordAudio("107051009", var_38_20)
						arg_35_1:RecordAudio("107051009", var_38_20)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_107051", "107051009", "story_v_out_107051.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_107051", "107051009", "story_v_out_107051.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = math.max(var_38_12, arg_35_1.talkMaxDuration)

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_21 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_11) / var_38_21

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_11 + var_38_21 and arg_35_1.time_ < var_38_11 + var_38_21 + arg_38_0 then
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
			local var_42_0 = "3014_tpose"

			if arg_39_1.actors_[var_42_0] == nil then
				local var_42_1 = Asset.Load("Char/" .. "3014_tpose")

				if not isNil(var_42_1) then
					local var_42_2 = Object.Instantiate(Asset.Load("Char/" .. "3014_tpose"), arg_39_1.stage_.transform)

					var_42_2.name = var_42_0
					var_42_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_39_1.actors_[var_42_0] = var_42_2

					local var_42_3 = var_42_2:GetComponentInChildren(typeof(CharacterEffect))

					var_42_3.enabled = true

					local var_42_4 = GameObjectTools.GetOrAddComponent(var_42_2, typeof(DynamicBoneHelper))

					if var_42_4 then
						var_42_4:EnableDynamicBone(false)
					end

					arg_39_1:ShowWeapon(var_42_3.transform, false)

					arg_39_1.var_[var_42_0 .. "Animator"] = var_42_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_39_1.var_[var_42_0 .. "Animator"].applyRootMotion = true
					arg_39_1.var_[var_42_0 .. "LipSync"] = var_42_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_42_5 = arg_39_1.actors_["3014_tpose"]
			local var_42_6 = 0

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect3014_tpose == nil then
				arg_39_1.var_.characterEffect3014_tpose = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.1

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_7 and not isNil(var_42_5) then
				local var_42_8 = (arg_39_1.time_ - var_42_6) / var_42_7

				if arg_39_1.var_.characterEffect3014_tpose and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_6 + var_42_7 and arg_39_1.time_ < var_42_6 + var_42_7 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect3014_tpose then
				arg_39_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_42_9 = arg_39_1.actors_["1099ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1099ui_story == nil then
				arg_39_1.var_.characterEffect1099ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.1

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1099ui_story and not isNil(var_42_9) then
					local var_42_13 = Mathf.Lerp(0, 0.5, var_42_12)

					arg_39_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1099ui_story.fillRatio = var_42_13
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1099ui_story then
				local var_42_14 = 0.5

				arg_39_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1099ui_story.fillRatio = var_42_14
			end

			local var_42_15 = arg_39_1.actors_["1050ui_story"].transform
			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.var_.moveOldPos1050ui_story = var_42_15.localPosition
			end

			local var_42_17 = 0.001

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Vector3.New(0, 100, 0)

				var_42_15.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1050ui_story, var_42_19, var_42_18)

				local var_42_20 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_20.x, var_42_20.y, var_42_20.z)

				local var_42_21 = var_42_15.localEulerAngles

				var_42_21.z = 0
				var_42_21.x = 0
				var_42_15.localEulerAngles = var_42_21
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				var_42_15.localPosition = Vector3.New(0, 100, 0)

				local var_42_22 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_22.x, var_42_22.y, var_42_22.z)

				local var_42_23 = var_42_15.localEulerAngles

				var_42_23.z = 0
				var_42_23.x = 0
				var_42_15.localEulerAngles = var_42_23
			end

			local var_42_24 = arg_39_1.actors_["3014_tpose"].transform
			local var_42_25 = 0

			if var_42_25 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 then
				arg_39_1.var_.moveOldPos3014_tpose = var_42_24.localPosition

				local var_42_26 = GameObjectTools.GetOrAddComponent(var_42_24.gameObject, typeof(DynamicBoneHelper))

				if var_42_26 then
					var_42_26:EnableDynamicBone(false)
				end
			end

			local var_42_27 = 0.001

			if var_42_25 <= arg_39_1.time_ and arg_39_1.time_ < var_42_25 + var_42_27 then
				local var_42_28 = (arg_39_1.time_ - var_42_25) / var_42_27
				local var_42_29 = Vector3.New(-0.7, -2.35, -2.9)

				var_42_24.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos3014_tpose, var_42_29, var_42_28)

				local var_42_30 = manager.ui.mainCamera.transform.position - var_42_24.position

				var_42_24.forward = Vector3.New(var_42_30.x, var_42_30.y, var_42_30.z)

				local var_42_31 = var_42_24.localEulerAngles

				var_42_31.z = 0
				var_42_31.x = 0
				var_42_24.localEulerAngles = var_42_31
			end

			if arg_39_1.time_ >= var_42_25 + var_42_27 and arg_39_1.time_ < var_42_25 + var_42_27 + arg_42_0 then
				var_42_24.localPosition = Vector3.New(-0.7, -2.35, -2.9)

				local var_42_32 = manager.ui.mainCamera.transform.position - var_42_24.position

				var_42_24.forward = Vector3.New(var_42_32.x, var_42_32.y, var_42_32.z)

				local var_42_33 = var_42_24.localEulerAngles

				var_42_33.z = 0
				var_42_33.x = 0
				var_42_24.localEulerAngles = var_42_33

				local var_42_34 = GameObjectTools.GetOrAddComponent(var_42_24.gameObject, typeof(DynamicBoneHelper))

				if var_42_34 then
					var_42_34:EnableDynamicBone(true)
				end
			end

			local var_42_35 = 0

			if var_42_35 < arg_39_1.time_ and arg_39_1.time_ <= var_42_35 + arg_42_0 then
				arg_39_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_42_36 = 0
			local var_42_37 = 0.85

			if var_42_36 < arg_39_1.time_ and arg_39_1.time_ <= var_42_36 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_38 = arg_39_1:FormatText(StoryNameCfg[96].name)

				arg_39_1.leftNameTxt_.text = var_42_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_39 = arg_39_1:GetWordFromCfg(107051010)
				local var_42_40 = arg_39_1:FormatText(var_42_39.content)

				arg_39_1.text_.text = var_42_40

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_41 = 34
				local var_42_42 = utf8.len(var_42_40)
				local var_42_43 = var_42_41 <= 0 and var_42_37 or var_42_37 * (var_42_42 / var_42_41)

				if var_42_43 > 0 and var_42_37 < var_42_43 then
					arg_39_1.talkMaxDuration = var_42_43

					if var_42_43 + var_42_36 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_43 + var_42_36
					end
				end

				arg_39_1.text_.text = var_42_40
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051010", "story_v_out_107051.awb") ~= 0 then
					local var_42_44 = manager.audio:GetVoiceLength("story_v_out_107051", "107051010", "story_v_out_107051.awb") / 1000

					if var_42_44 + var_42_36 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_44 + var_42_36
					end

					if var_42_39.prefab_name ~= "" and arg_39_1.actors_[var_42_39.prefab_name] ~= nil then
						local var_42_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_39.prefab_name].transform, "story_v_out_107051", "107051010", "story_v_out_107051.awb")

						arg_39_1:RecordAudio("107051010", var_42_45)
						arg_39_1:RecordAudio("107051010", var_42_45)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_107051", "107051010", "story_v_out_107051.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_107051", "107051010", "story_v_out_107051.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_46 = math.max(var_42_37, arg_39_1.talkMaxDuration)

			if var_42_36 <= arg_39_1.time_ and arg_39_1.time_ < var_42_36 + var_42_46 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_36) / var_42_46

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_36 + var_42_46 and arg_39_1.time_ < var_42_36 + var_42_46 + arg_42_0 then
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
			local var_46_0 = arg_43_1.actors_["1099ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1099ui_story == nil then
				arg_43_1.var_.characterEffect1099ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.1

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1099ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1099ui_story then
				arg_43_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_46_4 = arg_43_1.actors_["3014_tpose"]
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect3014_tpose == nil then
				arg_43_1.var_.characterEffect3014_tpose = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.1

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 and not isNil(var_46_4) then
				local var_46_7 = (arg_43_1.time_ - var_46_5) / var_46_6

				if arg_43_1.var_.characterEffect3014_tpose and not isNil(var_46_4) then
					local var_46_8 = Mathf.Lerp(0, 0.5, var_46_7)

					arg_43_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_43_1.var_.characterEffect3014_tpose.fillRatio = var_46_8
				end
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect3014_tpose then
				local var_46_9 = 0.5

				arg_43_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_43_1.var_.characterEffect3014_tpose.fillRatio = var_46_9
			end

			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action465")
			end

			local var_46_11 = 0

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_46_12 = 0
			local var_46_13 = 0.55

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_14 = arg_43_1:FormatText(StoryNameCfg[84].name)

				arg_43_1.leftNameTxt_.text = var_46_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_15 = arg_43_1:GetWordFromCfg(107051011)
				local var_46_16 = arg_43_1:FormatText(var_46_15.content)

				arg_43_1.text_.text = var_46_16

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 22
				local var_46_18 = utf8.len(var_46_16)
				local var_46_19 = var_46_17 <= 0 and var_46_13 or var_46_13 * (var_46_18 / var_46_17)

				if var_46_19 > 0 and var_46_13 < var_46_19 then
					arg_43_1.talkMaxDuration = var_46_19

					if var_46_19 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_19 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_16
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051011", "story_v_out_107051.awb") ~= 0 then
					local var_46_20 = manager.audio:GetVoiceLength("story_v_out_107051", "107051011", "story_v_out_107051.awb") / 1000

					if var_46_20 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_12
					end

					if var_46_15.prefab_name ~= "" and arg_43_1.actors_[var_46_15.prefab_name] ~= nil then
						local var_46_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_15.prefab_name].transform, "story_v_out_107051", "107051011", "story_v_out_107051.awb")

						arg_43_1:RecordAudio("107051011", var_46_21)
						arg_43_1:RecordAudio("107051011", var_46_21)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_107051", "107051011", "story_v_out_107051.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_107051", "107051011", "story_v_out_107051.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_22 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_22 and arg_43_1.time_ < var_46_12 + var_46_22 + arg_46_0 then
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
			local var_50_0 = arg_47_1.actors_["3014_tpose"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect3014_tpose == nil then
				arg_47_1.var_.characterEffect3014_tpose = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.1

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect3014_tpose and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect3014_tpose then
				arg_47_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1099ui_story"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1099ui_story == nil then
				arg_47_1.var_.characterEffect1099ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.1

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 and not isNil(var_50_4) then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.characterEffect1099ui_story and not isNil(var_50_4) then
					local var_50_8 = Mathf.Lerp(0, 0.5, var_50_7)

					arg_47_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1099ui_story.fillRatio = var_50_8
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1099ui_story then
				local var_50_9 = 0.5

				arg_47_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1099ui_story.fillRatio = var_50_9
			end

			local var_50_10 = 0
			local var_50_11 = 0.55

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_12 = arg_47_1:FormatText(StoryNameCfg[96].name)

				arg_47_1.leftNameTxt_.text = var_50_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_13 = arg_47_1:GetWordFromCfg(107051012)
				local var_50_14 = arg_47_1:FormatText(var_50_13.content)

				arg_47_1.text_.text = var_50_14

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_15 = 22
				local var_50_16 = utf8.len(var_50_14)
				local var_50_17 = var_50_15 <= 0 and var_50_11 or var_50_11 * (var_50_16 / var_50_15)

				if var_50_17 > 0 and var_50_11 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17

					if var_50_17 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_10
					end
				end

				arg_47_1.text_.text = var_50_14
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051012", "story_v_out_107051.awb") ~= 0 then
					local var_50_18 = manager.audio:GetVoiceLength("story_v_out_107051", "107051012", "story_v_out_107051.awb") / 1000

					if var_50_18 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_10
					end

					if var_50_13.prefab_name ~= "" and arg_47_1.actors_[var_50_13.prefab_name] ~= nil then
						local var_50_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_13.prefab_name].transform, "story_v_out_107051", "107051012", "story_v_out_107051.awb")

						arg_47_1:RecordAudio("107051012", var_50_19)
						arg_47_1:RecordAudio("107051012", var_50_19)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_107051", "107051012", "story_v_out_107051.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_107051", "107051012", "story_v_out_107051.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_20 = math.max(var_50_11, arg_47_1.talkMaxDuration)

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_20 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_10) / var_50_20

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_10 + var_50_20 and arg_47_1.time_ < var_50_10 + var_50_20 + arg_50_0 then
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
			local var_54_0 = 0
			local var_54_1 = 0.9

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[96].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(107051013)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 34
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051013", "story_v_out_107051.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_107051", "107051013", "story_v_out_107051.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_107051", "107051013", "story_v_out_107051.awb")

						arg_51_1:RecordAudio("107051013", var_54_9)
						arg_51_1:RecordAudio("107051013", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_107051", "107051013", "story_v_out_107051.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_107051", "107051013", "story_v_out_107051.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
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
			local var_58_0 = arg_55_1.actors_["1099ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1099ui_story == nil then
				arg_55_1.var_.characterEffect1099ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.1

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1099ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1099ui_story then
				arg_55_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["3014_tpose"]
			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect3014_tpose == nil then
				arg_55_1.var_.characterEffect3014_tpose = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.1

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 and not isNil(var_58_4) then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / var_58_6

				if arg_55_1.var_.characterEffect3014_tpose and not isNil(var_58_4) then
					local var_58_8 = Mathf.Lerp(0, 0.5, var_58_7)

					arg_55_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_55_1.var_.characterEffect3014_tpose.fillRatio = var_58_8
				end
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect3014_tpose then
				local var_58_9 = 0.5

				arg_55_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_55_1.var_.characterEffect3014_tpose.fillRatio = var_58_9
			end

			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_58_11 = 0
			local var_58_12 = 0.275

			if var_58_11 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_13 = arg_55_1:FormatText(StoryNameCfg[84].name)

				arg_55_1.leftNameTxt_.text = var_58_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_14 = arg_55_1:GetWordFromCfg(107051014)
				local var_58_15 = arg_55_1:FormatText(var_58_14.content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 11
				local var_58_17 = utf8.len(var_58_15)
				local var_58_18 = var_58_16 <= 0 and var_58_12 or var_58_12 * (var_58_17 / var_58_16)

				if var_58_18 > 0 and var_58_12 < var_58_18 then
					arg_55_1.talkMaxDuration = var_58_18

					if var_58_18 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051014", "story_v_out_107051.awb") ~= 0 then
					local var_58_19 = manager.audio:GetVoiceLength("story_v_out_107051", "107051014", "story_v_out_107051.awb") / 1000

					if var_58_19 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_19 + var_58_11
					end

					if var_58_14.prefab_name ~= "" and arg_55_1.actors_[var_58_14.prefab_name] ~= nil then
						local var_58_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_14.prefab_name].transform, "story_v_out_107051", "107051014", "story_v_out_107051.awb")

						arg_55_1:RecordAudio("107051014", var_58_20)
						arg_55_1:RecordAudio("107051014", var_58_20)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_107051", "107051014", "story_v_out_107051.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_107051", "107051014", "story_v_out_107051.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_21 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_21 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_21

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_21 and arg_55_1.time_ < var_58_11 + var_58_21 + arg_58_0 then
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
			local var_62_0 = arg_59_1.actors_["1099ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1099ui_story == nil then
				arg_59_1.var_.characterEffect1099ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.1

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1099ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1099ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1099ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1099ui_story.fillRatio = var_62_5
			end

			local var_62_6 = arg_59_1.actors_["1099ui_story"].transform
			local var_62_7 = 0

			if var_62_7 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.var_.moveOldPos1099ui_story = var_62_6.localPosition
			end

			local var_62_8 = 0.001

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_8 then
				local var_62_9 = (arg_59_1.time_ - var_62_7) / var_62_8
				local var_62_10 = Vector3.New(0, 100, 0)

				var_62_6.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1099ui_story, var_62_10, var_62_9)

				local var_62_11 = manager.ui.mainCamera.transform.position - var_62_6.position

				var_62_6.forward = Vector3.New(var_62_11.x, var_62_11.y, var_62_11.z)

				local var_62_12 = var_62_6.localEulerAngles

				var_62_12.z = 0
				var_62_12.x = 0
				var_62_6.localEulerAngles = var_62_12
			end

			if arg_59_1.time_ >= var_62_7 + var_62_8 and arg_59_1.time_ < var_62_7 + var_62_8 + arg_62_0 then
				var_62_6.localPosition = Vector3.New(0, 100, 0)

				local var_62_13 = manager.ui.mainCamera.transform.position - var_62_6.position

				var_62_6.forward = Vector3.New(var_62_13.x, var_62_13.y, var_62_13.z)

				local var_62_14 = var_62_6.localEulerAngles

				var_62_14.z = 0
				var_62_14.x = 0
				var_62_6.localEulerAngles = var_62_14
			end

			local var_62_15 = arg_59_1.actors_["3014_tpose"].transform
			local var_62_16 = 0

			if var_62_16 < arg_59_1.time_ and arg_59_1.time_ <= var_62_16 + arg_62_0 then
				arg_59_1.var_.moveOldPos3014_tpose = var_62_15.localPosition

				local var_62_17 = GameObjectTools.GetOrAddComponent(var_62_15.gameObject, typeof(DynamicBoneHelper))

				if var_62_17 then
					var_62_17:EnableDynamicBone(false)
				end
			end

			local var_62_18 = 0.001

			if var_62_16 <= arg_59_1.time_ and arg_59_1.time_ < var_62_16 + var_62_18 then
				local var_62_19 = (arg_59_1.time_ - var_62_16) / var_62_18
				local var_62_20 = Vector3.New(0, 100, 0)

				var_62_15.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos3014_tpose, var_62_20, var_62_19)

				local var_62_21 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_21.x, var_62_21.y, var_62_21.z)

				local var_62_22 = var_62_15.localEulerAngles

				var_62_22.z = 0
				var_62_22.x = 0
				var_62_15.localEulerAngles = var_62_22
			end

			if arg_59_1.time_ >= var_62_16 + var_62_18 and arg_59_1.time_ < var_62_16 + var_62_18 + arg_62_0 then
				var_62_15.localPosition = Vector3.New(0, 100, 0)

				local var_62_23 = manager.ui.mainCamera.transform.position - var_62_15.position

				var_62_15.forward = Vector3.New(var_62_23.x, var_62_23.y, var_62_23.z)

				local var_62_24 = var_62_15.localEulerAngles

				var_62_24.z = 0
				var_62_24.x = 0
				var_62_15.localEulerAngles = var_62_24

				local var_62_25 = GameObjectTools.GetOrAddComponent(var_62_15.gameObject, typeof(DynamicBoneHelper))

				if var_62_25 then
					var_62_25:EnableDynamicBone(true)
				end
			end

			local var_62_26 = 0
			local var_62_27 = 0.625

			if var_62_26 < arg_59_1.time_ and arg_59_1.time_ <= var_62_26 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_28 = arg_59_1:FormatText(StoryNameCfg[76].name)

				arg_59_1.leftNameTxt_.text = var_62_28

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

				local var_62_29 = arg_59_1:GetWordFromCfg(107051015)
				local var_62_30 = arg_59_1:FormatText(var_62_29.content)

				arg_59_1.text_.text = var_62_30

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_31 = 25
				local var_62_32 = utf8.len(var_62_30)
				local var_62_33 = var_62_31 <= 0 and var_62_27 or var_62_27 * (var_62_32 / var_62_31)

				if var_62_33 > 0 and var_62_27 < var_62_33 then
					arg_59_1.talkMaxDuration = var_62_33

					if var_62_33 + var_62_26 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_33 + var_62_26
					end
				end

				arg_59_1.text_.text = var_62_30
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051015", "story_v_out_107051.awb") ~= 0 then
					local var_62_34 = manager.audio:GetVoiceLength("story_v_out_107051", "107051015", "story_v_out_107051.awb") / 1000

					if var_62_34 + var_62_26 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_34 + var_62_26
					end

					if var_62_29.prefab_name ~= "" and arg_59_1.actors_[var_62_29.prefab_name] ~= nil then
						local var_62_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_29.prefab_name].transform, "story_v_out_107051", "107051015", "story_v_out_107051.awb")

						arg_59_1:RecordAudio("107051015", var_62_35)
						arg_59_1:RecordAudio("107051015", var_62_35)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_107051", "107051015", "story_v_out_107051.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_107051", "107051015", "story_v_out_107051.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_36 = math.max(var_62_27, arg_59_1.talkMaxDuration)

			if var_62_26 <= arg_59_1.time_ and arg_59_1.time_ < var_62_26 + var_62_36 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_26) / var_62_36

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_26 + var_62_36 and arg_59_1.time_ < var_62_26 + var_62_36 + arg_62_0 then
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
			local var_66_0 = arg_63_1.actors_["3014_tpose"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect3014_tpose == nil then
				arg_63_1.var_.characterEffect3014_tpose = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.1

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect3014_tpose and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect3014_tpose.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect3014_tpose then
				arg_63_1.var_.characterEffect3014_tpose.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["3014_tpose"].transform
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.var_.moveOldPos3014_tpose = var_66_4.localPosition

				local var_66_6 = GameObjectTools.GetOrAddComponent(var_66_4.gameObject, typeof(DynamicBoneHelper))

				if var_66_6 then
					var_66_6:EnableDynamicBone(false)
				end
			end

			local var_66_7 = 0.001

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_7 then
				local var_66_8 = (arg_63_1.time_ - var_66_5) / var_66_7
				local var_66_9 = Vector3.New(0, -2.35, -2.9)

				var_66_4.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos3014_tpose, var_66_9, var_66_8)

				local var_66_10 = manager.ui.mainCamera.transform.position - var_66_4.position

				var_66_4.forward = Vector3.New(var_66_10.x, var_66_10.y, var_66_10.z)

				local var_66_11 = var_66_4.localEulerAngles

				var_66_11.z = 0
				var_66_11.x = 0
				var_66_4.localEulerAngles = var_66_11
			end

			if arg_63_1.time_ >= var_66_5 + var_66_7 and arg_63_1.time_ < var_66_5 + var_66_7 + arg_66_0 then
				var_66_4.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_66_12 = manager.ui.mainCamera.transform.position - var_66_4.position

				var_66_4.forward = Vector3.New(var_66_12.x, var_66_12.y, var_66_12.z)

				local var_66_13 = var_66_4.localEulerAngles

				var_66_13.z = 0
				var_66_13.x = 0
				var_66_4.localEulerAngles = var_66_13

				local var_66_14 = GameObjectTools.GetOrAddComponent(var_66_4.gameObject, typeof(DynamicBoneHelper))

				if var_66_14 then
					var_66_14:EnableDynamicBone(true)
				end
			end

			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 then
				arg_63_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_66_16 = 0
			local var_66_17 = 0.675

			if var_66_16 < arg_63_1.time_ and arg_63_1.time_ <= var_66_16 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_18 = arg_63_1:FormatText(StoryNameCfg[96].name)

				arg_63_1.leftNameTxt_.text = var_66_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_19 = arg_63_1:GetWordFromCfg(107051016)
				local var_66_20 = arg_63_1:FormatText(var_66_19.content)

				arg_63_1.text_.text = var_66_20

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_21 = 27
				local var_66_22 = utf8.len(var_66_20)
				local var_66_23 = var_66_21 <= 0 and var_66_17 or var_66_17 * (var_66_22 / var_66_21)

				if var_66_23 > 0 and var_66_17 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23

					if var_66_23 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_16
					end
				end

				arg_63_1.text_.text = var_66_20
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051016", "story_v_out_107051.awb") ~= 0 then
					local var_66_24 = manager.audio:GetVoiceLength("story_v_out_107051", "107051016", "story_v_out_107051.awb") / 1000

					if var_66_24 + var_66_16 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_24 + var_66_16
					end

					if var_66_19.prefab_name ~= "" and arg_63_1.actors_[var_66_19.prefab_name] ~= nil then
						local var_66_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_19.prefab_name].transform, "story_v_out_107051", "107051016", "story_v_out_107051.awb")

						arg_63_1:RecordAudio("107051016", var_66_25)
						arg_63_1:RecordAudio("107051016", var_66_25)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_107051", "107051016", "story_v_out_107051.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_107051", "107051016", "story_v_out_107051.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = math.max(var_66_17, arg_63_1.talkMaxDuration)

			if var_66_16 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_26 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_26

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_26 and arg_63_1.time_ < var_66_16 + var_66_26 + arg_66_0 then
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
			local var_70_0 = 0
			local var_70_1 = 0.15

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[96].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:GetWordFromCfg(107051017)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 6
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051017", "story_v_out_107051.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_107051", "107051017", "story_v_out_107051.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_107051", "107051017", "story_v_out_107051.awb")

						arg_67_1:RecordAudio("107051017", var_70_9)
						arg_67_1:RecordAudio("107051017", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_107051", "107051017", "story_v_out_107051.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_107051", "107051017", "story_v_out_107051.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
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
			local var_74_0 = 0
			local var_74_1 = 0.5

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[96].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(107051018)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 20
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051018", "story_v_out_107051.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_107051", "107051018", "story_v_out_107051.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_107051", "107051018", "story_v_out_107051.awb")

						arg_71_1:RecordAudio("107051018", var_74_9)
						arg_71_1:RecordAudio("107051018", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_107051", "107051018", "story_v_out_107051.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_107051", "107051018", "story_v_out_107051.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
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
			local var_78_0 = 0
			local var_78_1 = 0.425

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[96].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(107051019)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 17
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051019", "story_v_out_107051.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_107051", "107051019", "story_v_out_107051.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_107051", "107051019", "story_v_out_107051.awb")

						arg_75_1:RecordAudio("107051019", var_78_9)
						arg_75_1:RecordAudio("107051019", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_107051", "107051019", "story_v_out_107051.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_107051", "107051019", "story_v_out_107051.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
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
			local var_82_0 = arg_79_1.actors_["3014_tpose"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect3014_tpose == nil then
				arg_79_1.var_.characterEffect3014_tpose = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.1

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect3014_tpose and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect3014_tpose.fillFlat = true
					arg_79_1.var_.characterEffect3014_tpose.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect3014_tpose then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect3014_tpose.fillFlat = true
				arg_79_1.var_.characterEffect3014_tpose.fillRatio = var_82_5
			end

			local var_82_6 = arg_79_1.actors_["3014_tpose"].transform
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.var_.moveOldPos3014_tpose = var_82_6.localPosition

				local var_82_8 = GameObjectTools.GetOrAddComponent(var_82_6.gameObject, typeof(DynamicBoneHelper))

				if var_82_8 then
					var_82_8:EnableDynamicBone(false)
				end
			end

			local var_82_9 = 0.001

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_9 then
				local var_82_10 = (arg_79_1.time_ - var_82_7) / var_82_9
				local var_82_11 = Vector3.New(0, 100, 0)

				var_82_6.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos3014_tpose, var_82_11, var_82_10)

				local var_82_12 = manager.ui.mainCamera.transform.position - var_82_6.position

				var_82_6.forward = Vector3.New(var_82_12.x, var_82_12.y, var_82_12.z)

				local var_82_13 = var_82_6.localEulerAngles

				var_82_13.z = 0
				var_82_13.x = 0
				var_82_6.localEulerAngles = var_82_13
			end

			if arg_79_1.time_ >= var_82_7 + var_82_9 and arg_79_1.time_ < var_82_7 + var_82_9 + arg_82_0 then
				var_82_6.localPosition = Vector3.New(0, 100, 0)

				local var_82_14 = manager.ui.mainCamera.transform.position - var_82_6.position

				var_82_6.forward = Vector3.New(var_82_14.x, var_82_14.y, var_82_14.z)

				local var_82_15 = var_82_6.localEulerAngles

				var_82_15.z = 0
				var_82_15.x = 0
				var_82_6.localEulerAngles = var_82_15

				local var_82_16 = GameObjectTools.GetOrAddComponent(var_82_6.gameObject, typeof(DynamicBoneHelper))

				if var_82_16 then
					var_82_16:EnableDynamicBone(true)
				end
			end

			local var_82_17 = 0
			local var_82_18 = 1

			if var_82_17 < arg_79_1.time_ and arg_79_1.time_ <= var_82_17 + arg_82_0 then
				local var_82_19 = "play"
				local var_82_20 = "effect"

				arg_79_1:AudioAction(var_82_19, var_82_20, "se_story_7", "se_story_7_manufacture", "")
			end

			local var_82_21 = 0
			local var_82_22 = 1.15

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_23 = arg_79_1:GetWordFromCfg(107051020)
				local var_82_24 = arg_79_1:FormatText(var_82_23.content)

				arg_79_1.text_.text = var_82_24

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_25 = 46
				local var_82_26 = utf8.len(var_82_24)
				local var_82_27 = var_82_25 <= 0 and var_82_22 or var_82_22 * (var_82_26 / var_82_25)

				if var_82_27 > 0 and var_82_22 < var_82_27 then
					arg_79_1.talkMaxDuration = var_82_27

					if var_82_27 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_27 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_24
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_28 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_28 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_28

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_28 and arg_79_1.time_ < var_82_21 + var_82_28 + arg_82_0 then
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
			local var_86_0 = "3016_tpose"

			if arg_83_1.actors_[var_86_0] == nil then
				local var_86_1 = Asset.Load("Char/" .. "3016_tpose")

				if not isNil(var_86_1) then
					local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "3016_tpose"), arg_83_1.stage_.transform)

					var_86_2.name = var_86_0
					var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_83_1.actors_[var_86_0] = var_86_2

					local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

					var_86_3.enabled = true

					local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

					if var_86_4 then
						var_86_4:EnableDynamicBone(false)
					end

					arg_83_1:ShowWeapon(var_86_3.transform, false)

					arg_83_1.var_[var_86_0 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_83_1.var_[var_86_0 .. "Animator"].applyRootMotion = true
					arg_83_1.var_[var_86_0 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_86_5 = arg_83_1.actors_["3016_tpose"]
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect3016_tpose == nil then
				arg_83_1.var_.characterEffect3016_tpose = var_86_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_7 = 0.1

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 and not isNil(var_86_5) then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7

				if arg_83_1.var_.characterEffect3016_tpose and not isNil(var_86_5) then
					arg_83_1.var_.characterEffect3016_tpose.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 and not isNil(var_86_5) and arg_83_1.var_.characterEffect3016_tpose then
				arg_83_1.var_.characterEffect3016_tpose.fillFlat = false
			end

			local var_86_9 = arg_83_1.actors_["3014_tpose"].transform
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos3014_tpose = var_86_9.localPosition

				local var_86_11 = GameObjectTools.GetOrAddComponent(var_86_9.gameObject, typeof(DynamicBoneHelper))

				if var_86_11 then
					var_86_11:EnableDynamicBone(false)
				end
			end

			local var_86_12 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_10) / var_86_12
				local var_86_14 = Vector3.New(0, -2.35, -2.9)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos3014_tpose, var_86_14, var_86_13)

				local var_86_15 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_15.x, var_86_15.y, var_86_15.z)

				local var_86_16 = var_86_9.localEulerAngles

				var_86_16.z = 0
				var_86_16.x = 0
				var_86_9.localEulerAngles = var_86_16
			end

			if arg_83_1.time_ >= var_86_10 + var_86_12 and arg_83_1.time_ < var_86_10 + var_86_12 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0, -2.35, -2.9)

				local var_86_17 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_17.x, var_86_17.y, var_86_17.z)

				local var_86_18 = var_86_9.localEulerAngles

				var_86_18.z = 0
				var_86_18.x = 0
				var_86_9.localEulerAngles = var_86_18

				local var_86_19 = GameObjectTools.GetOrAddComponent(var_86_9.gameObject, typeof(DynamicBoneHelper))

				if var_86_19 then
					var_86_19:EnableDynamicBone(true)
				end
			end

			local var_86_20 = 0

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1:PlayTimeline("3014_tpose", "StoryTimeline/CharAction/story3014/story3014action/3014action1_1")
			end

			local var_86_21 = 0
			local var_86_22 = 1

			if var_86_21 < arg_83_1.time_ and arg_83_1.time_ <= var_86_21 + arg_86_0 then
				local var_86_23 = "play"
				local var_86_24 = "effect"

				arg_83_1:AudioAction(var_86_23, var_86_24, "se_story_7", "se_story_7_monster", "")
			end

			local var_86_25 = 0
			local var_86_26 = 0.1

			if var_86_25 < arg_83_1.time_ and arg_83_1.time_ <= var_86_25 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_27 = arg_83_1:FormatText(StoryNameCfg[68].name)

				arg_83_1.leftNameTxt_.text = var_86_27

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

				local var_86_28 = arg_83_1:GetWordFromCfg(107051021)
				local var_86_29 = arg_83_1:FormatText(var_86_28.content)

				arg_83_1.text_.text = var_86_29

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_30 = 4
				local var_86_31 = utf8.len(var_86_29)
				local var_86_32 = var_86_30 <= 0 and var_86_26 or var_86_26 * (var_86_31 / var_86_30)

				if var_86_32 > 0 and var_86_26 < var_86_32 then
					arg_83_1.talkMaxDuration = var_86_32

					if var_86_32 + var_86_25 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_32 + var_86_25
					end
				end

				arg_83_1.text_.text = var_86_29
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_33 = math.max(var_86_26, arg_83_1.talkMaxDuration)

			if var_86_25 <= arg_83_1.time_ and arg_83_1.time_ < var_86_25 + var_86_33 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_25) / var_86_33

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_25 + var_86_33 and arg_83_1.time_ < var_86_25 + var_86_33 + arg_86_0 then
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
			local var_90_0 = arg_87_1.actors_["3016_tpose"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect3016_tpose == nil then
				arg_87_1.var_.characterEffect3016_tpose = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.1

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect3016_tpose and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect3016_tpose.fillFlat = true
					arg_87_1.var_.characterEffect3016_tpose.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect3016_tpose then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect3016_tpose.fillFlat = true
				arg_87_1.var_.characterEffect3016_tpose.fillRatio = var_90_5
			end

			local var_90_6 = arg_87_1.actors_["3014_tpose"].transform
			local var_90_7 = 0

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.var_.moveOldPos3014_tpose = var_90_6.localPosition

				local var_90_8 = GameObjectTools.GetOrAddComponent(var_90_6.gameObject, typeof(DynamicBoneHelper))

				if var_90_8 then
					var_90_8:EnableDynamicBone(false)
				end
			end

			local var_90_9 = 0.001

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_9 then
				local var_90_10 = (arg_87_1.time_ - var_90_7) / var_90_9
				local var_90_11 = Vector3.New(0, 100, 0)

				var_90_6.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos3014_tpose, var_90_11, var_90_10)

				local var_90_12 = manager.ui.mainCamera.transform.position - var_90_6.position

				var_90_6.forward = Vector3.New(var_90_12.x, var_90_12.y, var_90_12.z)

				local var_90_13 = var_90_6.localEulerAngles

				var_90_13.z = 0
				var_90_13.x = 0
				var_90_6.localEulerAngles = var_90_13
			end

			if arg_87_1.time_ >= var_90_7 + var_90_9 and arg_87_1.time_ < var_90_7 + var_90_9 + arg_90_0 then
				var_90_6.localPosition = Vector3.New(0, 100, 0)

				local var_90_14 = manager.ui.mainCamera.transform.position - var_90_6.position

				var_90_6.forward = Vector3.New(var_90_14.x, var_90_14.y, var_90_14.z)

				local var_90_15 = var_90_6.localEulerAngles

				var_90_15.z = 0
				var_90_15.x = 0
				var_90_6.localEulerAngles = var_90_15

				local var_90_16 = GameObjectTools.GetOrAddComponent(var_90_6.gameObject, typeof(DynamicBoneHelper))

				if var_90_16 then
					var_90_16:EnableDynamicBone(true)
				end
			end

			local var_90_17 = 0
			local var_90_18 = 0.35

			if var_90_17 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_19 = arg_87_1:FormatText(StoryNameCfg[76].name)

				arg_87_1.leftNameTxt_.text = var_90_19

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

				local var_90_20 = arg_87_1:GetWordFromCfg(107051022)
				local var_90_21 = arg_87_1:FormatText(var_90_20.content)

				arg_87_1.text_.text = var_90_21

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_22 = 14
				local var_90_23 = utf8.len(var_90_21)
				local var_90_24 = var_90_22 <= 0 and var_90_18 or var_90_18 * (var_90_23 / var_90_22)

				if var_90_24 > 0 and var_90_18 < var_90_24 then
					arg_87_1.talkMaxDuration = var_90_24

					if var_90_24 + var_90_17 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_24 + var_90_17
					end
				end

				arg_87_1.text_.text = var_90_21
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051022", "story_v_out_107051.awb") ~= 0 then
					local var_90_25 = manager.audio:GetVoiceLength("story_v_out_107051", "107051022", "story_v_out_107051.awb") / 1000

					if var_90_25 + var_90_17 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_25 + var_90_17
					end

					if var_90_20.prefab_name ~= "" and arg_87_1.actors_[var_90_20.prefab_name] ~= nil then
						local var_90_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_20.prefab_name].transform, "story_v_out_107051", "107051022", "story_v_out_107051.awb")

						arg_87_1:RecordAudio("107051022", var_90_26)
						arg_87_1:RecordAudio("107051022", var_90_26)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_107051", "107051022", "story_v_out_107051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_107051", "107051022", "story_v_out_107051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_27 = math.max(var_90_18, arg_87_1.talkMaxDuration)

			if var_90_17 <= arg_87_1.time_ and arg_87_1.time_ < var_90_17 + var_90_27 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_17) / var_90_27

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_17 + var_90_27 and arg_87_1.time_ < var_90_17 + var_90_27 + arg_90_0 then
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
			local var_94_0 = arg_91_1.actors_["1050ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1050ui_story == nil then
				arg_91_1.var_.characterEffect1050ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.1

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1050ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1050ui_story then
				arg_91_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["1050ui_story"].transform
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.var_.moveOldPos1050ui_story = var_94_4.localPosition

				local var_94_6 = "1050ui_story"

				arg_91_1:ShowWeapon(arg_91_1.var_[var_94_6 .. "Animator"].transform, true)
			end

			local var_94_7 = 0.001

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_7 then
				local var_94_8 = (arg_91_1.time_ - var_94_5) / var_94_7
				local var_94_9 = Vector3.New(-0.7, -1, -6.1)

				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1050ui_story, var_94_9, var_94_8)

				local var_94_10 = manager.ui.mainCamera.transform.position - var_94_4.position

				var_94_4.forward = Vector3.New(var_94_10.x, var_94_10.y, var_94_10.z)

				local var_94_11 = var_94_4.localEulerAngles

				var_94_11.z = 0
				var_94_11.x = 0
				var_94_4.localEulerAngles = var_94_11
			end

			if arg_91_1.time_ >= var_94_5 + var_94_7 and arg_91_1.time_ < var_94_5 + var_94_7 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_94_12 = manager.ui.mainCamera.transform.position - var_94_4.position

				var_94_4.forward = Vector3.New(var_94_12.x, var_94_12.y, var_94_12.z)

				local var_94_13 = var_94_4.localEulerAngles

				var_94_13.z = 0
				var_94_13.x = 0
				var_94_4.localEulerAngles = var_94_13
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			local var_94_15 = arg_91_1.actors_["1099ui_story"].transform
			local var_94_16 = 0

			if var_94_16 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.var_.moveOldPos1099ui_story = var_94_15.localPosition
			end

			local var_94_17 = 0.001

			if var_94_16 <= arg_91_1.time_ and arg_91_1.time_ < var_94_16 + var_94_17 then
				local var_94_18 = (arg_91_1.time_ - var_94_16) / var_94_17
				local var_94_19 = Vector3.New(0.7, -1.08, -5.9)

				var_94_15.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1099ui_story, var_94_19, var_94_18)

				local var_94_20 = manager.ui.mainCamera.transform.position - var_94_15.position

				var_94_15.forward = Vector3.New(var_94_20.x, var_94_20.y, var_94_20.z)

				local var_94_21 = var_94_15.localEulerAngles

				var_94_21.z = 0
				var_94_21.x = 0
				var_94_15.localEulerAngles = var_94_21
			end

			if arg_91_1.time_ >= var_94_16 + var_94_17 and arg_91_1.time_ < var_94_16 + var_94_17 + arg_94_0 then
				var_94_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_94_22 = manager.ui.mainCamera.transform.position - var_94_15.position

				var_94_15.forward = Vector3.New(var_94_22.x, var_94_22.y, var_94_22.z)

				local var_94_23 = var_94_15.localEulerAngles

				var_94_23.z = 0
				var_94_23.x = 0
				var_94_15.localEulerAngles = var_94_23
			end

			local var_94_24 = 0

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_94_25 = 0

			if var_94_25 < arg_91_1.time_ and arg_91_1.time_ <= var_94_25 + arg_94_0 then
				arg_91_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_94_26 = 0
			local var_94_27 = 0.225

			if var_94_26 < arg_91_1.time_ and arg_91_1.time_ <= var_94_26 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_28 = arg_91_1:FormatText(StoryNameCfg[75].name)

				arg_91_1.leftNameTxt_.text = var_94_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_29 = arg_91_1:GetWordFromCfg(107051023)
				local var_94_30 = arg_91_1:FormatText(var_94_29.content)

				arg_91_1.text_.text = var_94_30

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_31 = 9
				local var_94_32 = utf8.len(var_94_30)
				local var_94_33 = var_94_31 <= 0 and var_94_27 or var_94_27 * (var_94_32 / var_94_31)

				if var_94_33 > 0 and var_94_27 < var_94_33 then
					arg_91_1.talkMaxDuration = var_94_33

					if var_94_33 + var_94_26 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_33 + var_94_26
					end
				end

				arg_91_1.text_.text = var_94_30
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051023", "story_v_out_107051.awb") ~= 0 then
					local var_94_34 = manager.audio:GetVoiceLength("story_v_out_107051", "107051023", "story_v_out_107051.awb") / 1000

					if var_94_34 + var_94_26 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_34 + var_94_26
					end

					if var_94_29.prefab_name ~= "" and arg_91_1.actors_[var_94_29.prefab_name] ~= nil then
						local var_94_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_29.prefab_name].transform, "story_v_out_107051", "107051023", "story_v_out_107051.awb")

						arg_91_1:RecordAudio("107051023", var_94_35)
						arg_91_1:RecordAudio("107051023", var_94_35)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_107051", "107051023", "story_v_out_107051.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_107051", "107051023", "story_v_out_107051.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_36 = math.max(var_94_27, arg_91_1.talkMaxDuration)

			if var_94_26 <= arg_91_1.time_ and arg_91_1.time_ < var_94_26 + var_94_36 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_26) / var_94_36

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_26 + var_94_36 and arg_91_1.time_ < var_94_26 + var_94_36 + arg_94_0 then
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
			local var_98_0 = arg_95_1.actors_["1099ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1099ui_story == nil then
				arg_95_1.var_.characterEffect1099ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.1

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1099ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1099ui_story then
				arg_95_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["1050ui_story"]
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1050ui_story == nil then
				arg_95_1.var_.characterEffect1050ui_story = var_98_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.1

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 and not isNil(var_98_4) then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6

				if arg_95_1.var_.characterEffect1050ui_story and not isNil(var_98_4) then
					local var_98_8 = Mathf.Lerp(0, 0.5, var_98_7)

					arg_95_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1050ui_story.fillRatio = var_98_8
				end
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 and not isNil(var_98_4) and arg_95_1.var_.characterEffect1050ui_story then
				local var_98_9 = 0.5

				arg_95_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1050ui_story.fillRatio = var_98_9
			end

			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 then
				arg_95_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action445")
			end

			local var_98_11 = 0

			if var_98_11 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_98_12 = 0
			local var_98_13 = 0.425

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_14 = arg_95_1:FormatText(StoryNameCfg[84].name)

				arg_95_1.leftNameTxt_.text = var_98_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_15 = arg_95_1:GetWordFromCfg(107051024)
				local var_98_16 = arg_95_1:FormatText(var_98_15.content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_17 = 17
				local var_98_18 = utf8.len(var_98_16)
				local var_98_19 = var_98_17 <= 0 and var_98_13 or var_98_13 * (var_98_18 / var_98_17)

				if var_98_19 > 0 and var_98_13 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_12
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051024", "story_v_out_107051.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_107051", "107051024", "story_v_out_107051.awb") / 1000

					if var_98_20 + var_98_12 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_12
					end

					if var_98_15.prefab_name ~= "" and arg_95_1.actors_[var_98_15.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_15.prefab_name].transform, "story_v_out_107051", "107051024", "story_v_out_107051.awb")

						arg_95_1:RecordAudio("107051024", var_98_21)
						arg_95_1:RecordAudio("107051024", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_107051", "107051024", "story_v_out_107051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_107051", "107051024", "story_v_out_107051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_13, arg_95_1.talkMaxDuration)

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_12) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_12 + var_98_22 and arg_95_1.time_ < var_98_12 + var_98_22 + arg_98_0 then
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
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_102_1 = 0
			local var_102_2 = 0.2

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_3 = arg_99_1:FormatText(StoryNameCfg[84].name)

				arg_99_1.leftNameTxt_.text = var_102_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_4 = arg_99_1:GetWordFromCfg(107051025)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_6 = 8
				local var_102_7 = utf8.len(var_102_5)
				local var_102_8 = var_102_6 <= 0 and var_102_2 or var_102_2 * (var_102_7 / var_102_6)

				if var_102_8 > 0 and var_102_2 < var_102_8 then
					arg_99_1.talkMaxDuration = var_102_8

					if var_102_8 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_107051", "107051025", "story_v_out_107051.awb") ~= 0 then
					local var_102_9 = manager.audio:GetVoiceLength("story_v_out_107051", "107051025", "story_v_out_107051.awb") / 1000

					if var_102_9 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_1
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_out_107051", "107051025", "story_v_out_107051.awb")

						arg_99_1:RecordAudio("107051025", var_102_10)
						arg_99_1:RecordAudio("107051025", var_102_10)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_107051", "107051025", "story_v_out_107051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_107051", "107051025", "story_v_out_107051.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_11 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_11 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_11

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_11 and arg_99_1.time_ < var_102_1 + var_102_11 + arg_102_0 then
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
