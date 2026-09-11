return {
	Play115123001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115123001
		arg_1_1.duration_ = 6.8

		local var_1_0 = {
			ja = 5.8,
			ko = 6.133,
			zh = 5.466,
			en = 6.8
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
				arg_1_0:Play115123002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			local var_4_3 = "1017ui_story"

			if arg_1_1.actors_["1017ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1017ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1017ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1017ui_story = var_4_7.localPosition
			end

			local var_4_8 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 then
				var_4_7.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_1_1.time_ - 2) / var_4_8)
				var_4_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_7.position).x, (manager.ui.mainCamera.transform.position - var_4_7.position).y, (manager.ui.mainCamera.transform.position - var_4_7.position).z)
				var_4_7.localEulerAngles.z = 0
				var_4_7.localEulerAngles.x = 0
				var_4_7.localEulerAngles = var_4_7.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 then
				var_4_7.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_4_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_7.position).x, (manager.ui.mainCamera.transform.position - var_4_7.position).y, (manager.ui.mainCamera.transform.position - var_4_7.position).z)
				var_4_7.localEulerAngles.z = 0
				var_4_7.localEulerAngles.x = 0
				var_4_7.localEulerAngles = var_4_7.localEulerAngles
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_4_9 = arg_1_1.actors_["1017ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1017ui_story == nil then
				arg_1_1.var_.characterEffect1017ui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffect1017ui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_10 and arg_1_1.time_ < 2 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1017ui_story then
				arg_1_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 0.425

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:GetWordFromCfg(115123001)
				local var_4_16 = arg_1_1:FormatText(var_4_15.content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 17 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 17)

				if (17 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_16) / 17)) > 0 and var_4_13 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_12 = var_4_12 + 0.3

					if var_4_18 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123001", "story_v_out_115123.awb") ~= 0 then
					local var_4_19 = manager.audio:GetVoiceLength("story_v_out_115123", "115123001", "story_v_out_115123.awb") / 1000

					if var_4_19 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_12
					end

					if var_4_15.prefab_name ~= "" and arg_1_1.actors_[var_4_15.prefab_name] ~= nil then
						local var_4_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_15.prefab_name].transform, "story_v_out_115123", "115123001", "story_v_out_115123.awb")

						arg_1_1:RecordAudio("115123001", var_4_20)
						arg_1_1:RecordAudio("115123001", var_4_20)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_115123", "115123001", "story_v_out_115123.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_115123", "115123001", "story_v_out_115123.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_12 + 0.3
			local var_4_22 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115123002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 115123002
		arg_7_1.duration_ = 3.43

		local var_7_0 = {
			ja = 2.933,
			ko = 3.433,
			zh = 2.766,
			en = 3.066
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
				arg_7_0:Play115123003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1024ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1024ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1024ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1024ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1024ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1024ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_10_5 = arg_7_1.actors_["1024ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1024ui_story == nil then
				arg_7_1.var_.characterEffect1024ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect1024ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1024ui_story then
				arg_7_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_10_8 = arg_7_1.actors_["1017ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect1017ui_story == nil then
				arg_7_1.var_.characterEffect1017ui_story = var_10_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_9 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_9 and not isNil(var_10_8) then
				if arg_7_1.var_.characterEffect1017ui_story and not isNil(var_10_8) then
					arg_7_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_9)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_9 and arg_7_1.time_ < 0 + var_10_9 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect1017ui_story then
				arg_7_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_10_10 = 0
			local var_10_11 = 0.3

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_12 = arg_7_1:GetWordFromCfg(115123002)
				local var_10_13 = arg_7_1:FormatText(var_10_12.content)

				arg_7_1.text_.text = var_10_13

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 12 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 12)

				if (12 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 12)) > 0 and var_10_11 < var_10_15 then
					arg_7_1.talkMaxDuration = var_10_15

					if var_10_15 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_15 + var_10_10
					end
				end

				arg_7_1.text_.text = var_10_13
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123002", "story_v_out_115123.awb") ~= 0 then
					local var_10_16 = manager.audio:GetVoiceLength("story_v_out_115123", "115123002", "story_v_out_115123.awb") / 1000

					if var_10_16 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_16 + var_10_10
					end

					if var_10_12.prefab_name ~= "" and arg_7_1.actors_[var_10_12.prefab_name] ~= nil then
						local var_10_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_12.prefab_name].transform, "story_v_out_115123", "115123002", "story_v_out_115123.awb")

						arg_7_1:RecordAudio("115123002", var_10_17)
						arg_7_1:RecordAudio("115123002", var_10_17)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_115123", "115123002", "story_v_out_115123.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_115123", "115123002", "story_v_out_115123.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_18 = math.max(var_10_11, arg_7_1.talkMaxDuration)

			if var_10_10 <= arg_7_1.time_ and arg_7_1.time_ < var_10_10 + var_10_18 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_10) / var_10_18

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_10 + var_10_18 and arg_7_1.time_ < var_10_10 + var_10_18 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play115123003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 115123003
		arg_11_1.duration_ = 4.9

		local var_11_0 = {
			ja = 4.9,
			ko = 2.533,
			zh = 3.2,
			en = 3.266
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
				arg_11_0:Play115123004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_14_0 = 0
			local var_14_1 = 0.275

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(115123003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 11 <= 0 and var_14_1 or var_14_1 * (utf8.len(var_14_3) / 11)

				if (11 <= 0 and var_14_1 or var_14_1 * (utf8.len(var_14_3) / 11)) > 0 and var_14_1 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123003", "story_v_out_115123.awb") ~= 0 then
					local var_14_6 = manager.audio:GetVoiceLength("story_v_out_115123", "115123003", "story_v_out_115123.awb") / 1000

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end

					if var_14_2.prefab_name ~= "" and arg_11_1.actors_[var_14_2.prefab_name] ~= nil then
						local var_14_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_2.prefab_name].transform, "story_v_out_115123", "115123003", "story_v_out_115123.awb")

						arg_11_1:RecordAudio("115123003", var_14_7)
						arg_11_1:RecordAudio("115123003", var_14_7)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_115123", "115123003", "story_v_out_115123.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_115123", "115123003", "story_v_out_115123.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_8 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_8 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_8

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_8 and arg_11_1.time_ < var_14_0 + var_14_8 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play115123004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 115123004
		arg_15_1.duration_ = 3.53

		local var_15_0 = {
			ja = 3.2,
			ko = 3.533,
			zh = 2.966,
			en = 2.533
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
				arg_15_0:Play115123005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_18_0 = arg_15_1.actors_["1017ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1017ui_story == nil then
				arg_15_1.var_.characterEffect1017ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_1 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_1 and not isNil(var_18_0) then
				if arg_15_1.var_.characterEffect1017ui_story and not isNil(var_18_0) then
					arg_15_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_1 and arg_15_1.time_ < 0 + var_18_1 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1017ui_story then
				arg_15_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_18_3 = arg_15_1.actors_["1024ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1024ui_story == nil then
				arg_15_1.var_.characterEffect1024ui_story = var_18_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 and not isNil(var_18_3) then
				if arg_15_1.var_.characterEffect1024ui_story and not isNil(var_18_3) then
					arg_15_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_4)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1024ui_story then
				arg_15_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_18_5 = 0
			local var_18_6 = 0.275

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_7 = arg_15_1:GetWordFromCfg(115123004)
				local var_18_8 = arg_15_1:FormatText(var_18_7.content)

				arg_15_1.text_.text = var_18_8

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 11 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_8) / 11)

				if (11 <= 0 and var_18_6 or var_18_6 * (utf8.len(var_18_8) / 11)) > 0 and var_18_6 < var_18_10 then
					arg_15_1.talkMaxDuration = var_18_10

					if var_18_10 + var_18_5 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_5
					end
				end

				arg_15_1.text_.text = var_18_8
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123004", "story_v_out_115123.awb") ~= 0 then
					local var_18_11 = manager.audio:GetVoiceLength("story_v_out_115123", "115123004", "story_v_out_115123.awb") / 1000

					if var_18_11 + var_18_5 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_11 + var_18_5
					end

					if var_18_7.prefab_name ~= "" and arg_15_1.actors_[var_18_7.prefab_name] ~= nil then
						local var_18_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_7.prefab_name].transform, "story_v_out_115123", "115123004", "story_v_out_115123.awb")

						arg_15_1:RecordAudio("115123004", var_18_12)
						arg_15_1:RecordAudio("115123004", var_18_12)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_115123", "115123004", "story_v_out_115123.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_115123", "115123004", "story_v_out_115123.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_13 = math.max(var_18_6, arg_15_1.talkMaxDuration)

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_13 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_5) / var_18_13

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_5 + var_18_13 and arg_15_1.time_ < var_18_5 + var_18_13 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play115123005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 115123005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play115123006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1017ui_story = arg_19_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).z)
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles = arg_19_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1017ui_story"].transform.position).z)
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1017ui_story"].transform.localEulerAngles = arg_19_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1024ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1024ui_story = var_22_1.localPosition
			end

			local var_22_2 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 then
				var_22_1.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_2)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 then
				var_22_1.localPosition = Vector3.New(0, 100, 0)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			local var_22_3 = 0
			local var_22_4 = 0.675

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(115123005).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 27 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 27)

				if (27 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 27)) > 0 and var_22_4 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_3
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_4, arg_19_1.talkMaxDuration)

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_3) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_3 + var_22_8 and arg_19_1.time_ < var_22_3 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play115123006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115123006
		arg_23_1.duration_ = 4.5

		local var_23_0 = {
			ja = 4.5,
			ko = 3.433,
			zh = 3.266,
			en = 3.833
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
				arg_23_0:Play115123007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.4

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[282].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_1 = arg_23_1:GetWordFromCfg(115123006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 16 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 16)

				if (16 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 16)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123006", "story_v_out_115123.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_115123", "115123006", "story_v_out_115123.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_115123", "115123006", "story_v_out_115123.awb")

						arg_23_1:RecordAudio("115123006", var_26_6)
						arg_23_1:RecordAudio("115123006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115123", "115123006", "story_v_out_115123.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115123", "115123006", "story_v_out_115123.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play115123007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115123007
		arg_27_1.duration_ = 6.9

		local var_27_0 = {
			ja = 6.9,
			ko = 4.666,
			zh = 3.833,
			en = 6
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
				arg_27_0:Play115123008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.5

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[283].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(115123007)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 20 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 20)

				if (20 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 20)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123007", "story_v_out_115123.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_115123", "115123007", "story_v_out_115123.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_115123", "115123007", "story_v_out_115123.awb")

						arg_27_1:RecordAudio("115123007", var_30_6)
						arg_27_1:RecordAudio("115123007", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_115123", "115123007", "story_v_out_115123.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_115123", "115123007", "story_v_out_115123.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115123008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115123008
		arg_31_1.duration_ = 8.27

		local var_31_0 = {
			ja = 8.266,
			ko = 5.566,
			zh = 5.5,
			en = 6.6
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
				arg_31_0:Play115123009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.625

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[283].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(115123008)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 25 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 25)

				if (25 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 25)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123008", "story_v_out_115123.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_115123", "115123008", "story_v_out_115123.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_115123", "115123008", "story_v_out_115123.awb")

						arg_31_1:RecordAudio("115123008", var_34_6)
						arg_31_1:RecordAudio("115123008", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_115123", "115123008", "story_v_out_115123.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_115123", "115123008", "story_v_out_115123.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play115123009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115123009
		arg_35_1.duration_ = 7.9

		local var_35_0 = {
			ja = 7.9,
			ko = 4.033,
			zh = 4.2,
			en = 5.666
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
				arg_35_0:Play115123010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.425

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[282].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(115123009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 17)

				if (17 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 17)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123009", "story_v_out_115123.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_115123", "115123009", "story_v_out_115123.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_115123", "115123009", "story_v_out_115123.awb")

						arg_35_1:RecordAudio("115123009", var_38_6)
						arg_35_1:RecordAudio("115123009", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115123", "115123009", "story_v_out_115123.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115123", "115123009", "story_v_out_115123.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play115123010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115123010
		arg_39_1.duration_ = 7.3

		local var_39_0 = {
			ja = 7.3,
			ko = 4.5,
			zh = 3.833,
			en = 2.933
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
				arg_39_0:Play115123011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.325

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[283].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(115123010)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 13 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 13)

				if (13 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 13)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123010", "story_v_out_115123.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_115123", "115123010", "story_v_out_115123.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_115123", "115123010", "story_v_out_115123.awb")

						arg_39_1:RecordAudio("115123010", var_42_6)
						arg_39_1:RecordAudio("115123010", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115123", "115123010", "story_v_out_115123.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115123", "115123010", "story_v_out_115123.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115123011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115123011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play115123012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.575

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(115123011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 23 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 23)

				if (23 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 23)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115123012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115123012
		arg_47_1.duration_ = 3.3

		local var_47_0 = {
			ja = 1.999999999999,
			ko = 3.3,
			zh = 3.1,
			en = 2.233
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
				arg_47_0:Play115123013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1024ui_story = arg_47_1.actors_["1024ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1024ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).z)
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles = arg_47_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1024ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_47_1.actors_["1024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1024ui_story"].transform.position).z)
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1024ui_story"].transform.localEulerAngles = arg_47_1.actors_["1024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_50_1 = arg_47_1.actors_["1024ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1024ui_story == nil then
				arg_47_1.var_.characterEffect1024ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1024ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1024ui_story then
				arg_47_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1017ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1017ui_story = var_50_4.localPosition
			end

			local var_50_5 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				var_50_4.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_47_1.time_ - 0) / var_50_5)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				var_50_4.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action1_1")
			end

			local var_50_6 = arg_47_1.actors_["1017ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1017ui_story == nil then
				arg_47_1.var_.characterEffect1017ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_7 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 and not isNil(var_50_6) then
				if arg_47_1.var_.characterEffect1017ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_7)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1017ui_story then
				arg_47_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_50_8 = 0
			local var_50_9 = 0.325

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(115123012)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 13 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 13)

				if (13 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 13)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123012", "story_v_out_115123.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_115123", "115123012", "story_v_out_115123.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_115123", "115123012", "story_v_out_115123.awb")

						arg_47_1:RecordAudio("115123012", var_50_15)
						arg_47_1:RecordAudio("115123012", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_115123", "115123012", "story_v_out_115123.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_115123", "115123012", "story_v_out_115123.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play115123013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 115123013
		arg_51_1.duration_ = 7.43

		local var_51_0 = {
			ja = 4.133,
			ko = 7.433,
			zh = 6.766,
			en = 6.266
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
				arg_51_0:Play115123014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_54_0 = arg_51_1.actors_["1017ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1017ui_story == nil then
				arg_51_1.var_.characterEffect1017ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_1 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 and not isNil(var_54_0) then
				if arg_51_1.var_.characterEffect1017ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1017ui_story then
				arg_51_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_54_3 = arg_51_1.actors_["1024ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1024ui_story == nil then
				arg_51_1.var_.characterEffect1024ui_story = var_54_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_4 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 and not isNil(var_54_3) then
				if arg_51_1.var_.characterEffect1024ui_story and not isNil(var_54_3) then
					arg_51_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_4)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1024ui_story then
				arg_51_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_54_5 = 0
			local var_54_6 = 0.9

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:GetWordFromCfg(115123013)
				local var_54_8 = arg_51_1:FormatText(var_54_7.content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 36 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 36)

				if (36 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 36)) > 0 and var_54_6 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123013", "story_v_out_115123.awb") ~= 0 then
					local var_54_11 = manager.audio:GetVoiceLength("story_v_out_115123", "115123013", "story_v_out_115123.awb") / 1000

					if var_54_11 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_5
					end

					if var_54_7.prefab_name ~= "" and arg_51_1.actors_[var_54_7.prefab_name] ~= nil then
						local var_54_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_7.prefab_name].transform, "story_v_out_115123", "115123013", "story_v_out_115123.awb")

						arg_51_1:RecordAudio("115123013", var_54_12)
						arg_51_1:RecordAudio("115123013", var_54_12)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_115123", "115123013", "story_v_out_115123.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_115123", "115123013", "story_v_out_115123.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_13 and arg_51_1.time_ < var_54_5 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play115123014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 115123014
		arg_55_1.duration_ = 2.03

		local var_55_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 1.999999999999,
			en = 1.999999999999
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
			arg_55_1.auto_ = false
		end

		function arg_55_1.playNext_(arg_57_0)
			arg_55_1.onStoryFinished_()
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_0 = arg_55_1.actors_["1024ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1024ui_story == nil then
				arg_55_1.var_.characterEffect1024ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_1 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 and not isNil(var_58_0) then
				if arg_55_1.var_.characterEffect1024ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1024ui_story then
				arg_55_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_58_3 = arg_55_1.actors_["1017ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1017ui_story == nil then
				arg_55_1.var_.characterEffect1017ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect1017ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_4)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1017ui_story then
				arg_55_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_58_5 = 0
			local var_58_6 = 0.175

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(115123014)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 7 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 7)

				if (7 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 7)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115123", "115123014", "story_v_out_115123.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_115123", "115123014", "story_v_out_115123.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_115123", "115123014", "story_v_out_115123.awb")

						arg_55_1:RecordAudio("115123014", var_58_12)
						arg_55_1:RecordAudio("115123014", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_115123", "115123014", "story_v_out_115123.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_115123", "115123014", "story_v_out_115123.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_115123.awb"
	}
}
