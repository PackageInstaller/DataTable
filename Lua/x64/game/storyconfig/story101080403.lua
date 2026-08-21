return {
	Play108043001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 108043001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play108043002(arg_1_1)
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

			local var_4_5 = arg_1_1.actors_["1050ui_story"].transform
			local var_4_6 = 0

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.var_.moveOldPos1050ui_story = var_4_5.localPosition
			end

			local var_4_7 = 0.001

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				local var_4_8 = (arg_1_1.time_ - var_4_6) / var_4_7
				local var_4_9 = Vector3.New(0, -1, -6.1)

				var_4_5.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1050ui_story, var_4_9, var_4_8)

				local var_4_10 = manager.ui.mainCamera.transform.position - var_4_5.position

				var_4_5.forward = Vector3.New(var_4_10.x, var_4_10.y, var_4_10.z)

				local var_4_11 = var_4_5.localEulerAngles

				var_4_11.z = 0
				var_4_11.x = 0
				var_4_5.localEulerAngles = var_4_11
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				var_4_5.localPosition = Vector3.New(0, -1, -6.1)

				local var_4_12 = manager.ui.mainCamera.transform.position - var_4_5.position

				var_4_5.forward = Vector3.New(var_4_12.x, var_4_12.y, var_4_12.z)

				local var_4_13 = var_4_5.localEulerAngles

				var_4_13.z = 0
				var_4_13.x = 0
				var_4_5.localEulerAngles = var_4_13
			end

			local var_4_14 = arg_1_1.actors_["1050ui_story"]
			local var_4_15 = 0

			if var_4_15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1050ui_story == nil then
				arg_1_1.var_.characterEffect1050ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.2

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 and not isNil(var_4_14) then
				local var_4_17 = (arg_1_1.time_ - var_4_15) / var_4_16

				if arg_1_1.var_.characterEffect1050ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1050ui_story then
				arg_1_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_4_20 = 0
			local var_4_21 = 0.2

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_22 = arg_1_1:FormatText(StoryNameCfg[74].name)

				arg_1_1.leftNameTxt_.text = var_4_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(108043001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043001", "story_v_out_108043.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_108043", "108043001", "story_v_out_108043.awb") / 1000

					if var_4_28 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_108043", "108043001", "story_v_out_108043.awb")

						arg_1_1:RecordAudio("108043001", var_4_29)
						arg_1_1:RecordAudio("108043001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_108043", "108043001", "story_v_out_108043.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_108043", "108043001", "story_v_out_108043.awb")
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
	Play108043002 = function(arg_5_0, arg_5_1)
		arg_5_1.time_ = 0
		arg_5_1.frameCnt_ = 0
		arg_5_1.state_ = "playing"
		arg_5_1.curTalkId_ = 108043002
		arg_5_1.duration_ = 8.63

		local var_5_0 = {
			ja = 8.633,
			ko = 4.133,
			zh = 8.333,
			en = 7.166
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
				arg_5_0:Play108043003(arg_5_1)
			end
		end

		function arg_5_1.onSingleLineUpdate_(arg_8_0)
			local var_8_0 = arg_5_1.actors_["1050ui_story"]
			local var_8_1 = 0

			if var_8_1 < arg_5_1.time_ and arg_5_1.time_ <= var_8_1 + arg_8_0 and not isNil(var_8_0) and arg_5_1.var_.characterEffect1050ui_story == nil then
				arg_5_1.var_.characterEffect1050ui_story = var_8_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_8_2 = 0.2

			if var_8_1 <= arg_5_1.time_ and arg_5_1.time_ < var_8_1 + var_8_2 and not isNil(var_8_0) then
				local var_8_3 = (arg_5_1.time_ - var_8_1) / var_8_2

				if arg_5_1.var_.characterEffect1050ui_story and not isNil(var_8_0) then
					local var_8_4 = Mathf.Lerp(0, 0.5, var_8_3)

					arg_5_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_5_1.var_.characterEffect1050ui_story.fillRatio = var_8_4
				end
			end

			if arg_5_1.time_ >= var_8_1 + var_8_2 and arg_5_1.time_ < var_8_1 + var_8_2 + arg_8_0 and not isNil(var_8_0) and arg_5_1.var_.characterEffect1050ui_story then
				local var_8_5 = 0.5

				arg_5_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_5_1.var_.characterEffect1050ui_story.fillRatio = var_8_5
			end

			local var_8_6 = 0
			local var_8_7 = 0.7

			if var_8_6 < arg_5_1.time_ and arg_5_1.time_ <= var_8_6 + arg_8_0 then
				arg_5_1.talkMaxDuration = 0
				arg_5_1.dialogCg_.alpha = 1

				arg_5_1.dialog_:SetActive(true)
				SetActive(arg_5_1.leftNameGo_, true)

				local var_8_8 = arg_5_1:FormatText(StoryNameCfg[80].name)

				arg_5_1.leftNameTxt_.text = var_8_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_1.leftNameTxt_.transform)

				arg_5_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_5_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_5_1:RecordName(arg_5_1.leftNameTxt_.text)
				SetActive(arg_5_1.iconTrs_.gameObject, true)
				arg_5_1.iconController_:SetSelectedState("hero")

				arg_5_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_5_1.callingController_:SetSelectedState("normal")

				arg_5_1.keyicon_.color = Color.New(1, 1, 1)
				arg_5_1.icon_.color = Color.New(1, 1, 1)

				local var_8_9 = arg_5_1:GetWordFromCfg(108043002)
				local var_8_10 = arg_5_1:FormatText(var_8_9.content)

				arg_5_1.text_.text = var_8_10

				LuaForUtil.ClearLinePrefixSymbol(arg_5_1.text_)

				local var_8_11 = 16
				local var_8_12 = utf8.len(var_8_10)
				local var_8_13 = var_8_11 <= 0 and var_8_7 or var_8_7 * (var_8_12 / var_8_11)

				if var_8_13 > 0 and var_8_7 < var_8_13 then
					arg_5_1.talkMaxDuration = var_8_13

					if var_8_13 + var_8_6 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_13 + var_8_6
					end
				end

				arg_5_1.text_.text = var_8_10
				arg_5_1.typewritter.percent = 0

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043002", "story_v_out_108043.awb") ~= 0 then
					local var_8_14 = manager.audio:GetVoiceLength("story_v_out_108043", "108043002", "story_v_out_108043.awb") / 1000

					if var_8_14 + var_8_6 > arg_5_1.duration_ then
						arg_5_1.duration_ = var_8_14 + var_8_6
					end

					if var_8_9.prefab_name ~= "" and arg_5_1.actors_[var_8_9.prefab_name] ~= nil then
						local var_8_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_5_1.actors_[var_8_9.prefab_name].transform, "story_v_out_108043", "108043002", "story_v_out_108043.awb")

						arg_5_1:RecordAudio("108043002", var_8_15)
						arg_5_1:RecordAudio("108043002", var_8_15)
					else
						arg_5_1:AudioAction("play", "voice", "story_v_out_108043", "108043002", "story_v_out_108043.awb")
					end

					arg_5_1:RecordHistoryTalkVoice("story_v_out_108043", "108043002", "story_v_out_108043.awb")
				end

				arg_5_1:RecordContent(arg_5_1.text_.text)
			end

			local var_8_16 = math.max(var_8_7, arg_5_1.talkMaxDuration)

			if var_8_6 <= arg_5_1.time_ and arg_5_1.time_ < var_8_6 + var_8_16 then
				arg_5_1.typewritter.percent = (arg_5_1.time_ - var_8_6) / var_8_16

				arg_5_1.typewritter:SetDirty()
			end

			if arg_5_1.time_ >= var_8_6 + var_8_16 and arg_5_1.time_ < var_8_6 + var_8_16 + arg_8_0 then
				arg_5_1.typewritter.percent = 1

				arg_5_1.typewritter:SetDirty()
				arg_5_1:ShowNextGo(true)
			end
		end

		arg_5_1.nodeConfigList_ = {}

		arg_5_1:InitPlayNodeList()
	end,
	Play108043003 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 108043003
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play108043004(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.1

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

				local var_12_2 = arg_9_1:GetWordFromCfg(108043003)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 44
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
	Play108043004 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 108043004
		arg_13_1.duration_ = 9.5

		local var_13_0 = {
			ja = 5.966,
			ko = 4.566,
			zh = 6.666,
			en = 9.5
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
				arg_13_0:Play108043005(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.775

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[80].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(108043004)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 19
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043004", "story_v_out_108043.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_108043", "108043004", "story_v_out_108043.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_108043", "108043004", "story_v_out_108043.awb")

						arg_13_1:RecordAudio("108043004", var_16_9)
						arg_13_1:RecordAudio("108043004", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_108043", "108043004", "story_v_out_108043.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_108043", "108043004", "story_v_out_108043.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play108043005 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 108043005
		arg_17_1.duration_ = 8.9

		local var_17_0 = {
			ja = 2.6,
			ko = 4.366,
			zh = 8.9,
			en = 8.833
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
				arg_17_0:Play108043006(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.8

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[80].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(108043005)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043005", "story_v_out_108043.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_108043", "108043005", "story_v_out_108043.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_108043", "108043005", "story_v_out_108043.awb")

						arg_17_1:RecordAudio("108043005", var_20_9)
						arg_17_1:RecordAudio("108043005", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_108043", "108043005", "story_v_out_108043.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_108043", "108043005", "story_v_out_108043.awb")
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
	Play108043006 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 108043006
		arg_21_1.duration_ = 9

		local var_21_0 = {
			ja = 7.8,
			ko = 4.966,
			zh = 5.8,
			en = 9
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
				arg_21_0:Play108043007(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.65

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[80].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(108043006)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043006", "story_v_out_108043.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_108043", "108043006", "story_v_out_108043.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_108043", "108043006", "story_v_out_108043.awb")

						arg_21_1:RecordAudio("108043006", var_24_9)
						arg_21_1:RecordAudio("108043006", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_108043", "108043006", "story_v_out_108043.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_108043", "108043006", "story_v_out_108043.awb")
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
	Play108043007 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 108043007
		arg_25_1.duration_ = 7.57

		local var_25_0 = {
			ja = 7.3,
			ko = 7.566,
			zh = 4.866,
			en = 5.4
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
				arg_25_0:Play108043008(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.625

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[76].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(108043007)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 21
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043007", "story_v_out_108043.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_108043", "108043007", "story_v_out_108043.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_108043", "108043007", "story_v_out_108043.awb")

						arg_25_1:RecordAudio("108043007", var_28_9)
						arg_25_1:RecordAudio("108043007", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_108043", "108043007", "story_v_out_108043.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_108043", "108043007", "story_v_out_108043.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play108043008 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 108043008
		arg_29_1.duration_ = 3

		local var_29_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 3,
			en = 2.7
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
				arg_29_0:Play108043009(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1050ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1050ui_story == nil then
				arg_29_1.var_.characterEffect1050ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1050ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1050ui_story then
				arg_29_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_32_4 = 0

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_2")
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_32_6 = 0
			local var_32_7 = 0.3

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[74].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(108043008)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 8
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043008", "story_v_out_108043.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_108043", "108043008", "story_v_out_108043.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_108043", "108043008", "story_v_out_108043.awb")

						arg_29_1:RecordAudio("108043008", var_32_15)
						arg_29_1:RecordAudio("108043008", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_108043", "108043008", "story_v_out_108043.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_108043", "108043008", "story_v_out_108043.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play108043009 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 108043009
		arg_33_1.duration_ = 7.73

		local var_33_0 = {
			ja = 3.733,
			ko = 5.033,
			zh = 4.6,
			en = 7.733
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
				arg_33_0:Play108043010(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1050ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1050ui_story == nil then
				arg_33_1.var_.characterEffect1050ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1050ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1050ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1050ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1050ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.6

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[80].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10004")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(108043009)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 16
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043009", "story_v_out_108043.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_108043", "108043009", "story_v_out_108043.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_108043", "108043009", "story_v_out_108043.awb")

						arg_33_1:RecordAudio("108043009", var_36_15)
						arg_33_1:RecordAudio("108043009", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_108043", "108043009", "story_v_out_108043.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_108043", "108043009", "story_v_out_108043.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play108043010 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 108043010
		arg_37_1.duration_ = 3.43

		local var_37_0 = {
			ja = 1.999999999999,
			ko = 3.1,
			zh = 3.433,
			en = 3.033
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
				arg_37_0:Play108043011(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1050ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1050ui_story == nil then
				arg_37_1.var_.characterEffect1050ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1050ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1050ui_story then
				arg_37_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_40_5 = 0
			local var_40_6 = 0.4

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_7 = arg_37_1:FormatText(StoryNameCfg[74].name)

				arg_37_1.leftNameTxt_.text = var_40_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(108043010)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 12
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_6 or var_40_6 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_6 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043010", "story_v_out_108043.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_108043", "108043010", "story_v_out_108043.awb") / 1000

					if var_40_13 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_5
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_108043", "108043010", "story_v_out_108043.awb")

						arg_37_1:RecordAudio("108043010", var_40_14)
						arg_37_1:RecordAudio("108043010", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_108043", "108043010", "story_v_out_108043.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_108043", "108043010", "story_v_out_108043.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_15 and arg_37_1.time_ < var_40_5 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play108043011 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 108043011
		arg_41_1.duration_ = 5.93

		local var_41_0 = {
			ja = 5,
			ko = 4.366,
			zh = 4.033,
			en = 5.933
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
				arg_41_0:Play108043012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "1099ui_story"

			if arg_41_1.actors_[var_44_0] == nil then
				local var_44_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_44_1) then
					local var_44_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_41_1.stage_.transform)

					var_44_2.name = var_44_0
					var_44_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_41_1.actors_[var_44_0] = var_44_2

					local var_44_3 = var_44_2:GetComponentInChildren(typeof(CharacterEffect))

					var_44_3.enabled = true

					local var_44_4 = GameObjectTools.GetOrAddComponent(var_44_2, typeof(DynamicBoneHelper))

					if var_44_4 then
						var_44_4:EnableDynamicBone(false)
					end

					arg_41_1:ShowWeapon(var_44_3.transform, false)

					arg_41_1.var_[var_44_0 .. "Animator"] = var_44_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_41_1.var_[var_44_0 .. "Animator"].applyRootMotion = true
					arg_41_1.var_[var_44_0 .. "LipSync"] = var_44_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_44_5 = arg_41_1.actors_["1099ui_story"]
			local var_44_6 = 0

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1099ui_story == nil then
				arg_41_1.var_.characterEffect1099ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.2

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_7 and not isNil(var_44_5) then
				local var_44_8 = (arg_41_1.time_ - var_44_6) / var_44_7

				if arg_41_1.var_.characterEffect1099ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_6 + var_44_7 and arg_41_1.time_ < var_44_6 + var_44_7 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1099ui_story then
				arg_41_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_44_9 = arg_41_1.actors_["1050ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1050ui_story == nil then
				arg_41_1.var_.characterEffect1050ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.2

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1050ui_story and not isNil(var_44_9) then
					local var_44_13 = Mathf.Lerp(0, 0.5, var_44_12)

					arg_41_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1050ui_story.fillRatio = var_44_13
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1050ui_story then
				local var_44_14 = 0.5

				arg_41_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1050ui_story.fillRatio = var_44_14
			end

			local var_44_15 = arg_41_1.actors_["1099ui_story"].transform
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.var_.moveOldPos1099ui_story = var_44_15.localPosition
			end

			local var_44_17 = 0.001

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Vector3.New(0.7, -1.08, -5.9)

				var_44_15.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1099ui_story, var_44_19, var_44_18)

				local var_44_20 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_20.x, var_44_20.y, var_44_20.z)

				local var_44_21 = var_44_15.localEulerAngles

				var_44_21.z = 0
				var_44_21.x = 0
				var_44_15.localEulerAngles = var_44_21
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				var_44_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_44_22 = manager.ui.mainCamera.transform.position - var_44_15.position

				var_44_15.forward = Vector3.New(var_44_22.x, var_44_22.y, var_44_22.z)

				local var_44_23 = var_44_15.localEulerAngles

				var_44_23.z = 0
				var_44_23.x = 0
				var_44_15.localEulerAngles = var_44_23
			end

			local var_44_24 = arg_41_1.actors_["1050ui_story"].transform
			local var_44_25 = 0

			if var_44_25 < arg_41_1.time_ and arg_41_1.time_ <= var_44_25 + arg_44_0 then
				arg_41_1.var_.moveOldPos1050ui_story = var_44_24.localPosition
			end

			local var_44_26 = 0.5

			if var_44_25 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 then
				local var_44_27 = (arg_41_1.time_ - var_44_25) / var_44_26
				local var_44_28 = Vector3.New(-0.7, -1, -6.1)

				var_44_24.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1050ui_story, var_44_28, var_44_27)

				local var_44_29 = manager.ui.mainCamera.transform.position - var_44_24.position

				var_44_24.forward = Vector3.New(var_44_29.x, var_44_29.y, var_44_29.z)

				local var_44_30 = var_44_24.localEulerAngles

				var_44_30.z = 0
				var_44_30.x = 0
				var_44_24.localEulerAngles = var_44_30
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 then
				var_44_24.localPosition = Vector3.New(-0.7, -1, -6.1)

				local var_44_31 = manager.ui.mainCamera.transform.position - var_44_24.position

				var_44_24.forward = Vector3.New(var_44_31.x, var_44_31.y, var_44_31.z)

				local var_44_32 = var_44_24.localEulerAngles

				var_44_32.z = 0
				var_44_32.x = 0
				var_44_24.localEulerAngles = var_44_32
			end

			local var_44_33 = 0

			if var_44_33 < arg_41_1.time_ and arg_41_1.time_ <= var_44_33 + arg_44_0 then
				arg_41_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			local var_44_34 = 0

			if var_44_34 < arg_41_1.time_ and arg_41_1.time_ <= var_44_34 + arg_44_0 then
				arg_41_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_44_35 = 0
			local var_44_36 = 0.525

			if var_44_35 < arg_41_1.time_ and arg_41_1.time_ <= var_44_35 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_37 = arg_41_1:FormatText(StoryNameCfg[84].name)

				arg_41_1.leftNameTxt_.text = var_44_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_38 = arg_41_1:GetWordFromCfg(108043011)
				local var_44_39 = arg_41_1:FormatText(var_44_38.content)

				arg_41_1.text_.text = var_44_39

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_40 = 21
				local var_44_41 = utf8.len(var_44_39)
				local var_44_42 = var_44_40 <= 0 and var_44_36 or var_44_36 * (var_44_41 / var_44_40)

				if var_44_42 > 0 and var_44_36 < var_44_42 then
					arg_41_1.talkMaxDuration = var_44_42

					if var_44_42 + var_44_35 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_42 + var_44_35
					end
				end

				arg_41_1.text_.text = var_44_39
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043011", "story_v_out_108043.awb") ~= 0 then
					local var_44_43 = manager.audio:GetVoiceLength("story_v_out_108043", "108043011", "story_v_out_108043.awb") / 1000

					if var_44_43 + var_44_35 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_43 + var_44_35
					end

					if var_44_38.prefab_name ~= "" and arg_41_1.actors_[var_44_38.prefab_name] ~= nil then
						local var_44_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_38.prefab_name].transform, "story_v_out_108043", "108043011", "story_v_out_108043.awb")

						arg_41_1:RecordAudio("108043011", var_44_44)
						arg_41_1:RecordAudio("108043011", var_44_44)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_108043", "108043011", "story_v_out_108043.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_108043", "108043011", "story_v_out_108043.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_45 = math.max(var_44_36, arg_41_1.talkMaxDuration)

			if var_44_35 <= arg_41_1.time_ and arg_41_1.time_ < var_44_35 + var_44_45 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_35) / var_44_45

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_35 + var_44_45 and arg_41_1.time_ < var_44_35 + var_44_45 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play108043012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 108043012
		arg_45_1.duration_ = 1.67

		local var_45_0 = {
			ja = 1.266,
			ko = 1.1,
			zh = 1.666,
			en = 1.2
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
				arg_45_0:Play108043013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1050ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1050ui_story == nil then
				arg_45_1.var_.characterEffect1050ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1050ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1050ui_story then
				arg_45_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1099ui_story"]
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1099ui_story == nil then
				arg_45_1.var_.characterEffect1099ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_6 = 0.2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 and not isNil(var_48_4) then
				local var_48_7 = (arg_45_1.time_ - var_48_5) / var_48_6

				if arg_45_1.var_.characterEffect1099ui_story and not isNil(var_48_4) then
					local var_48_8 = Mathf.Lerp(0, 0.5, var_48_7)

					arg_45_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1099ui_story.fillRatio = var_48_8
				end
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1099ui_story then
				local var_48_9 = 0.5

				arg_45_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1099ui_story.fillRatio = var_48_9
			end

			local var_48_10 = 0
			local var_48_11 = 0.2

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[74].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(108043012)
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

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043012", "story_v_out_108043.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_108043", "108043012", "story_v_out_108043.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_108043", "108043012", "story_v_out_108043.awb")

						arg_45_1:RecordAudio("108043012", var_48_19)
						arg_45_1:RecordAudio("108043012", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_108043", "108043012", "story_v_out_108043.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_108043", "108043012", "story_v_out_108043.awb")
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
	Play108043013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 108043013
		arg_49_1.duration_ = 2.73

		local var_49_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
			arg_49_1.auto_ = false
		end

		function arg_49_1.playNext_(arg_51_0)
			arg_49_1.onStoryFinished_()
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1099ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1099ui_story == nil then
				arg_49_1.var_.characterEffect1099ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1099ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1099ui_story then
				arg_49_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1050ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1050ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1050ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1050ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1050ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_52_11 = 0
			local var_52_12 = 0.175

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_13 = arg_49_1:FormatText(StoryNameCfg[84].name)

				arg_49_1.leftNameTxt_.text = var_52_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(108043013)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 7
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_12 or var_52_12 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_12 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108043", "108043013", "story_v_out_108043.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_108043", "108043013", "story_v_out_108043.awb") / 1000

					if var_52_19 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_11
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_108043", "108043013", "story_v_out_108043.awb")

						arg_49_1:RecordAudio("108043013", var_52_20)
						arg_49_1:RecordAudio("108043013", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_108043", "108043013", "story_v_out_108043.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_108043", "108043013", "story_v_out_108043.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_21 and arg_49_1.time_ < var_52_11 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_108043.awb"
	}
}
