return {
	Play122143001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122143001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122143002(arg_1_1)
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_6 = 2
			local var_4_7 = 0.225

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_8 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_8:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_9 = arg_1_1:GetWordFromCfg(122143001)
				local var_4_10 = arg_1_1:FormatText(var_4_9.content)

				arg_1_1.text_.text = var_4_10

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_11 = 9
				local var_4_12 = utf8.len(var_4_10)
				local var_4_13 = var_4_11 <= 0 and var_4_7 or var_4_7 * (var_4_12 / var_4_11)

				if var_4_13 > 0 and var_4_7 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_6 = var_4_6 + 0.3

					if var_4_13 + var_4_6 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_6
					end
				end

				arg_1_1.text_.text = var_4_10
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_6 + 0.3
			local var_4_15 = math.max(var_4_7, arg_1_1.talkMaxDuration)

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play122143002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 122143002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play122143003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.75

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(122143002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 70
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play122143003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 122143003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play122143004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.225

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(122143003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 49
				local var_14_5 = utf8.len(var_14_3)
				local var_14_6 = var_14_4 <= 0 and var_14_1 or var_14_1 * (var_14_5 / var_14_4)

				if var_14_6 > 0 and var_14_1 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_7 and arg_11_1.time_ < var_14_0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play122143004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 122143004
		arg_15_1.duration_ = 8.23

		local var_15_0 = {
			ja = 8.233,
			ko = 7.633,
			zh = 7.633
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
				arg_15_0:Play122143005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "1184ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["1184ui_story"].transform
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.var_.moveOldPos1184ui_story = var_18_5.localPosition
			end

			local var_18_7 = 0.001

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7
				local var_18_9 = Vector3.New(-0.7, -0.97, -6)

				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1184ui_story, var_18_9, var_18_8)

				local var_18_10 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_10.x, var_18_10.y, var_18_10.z)

				local var_18_11 = var_18_5.localEulerAngles

				var_18_11.z = 0
				var_18_11.x = 0
				var_18_5.localEulerAngles = var_18_11
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_18_12 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_12.x, var_18_12.y, var_18_12.z)

				local var_18_13 = var_18_5.localEulerAngles

				var_18_13.z = 0
				var_18_13.x = 0
				var_18_5.localEulerAngles = var_18_13
			end

			local var_18_14 = arg_15_1.actors_["1184ui_story"]
			local var_18_15 = 0

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1184ui_story == nil then
				arg_15_1.var_.characterEffect1184ui_story = var_18_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_16 = 0.200000002980232

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 and not isNil(var_18_14) then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16

				if arg_15_1.var_.characterEffect1184ui_story and not isNil(var_18_14) then
					arg_15_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1184ui_story then
				arg_15_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_18_18 = 0

			if var_18_18 < arg_15_1.time_ and arg_15_1.time_ <= var_18_18 + arg_18_0 then
				arg_15_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_18_19 = 0

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_18_20 = "1084ui_story"

			if arg_15_1.actors_[var_18_20] == nil then
				local var_18_21 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_18_21) then
					local var_18_22 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_15_1.stage_.transform)

					var_18_22.name = var_18_20
					var_18_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_20] = var_18_22

					local var_18_23 = var_18_22:GetComponentInChildren(typeof(CharacterEffect))

					var_18_23.enabled = true

					local var_18_24 = GameObjectTools.GetOrAddComponent(var_18_22, typeof(DynamicBoneHelper))

					if var_18_24 then
						var_18_24:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_23.transform, false)

					arg_15_1.var_[var_18_20 .. "Animator"] = var_18_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_20 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_20 .. "LipSync"] = var_18_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_25 = arg_15_1.actors_["1084ui_story"].transform
			local var_18_26 = 0

			if var_18_26 < arg_15_1.time_ and arg_15_1.time_ <= var_18_26 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = var_18_25.localPosition
			end

			local var_18_27 = 0.001

			if var_18_26 <= arg_15_1.time_ and arg_15_1.time_ < var_18_26 + var_18_27 then
				local var_18_28 = (arg_15_1.time_ - var_18_26) / var_18_27
				local var_18_29 = Vector3.New(0.7, -0.97, -6)

				var_18_25.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, var_18_29, var_18_28)

				local var_18_30 = manager.ui.mainCamera.transform.position - var_18_25.position

				var_18_25.forward = Vector3.New(var_18_30.x, var_18_30.y, var_18_30.z)

				local var_18_31 = var_18_25.localEulerAngles

				var_18_31.z = 0
				var_18_31.x = 0
				var_18_25.localEulerAngles = var_18_31
			end

			if arg_15_1.time_ >= var_18_26 + var_18_27 and arg_15_1.time_ < var_18_26 + var_18_27 + arg_18_0 then
				var_18_25.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_18_32 = manager.ui.mainCamera.transform.position - var_18_25.position

				var_18_25.forward = Vector3.New(var_18_32.x, var_18_32.y, var_18_32.z)

				local var_18_33 = var_18_25.localEulerAngles

				var_18_33.z = 0
				var_18_33.x = 0
				var_18_25.localEulerAngles = var_18_33
			end

			local var_18_34 = arg_15_1.actors_["1084ui_story"]
			local var_18_35 = 0

			if var_18_35 < arg_15_1.time_ and arg_15_1.time_ <= var_18_35 + arg_18_0 and not isNil(var_18_34) and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = var_18_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_36 = 0.0166666666666667

			if var_18_35 <= arg_15_1.time_ and arg_15_1.time_ < var_18_35 + var_18_36 and not isNil(var_18_34) then
				local var_18_37 = (arg_15_1.time_ - var_18_35) / var_18_36

				if arg_15_1.var_.characterEffect1084ui_story and not isNil(var_18_34) then
					local var_18_38 = Mathf.Lerp(0, 0.5, var_18_37)

					arg_15_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1084ui_story.fillRatio = var_18_38
				end
			end

			if arg_15_1.time_ >= var_18_35 + var_18_36 and arg_15_1.time_ < var_18_35 + var_18_36 + arg_18_0 and not isNil(var_18_34) and arg_15_1.var_.characterEffect1084ui_story then
				local var_18_39 = 0.5

				arg_15_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1084ui_story.fillRatio = var_18_39
			end

			local var_18_40 = 0

			if var_18_40 < arg_15_1.time_ and arg_15_1.time_ <= var_18_40 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_18_41 = 0

			if var_18_41 < arg_15_1.time_ and arg_15_1.time_ <= var_18_41 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_18_42 = 0
			local var_18_43 = 0.75

			if var_18_42 < arg_15_1.time_ and arg_15_1.time_ <= var_18_42 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_44 = arg_15_1:FormatText(StoryNameCfg[6].name)

				arg_15_1.leftNameTxt_.text = var_18_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_45 = arg_15_1:GetWordFromCfg(122143004)
				local var_18_46 = arg_15_1:FormatText(var_18_45.content)

				arg_15_1.text_.text = var_18_46

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_47 = 30
				local var_18_48 = utf8.len(var_18_46)
				local var_18_49 = var_18_47 <= 0 and var_18_43 or var_18_43 * (var_18_48 / var_18_47)

				if var_18_49 > 0 and var_18_43 < var_18_49 then
					arg_15_1.talkMaxDuration = var_18_49

					if var_18_49 + var_18_42 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_49 + var_18_42
					end
				end

				arg_15_1.text_.text = var_18_46
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143004", "story_v_out_122143.awb") ~= 0 then
					local var_18_50 = manager.audio:GetVoiceLength("story_v_out_122143", "122143004", "story_v_out_122143.awb") / 1000

					if var_18_50 + var_18_42 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_50 + var_18_42
					end

					if var_18_45.prefab_name ~= "" and arg_15_1.actors_[var_18_45.prefab_name] ~= nil then
						local var_18_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_45.prefab_name].transform, "story_v_out_122143", "122143004", "story_v_out_122143.awb")

						arg_15_1:RecordAudio("122143004", var_18_51)
						arg_15_1:RecordAudio("122143004", var_18_51)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_122143", "122143004", "story_v_out_122143.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_122143", "122143004", "story_v_out_122143.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_52 = math.max(var_18_43, arg_15_1.talkMaxDuration)

			if var_18_42 <= arg_15_1.time_ and arg_15_1.time_ < var_18_42 + var_18_52 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_42) / var_18_52

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_42 + var_18_52 and arg_15_1.time_ < var_18_42 + var_18_52 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play122143005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122143005
		arg_19_1.duration_ = 7.37

		local var_19_0 = {
			ja = 7.366,
			ko = 6.433,
			zh = 6.433
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
				arg_19_0:Play122143006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1084ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1084ui_story and not isNil(var_22_0) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_22_4 = 0

			if var_22_4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_22_5 = arg_19_1.actors_["1184ui_story"]
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1184ui_story == nil then
				arg_19_1.var_.characterEffect1184ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_7 = 0.200000002980232

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 and not isNil(var_22_5) then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7

				if arg_19_1.var_.characterEffect1184ui_story and not isNil(var_22_5) then
					local var_22_9 = Mathf.Lerp(0, 0.5, var_22_8)

					arg_19_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1184ui_story.fillRatio = var_22_9
				end
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1184ui_story then
				local var_22_10 = 0.5

				arg_19_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1184ui_story.fillRatio = var_22_10
			end

			local var_22_11 = 0
			local var_22_12 = 0.7

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_13 = arg_19_1:FormatText(StoryNameCfg[451].name)

				arg_19_1.leftNameTxt_.text = var_22_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_14 = arg_19_1:GetWordFromCfg(122143005)
				local var_22_15 = arg_19_1:FormatText(var_22_14.content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_16 = 28
				local var_22_17 = utf8.len(var_22_15)
				local var_22_18 = var_22_16 <= 0 and var_22_12 or var_22_12 * (var_22_17 / var_22_16)

				if var_22_18 > 0 and var_22_12 < var_22_18 then
					arg_19_1.talkMaxDuration = var_22_18

					if var_22_18 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_18 + var_22_11
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143005", "story_v_out_122143.awb") ~= 0 then
					local var_22_19 = manager.audio:GetVoiceLength("story_v_out_122143", "122143005", "story_v_out_122143.awb") / 1000

					if var_22_19 + var_22_11 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_11
					end

					if var_22_14.prefab_name ~= "" and arg_19_1.actors_[var_22_14.prefab_name] ~= nil then
						local var_22_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_14.prefab_name].transform, "story_v_out_122143", "122143005", "story_v_out_122143.awb")

						arg_19_1:RecordAudio("122143005", var_22_20)
						arg_19_1:RecordAudio("122143005", var_22_20)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_122143", "122143005", "story_v_out_122143.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_122143", "122143005", "story_v_out_122143.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_12, arg_19_1.talkMaxDuration)

			if var_22_11 <= arg_19_1.time_ and arg_19_1.time_ < var_22_11 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_11) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_11 + var_22_21 and arg_19_1.time_ < var_22_11 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play122143006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122143006
		arg_23_1.duration_ = 9.5

		local var_23_0 = {
			ja = 9.5,
			ko = 3,
			zh = 3
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
				arg_23_0:Play122143007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1184ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1184ui_story == nil then
				arg_23_1.var_.characterEffect1184ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1184ui_story and not isNil(var_26_0) then
					arg_23_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1184ui_story then
				arg_23_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_26_4 = 0

			if var_26_4 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_26_5 = 0

			if var_26_5 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_26_6 = arg_23_1.actors_["1084ui_story"]
			local var_26_7 = 0

			if var_26_7 < arg_23_1.time_ and arg_23_1.time_ <= var_26_7 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1084ui_story == nil then
				arg_23_1.var_.characterEffect1084ui_story = var_26_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_8 = 0.200000002980232

			if var_26_7 <= arg_23_1.time_ and arg_23_1.time_ < var_26_7 + var_26_8 and not isNil(var_26_6) then
				local var_26_9 = (arg_23_1.time_ - var_26_7) / var_26_8

				if arg_23_1.var_.characterEffect1084ui_story and not isNil(var_26_6) then
					local var_26_10 = Mathf.Lerp(0, 0.5, var_26_9)

					arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_10
				end
			end

			if arg_23_1.time_ >= var_26_7 + var_26_8 and arg_23_1.time_ < var_26_7 + var_26_8 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1084ui_story then
				local var_26_11 = 0.5

				arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_11
			end

			local var_26_12 = 0
			local var_26_13 = 0.3

			if var_26_12 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_14 = arg_23_1:FormatText(StoryNameCfg[6].name)

				arg_23_1.leftNameTxt_.text = var_26_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_15 = arg_23_1:GetWordFromCfg(122143006)
				local var_26_16 = arg_23_1:FormatText(var_26_15.content)

				arg_23_1.text_.text = var_26_16

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_17 = 12
				local var_26_18 = utf8.len(var_26_16)
				local var_26_19 = var_26_17 <= 0 and var_26_13 or var_26_13 * (var_26_18 / var_26_17)

				if var_26_19 > 0 and var_26_13 < var_26_19 then
					arg_23_1.talkMaxDuration = var_26_19

					if var_26_19 + var_26_12 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_19 + var_26_12
					end
				end

				arg_23_1.text_.text = var_26_16
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143006", "story_v_out_122143.awb") ~= 0 then
					local var_26_20 = manager.audio:GetVoiceLength("story_v_out_122143", "122143006", "story_v_out_122143.awb") / 1000

					if var_26_20 + var_26_12 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_20 + var_26_12
					end

					if var_26_15.prefab_name ~= "" and arg_23_1.actors_[var_26_15.prefab_name] ~= nil then
						local var_26_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_15.prefab_name].transform, "story_v_out_122143", "122143006", "story_v_out_122143.awb")

						arg_23_1:RecordAudio("122143006", var_26_21)
						arg_23_1:RecordAudio("122143006", var_26_21)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122143", "122143006", "story_v_out_122143.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122143", "122143006", "story_v_out_122143.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_22 = math.max(var_26_13, arg_23_1.talkMaxDuration)

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_22 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_12) / var_26_22

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_12 + var_26_22 and arg_23_1.time_ < var_26_12 + var_26_22 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play122143007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122143007
		arg_27_1.duration_ = 2.2

		local var_27_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_27_0:Play122143008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1084ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_30_4 = 0

			if var_30_4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_5 = arg_27_1.actors_["1184ui_story"]
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1184ui_story == nil then
				arg_27_1.var_.characterEffect1184ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_7 = 0.200000002980232

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 and not isNil(var_30_5) then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7

				if arg_27_1.var_.characterEffect1184ui_story and not isNil(var_30_5) then
					local var_30_9 = Mathf.Lerp(0, 0.5, var_30_8)

					arg_27_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1184ui_story.fillRatio = var_30_9
				end
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1184ui_story then
				local var_30_10 = 0.5

				arg_27_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1184ui_story.fillRatio = var_30_10
			end

			local var_30_11 = 0
			local var_30_12 = 0.1

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_13 = arg_27_1:FormatText(StoryNameCfg[451].name)

				arg_27_1.leftNameTxt_.text = var_30_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_14 = arg_27_1:GetWordFromCfg(122143007)
				local var_30_15 = arg_27_1:FormatText(var_30_14.content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_16 = 4
				local var_30_17 = utf8.len(var_30_15)
				local var_30_18 = var_30_16 <= 0 and var_30_12 or var_30_12 * (var_30_17 / var_30_16)

				if var_30_18 > 0 and var_30_12 < var_30_18 then
					arg_27_1.talkMaxDuration = var_30_18

					if var_30_18 + var_30_11 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_18 + var_30_11
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143007", "story_v_out_122143.awb") ~= 0 then
					local var_30_19 = manager.audio:GetVoiceLength("story_v_out_122143", "122143007", "story_v_out_122143.awb") / 1000

					if var_30_19 + var_30_11 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_11
					end

					if var_30_14.prefab_name ~= "" and arg_27_1.actors_[var_30_14.prefab_name] ~= nil then
						local var_30_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_14.prefab_name].transform, "story_v_out_122143", "122143007", "story_v_out_122143.awb")

						arg_27_1:RecordAudio("122143007", var_30_20)
						arg_27_1:RecordAudio("122143007", var_30_20)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122143", "122143007", "story_v_out_122143.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122143", "122143007", "story_v_out_122143.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_21 = math.max(var_30_12, arg_27_1.talkMaxDuration)

			if var_30_11 <= arg_27_1.time_ and arg_27_1.time_ < var_30_11 + var_30_21 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_11) / var_30_21

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_11 + var_30_21 and arg_27_1.time_ < var_30_11 + var_30_21 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play122143008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122143008
		arg_31_1.duration_ = 1

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play122143009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1184ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1184ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1184ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1084ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0, 100, 0)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, var_34_13, var_34_12)

				local var_34_14 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_14.x, var_34_14.y, var_34_14.z)

				local var_34_15 = var_34_9.localEulerAngles

				var_34_15.z = 0
				var_34_15.x = 0
				var_34_9.localEulerAngles = var_34_15
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				var_34_9.localPosition = Vector3.New(0, 100, 0)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_9.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_9.localEulerAngles = var_34_17
			end

			local var_34_18 = 0

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1.fswbg_:SetActive(true)
				arg_31_1.dialog_:SetActive(false)

				arg_31_1.fswtw_.percent = 0

				local var_34_19 = arg_31_1:GetWordFromCfg(122143008)
				local var_34_20 = arg_31_1:FormatText(var_34_19.content)

				arg_31_1.fswt_.text = var_34_20

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.fswt_)

				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_31_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_31_1.fswtw_:SetDirty()

				arg_31_1.typewritterCharCountI18N = 0

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_21 = 0

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				SetActive(arg_31_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_31_1:ShowNextGo(false)
			end

			local var_34_22 = 10
			local var_34_23 = 0.666666666666667
			local var_34_24 = arg_31_1:GetWordFromCfg(122143008)
			local var_34_25 = arg_31_1:FormatText(var_34_24.content)
			local var_34_26, var_34_27 = arg_31_1:GetPercentByPara(var_34_25, 1)

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_28 = var_34_22 <= 0 and var_34_23 or var_34_23 * ((var_34_27 - arg_31_1.typewritterCharCountI18N) / var_34_22)

				if var_34_28 > 0 and var_34_23 < var_34_28 then
					arg_31_1.talkMaxDuration = var_34_28

					if var_34_28 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_28 + var_34_21
					end
				end
			end

			local var_34_29 = 0.666666666666667
			local var_34_30 = math.max(var_34_29, arg_31_1.talkMaxDuration)

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_30 then
				local var_34_31 = (arg_31_1.time_ - var_34_21) / var_34_30

				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_26, var_34_31)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= var_34_21 + var_34_30 and arg_31_1.time_ < var_34_21 + var_34_30 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_26

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_27
			end

			local var_34_32 = 0

			if var_34_32 < arg_31_1.time_ and arg_31_1.time_ <= var_34_32 + arg_34_0 then
				local var_34_33 = arg_31_1.fswbg_.transform:Find("textbox/adapt/content") or arg_31_1.fswbg_.transform:Find("textbox/content")
				local var_34_34 = arg_31_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_34_35 = var_34_33:GetComponent("Text")
				local var_34_36 = var_34_33:GetComponent("RectTransform")

				var_34_35.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_34_36.offsetMin = Vector2.New(0, 0)
				var_34_36.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play122143009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122143009
		arg_35_1.duration_ = 6.5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play122143010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.fswbg_:SetActive(false)
				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_2 = 1.5

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Color.New(1, 1, 1)

				var_38_4.a = Mathf.Lerp(1, 0, var_38_3)
				arg_35_1.mask_.color = var_38_4
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				local var_38_5 = Color.New(1, 1, 1)
				local var_38_6 = 0

				arg_35_1.mask_.enabled = false
				var_38_5.a = var_38_6
				arg_35_1.mask_.color = var_38_5
			end

			local var_38_7 = manager.ui.mainCamera.transform
			local var_38_8 = 0.833333333333333

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_7.localPosition
			end

			local var_38_9 = 1.5

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_9 then
				local var_38_10 = (arg_35_1.time_ - var_38_8) / 0.066
				local var_38_11, var_38_12 = math.modf(var_38_10)

				var_38_7.localPosition = Vector3.New(var_38_12 * 0.13, var_38_12 * 0.13, var_38_12 * 0.13) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= var_38_8 + var_38_9 and arg_35_1.time_ < var_38_8 + var_38_9 + arg_38_0 then
				var_38_7.localPosition = arg_35_1.var_.shakeOldPos
			end

			local var_38_13 = 1.5

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			local var_38_14 = 0.833333333333333

			if arg_35_1.time_ >= var_38_13 + var_38_14 and arg_35_1.time_ < var_38_13 + var_38_14 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			local var_38_15 = 0
			local var_38_16 = 1

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				local var_38_17 = "play"
				local var_38_18 = "effect"

				arg_35_1:AudioAction(var_38_17, var_38_18, "se_story_122_02", "se_story_122_02_hit", "")
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_19 = 1.5
			local var_38_20 = 1.15

			if var_38_19 < arg_35_1.time_ and arg_35_1.time_ <= var_38_19 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_21 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_21:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_22 = arg_35_1:GetWordFromCfg(122143009)
				local var_38_23 = arg_35_1:FormatText(var_38_22.content)

				arg_35_1.text_.text = var_38_23

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_24 = 46
				local var_38_25 = utf8.len(var_38_23)
				local var_38_26 = var_38_24 <= 0 and var_38_20 or var_38_20 * (var_38_25 / var_38_24)

				if var_38_26 > 0 and var_38_20 < var_38_26 then
					arg_35_1.talkMaxDuration = var_38_26
					var_38_19 = var_38_19 + 0.3

					if var_38_26 + var_38_19 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_26 + var_38_19
					end
				end

				arg_35_1.text_.text = var_38_23
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_27 = var_38_19 + 0.3
			local var_38_28 = math.max(var_38_20, arg_35_1.talkMaxDuration)

			if var_38_27 <= arg_35_1.time_ and arg_35_1.time_ < var_38_27 + var_38_28 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_27) / var_38_28

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_27 + var_38_28 and arg_35_1.time_ < var_38_27 + var_38_28 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play122143010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122143010
		arg_41_1.duration_ = 1.1

		local var_41_0 = {
			ja = 1.1,
			ko = 1,
			zh = 1
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
				arg_41_0:Play122143011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.075

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(122143010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 3
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143010", "story_v_out_122143.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_122143", "122143010", "story_v_out_122143.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_122143", "122143010", "story_v_out_122143.awb")

						arg_41_1:RecordAudio("122143010", var_44_9)
						arg_41_1:RecordAudio("122143010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122143", "122143010", "story_v_out_122143.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122143", "122143010", "story_v_out_122143.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play122143011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122143011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122143012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 1.1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(122143011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 44
				local var_48_5 = utf8.len(var_48_3)
				local var_48_6 = var_48_4 <= 0 and var_48_1 or var_48_1 * (var_48_5 / var_48_4)

				if var_48_6 > 0 and var_48_1 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_7 and arg_45_1.time_ < var_48_0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122143012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122143012
		arg_49_1.duration_ = 8.93

		local var_49_0 = {
			ja = 8.933,
			ko = 6.333,
			zh = 6.333
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
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122143013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1184ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1184ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.7, -0.97, -6)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1184ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1184ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1184ui_story == nil then
				arg_49_1.var_.characterEffect1184ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1184ui_story and not isNil(var_52_9) then
					local var_52_13 = Mathf.Lerp(0, 0.5, var_52_12)

					arg_49_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1184ui_story.fillRatio = var_52_13
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1184ui_story then
				local var_52_14 = 0.5

				arg_49_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1184ui_story.fillRatio = var_52_14
			end

			local var_52_15 = arg_49_1.actors_["1084ui_story"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos1084ui_story = var_52_15.localPosition
			end

			local var_52_17 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Vector3.New(0.7, -0.97, -6)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1084ui_story, var_52_19, var_52_18)

				local var_52_20 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_20.x, var_52_20.y, var_52_20.z)

				local var_52_21 = var_52_15.localEulerAngles

				var_52_21.z = 0
				var_52_21.x = 0
				var_52_15.localEulerAngles = var_52_21
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_52_22 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_22.x, var_52_22.y, var_52_22.z)

				local var_52_23 = var_52_15.localEulerAngles

				var_52_23.z = 0
				var_52_23.x = 0
				var_52_15.localEulerAngles = var_52_23
			end

			local var_52_24 = arg_49_1.actors_["1084ui_story"]
			local var_52_25 = 0

			if var_52_25 < arg_49_1.time_ and arg_49_1.time_ <= var_52_25 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_26 = 0.200000002980232

			if var_52_25 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 and not isNil(var_52_24) then
				local var_52_27 = (arg_49_1.time_ - var_52_25) / var_52_26

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_24) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 and not isNil(var_52_24) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_52_28 = 0

			if var_52_28 < arg_49_1.time_ and arg_49_1.time_ <= var_52_28 + arg_52_0 then
				arg_49_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_52_29 = 0

			if var_52_29 < arg_49_1.time_ and arg_49_1.time_ <= var_52_29 + arg_52_0 then
				arg_49_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_52_30 = 0

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			local var_52_31 = 0

			if var_52_31 < arg_49_1.time_ and arg_49_1.time_ <= var_52_31 + arg_52_0 then
				arg_49_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_52_32 = 0
			local var_52_33 = 0.725

			if var_52_32 < arg_49_1.time_ and arg_49_1.time_ <= var_52_32 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_34 = arg_49_1:FormatText(StoryNameCfg[451].name)

				arg_49_1.leftNameTxt_.text = var_52_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_35 = arg_49_1:GetWordFromCfg(122143012)
				local var_52_36 = arg_49_1:FormatText(var_52_35.content)

				arg_49_1.text_.text = var_52_36

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_37 = 29
				local var_52_38 = utf8.len(var_52_36)
				local var_52_39 = var_52_37 <= 0 and var_52_33 or var_52_33 * (var_52_38 / var_52_37)

				if var_52_39 > 0 and var_52_33 < var_52_39 then
					arg_49_1.talkMaxDuration = var_52_39

					if var_52_39 + var_52_32 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_39 + var_52_32
					end
				end

				arg_49_1.text_.text = var_52_36
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143012", "story_v_out_122143.awb") ~= 0 then
					local var_52_40 = manager.audio:GetVoiceLength("story_v_out_122143", "122143012", "story_v_out_122143.awb") / 1000

					if var_52_40 + var_52_32 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_40 + var_52_32
					end

					if var_52_35.prefab_name ~= "" and arg_49_1.actors_[var_52_35.prefab_name] ~= nil then
						local var_52_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_35.prefab_name].transform, "story_v_out_122143", "122143012", "story_v_out_122143.awb")

						arg_49_1:RecordAudio("122143012", var_52_41)
						arg_49_1:RecordAudio("122143012", var_52_41)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122143", "122143012", "story_v_out_122143.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122143", "122143012", "story_v_out_122143.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_42 = math.max(var_52_33, arg_49_1.talkMaxDuration)

			if var_52_32 <= arg_49_1.time_ and arg_49_1.time_ < var_52_32 + var_52_42 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_32) / var_52_42

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_32 + var_52_42 and arg_49_1.time_ < var_52_32 + var_52_42 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play122143013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122143013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122143014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1184ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1184ui_story == nil then
				arg_53_1.var_.characterEffect1184ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1184ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1184ui_story then
				arg_53_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_56_5 = arg_53_1.actors_["1084ui_story"]
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_7 = 0.200000002980232

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_7 and not isNil(var_56_5) then
				local var_56_8 = (arg_53_1.time_ - var_56_6) / var_56_7

				if arg_53_1.var_.characterEffect1084ui_story and not isNil(var_56_5) then
					local var_56_9 = Mathf.Lerp(0, 0.5, var_56_8)

					arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1084ui_story.fillRatio = var_56_9
				end
			end

			if arg_53_1.time_ >= var_56_6 + var_56_7 and arg_53_1.time_ < var_56_6 + var_56_7 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1084ui_story then
				local var_56_10 = 0.5

				arg_53_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1084ui_story.fillRatio = var_56_10
			end

			local var_56_11 = 0
			local var_56_12 = 0.05

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(122143013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 2
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143013", "story_v_out_122143.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_122143", "122143013", "story_v_out_122143.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_122143", "122143013", "story_v_out_122143.awb")

						arg_53_1:RecordAudio("122143013", var_56_20)
						arg_53_1:RecordAudio("122143013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122143", "122143013", "story_v_out_122143.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122143", "122143013", "story_v_out_122143.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122143014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122143014
		arg_57_1.duration_ = 12.9

		local var_57_0 = {
			ja = 12.9,
			ko = 7.8,
			zh = 7.8
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122143015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1084ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1184ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1184ui_story == nil then
				arg_57_1.var_.characterEffect1184ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect1184ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1184ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1184ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1184ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0
			local var_60_11 = 0.875

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_12 = arg_57_1:FormatText(StoryNameCfg[451].name)

				arg_57_1.leftNameTxt_.text = var_60_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_13 = arg_57_1:GetWordFromCfg(122143014)
				local var_60_14 = arg_57_1:FormatText(var_60_13.content)

				arg_57_1.text_.text = var_60_14

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_15 = 35
				local var_60_16 = utf8.len(var_60_14)
				local var_60_17 = var_60_15 <= 0 and var_60_11 or var_60_11 * (var_60_16 / var_60_15)

				if var_60_17 > 0 and var_60_11 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17

					if var_60_17 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_10
					end
				end

				arg_57_1.text_.text = var_60_14
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143014", "story_v_out_122143.awb") ~= 0 then
					local var_60_18 = manager.audio:GetVoiceLength("story_v_out_122143", "122143014", "story_v_out_122143.awb") / 1000

					if var_60_18 + var_60_10 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_18 + var_60_10
					end

					if var_60_13.prefab_name ~= "" and arg_57_1.actors_[var_60_13.prefab_name] ~= nil then
						local var_60_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_13.prefab_name].transform, "story_v_out_122143", "122143014", "story_v_out_122143.awb")

						arg_57_1:RecordAudio("122143014", var_60_19)
						arg_57_1:RecordAudio("122143014", var_60_19)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122143", "122143014", "story_v_out_122143.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122143", "122143014", "story_v_out_122143.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_20 = math.max(var_60_11, arg_57_1.talkMaxDuration)

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_10) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_10 + var_60_20 and arg_57_1.time_ < var_60_10 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122143015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122143015
		arg_61_1.duration_ = 11.2

		local var_61_0 = {
			ja = 11.2,
			ko = 8.566,
			zh = 8.566
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122143016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.95

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[451].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(122143015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 38
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143015", "story_v_out_122143.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_122143", "122143015", "story_v_out_122143.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_122143", "122143015", "story_v_out_122143.awb")

						arg_61_1:RecordAudio("122143015", var_64_9)
						arg_61_1:RecordAudio("122143015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122143", "122143015", "story_v_out_122143.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122143", "122143015", "story_v_out_122143.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122143016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122143016
		arg_65_1.duration_ = 4.33

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122143017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1084ui_story"].transform
			local var_68_1 = 1.966

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1084ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1084ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1184ui_story"].transform
			local var_68_10 = 1.966

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.var_.moveOldPos1184ui_story = var_68_9.localPosition
			end

			local var_68_11 = 0.001

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11
				local var_68_13 = Vector3.New(0, 100, 0)

				var_68_9.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1184ui_story, var_68_13, var_68_12)

				local var_68_14 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_14.x, var_68_14.y, var_68_14.z)

				local var_68_15 = var_68_9.localEulerAngles

				var_68_15.z = 0
				var_68_15.x = 0
				var_68_9.localEulerAngles = var_68_15
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 then
				var_68_9.localPosition = Vector3.New(0, 100, 0)

				local var_68_16 = manager.ui.mainCamera.transform.position - var_68_9.position

				var_68_9.forward = Vector3.New(var_68_16.x, var_68_16.y, var_68_16.z)

				local var_68_17 = var_68_9.localEulerAngles

				var_68_17.z = 0
				var_68_17.x = 0
				var_68_9.localEulerAngles = var_68_17
			end

			local var_68_18 = 2.13333333333333

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1.fswbg_:SetActive(true)
				arg_65_1.dialog_:SetActive(false)

				arg_65_1.fswtw_.percent = 0

				local var_68_19 = arg_65_1:GetWordFromCfg(122143016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.fswt_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.fswt_)

				arg_65_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_65_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_65_1.fswtw_:SetDirty()

				arg_65_1.typewritterCharCountI18N = 0

				SetActive(arg_65_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_65_1:ShowNextGo(false)
			end

			local var_68_21 = 2.13333333333333

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.var_.oldValueTypewriter = arg_65_1.fswtw_.percent

				SetActive(arg_65_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_65_1:ShowNextGo(false)
			end

			local var_68_22 = 10
			local var_68_23 = 0.666666666666667
			local var_68_24 = arg_65_1:GetWordFromCfg(122143016)
			local var_68_25 = arg_65_1:FormatText(var_68_24.content)
			local var_68_26, var_68_27 = arg_65_1:GetPercentByPara(var_68_25, 1)

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				local var_68_28 = var_68_22 <= 0 and var_68_23 or var_68_23 * ((var_68_27 - arg_65_1.typewritterCharCountI18N) / var_68_22)

				if var_68_28 > 0 and var_68_23 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_21
					end
				end
			end

			local var_68_29 = 0.666666666666667
			local var_68_30 = math.max(var_68_29, arg_65_1.talkMaxDuration)

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_30 then
				local var_68_31 = (arg_65_1.time_ - var_68_21) / var_68_30

				arg_65_1.fswtw_.percent = Mathf.Lerp(arg_65_1.var_.oldValueTypewriter, var_68_26, var_68_31)
				arg_65_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_65_1.fswtw_:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_30 and arg_65_1.time_ < var_68_21 + var_68_30 + arg_68_0 then
				arg_65_1.fswtw_.percent = var_68_26

				arg_65_1.fswtw_:SetDirty()
				arg_65_1:ShowNextGo(true)

				arg_65_1.typewritterCharCountI18N = var_68_27
			end

			local var_68_32 = 0

			if var_68_32 < arg_65_1.time_ and arg_65_1.time_ <= var_68_32 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_33 = 2

			if var_68_32 <= arg_65_1.time_ and arg_65_1.time_ < var_68_32 + var_68_33 then
				local var_68_34 = (arg_65_1.time_ - var_68_32) / var_68_33
				local var_68_35 = Color.New(0, 0, 0)

				var_68_35.a = Mathf.Lerp(0, 1, var_68_34)
				arg_65_1.mask_.color = var_68_35
			end

			if arg_65_1.time_ >= var_68_32 + var_68_33 and arg_65_1.time_ < var_68_32 + var_68_33 + arg_68_0 then
				local var_68_36 = Color.New(0, 0, 0)

				var_68_36.a = 1
				arg_65_1.mask_.color = var_68_36
			end

			local var_68_37 = 2.01666666666667

			if var_68_37 < arg_65_1.time_ and arg_65_1.time_ <= var_68_37 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_38 = 2

			if var_68_37 <= arg_65_1.time_ and arg_65_1.time_ < var_68_37 + var_68_38 then
				local var_68_39 = (arg_65_1.time_ - var_68_37) / var_68_38
				local var_68_40 = Color.New(0, 0, 0)

				var_68_40.a = Mathf.Lerp(1, 0, var_68_39)
				arg_65_1.mask_.color = var_68_40
			end

			if arg_65_1.time_ >= var_68_37 + var_68_38 and arg_65_1.time_ < var_68_37 + var_68_38 + arg_68_0 then
				local var_68_41 = Color.New(0, 0, 0)
				local var_68_42 = 0

				arg_65_1.mask_.enabled = false
				var_68_41.a = var_68_42
				arg_65_1.mask_.color = var_68_41
			end

			local var_68_43 = 2.15
			local var_68_44 = 1
			local var_68_45 = manager.audio:GetVoiceLength("story_v_out_122143", "122143016", "story_v_out_122143") / 1000

			if var_68_45 > 0 and var_68_44 < var_68_45 and var_68_45 + var_68_43 > arg_65_1.duration_ then
				local var_68_46 = var_68_45

				arg_65_1.duration_ = var_68_45 + var_68_43
			end

			if var_68_43 < arg_65_1.time_ and arg_65_1.time_ <= var_68_43 + arg_68_0 then
				local var_68_47 = "play"
				local var_68_48 = "voice"

				arg_65_1:AudioAction(var_68_47, var_68_48, "story_v_out_122143", "122143016", "story_v_out_122143")
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play122143017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122143017
		arg_69_1.duration_ = 2.37

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122143018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.fswbg_:SetActive(true)
				arg_69_1.dialog_:SetActive(false)

				arg_69_1.fswtw_.percent = 0

				local var_72_1 = arg_69_1:GetWordFromCfg(122143017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.fswt_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.fswt_)

				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_69_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_69_1.fswtw_:SetDirty()

				arg_69_1.typewritterCharCountI18N = 0

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_3 = 0.0166666666666666

			if var_72_3 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.var_.oldValueTypewriter = arg_69_1.fswtw_.percent

				SetActive(arg_69_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_69_1:ShowNextGo(false)
			end

			local var_72_4 = 28
			local var_72_5 = 1.86666666666667
			local var_72_6 = arg_69_1:GetWordFromCfg(122143017)
			local var_72_7 = arg_69_1:FormatText(var_72_6.content)
			local var_72_8, var_72_9 = arg_69_1:GetPercentByPara(var_72_7, 1)

			if var_72_3 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				local var_72_10 = var_72_4 <= 0 and var_72_5 or var_72_5 * ((var_72_9 - arg_69_1.typewritterCharCountI18N) / var_72_4)

				if var_72_10 > 0 and var_72_5 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_3
					end
				end
			end

			local var_72_11 = 1.86666666666667
			local var_72_12 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_3) / var_72_12

				arg_69_1.fswtw_.percent = Mathf.Lerp(arg_69_1.var_.oldValueTypewriter, var_72_8, var_72_13)
				arg_69_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_69_1.fswtw_:SetDirty()
			end

			if arg_69_1.time_ >= var_72_3 + var_72_12 and arg_69_1.time_ < var_72_3 + var_72_12 + arg_72_0 then
				arg_69_1.fswtw_.percent = var_72_8

				arg_69_1.fswtw_:SetDirty()
				arg_69_1:ShowNextGo(true)

				arg_69_1.typewritterCharCountI18N = var_72_9
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122143018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122143018
		arg_73_1.duration_ = 2.75

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play122143019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.fswbg_:SetActive(true)
				arg_73_1.dialog_:SetActive(false)

				arg_73_1.fswtw_.percent = 0

				local var_76_1 = arg_73_1:GetWordFromCfg(122143018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.fswt_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.fswt_)

				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_73_1.fswtw_:SetDirty()

				arg_73_1.typewritterCharCountI18N = 0

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_3 = 0.0166666666666667

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.var_.oldValueTypewriter = arg_73_1.fswtw_.percent

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_4 = 41
			local var_76_5 = 2.73333333333333
			local var_76_6 = arg_73_1:GetWordFromCfg(122143018)
			local var_76_7 = arg_73_1:FormatText(var_76_6.content)
			local var_76_8, var_76_9 = arg_73_1:GetPercentByPara(var_76_7, 1)

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				local var_76_10 = var_76_4 <= 0 and var_76_5 or var_76_5 * ((var_76_9 - arg_73_1.typewritterCharCountI18N) / var_76_4)

				if var_76_10 > 0 and var_76_5 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_3
					end
				end
			end

			local var_76_11 = 2.73333333333333
			local var_76_12 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_3) / var_76_12

				arg_73_1.fswtw_.percent = Mathf.Lerp(arg_73_1.var_.oldValueTypewriter, var_76_8, var_76_13)
				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_73_1.fswtw_:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_12 and arg_73_1.time_ < var_76_3 + var_76_12 + arg_76_0 then
				arg_73_1.fswtw_.percent = var_76_8

				arg_73_1.fswtw_:SetDirty()
				arg_73_1:ShowNextGo(true)

				arg_73_1.typewritterCharCountI18N = var_76_9
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122143019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122143019
		arg_77_1.duration_ = 12.17

		local var_77_0 = {
			ja = 12.166,
			ko = 9.533,
			zh = 9.533
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play122143020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_1 = 2

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_1 then
				local var_80_2 = (arg_77_1.time_ - var_80_0) / var_80_1
				local var_80_3 = Color.New(0, 0, 0)

				var_80_3.a = Mathf.Lerp(0, 1, var_80_2)
				arg_77_1.mask_.color = var_80_3
			end

			if arg_77_1.time_ >= var_80_0 + var_80_1 and arg_77_1.time_ < var_80_0 + var_80_1 + arg_80_0 then
				local var_80_4 = Color.New(0, 0, 0)

				var_80_4.a = 1
				arg_77_1.mask_.color = var_80_4
			end

			local var_80_5 = 2

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_6 = 2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6
				local var_80_8 = Color.New(0, 0, 0)

				var_80_8.a = Mathf.Lerp(1, 0, var_80_7)
				arg_77_1.mask_.color = var_80_8
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 then
				local var_80_9 = Color.New(0, 0, 0)
				local var_80_10 = 0

				arg_77_1.mask_.enabled = false
				var_80_9.a = var_80_10
				arg_77_1.mask_.color = var_80_9
			end

			local var_80_11 = 1.98333333333333

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(false)
				arg_77_1.dialog_:SetActive(false)
				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_12 = arg_77_1.actors_["1084ui_story"].transform
			local var_80_13 = 3.8

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1.var_.moveOldPos1084ui_story = var_80_12.localPosition
			end

			local var_80_14 = 0.001

			if var_80_13 <= arg_77_1.time_ and arg_77_1.time_ < var_80_13 + var_80_14 then
				local var_80_15 = (arg_77_1.time_ - var_80_13) / var_80_14
				local var_80_16 = Vector3.New(0, -0.97, -6)

				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1084ui_story, var_80_16, var_80_15)

				local var_80_17 = manager.ui.mainCamera.transform.position - var_80_12.position

				var_80_12.forward = Vector3.New(var_80_17.x, var_80_17.y, var_80_17.z)

				local var_80_18 = var_80_12.localEulerAngles

				var_80_18.z = 0
				var_80_18.x = 0
				var_80_12.localEulerAngles = var_80_18
			end

			if arg_77_1.time_ >= var_80_13 + var_80_14 and arg_77_1.time_ < var_80_13 + var_80_14 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(0, -0.97, -6)

				local var_80_19 = manager.ui.mainCamera.transform.position - var_80_12.position

				var_80_12.forward = Vector3.New(var_80_19.x, var_80_19.y, var_80_19.z)

				local var_80_20 = var_80_12.localEulerAngles

				var_80_20.z = 0
				var_80_20.x = 0
				var_80_12.localEulerAngles = var_80_20
			end

			local var_80_21 = arg_77_1.actors_["1084ui_story"]
			local var_80_22 = 3.8

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 and not isNil(var_80_21) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_23 = 0.200000002980232

			if var_80_22 <= arg_77_1.time_ and arg_77_1.time_ < var_80_22 + var_80_23 and not isNil(var_80_21) then
				local var_80_24 = (arg_77_1.time_ - var_80_22) / var_80_23

				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_21) then
					arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_22 + var_80_23 and arg_77_1.time_ < var_80_22 + var_80_23 + arg_80_0 and not isNil(var_80_21) and arg_77_1.var_.characterEffect1084ui_story then
				arg_77_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_80_25 = 3.8

			if var_80_25 < arg_77_1.time_ and arg_77_1.time_ <= var_80_25 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_80_26 = 3.8

			if var_80_26 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_27 = 4
			local var_80_28 = 0.675

			if var_80_27 < arg_77_1.time_ and arg_77_1.time_ <= var_80_27 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_29 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_29:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_30 = arg_77_1:FormatText(StoryNameCfg[451].name)

				arg_77_1.leftNameTxt_.text = var_80_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_31 = arg_77_1:GetWordFromCfg(122143019)
				local var_80_32 = arg_77_1:FormatText(var_80_31.content)

				arg_77_1.text_.text = var_80_32

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_33 = 27
				local var_80_34 = utf8.len(var_80_32)
				local var_80_35 = var_80_33 <= 0 and var_80_28 or var_80_28 * (var_80_34 / var_80_33)

				if var_80_35 > 0 and var_80_28 < var_80_35 then
					arg_77_1.talkMaxDuration = var_80_35
					var_80_27 = var_80_27 + 0.3

					if var_80_35 + var_80_27 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_35 + var_80_27
					end
				end

				arg_77_1.text_.text = var_80_32
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143019", "story_v_out_122143.awb") ~= 0 then
					local var_80_36 = manager.audio:GetVoiceLength("story_v_out_122143", "122143019", "story_v_out_122143.awb") / 1000

					if var_80_36 + var_80_27 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_36 + var_80_27
					end

					if var_80_31.prefab_name ~= "" and arg_77_1.actors_[var_80_31.prefab_name] ~= nil then
						local var_80_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_31.prefab_name].transform, "story_v_out_122143", "122143019", "story_v_out_122143.awb")

						arg_77_1:RecordAudio("122143019", var_80_37)
						arg_77_1:RecordAudio("122143019", var_80_37)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122143", "122143019", "story_v_out_122143.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122143", "122143019", "story_v_out_122143.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_38 = var_80_27 + 0.3
			local var_80_39 = math.max(var_80_28, arg_77_1.talkMaxDuration)

			if var_80_38 <= arg_77_1.time_ and arg_77_1.time_ < var_80_38 + var_80_39 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_38) / var_80_39

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_38 + var_80_39 and arg_77_1.time_ < var_80_38 + var_80_39 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play122143020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122143020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122143021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1084ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1084ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1084ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = 0
			local var_86_10 = 1.125

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_11 = arg_83_1:GetWordFromCfg(122143020)
				local var_86_12 = arg_83_1:FormatText(var_86_11.content)

				arg_83_1.text_.text = var_86_12

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 45
				local var_86_14 = utf8.len(var_86_12)
				local var_86_15 = var_86_13 <= 0 and var_86_10 or var_86_10 * (var_86_14 / var_86_13)

				if var_86_15 > 0 and var_86_10 < var_86_15 then
					arg_83_1.talkMaxDuration = var_86_15

					if var_86_15 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_15 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_12
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_9) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_9 + var_86_16 and arg_83_1.time_ < var_86_9 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play122143021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122143021
		arg_87_1.duration_ = 6.5

		local var_87_0 = {
			ja = 6.5,
			ko = 5.866,
			zh = 5.866
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
				arg_87_0:Play122143022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1084ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1084ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, -0.97, -6)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1084ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1084ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_9) then
					arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1084ui_story then
				arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_90_14 = 0
			local var_90_15 = 0.475

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_16 = arg_87_1:FormatText(StoryNameCfg[451].name)

				arg_87_1.leftNameTxt_.text = var_90_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_17 = arg_87_1:GetWordFromCfg(122143021)
				local var_90_18 = arg_87_1:FormatText(var_90_17.content)

				arg_87_1.text_.text = var_90_18

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_19 = 19
				local var_90_20 = utf8.len(var_90_18)
				local var_90_21 = var_90_19 <= 0 and var_90_15 or var_90_15 * (var_90_20 / var_90_19)

				if var_90_21 > 0 and var_90_15 < var_90_21 then
					arg_87_1.talkMaxDuration = var_90_21

					if var_90_21 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_21 + var_90_14
					end
				end

				arg_87_1.text_.text = var_90_18
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143021", "story_v_out_122143.awb") ~= 0 then
					local var_90_22 = manager.audio:GetVoiceLength("story_v_out_122143", "122143021", "story_v_out_122143.awb") / 1000

					if var_90_22 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_14
					end

					if var_90_17.prefab_name ~= "" and arg_87_1.actors_[var_90_17.prefab_name] ~= nil then
						local var_90_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_17.prefab_name].transform, "story_v_out_122143", "122143021", "story_v_out_122143.awb")

						arg_87_1:RecordAudio("122143021", var_90_23)
						arg_87_1:RecordAudio("122143021", var_90_23)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_122143", "122143021", "story_v_out_122143.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_122143", "122143021", "story_v_out_122143.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_24 = math.max(var_90_15, arg_87_1.talkMaxDuration)

			if var_90_14 <= arg_87_1.time_ and arg_87_1.time_ < var_90_14 + var_90_24 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_14) / var_90_24

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_14 + var_90_24 and arg_87_1.time_ < var_90_14 + var_90_24 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play122143022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122143022
		arg_91_1.duration_ = 6.03

		local var_91_0 = {
			ja = 6.033,
			ko = 5.6,
			zh = 5.6
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
			arg_91_1.auto_ = false
		end

		function arg_91_1.playNext_(arg_93_0)
			arg_91_1.onStoryFinished_()
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.675

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[451].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(122143022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_122143", "122143022", "story_v_out_122143.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_122143", "122143022", "story_v_out_122143.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_122143", "122143022", "story_v_out_122143.awb")

						arg_91_1:RecordAudio("122143022", var_94_9)
						arg_91_1:RecordAudio("122143022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_122143", "122143022", "story_v_out_122143.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_122143", "122143022", "story_v_out_122143.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	assets = {},
	voices = {
		"story_v_out_122143.awb"
	}
}
