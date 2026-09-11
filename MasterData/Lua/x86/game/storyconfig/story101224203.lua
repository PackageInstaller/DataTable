return {
	Play122423001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122423001
		arg_1_1.duration_ = 11.67

		local var_1_0 = {
			ja = 11.666,
			ko = 7.266,
			zh = 7.266
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
				arg_1_0:Play122423002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_4_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_1_1.stage_.transform)

				var_4_0.name = "2079ui_story"
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_["2079ui_story"] = var_4_0

				local var_4_1 = var_4_0:GetComponentInChildren(typeof(CharacterEffect))

				var_4_1.enabled = true

				local var_4_2 = GameObjectTools.GetOrAddComponent(var_4_0, typeof(DynamicBoneHelper))

				if var_4_2 then
					var_4_2:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_1.transform, false)

				arg_1_1.var_["2079ui_story" .. "Animator"] = var_4_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_1_1.var_["2079ui_story" .. "LipSync"] = var_4_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_3 = arg_1_1.actors_["2079ui_story"].transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPos2079ui_story = var_4_3.localPosition
			end

			local var_4_4 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 then
				var_4_3.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_1_1.time_ - 0) / var_4_4)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 then
				var_4_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_4_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_3.position).x, (manager.ui.mainCamera.transform.position - var_4_3.position).y, (manager.ui.mainCamera.transform.position - var_4_3.position).z)
				var_4_3.localEulerAngles.z = 0
				var_4_3.localEulerAngles.x = 0
				var_4_3.localEulerAngles = var_4_3.localEulerAngles
			end

			local var_4_5 = arg_1_1.actors_["2079ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect2079ui_story == nil then
				arg_1_1.var_.characterEffect2079ui_story = var_4_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_6 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_6 and not isNil(var_4_5) then
				if arg_1_1.var_.characterEffect2079ui_story and not isNil(var_4_5) then
					arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_6 and arg_1_1.time_ < 0 + var_4_6 + arg_4_0 and not isNil(var_4_5) and arg_1_1.var_.characterEffect2079ui_story then
				arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_8 = 0
			local var_4_9 = 0.875

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_10 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_10:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[469].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:GetWordFromCfg(122423001)
				local var_4_12 = arg_1_1:FormatText(var_4_11.content)

				arg_1_1.text_.text = var_4_12

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_14 = 35 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_12) / 35)

				if (35 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_12) / 35)) > 0 and var_4_9 < var_4_14 then
					arg_1_1.talkMaxDuration = var_4_14
					var_4_8 = var_4_8 + 0.3

					if var_4_14 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_12
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423001", "story_v_out_122423.awb") ~= 0 then
					local var_4_15 = manager.audio:GetVoiceLength("story_v_out_122423", "122423001", "story_v_out_122423.awb") / 1000

					if var_4_15 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_8
					end

					if var_4_11.prefab_name ~= "" and arg_1_1.actors_[var_4_11.prefab_name] ~= nil then
						local var_4_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_11.prefab_name].transform, "story_v_out_122423", "122423001", "story_v_out_122423.awb")

						arg_1_1:RecordAudio("122423001", var_4_16)
						arg_1_1:RecordAudio("122423001", var_4_16)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122423", "122423001", "story_v_out_122423.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122423", "122423001", "story_v_out_122423.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_8 + 0.3
			local var_4_18 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play122423002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 122423002
		arg_7_1.duration_ = 1.47

		local var_7_0 = {
			ja = 1.4,
			ko = 1.466,
			zh = 1.466
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
				arg_7_0:Play122423003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["2079ui_story"]) and arg_7_1.var_.characterEffect2079ui_story == nil then
				arg_7_1.var_.characterEffect2079ui_story = arg_7_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["2079ui_story"]) then
				if arg_7_1.var_.characterEffect2079ui_story and not isNil(arg_7_1.actors_["2079ui_story"]) then
					arg_7_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_7_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["2079ui_story"]) and arg_7_1.var_.characterEffect2079ui_story then
				arg_7_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_7_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 0.075

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(122423002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_6 = 3 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_4) / 3)

				if (3 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_4) / 3)) > 0 and var_10_2 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423002", "story_v_out_122423.awb") ~= 0 then
					local var_10_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423002", "story_v_out_122423.awb") / 1000

					if var_10_7 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_1
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_122423", "122423002", "story_v_out_122423.awb")

						arg_7_1:RecordAudio("122423002", var_10_8)
						arg_7_1:RecordAudio("122423002", var_10_8)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_122423", "122423002", "story_v_out_122423.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_122423", "122423002", "story_v_out_122423.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_9 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_9 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_9

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_9 and arg_7_1.time_ < var_10_1 + var_10_9 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play122423003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 122423003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play122423004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos2079ui_story = arg_11_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).z)
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles = arg_11_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["2079ui_story"].transform.position).z)
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["2079ui_story"].transform.localEulerAngles = arg_11_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_14_1 = 0
			local var_14_2 = 0.925

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(122423003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 37 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 37)

				if (37 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 37)) > 0 and var_14_2 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_1 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_1
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_6 = math.max(var_14_2, arg_11_1.talkMaxDuration)

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_6 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_1) / var_14_6

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_1 + var_14_6 and arg_11_1.time_ < var_14_1 + var_14_6 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play122423004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 122423004
		arg_15_1.duration_ = 8.77

		local var_15_0 = {
			ja = 8.6,
			ko = 8.766,
			zh = 8.766
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
				arg_15_0:Play122423005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.525

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:GetWordFromCfg(122423004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 21 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 21)

				if (21 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 21)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423004", "story_v_out_122423.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_122423", "122423004", "story_v_out_122423.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_122423", "122423004", "story_v_out_122423.awb")

						arg_15_1:RecordAudio("122423004", var_18_6)
						arg_15_1:RecordAudio("122423004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_122423", "122423004", "story_v_out_122423.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_122423", "122423004", "story_v_out_122423.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play122423005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122423005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play122423006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.9

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(122423005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 36 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 36)

				if (36 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 36)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play122423006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122423006
		arg_23_1.duration_ = 5.8

		local var_23_0 = {
			ja = 4,
			ko = 5.8,
			zh = 5.8
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
				arg_23_0:Play122423007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1075ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1075ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1075ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1075ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1075ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1075ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1075ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1075ui_story == nil then
				arg_23_1.var_.characterEffect1075ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1075ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1075ui_story then
				arg_23_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_26_8 = 0
			local var_26_9 = 0.375

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(122423006)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)

				if (15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423006", "story_v_out_122423.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_122423", "122423006", "story_v_out_122423.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_122423", "122423006", "story_v_out_122423.awb")

						arg_23_1:RecordAudio("122423006", var_26_15)
						arg_23_1:RecordAudio("122423006", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122423", "122423006", "story_v_out_122423.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122423", "122423006", "story_v_out_122423.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play122423007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122423007
		arg_27_1.duration_ = 5.2

		local var_27_0 = {
			ja = 5.2,
			ko = 3.4,
			zh = 3.4
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
				arg_27_0:Play122423008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1075ui_story = arg_27_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).z)
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles = arg_27_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_27_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1075ui_story"].transform.position).z)
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1075ui_story"].transform.localEulerAngles = arg_27_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_30_1 = 0
			local var_30_2 = 0.3

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(122423007)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 12 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_4) / 12)

				if (12 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_4) / 12)) > 0 and var_30_2 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423007", "story_v_out_122423.awb") ~= 0 then
					local var_30_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423007", "story_v_out_122423.awb") / 1000

					if var_30_7 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_1
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_122423", "122423007", "story_v_out_122423.awb")

						arg_27_1:RecordAudio("122423007", var_30_8)
						arg_27_1:RecordAudio("122423007", var_30_8)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122423", "122423007", "story_v_out_122423.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122423", "122423007", "story_v_out_122423.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_9 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_9 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_9

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_9 and arg_27_1.time_ < var_30_1 + var_30_9 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play122423008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122423008
		arg_31_1.duration_ = 11

		local var_31_0 = {
			ja = 11,
			ko = 9.6,
			zh = 9.6
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
				arg_31_0:Play122423009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1075ui_story = arg_31_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).z)
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles = arg_31_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_31_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1075ui_story"].transform.position).z)
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1075ui_story"].transform.localEulerAngles = arg_31_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1075ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1075ui_story == nil then
				arg_31_1.var_.characterEffect1075ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1075ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1075ui_story then
				arg_31_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_34_3 = 0
			local var_34_4 = 1.075

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_5 = arg_31_1:GetWordFromCfg(122423008)
				local var_34_6 = arg_31_1:FormatText(var_34_5.content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 39 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 39)

				if (39 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_6) / 39)) > 0 and var_34_4 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423008", "story_v_out_122423.awb") ~= 0 then
					local var_34_9 = manager.audio:GetVoiceLength("story_v_out_122423", "122423008", "story_v_out_122423.awb") / 1000

					if var_34_9 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_3
					end

					if var_34_5.prefab_name ~= "" and arg_31_1.actors_[var_34_5.prefab_name] ~= nil then
						local var_34_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_5.prefab_name].transform, "story_v_out_122423", "122423008", "story_v_out_122423.awb")

						arg_31_1:RecordAudio("122423008", var_34_10)
						arg_31_1:RecordAudio("122423008", var_34_10)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_122423", "122423008", "story_v_out_122423.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_122423", "122423008", "story_v_out_122423.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_11 and arg_31_1.time_ < var_34_3 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play122423009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122423009
		arg_35_1.duration_ = 5.07

		local var_35_0 = {
			ja = 5.066,
			ko = 3.266,
			zh = 3.266
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
				arg_35_0:Play122423010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1075ui_story = arg_35_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).z)
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles = arg_35_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_35_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1075ui_story"].transform.position).z)
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1075ui_story"].transform.localEulerAngles = arg_35_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1075ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1075ui_story == nil then
				arg_35_1.var_.characterEffect1075ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1075ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1075ui_story then
				arg_35_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.3

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(122423009)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 12 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 12)

				if (12 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 12)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423009", "story_v_out_122423.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_122423", "122423009", "story_v_out_122423.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_122423", "122423009", "story_v_out_122423.awb")

						arg_35_1:RecordAudio("122423009", var_38_11)
						arg_35_1:RecordAudio("122423009", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122423", "122423009", "story_v_out_122423.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122423", "122423009", "story_v_out_122423.awb")
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

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play122423010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122423010
		arg_39_1.duration_ = 13.4

		local var_39_0 = {
			ja = 13.4,
			ko = 7.8,
			zh = 7.8
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
				arg_39_0:Play122423011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1075ui_story"]) and arg_39_1.var_.characterEffect1075ui_story == nil then
				arg_39_1.var_.characterEffect1075ui_story = arg_39_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1075ui_story"]) then
				if arg_39_1.var_.characterEffect1075ui_story and not isNil(arg_39_1.actors_["1075ui_story"]) then
					arg_39_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1075ui_story"]) and arg_39_1.var_.characterEffect1075ui_story then
				arg_39_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.675

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(122423010)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 27 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 27)

				if (27 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 27)) > 0 and var_42_2 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423010", "story_v_out_122423.awb") ~= 0 then
					local var_42_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423010", "story_v_out_122423.awb") / 1000

					if var_42_7 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_1
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_122423", "122423010", "story_v_out_122423.awb")

						arg_39_1:RecordAudio("122423010", var_42_8)
						arg_39_1:RecordAudio("122423010", var_42_8)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_122423", "122423010", "story_v_out_122423.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_122423", "122423010", "story_v_out_122423.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_9 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_9 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_9

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_9 and arg_39_1.time_ < var_42_1 + var_42_9 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122423011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122423011
		arg_43_1.duration_ = 14.3

		local var_43_0 = {
			ja = 14.3,
			ko = 10.433,
			zh = 10.433
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
				arg_43_0:Play122423012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1075ui_story"]) and arg_43_1.var_.characterEffect1075ui_story == nil then
				arg_43_1.var_.characterEffect1075ui_story = arg_43_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1075ui_story"]) then
				if arg_43_1.var_.characterEffect1075ui_story and not isNil(arg_43_1.actors_["1075ui_story"]) then
					arg_43_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1075ui_story"]) and arg_43_1.var_.characterEffect1075ui_story then
				arg_43_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_46_2 = 0
			local var_46_3 = 1.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(122423011)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 44 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 44)

				if (44 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 44)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423011", "story_v_out_122423.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_122423", "122423011", "story_v_out_122423.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_122423", "122423011", "story_v_out_122423.awb")

						arg_43_1:RecordAudio("122423011", var_46_9)
						arg_43_1:RecordAudio("122423011", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122423", "122423011", "story_v_out_122423.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122423", "122423011", "story_v_out_122423.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play122423012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122423012
		arg_47_1.duration_ = 15.2

		local var_47_0 = {
			ja = 15.2,
			ko = 7.533,
			zh = 7.533
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
				arg_47_0:Play122423013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_50_0 = 0
			local var_50_1 = 0.775

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(122423012)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 31 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 31)

				if (31 <= 0 and var_50_1 or var_50_1 * (utf8.len(var_50_3) / 31)) > 0 and var_50_1 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423012", "story_v_out_122423.awb") ~= 0 then
					local var_50_6 = manager.audio:GetVoiceLength("story_v_out_122423", "122423012", "story_v_out_122423.awb") / 1000

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end

					if var_50_2.prefab_name ~= "" and arg_47_1.actors_[var_50_2.prefab_name] ~= nil then
						local var_50_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_2.prefab_name].transform, "story_v_out_122423", "122423012", "story_v_out_122423.awb")

						arg_47_1:RecordAudio("122423012", var_50_7)
						arg_47_1:RecordAudio("122423012", var_50_7)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_122423", "122423012", "story_v_out_122423.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_122423", "122423012", "story_v_out_122423.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play122423013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122423013
		arg_51_1.duration_ = 14.83

		local var_51_0 = {
			ja = 14.833,
			ko = 7.333,
			zh = 7.333
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
				arg_51_0:Play122423014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1075ui_story"]) and arg_51_1.var_.characterEffect1075ui_story == nil then
				arg_51_1.var_.characterEffect1075ui_story = arg_51_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1075ui_story"]) then
				if arg_51_1.var_.characterEffect1075ui_story and not isNil(arg_51_1.actors_["1075ui_story"]) then
					arg_51_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1075ui_story"]) and arg_51_1.var_.characterEffect1075ui_story then
				arg_51_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.775

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(122423013)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 31 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 31)

				if (31 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_4) / 31)) > 0 and var_54_2 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423013", "story_v_out_122423.awb") ~= 0 then
					local var_54_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423013", "story_v_out_122423.awb") / 1000

					if var_54_7 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_1
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_122423", "122423013", "story_v_out_122423.awb")

						arg_51_1:RecordAudio("122423013", var_54_8)
						arg_51_1:RecordAudio("122423013", var_54_8)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_122423", "122423013", "story_v_out_122423.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_122423", "122423013", "story_v_out_122423.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_9 and arg_51_1.time_ < var_54_1 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play122423014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122423014
		arg_55_1.duration_ = 17.43

		local var_55_0 = {
			ja = 17.433,
			ko = 10.1,
			zh = 10.1
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
				arg_55_0:Play122423015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1075ui_story"]) and arg_55_1.var_.characterEffect1075ui_story == nil then
				arg_55_1.var_.characterEffect1075ui_story = arg_55_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1075ui_story"]) then
				if arg_55_1.var_.characterEffect1075ui_story and not isNil(arg_55_1.actors_["1075ui_story"]) then
					arg_55_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1075ui_story"]) and arg_55_1.var_.characterEffect1075ui_story then
				arg_55_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_58_2 = 0
			local var_58_3 = 1.225

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_4 = arg_55_1:GetWordFromCfg(122423014)
				local var_58_5 = arg_55_1:FormatText(var_58_4.content)

				arg_55_1.text_.text = var_58_5

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 49 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 49)

				if (49 <= 0 and var_58_3 or var_58_3 * (utf8.len(var_58_5) / 49)) > 0 and var_58_3 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_2
					end
				end

				arg_55_1.text_.text = var_58_5
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423014", "story_v_out_122423.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_122423", "122423014", "story_v_out_122423.awb") / 1000

					if var_58_8 + var_58_2 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_2
					end

					if var_58_4.prefab_name ~= "" and arg_55_1.actors_[var_58_4.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_4.prefab_name].transform, "story_v_out_122423", "122423014", "story_v_out_122423.awb")

						arg_55_1:RecordAudio("122423014", var_58_9)
						arg_55_1:RecordAudio("122423014", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_122423", "122423014", "story_v_out_122423.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_122423", "122423014", "story_v_out_122423.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_3, arg_55_1.talkMaxDuration)

			if var_58_2 <= arg_55_1.time_ and arg_55_1.time_ < var_58_2 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_2) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_2 + var_58_10 and arg_55_1.time_ < var_58_2 + var_58_10 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122423015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122423015
		arg_59_1.duration_ = 11.97

		local var_59_0 = {
			ja = 11.966,
			ko = 6.366,
			zh = 6.366
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
				arg_59_0:Play122423016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1075ui_story"]) and arg_59_1.var_.characterEffect1075ui_story == nil then
				arg_59_1.var_.characterEffect1075ui_story = arg_59_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1075ui_story"]) then
				if arg_59_1.var_.characterEffect1075ui_story and not isNil(arg_59_1.actors_["1075ui_story"]) then
					arg_59_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1075ui_story"]) and arg_59_1.var_.characterEffect1075ui_story then
				arg_59_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.7

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(122423015)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 28 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 28)

				if (28 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 28)) > 0 and var_62_2 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423015", "story_v_out_122423.awb") ~= 0 then
					local var_62_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423015", "story_v_out_122423.awb") / 1000

					if var_62_7 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_1
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_122423", "122423015", "story_v_out_122423.awb")

						arg_59_1:RecordAudio("122423015", var_62_8)
						arg_59_1:RecordAudio("122423015", var_62_8)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122423", "122423015", "story_v_out_122423.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122423", "122423015", "story_v_out_122423.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_9 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_9 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_9

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_9 and arg_59_1.time_ < var_62_1 + var_62_9 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play122423016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122423016
		arg_63_1.duration_ = 4.1

		local var_63_0 = {
			ja = 4.1,
			ko = 2.1,
			zh = 2.1
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
				arg_63_0:Play122423017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1075ui_story = arg_63_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).z)
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles = arg_63_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1075ui_story"].transform.position).z)
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1075ui_story"].transform.localEulerAngles = arg_63_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["2079ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos2079ui_story = var_66_1.localPosition
			end

			local var_66_2 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 then
				var_66_1.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_63_1.time_ - 0) / var_66_2)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 then
				var_66_1.localPosition = Vector3.New(0, -1.28, -5.6)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			local var_66_3 = arg_63_1.actors_["2079ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect2079ui_story == nil then
				arg_63_1.var_.characterEffect2079ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect2079ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_63_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_4)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect2079ui_story then
				arg_63_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_63_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_5 = 0
			local var_66_6 = 0.25

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_7 = arg_63_1:GetWordFromCfg(122423016)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 10 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 10)

				if (10 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 10)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423016", "story_v_out_122423.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_122423", "122423016", "story_v_out_122423.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_122423", "122423016", "story_v_out_122423.awb")

						arg_63_1:RecordAudio("122423016", var_66_12)
						arg_63_1:RecordAudio("122423016", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_122423", "122423016", "story_v_out_122423.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_122423", "122423016", "story_v_out_122423.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play122423017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 122423017
		arg_67_1.duration_ = 3.1

		local var_67_0 = {
			ja = 3.1,
			ko = 1.4,
			zh = 1.4
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
				arg_67_0:Play122423018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) and arg_67_1.var_.characterEffect2079ui_story == nil then
				arg_67_1.var_.characterEffect2079ui_story = arg_67_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) then
				if arg_67_1.var_.characterEffect2079ui_story and not isNil(arg_67_1.actors_["2079ui_story"]) then
					arg_67_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) and arg_67_1.var_.characterEffect2079ui_story then
				arg_67_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_70_2 = 0
			local var_70_3 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[469].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(122423017)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 9 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 9)

				if (9 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 9)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423017", "story_v_out_122423.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_122423", "122423017", "story_v_out_122423.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_122423", "122423017", "story_v_out_122423.awb")

						arg_67_1:RecordAudio("122423017", var_70_9)
						arg_67_1:RecordAudio("122423017", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_122423", "122423017", "story_v_out_122423.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_122423", "122423017", "story_v_out_122423.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play122423018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 122423018
		arg_71_1.duration_ = 5.5

		local var_71_0 = {
			ja = 5.5,
			ko = 3.366,
			zh = 3.366
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
			arg_71_1.auto_ = false
		end

		function arg_71_1.playNext_(arg_73_0)
			arg_71_1.onStoryFinished_()
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story == nil then
				arg_71_1.var_.characterEffect2079ui_story = arg_71_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) then
				if arg_71_1.var_.characterEffect2079ui_story and not isNil(arg_71_1.actors_["2079ui_story"]) then
					arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_71_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story then
				arg_71_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_71_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.375

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095_1")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:GetWordFromCfg(122423018)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 15 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 15)

				if (15 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 15)) > 0 and var_74_2 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122423", "122423018", "story_v_out_122423.awb") ~= 0 then
					local var_74_7 = manager.audio:GetVoiceLength("story_v_out_122423", "122423018", "story_v_out_122423.awb") / 1000

					if var_74_7 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_1
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_122423", "122423018", "story_v_out_122423.awb")

						arg_71_1:RecordAudio("122423018", var_74_8)
						arg_71_1:RecordAudio("122423018", var_74_8)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_122423", "122423018", "story_v_out_122423.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_122423", "122423018", "story_v_out_122423.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_9 and arg_71_1.time_ < var_74_1 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_122423.awb"
	}
}
