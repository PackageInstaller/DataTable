return {
	Play910116001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910116001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910116002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST47"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST47

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST47" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 1.05

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(910116001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 42
				local var_4_28 = utf8.len(var_4_26)
				local var_4_29 = var_4_27 <= 0 and var_4_23 or var_4_23 * (var_4_28 / var_4_27)

				if var_4_29 > 0 and var_4_23 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_22 = var_4_22 + 0.3

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_22 + 0.3
			local var_4_31 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play910116002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910116002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910116003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.775

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

				local var_10_2 = arg_7_1:GetWordFromCfg(910116002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 31
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
	Play910116003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910116003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910116004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1060ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "1060ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1060ui_story"), arg_11_1.stage_.transform)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

					var_14_3.enabled = true

					local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

					if var_14_4 then
						var_14_4:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_3.transform, false)

					arg_11_1.var_[var_14_0 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_0 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_0 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_5 = arg_11_1.actors_["1060ui_story"].transform
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.var_.moveOldPos1060ui_story = var_14_5.localPosition
			end

			local var_14_7 = 0.001

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7
				local var_14_9 = Vector3.New(-0.7, -1.14, -6.33)

				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1060ui_story, var_14_9, var_14_8)

				local var_14_10 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_10.x, var_14_10.y, var_14_10.z)

				local var_14_11 = var_14_5.localEulerAngles

				var_14_11.z = 0
				var_14_11.x = 0
				var_14_5.localEulerAngles = var_14_11
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(-0.7, -1.14, -6.33)

				local var_14_12 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_12.x, var_14_12.y, var_14_12.z)

				local var_14_13 = var_14_5.localEulerAngles

				var_14_13.z = 0
				var_14_13.x = 0
				var_14_5.localEulerAngles = var_14_13
			end

			local var_14_14 = arg_11_1.actors_["1060ui_story"]
			local var_14_15 = 0

			if var_14_15 < arg_11_1.time_ and arg_11_1.time_ <= var_14_15 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1060ui_story == nil then
				arg_11_1.var_.characterEffect1060ui_story = var_14_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_16 = 0.200000002980232

			if var_14_15 <= arg_11_1.time_ and arg_11_1.time_ < var_14_15 + var_14_16 and not isNil(var_14_14) then
				local var_14_17 = (arg_11_1.time_ - var_14_15) / var_14_16

				if arg_11_1.var_.characterEffect1060ui_story and not isNil(var_14_14) then
					arg_11_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_15 + var_14_16 and arg_11_1.time_ < var_14_15 + var_14_16 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1060ui_story then
				arg_11_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_14_18 = 0

			if var_14_18 < arg_11_1.time_ and arg_11_1.time_ <= var_14_18 + arg_14_0 then
				arg_11_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action2_1")
			end

			local var_14_19 = 0

			if var_14_19 < arg_11_1.time_ and arg_11_1.time_ <= var_14_19 + arg_14_0 then
				arg_11_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_14_20 = "1070ui_story"

			if arg_11_1.actors_[var_14_20] == nil then
				local var_14_21 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_14_21) then
					local var_14_22 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_11_1.stage_.transform)

					var_14_22.name = var_14_20
					var_14_22.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_20] = var_14_22

					local var_14_23 = var_14_22:GetComponentInChildren(typeof(CharacterEffect))

					var_14_23.enabled = true

					local var_14_24 = GameObjectTools.GetOrAddComponent(var_14_22, typeof(DynamicBoneHelper))

					if var_14_24 then
						var_14_24:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_23.transform, false)

					arg_11_1.var_[var_14_20 .. "Animator"] = var_14_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_20 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_20 .. "LipSync"] = var_14_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_25 = arg_11_1.actors_["1070ui_story"].transform
			local var_14_26 = 0

			if var_14_26 < arg_11_1.time_ and arg_11_1.time_ <= var_14_26 + arg_14_0 then
				arg_11_1.var_.moveOldPos1070ui_story = var_14_25.localPosition
			end

			local var_14_27 = 0.001

			if var_14_26 <= arg_11_1.time_ and arg_11_1.time_ < var_14_26 + var_14_27 then
				local var_14_28 = (arg_11_1.time_ - var_14_26) / var_14_27
				local var_14_29 = Vector3.New(0.7, -0.95, -6.05)

				var_14_25.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1070ui_story, var_14_29, var_14_28)

				local var_14_30 = manager.ui.mainCamera.transform.position - var_14_25.position

				var_14_25.forward = Vector3.New(var_14_30.x, var_14_30.y, var_14_30.z)

				local var_14_31 = var_14_25.localEulerAngles

				var_14_31.z = 0
				var_14_31.x = 0
				var_14_25.localEulerAngles = var_14_31
			end

			if arg_11_1.time_ >= var_14_26 + var_14_27 and arg_11_1.time_ < var_14_26 + var_14_27 + arg_14_0 then
				var_14_25.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_14_32 = manager.ui.mainCamera.transform.position - var_14_25.position

				var_14_25.forward = Vector3.New(var_14_32.x, var_14_32.y, var_14_32.z)

				local var_14_33 = var_14_25.localEulerAngles

				var_14_33.z = 0
				var_14_33.x = 0
				var_14_25.localEulerAngles = var_14_33
			end

			local var_14_34 = arg_11_1.actors_["1070ui_story"]
			local var_14_35 = 0

			if var_14_35 < arg_11_1.time_ and arg_11_1.time_ <= var_14_35 + arg_14_0 and not isNil(var_14_34) and arg_11_1.var_.characterEffect1070ui_story == nil then
				arg_11_1.var_.characterEffect1070ui_story = var_14_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_36 = 0.200000002980232

			if var_14_35 <= arg_11_1.time_ and arg_11_1.time_ < var_14_35 + var_14_36 and not isNil(var_14_34) then
				local var_14_37 = (arg_11_1.time_ - var_14_35) / var_14_36

				if arg_11_1.var_.characterEffect1070ui_story and not isNil(var_14_34) then
					local var_14_38 = Mathf.Lerp(0, 0.5, var_14_37)

					arg_11_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1070ui_story.fillRatio = var_14_38
				end
			end

			if arg_11_1.time_ >= var_14_35 + var_14_36 and arg_11_1.time_ < var_14_35 + var_14_36 + arg_14_0 and not isNil(var_14_34) and arg_11_1.var_.characterEffect1070ui_story then
				local var_14_39 = 0.5

				arg_11_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1070ui_story.fillRatio = var_14_39
			end

			local var_14_40 = 0
			local var_14_41 = 0.65

			if var_14_40 < arg_11_1.time_ and arg_11_1.time_ <= var_14_40 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_42 = arg_11_1:FormatText(StoryNameCfg[584].name)

				arg_11_1.leftNameTxt_.text = var_14_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_43 = arg_11_1:GetWordFromCfg(910116003)
				local var_14_44 = arg_11_1:FormatText(var_14_43.content)

				arg_11_1.text_.text = var_14_44

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_45 = 26
				local var_14_46 = utf8.len(var_14_44)
				local var_14_47 = var_14_45 <= 0 and var_14_41 or var_14_41 * (var_14_46 / var_14_45)

				if var_14_47 > 0 and var_14_41 < var_14_47 then
					arg_11_1.talkMaxDuration = var_14_47

					if var_14_47 + var_14_40 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_47 + var_14_40
					end
				end

				arg_11_1.text_.text = var_14_44
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_48 = math.max(var_14_41, arg_11_1.talkMaxDuration)

			if var_14_40 <= arg_11_1.time_ and arg_11_1.time_ < var_14_40 + var_14_48 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_40) / var_14_48

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_40 + var_14_48 and arg_11_1.time_ < var_14_40 + var_14_48 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910116004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910116005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1070ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1070ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0.7, -0.95, -6.05)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1070ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = arg_15_1.actors_["1070ui_story"]
			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1070ui_story == nil then
				arg_15_1.var_.characterEffect1070ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.200000002980232

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 and not isNil(var_18_9) then
				local var_18_12 = (arg_15_1.time_ - var_18_10) / var_18_11

				if arg_15_1.var_.characterEffect1070ui_story and not isNil(var_18_9) then
					arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1070ui_story then
				arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_18_13 = 0

			if var_18_13 < arg_15_1.time_ and arg_15_1.time_ <= var_18_13 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_18_14 = 0

			if var_18_14 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_18_15 = arg_15_1.actors_["1060ui_story"]
			local var_18_16 = 0

			if var_18_16 < arg_15_1.time_ and arg_15_1.time_ <= var_18_16 + arg_18_0 and not isNil(var_18_15) and arg_15_1.var_.characterEffect1060ui_story == nil then
				arg_15_1.var_.characterEffect1060ui_story = var_18_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_17 = 0.200000002980232

			if var_18_16 <= arg_15_1.time_ and arg_15_1.time_ < var_18_16 + var_18_17 and not isNil(var_18_15) then
				local var_18_18 = (arg_15_1.time_ - var_18_16) / var_18_17

				if arg_15_1.var_.characterEffect1060ui_story and not isNil(var_18_15) then
					local var_18_19 = Mathf.Lerp(0, 0.5, var_18_18)

					arg_15_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1060ui_story.fillRatio = var_18_19
				end
			end

			if arg_15_1.time_ >= var_18_16 + var_18_17 and arg_15_1.time_ < var_18_16 + var_18_17 + arg_18_0 and not isNil(var_18_15) and arg_15_1.var_.characterEffect1060ui_story then
				local var_18_20 = 0.5

				arg_15_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1060ui_story.fillRatio = var_18_20
			end

			local var_18_21 = 0
			local var_18_22 = 0.5

			if var_18_21 < arg_15_1.time_ and arg_15_1.time_ <= var_18_21 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_23 = arg_15_1:FormatText(StoryNameCfg[318].name)

				arg_15_1.leftNameTxt_.text = var_18_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_24 = arg_15_1:GetWordFromCfg(910116004)
				local var_18_25 = arg_15_1:FormatText(var_18_24.content)

				arg_15_1.text_.text = var_18_25

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_26 = 20
				local var_18_27 = utf8.len(var_18_25)
				local var_18_28 = var_18_26 <= 0 and var_18_22 or var_18_22 * (var_18_27 / var_18_26)

				if var_18_28 > 0 and var_18_22 < var_18_28 then
					arg_15_1.talkMaxDuration = var_18_28

					if var_18_28 + var_18_21 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_28 + var_18_21
					end
				end

				arg_15_1.text_.text = var_18_25
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_29 = math.max(var_18_22, arg_15_1.talkMaxDuration)

			if var_18_21 <= arg_15_1.time_ and arg_15_1.time_ < var_18_21 + var_18_29 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_21) / var_18_29

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_21 + var_18_29 and arg_15_1.time_ < var_18_21 + var_18_29 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910116005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910116006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1074ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["1074ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos1074ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0, -1.055, -6.12)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1074ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["1074ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1074ui_story == nil then
				arg_19_1.var_.characterEffect1074ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.200000002980232

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect1074ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1074ui_story then
				arg_19_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 then
				arg_19_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_20 = arg_19_1.actors_["1060ui_story"].transform
			local var_22_21 = 0

			if var_22_21 < arg_19_1.time_ and arg_19_1.time_ <= var_22_21 + arg_22_0 then
				arg_19_1.var_.moveOldPos1060ui_story = var_22_20.localPosition
			end

			local var_22_22 = 0.001

			if var_22_21 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_22 then
				local var_22_23 = (arg_19_1.time_ - var_22_21) / var_22_22
				local var_22_24 = Vector3.New(0, 100, 0)

				var_22_20.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1060ui_story, var_22_24, var_22_23)

				local var_22_25 = manager.ui.mainCamera.transform.position - var_22_20.position

				var_22_20.forward = Vector3.New(var_22_25.x, var_22_25.y, var_22_25.z)

				local var_22_26 = var_22_20.localEulerAngles

				var_22_26.z = 0
				var_22_26.x = 0
				var_22_20.localEulerAngles = var_22_26
			end

			if arg_19_1.time_ >= var_22_21 + var_22_22 and arg_19_1.time_ < var_22_21 + var_22_22 + arg_22_0 then
				var_22_20.localPosition = Vector3.New(0, 100, 0)

				local var_22_27 = manager.ui.mainCamera.transform.position - var_22_20.position

				var_22_20.forward = Vector3.New(var_22_27.x, var_22_27.y, var_22_27.z)

				local var_22_28 = var_22_20.localEulerAngles

				var_22_28.z = 0
				var_22_28.x = 0
				var_22_20.localEulerAngles = var_22_28
			end

			local var_22_29 = arg_19_1.actors_["1060ui_story"]
			local var_22_30 = 0

			if var_22_30 < arg_19_1.time_ and arg_19_1.time_ <= var_22_30 + arg_22_0 and not isNil(var_22_29) and arg_19_1.var_.characterEffect1060ui_story == nil then
				arg_19_1.var_.characterEffect1060ui_story = var_22_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_31 = 0.200000002980232

			if var_22_30 <= arg_19_1.time_ and arg_19_1.time_ < var_22_30 + var_22_31 and not isNil(var_22_29) then
				local var_22_32 = (arg_19_1.time_ - var_22_30) / var_22_31

				if arg_19_1.var_.characterEffect1060ui_story and not isNil(var_22_29) then
					local var_22_33 = Mathf.Lerp(0, 0.5, var_22_32)

					arg_19_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1060ui_story.fillRatio = var_22_33
				end
			end

			if arg_19_1.time_ >= var_22_30 + var_22_31 and arg_19_1.time_ < var_22_30 + var_22_31 + arg_22_0 and not isNil(var_22_29) and arg_19_1.var_.characterEffect1060ui_story then
				local var_22_34 = 0.5

				arg_19_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1060ui_story.fillRatio = var_22_34
			end

			local var_22_35 = arg_19_1.actors_["1070ui_story"].transform
			local var_22_36 = 0

			if var_22_36 < arg_19_1.time_ and arg_19_1.time_ <= var_22_36 + arg_22_0 then
				arg_19_1.var_.moveOldPos1070ui_story = var_22_35.localPosition
			end

			local var_22_37 = 0.001

			if var_22_36 <= arg_19_1.time_ and arg_19_1.time_ < var_22_36 + var_22_37 then
				local var_22_38 = (arg_19_1.time_ - var_22_36) / var_22_37
				local var_22_39 = Vector3.New(0, 100, 0)

				var_22_35.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1070ui_story, var_22_39, var_22_38)

				local var_22_40 = manager.ui.mainCamera.transform.position - var_22_35.position

				var_22_35.forward = Vector3.New(var_22_40.x, var_22_40.y, var_22_40.z)

				local var_22_41 = var_22_35.localEulerAngles

				var_22_41.z = 0
				var_22_41.x = 0
				var_22_35.localEulerAngles = var_22_41
			end

			if arg_19_1.time_ >= var_22_36 + var_22_37 and arg_19_1.time_ < var_22_36 + var_22_37 + arg_22_0 then
				var_22_35.localPosition = Vector3.New(0, 100, 0)

				local var_22_42 = manager.ui.mainCamera.transform.position - var_22_35.position

				var_22_35.forward = Vector3.New(var_22_42.x, var_22_42.y, var_22_42.z)

				local var_22_43 = var_22_35.localEulerAngles

				var_22_43.z = 0
				var_22_43.x = 0
				var_22_35.localEulerAngles = var_22_43
			end

			local var_22_44 = arg_19_1.actors_["1070ui_story"]
			local var_22_45 = 0

			if var_22_45 < arg_19_1.time_ and arg_19_1.time_ <= var_22_45 + arg_22_0 and not isNil(var_22_44) and arg_19_1.var_.characterEffect1070ui_story == nil then
				arg_19_1.var_.characterEffect1070ui_story = var_22_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_46 = 0.200000002980232

			if var_22_45 <= arg_19_1.time_ and arg_19_1.time_ < var_22_45 + var_22_46 and not isNil(var_22_44) then
				local var_22_47 = (arg_19_1.time_ - var_22_45) / var_22_46

				if arg_19_1.var_.characterEffect1070ui_story and not isNil(var_22_44) then
					local var_22_48 = Mathf.Lerp(0, 0.5, var_22_47)

					arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1070ui_story.fillRatio = var_22_48
				end
			end

			if arg_19_1.time_ >= var_22_45 + var_22_46 and arg_19_1.time_ < var_22_45 + var_22_46 + arg_22_0 and not isNil(var_22_44) and arg_19_1.var_.characterEffect1070ui_story then
				local var_22_49 = 0.5

				arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1070ui_story.fillRatio = var_22_49
			end

			local var_22_50 = 0
			local var_22_51 = 0.275

			if var_22_50 < arg_19_1.time_ and arg_19_1.time_ <= var_22_50 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_52 = arg_19_1:FormatText(StoryNameCfg[410].name)

				arg_19_1.leftNameTxt_.text = var_22_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_53 = arg_19_1:GetWordFromCfg(910116005)
				local var_22_54 = arg_19_1:FormatText(var_22_53.content)

				arg_19_1.text_.text = var_22_54

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_55 = 11
				local var_22_56 = utf8.len(var_22_54)
				local var_22_57 = var_22_55 <= 0 and var_22_51 or var_22_51 * (var_22_56 / var_22_55)

				if var_22_57 > 0 and var_22_51 < var_22_57 then
					arg_19_1.talkMaxDuration = var_22_57

					if var_22_57 + var_22_50 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_57 + var_22_50
					end
				end

				arg_19_1.text_.text = var_22_54
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_58 = math.max(var_22_51, arg_19_1.talkMaxDuration)

			if var_22_50 <= arg_19_1.time_ and arg_19_1.time_ < var_22_50 + var_22_58 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_50) / var_22_58

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_50 + var_22_58 and arg_19_1.time_ < var_22_50 + var_22_58 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play910116006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910116006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910116007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1060ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1060ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(-0.7, -1.14, -6.33)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1060ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-0.7, -1.14, -6.33)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["1060ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1060ui_story == nil then
				arg_23_1.var_.characterEffect1060ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 and not isNil(var_26_9) then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect1060ui_story and not isNil(var_26_9) then
					local var_26_13 = Mathf.Lerp(0, 0.5, var_26_12)

					arg_23_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1060ui_story.fillRatio = var_26_13
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1060ui_story then
				local var_26_14 = 0.5

				arg_23_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1060ui_story.fillRatio = var_26_14
			end

			local var_26_15 = arg_23_1.actors_["1070ui_story"].transform
			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070ui_story = var_26_15.localPosition
			end

			local var_26_17 = 0.001

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_17 then
				local var_26_18 = (arg_23_1.time_ - var_26_16) / var_26_17
				local var_26_19 = Vector3.New(0.7, -0.95, -6.05)

				var_26_15.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070ui_story, var_26_19, var_26_18)

				local var_26_20 = manager.ui.mainCamera.transform.position - var_26_15.position

				var_26_15.forward = Vector3.New(var_26_20.x, var_26_20.y, var_26_20.z)

				local var_26_21 = var_26_15.localEulerAngles

				var_26_21.z = 0
				var_26_21.x = 0
				var_26_15.localEulerAngles = var_26_21
			end

			if arg_23_1.time_ >= var_26_16 + var_26_17 and arg_23_1.time_ < var_26_16 + var_26_17 + arg_26_0 then
				var_26_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_26_22 = manager.ui.mainCamera.transform.position - var_26_15.position

				var_26_15.forward = Vector3.New(var_26_22.x, var_26_22.y, var_26_22.z)

				local var_26_23 = var_26_15.localEulerAngles

				var_26_23.z = 0
				var_26_23.x = 0
				var_26_15.localEulerAngles = var_26_23
			end

			local var_26_24 = arg_23_1.actors_["1070ui_story"]
			local var_26_25 = 0

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 and not isNil(var_26_24) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_26 = 0.200000002980232

			if var_26_25 <= arg_23_1.time_ and arg_23_1.time_ < var_26_25 + var_26_26 and not isNil(var_26_24) then
				local var_26_27 = (arg_23_1.time_ - var_26_25) / var_26_26

				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_24) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_25 + var_26_26 and arg_23_1.time_ < var_26_25 + var_26_26 + arg_26_0 and not isNil(var_26_24) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_26_28 = 0

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_26_29 = 0

			if var_26_29 < arg_23_1.time_ and arg_23_1.time_ <= var_26_29 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_30 = arg_23_1.actors_["1074ui_story"].transform
			local var_26_31 = 0

			if var_26_31 < arg_23_1.time_ and arg_23_1.time_ <= var_26_31 + arg_26_0 then
				arg_23_1.var_.moveOldPos1074ui_story = var_26_30.localPosition
			end

			local var_26_32 = 0.001

			if var_26_31 <= arg_23_1.time_ and arg_23_1.time_ < var_26_31 + var_26_32 then
				local var_26_33 = (arg_23_1.time_ - var_26_31) / var_26_32
				local var_26_34 = Vector3.New(0, 100, 0)

				var_26_30.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1074ui_story, var_26_34, var_26_33)

				local var_26_35 = manager.ui.mainCamera.transform.position - var_26_30.position

				var_26_30.forward = Vector3.New(var_26_35.x, var_26_35.y, var_26_35.z)

				local var_26_36 = var_26_30.localEulerAngles

				var_26_36.z = 0
				var_26_36.x = 0
				var_26_30.localEulerAngles = var_26_36
			end

			if arg_23_1.time_ >= var_26_31 + var_26_32 and arg_23_1.time_ < var_26_31 + var_26_32 + arg_26_0 then
				var_26_30.localPosition = Vector3.New(0, 100, 0)

				local var_26_37 = manager.ui.mainCamera.transform.position - var_26_30.position

				var_26_30.forward = Vector3.New(var_26_37.x, var_26_37.y, var_26_37.z)

				local var_26_38 = var_26_30.localEulerAngles

				var_26_38.z = 0
				var_26_38.x = 0
				var_26_30.localEulerAngles = var_26_38
			end

			local var_26_39 = arg_23_1.actors_["1074ui_story"]
			local var_26_40 = 0

			if var_26_40 < arg_23_1.time_ and arg_23_1.time_ <= var_26_40 + arg_26_0 and not isNil(var_26_39) and arg_23_1.var_.characterEffect1074ui_story == nil then
				arg_23_1.var_.characterEffect1074ui_story = var_26_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_41 = 0.200000002980232

			if var_26_40 <= arg_23_1.time_ and arg_23_1.time_ < var_26_40 + var_26_41 and not isNil(var_26_39) then
				local var_26_42 = (arg_23_1.time_ - var_26_40) / var_26_41

				if arg_23_1.var_.characterEffect1074ui_story and not isNil(var_26_39) then
					local var_26_43 = Mathf.Lerp(0, 0.5, var_26_42)

					arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1074ui_story.fillRatio = var_26_43
				end
			end

			if arg_23_1.time_ >= var_26_40 + var_26_41 and arg_23_1.time_ < var_26_40 + var_26_41 + arg_26_0 and not isNil(var_26_39) and arg_23_1.var_.characterEffect1074ui_story then
				local var_26_44 = 0.5

				arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1074ui_story.fillRatio = var_26_44
			end

			local var_26_45 = 0
			local var_26_46 = 0.275

			if var_26_45 < arg_23_1.time_ and arg_23_1.time_ <= var_26_45 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_47 = arg_23_1:FormatText(StoryNameCfg[318].name)

				arg_23_1.leftNameTxt_.text = var_26_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_48 = arg_23_1:GetWordFromCfg(910116006)
				local var_26_49 = arg_23_1:FormatText(var_26_48.content)

				arg_23_1.text_.text = var_26_49

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_50 = 11
				local var_26_51 = utf8.len(var_26_49)
				local var_26_52 = var_26_50 <= 0 and var_26_46 or var_26_46 * (var_26_51 / var_26_50)

				if var_26_52 > 0 and var_26_46 < var_26_52 then
					arg_23_1.talkMaxDuration = var_26_52

					if var_26_52 + var_26_45 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_52 + var_26_45
					end
				end

				arg_23_1.text_.text = var_26_49
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_53 = math.max(var_26_46, arg_23_1.talkMaxDuration)

			if var_26_45 <= arg_23_1.time_ and arg_23_1.time_ < var_26_45 + var_26_53 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_45) / var_26_53

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_45 + var_26_53 and arg_23_1.time_ < var_26_45 + var_26_53 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play910116007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910116007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910116008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1060ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1060ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(-0.7, -1.14, -6.33)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1060ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(-0.7, -1.14, -6.33)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["1060ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1060ui_story == nil then
				arg_27_1.var_.characterEffect1060ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect1060ui_story and not isNil(var_30_9) then
					arg_27_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1060ui_story then
				arg_27_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action2_2")
			end

			local var_30_14 = 0

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_15 = arg_27_1.actors_["1070ui_story"]
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.characterEffect1070ui_story == nil then
				arg_27_1.var_.characterEffect1070ui_story = var_30_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_17 = 0.200000002980232

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_17 and not isNil(var_30_15) then
				local var_30_18 = (arg_27_1.time_ - var_30_16) / var_30_17

				if arg_27_1.var_.characterEffect1070ui_story and not isNil(var_30_15) then
					local var_30_19 = Mathf.Lerp(0, 0.5, var_30_18)

					arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1070ui_story.fillRatio = var_30_19
				end
			end

			if arg_27_1.time_ >= var_30_16 + var_30_17 and arg_27_1.time_ < var_30_16 + var_30_17 + arg_30_0 and not isNil(var_30_15) and arg_27_1.var_.characterEffect1070ui_story then
				local var_30_20 = 0.5

				arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1070ui_story.fillRatio = var_30_20
			end

			local var_30_21 = 0
			local var_30_22 = 0.725

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_23 = arg_27_1:FormatText(StoryNameCfg[584].name)

				arg_27_1.leftNameTxt_.text = var_30_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_24 = arg_27_1:GetWordFromCfg(910116007)
				local var_30_25 = arg_27_1:FormatText(var_30_24.content)

				arg_27_1.text_.text = var_30_25

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_26 = 29
				local var_30_27 = utf8.len(var_30_25)
				local var_30_28 = var_30_26 <= 0 and var_30_22 or var_30_22 * (var_30_27 / var_30_26)

				if var_30_28 > 0 and var_30_22 < var_30_28 then
					arg_27_1.talkMaxDuration = var_30_28

					if var_30_28 + var_30_21 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_21
					end
				end

				arg_27_1.text_.text = var_30_25
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_29 = math.max(var_30_22, arg_27_1.talkMaxDuration)

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_29 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_21) / var_30_29

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_21 + var_30_29 and arg_27_1.time_ < var_30_21 + var_30_29 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910116008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910116009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1070ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1070ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0.7, -0.95, -6.05)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1070ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1070ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1070ui_story == nil then
				arg_31_1.var_.characterEffect1070ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect1070ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1070ui_story then
				arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_34_14 = arg_31_1.actors_["1060ui_story"]
			local var_34_15 = 0

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 and not isNil(var_34_14) and arg_31_1.var_.characterEffect1060ui_story == nil then
				arg_31_1.var_.characterEffect1060ui_story = var_34_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_16 = 0.200000002980232

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_16 and not isNil(var_34_14) then
				local var_34_17 = (arg_31_1.time_ - var_34_15) / var_34_16

				if arg_31_1.var_.characterEffect1060ui_story and not isNil(var_34_14) then
					local var_34_18 = Mathf.Lerp(0, 0.5, var_34_17)

					arg_31_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1060ui_story.fillRatio = var_34_18
				end
			end

			if arg_31_1.time_ >= var_34_15 + var_34_16 and arg_31_1.time_ < var_34_15 + var_34_16 + arg_34_0 and not isNil(var_34_14) and arg_31_1.var_.characterEffect1060ui_story then
				local var_34_19 = 0.5

				arg_31_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1060ui_story.fillRatio = var_34_19
			end

			local var_34_20 = 0
			local var_34_21 = 0.175

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_22 = arg_31_1:FormatText(StoryNameCfg[318].name)

				arg_31_1.leftNameTxt_.text = var_34_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_23 = arg_31_1:GetWordFromCfg(910116008)
				local var_34_24 = arg_31_1:FormatText(var_34_23.content)

				arg_31_1.text_.text = var_34_24

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_25 = 7
				local var_34_26 = utf8.len(var_34_24)
				local var_34_27 = var_34_25 <= 0 and var_34_21 or var_34_21 * (var_34_26 / var_34_25)

				if var_34_27 > 0 and var_34_21 < var_34_27 then
					arg_31_1.talkMaxDuration = var_34_27

					if var_34_27 + var_34_20 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_27 + var_34_20
					end
				end

				arg_31_1.text_.text = var_34_24
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_28 = math.max(var_34_21, arg_31_1.talkMaxDuration)

			if var_34_20 <= arg_31_1.time_ and arg_31_1.time_ < var_34_20 + var_34_28 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_20) / var_34_28

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_20 + var_34_28 and arg_31_1.time_ < var_34_20 + var_34_28 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910116009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910116010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1060ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1060ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(-0.7, -1.14, -6.33)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1060ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(-0.7, -1.14, -6.33)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1060ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1060ui_story == nil then
				arg_35_1.var_.characterEffect1060ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect1060ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1060ui_story then
				arg_35_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_15 = arg_35_1.actors_["1070ui_story"]
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 and not isNil(var_38_15) and arg_35_1.var_.characterEffect1070ui_story == nil then
				arg_35_1.var_.characterEffect1070ui_story = var_38_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_17 = 0.200000002980232

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_17 and not isNil(var_38_15) then
				local var_38_18 = (arg_35_1.time_ - var_38_16) / var_38_17

				if arg_35_1.var_.characterEffect1070ui_story and not isNil(var_38_15) then
					local var_38_19 = Mathf.Lerp(0, 0.5, var_38_18)

					arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1070ui_story.fillRatio = var_38_19
				end
			end

			if arg_35_1.time_ >= var_38_16 + var_38_17 and arg_35_1.time_ < var_38_16 + var_38_17 + arg_38_0 and not isNil(var_38_15) and arg_35_1.var_.characterEffect1070ui_story then
				local var_38_20 = 0.5

				arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1070ui_story.fillRatio = var_38_20
			end

			local var_38_21 = 0
			local var_38_22 = 1

			if var_38_21 < arg_35_1.time_ and arg_35_1.time_ <= var_38_21 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_23 = arg_35_1:FormatText(StoryNameCfg[584].name)

				arg_35_1.leftNameTxt_.text = var_38_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_24 = arg_35_1:GetWordFromCfg(910116009)
				local var_38_25 = arg_35_1:FormatText(var_38_24.content)

				arg_35_1.text_.text = var_38_25

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_26 = 40
				local var_38_27 = utf8.len(var_38_25)
				local var_38_28 = var_38_26 <= 0 and var_38_22 or var_38_22 * (var_38_27 / var_38_26)

				if var_38_28 > 0 and var_38_22 < var_38_28 then
					arg_35_1.talkMaxDuration = var_38_28

					if var_38_28 + var_38_21 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_21
					end
				end

				arg_35_1.text_.text = var_38_25
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_29 = math.max(var_38_22, arg_35_1.talkMaxDuration)

			if var_38_21 <= arg_35_1.time_ and arg_35_1.time_ < var_38_21 + var_38_29 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_21) / var_38_29

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_21 + var_38_29 and arg_35_1.time_ < var_38_21 + var_38_29 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910116010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910116011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1074ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1074ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1074ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1074ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1074ui_story == nil then
				arg_39_1.var_.characterEffect1074ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1074ui_story and not isNil(var_42_9) then
					arg_39_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1074ui_story then
				arg_39_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_42_13 = 0

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 then
				arg_39_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_42_14 = 0

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_15 = arg_39_1.actors_["1060ui_story"].transform
			local var_42_16 = 0

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.var_.moveOldPos1060ui_story = var_42_15.localPosition
			end

			local var_42_17 = 0.001

			if var_42_16 <= arg_39_1.time_ and arg_39_1.time_ < var_42_16 + var_42_17 then
				local var_42_18 = (arg_39_1.time_ - var_42_16) / var_42_17
				local var_42_19 = Vector3.New(0.7, -1.14, -6.33)

				var_42_15.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1060ui_story, var_42_19, var_42_18)

				local var_42_20 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_20.x, var_42_20.y, var_42_20.z)

				local var_42_21 = var_42_15.localEulerAngles

				var_42_21.z = 0
				var_42_21.x = 0
				var_42_15.localEulerAngles = var_42_21
			end

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				var_42_15.localPosition = Vector3.New(0.7, -1.14, -6.33)

				local var_42_22 = manager.ui.mainCamera.transform.position - var_42_15.position

				var_42_15.forward = Vector3.New(var_42_22.x, var_42_22.y, var_42_22.z)

				local var_42_23 = var_42_15.localEulerAngles

				var_42_23.z = 0
				var_42_23.x = 0
				var_42_15.localEulerAngles = var_42_23
			end

			local var_42_24 = arg_39_1.actors_["1060ui_story"]
			local var_42_25 = 0

			if var_42_25 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 and not isNil(var_42_24) and arg_39_1.var_.characterEffect1060ui_story == nil then
				arg_39_1.var_.characterEffect1060ui_story = var_42_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_26 = 0.200000002980232

			if var_42_25 <= arg_39_1.time_ and arg_39_1.time_ < var_42_25 + var_42_26 and not isNil(var_42_24) then
				local var_42_27 = (arg_39_1.time_ - var_42_25) / var_42_26

				if arg_39_1.var_.characterEffect1060ui_story and not isNil(var_42_24) then
					local var_42_28 = Mathf.Lerp(0, 0.5, var_42_27)

					arg_39_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1060ui_story.fillRatio = var_42_28
				end
			end

			if arg_39_1.time_ >= var_42_25 + var_42_26 and arg_39_1.time_ < var_42_25 + var_42_26 + arg_42_0 and not isNil(var_42_24) and arg_39_1.var_.characterEffect1060ui_story then
				local var_42_29 = 0.5

				arg_39_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1060ui_story.fillRatio = var_42_29
			end

			local var_42_30 = arg_39_1.actors_["1070ui_story"].transform
			local var_42_31 = 0

			if var_42_31 < arg_39_1.time_ and arg_39_1.time_ <= var_42_31 + arg_42_0 then
				arg_39_1.var_.moveOldPos1070ui_story = var_42_30.localPosition
			end

			local var_42_32 = 0.001

			if var_42_31 <= arg_39_1.time_ and arg_39_1.time_ < var_42_31 + var_42_32 then
				local var_42_33 = (arg_39_1.time_ - var_42_31) / var_42_32
				local var_42_34 = Vector3.New(0, 100, 0)

				var_42_30.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1070ui_story, var_42_34, var_42_33)

				local var_42_35 = manager.ui.mainCamera.transform.position - var_42_30.position

				var_42_30.forward = Vector3.New(var_42_35.x, var_42_35.y, var_42_35.z)

				local var_42_36 = var_42_30.localEulerAngles

				var_42_36.z = 0
				var_42_36.x = 0
				var_42_30.localEulerAngles = var_42_36
			end

			if arg_39_1.time_ >= var_42_31 + var_42_32 and arg_39_1.time_ < var_42_31 + var_42_32 + arg_42_0 then
				var_42_30.localPosition = Vector3.New(0, 100, 0)

				local var_42_37 = manager.ui.mainCamera.transform.position - var_42_30.position

				var_42_30.forward = Vector3.New(var_42_37.x, var_42_37.y, var_42_37.z)

				local var_42_38 = var_42_30.localEulerAngles

				var_42_38.z = 0
				var_42_38.x = 0
				var_42_30.localEulerAngles = var_42_38
			end

			local var_42_39 = arg_39_1.actors_["1070ui_story"]
			local var_42_40 = 0

			if var_42_40 < arg_39_1.time_ and arg_39_1.time_ <= var_42_40 + arg_42_0 and not isNil(var_42_39) and arg_39_1.var_.characterEffect1070ui_story == nil then
				arg_39_1.var_.characterEffect1070ui_story = var_42_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_41 = 0.200000002980232

			if var_42_40 <= arg_39_1.time_ and arg_39_1.time_ < var_42_40 + var_42_41 and not isNil(var_42_39) then
				local var_42_42 = (arg_39_1.time_ - var_42_40) / var_42_41

				if arg_39_1.var_.characterEffect1070ui_story and not isNil(var_42_39) then
					local var_42_43 = Mathf.Lerp(0, 0.5, var_42_42)

					arg_39_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1070ui_story.fillRatio = var_42_43
				end
			end

			if arg_39_1.time_ >= var_42_40 + var_42_41 and arg_39_1.time_ < var_42_40 + var_42_41 + arg_42_0 and not isNil(var_42_39) and arg_39_1.var_.characterEffect1070ui_story then
				local var_42_44 = 0.5

				arg_39_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1070ui_story.fillRatio = var_42_44
			end

			local var_42_45 = 0
			local var_42_46 = 0.85

			if var_42_45 < arg_39_1.time_ and arg_39_1.time_ <= var_42_45 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_47 = arg_39_1:FormatText(StoryNameCfg[410].name)

				arg_39_1.leftNameTxt_.text = var_42_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_48 = arg_39_1:GetWordFromCfg(910116010)
				local var_42_49 = arg_39_1:FormatText(var_42_48.content)

				arg_39_1.text_.text = var_42_49

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_50 = 34
				local var_42_51 = utf8.len(var_42_49)
				local var_42_52 = var_42_50 <= 0 and var_42_46 or var_42_46 * (var_42_51 / var_42_50)

				if var_42_52 > 0 and var_42_46 < var_42_52 then
					arg_39_1.talkMaxDuration = var_42_52

					if var_42_52 + var_42_45 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_52 + var_42_45
					end
				end

				arg_39_1.text_.text = var_42_49
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_53 = math.max(var_42_46, arg_39_1.talkMaxDuration)

			if var_42_45 <= arg_39_1.time_ and arg_39_1.time_ < var_42_45 + var_42_53 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_45) / var_42_53

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_45 + var_42_53 and arg_39_1.time_ < var_42_45 + var_42_53 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play910116011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910116011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910116012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1060ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1060ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0.7, -1.14, -6.33)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1060ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0.7, -1.14, -6.33)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1060ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1060ui_story == nil then
				arg_43_1.var_.characterEffect1060ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1060ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1060ui_story then
				arg_43_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			local var_46_14 = 0

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_46_15 = arg_43_1.actors_["1074ui_story"]
			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_17 = 0.200000002980232

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 and not isNil(var_46_15) then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17

				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_15) then
					local var_46_19 = Mathf.Lerp(0, 0.5, var_46_18)

					arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1074ui_story.fillRatio = var_46_19
				end
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 and not isNil(var_46_15) and arg_43_1.var_.characterEffect1074ui_story then
				local var_46_20 = 0.5

				arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1074ui_story.fillRatio = var_46_20
			end

			local var_46_21 = 0
			local var_46_22 = 0.7

			if var_46_21 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_23 = arg_43_1:FormatText(StoryNameCfg[584].name)

				arg_43_1.leftNameTxt_.text = var_46_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_24 = arg_43_1:GetWordFromCfg(910116011)
				local var_46_25 = arg_43_1:FormatText(var_46_24.content)

				arg_43_1.text_.text = var_46_25

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_26 = 29
				local var_46_27 = utf8.len(var_46_25)
				local var_46_28 = var_46_26 <= 0 and var_46_22 or var_46_22 * (var_46_27 / var_46_26)

				if var_46_28 > 0 and var_46_22 < var_46_28 then
					arg_43_1.talkMaxDuration = var_46_28

					if var_46_28 + var_46_21 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_28 + var_46_21
					end
				end

				arg_43_1.text_.text = var_46_25
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_29 = math.max(var_46_22, arg_43_1.talkMaxDuration)

			if var_46_21 <= arg_43_1.time_ and arg_43_1.time_ < var_46_21 + var_46_29 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_21) / var_46_29

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_21 + var_46_29 and arg_43_1.time_ < var_46_21 + var_46_29 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play910116012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910116012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910116013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1074ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos1074ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1074ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["1074ui_story"]
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_11 = 0.200000002980232

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 and not isNil(var_50_9) then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11

				if arg_47_1.var_.characterEffect1074ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect1074ui_story then
				arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_50_13 = 0

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_15 = arg_47_1.actors_["1060ui_story"]
			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.characterEffect1060ui_story == nil then
				arg_47_1.var_.characterEffect1060ui_story = var_50_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_17 = 0.200000002980232

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_17 and not isNil(var_50_15) then
				local var_50_18 = (arg_47_1.time_ - var_50_16) / var_50_17

				if arg_47_1.var_.characterEffect1060ui_story and not isNil(var_50_15) then
					local var_50_19 = Mathf.Lerp(0, 0.5, var_50_18)

					arg_47_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1060ui_story.fillRatio = var_50_19
				end
			end

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 and not isNil(var_50_15) and arg_47_1.var_.characterEffect1060ui_story then
				local var_50_20 = 0.5

				arg_47_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1060ui_story.fillRatio = var_50_20
			end

			local var_50_21 = 0
			local var_50_22 = 0.475

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_23 = arg_47_1:FormatText(StoryNameCfg[410].name)

				arg_47_1.leftNameTxt_.text = var_50_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_24 = arg_47_1:GetWordFromCfg(910116012)
				local var_50_25 = arg_47_1:FormatText(var_50_24.content)

				arg_47_1.text_.text = var_50_25

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_26 = 19
				local var_50_27 = utf8.len(var_50_25)
				local var_50_28 = var_50_26 <= 0 and var_50_22 or var_50_22 * (var_50_27 / var_50_26)

				if var_50_28 > 0 and var_50_22 < var_50_28 then
					arg_47_1.talkMaxDuration = var_50_28

					if var_50_28 + var_50_21 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_28 + var_50_21
					end
				end

				arg_47_1.text_.text = var_50_25
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_29 = math.max(var_50_22, arg_47_1.talkMaxDuration)

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_29 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_21) / var_50_29

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_21 + var_50_29 and arg_47_1.time_ < var_50_21 + var_50_29 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play910116013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910116013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910116014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1060ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1060ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0.7, -1.14, -6.33)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1060ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0.7, -1.14, -6.33)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1060ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1060ui_story == nil then
				arg_51_1.var_.characterEffect1060ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1060ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1060ui_story then
				arg_51_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_14 = arg_51_1.actors_["1074ui_story"]
			local var_54_15 = 0

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1074ui_story == nil then
				arg_51_1.var_.characterEffect1074ui_story = var_54_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_16 = 0.200000002980232

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_16 and not isNil(var_54_14) then
				local var_54_17 = (arg_51_1.time_ - var_54_15) / var_54_16

				if arg_51_1.var_.characterEffect1074ui_story and not isNil(var_54_14) then
					local var_54_18 = Mathf.Lerp(0, 0.5, var_54_17)

					arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1074ui_story.fillRatio = var_54_18
				end
			end

			if arg_51_1.time_ >= var_54_15 + var_54_16 and arg_51_1.time_ < var_54_15 + var_54_16 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1074ui_story then
				local var_54_19 = 0.5

				arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1074ui_story.fillRatio = var_54_19
			end

			local var_54_20 = 0
			local var_54_21 = 0.375

			if var_54_20 < arg_51_1.time_ and arg_51_1.time_ <= var_54_20 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_22 = arg_51_1:FormatText(StoryNameCfg[584].name)

				arg_51_1.leftNameTxt_.text = var_54_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_23 = arg_51_1:GetWordFromCfg(910116013)
				local var_54_24 = arg_51_1:FormatText(var_54_23.content)

				arg_51_1.text_.text = var_54_24

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_25 = 15
				local var_54_26 = utf8.len(var_54_24)
				local var_54_27 = var_54_25 <= 0 and var_54_21 or var_54_21 * (var_54_26 / var_54_25)

				if var_54_27 > 0 and var_54_21 < var_54_27 then
					arg_51_1.talkMaxDuration = var_54_27

					if var_54_27 + var_54_20 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_27 + var_54_20
					end
				end

				arg_51_1.text_.text = var_54_24
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_28 = math.max(var_54_21, arg_51_1.talkMaxDuration)

			if var_54_20 <= arg_51_1.time_ and arg_51_1.time_ < var_54_20 + var_54_28 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_20) / var_54_28

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_20 + var_54_28 and arg_51_1.time_ < var_54_20 + var_54_28 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play910116014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910116014
		arg_55_1.duration_ = 9

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910116015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "ST37"

			if arg_55_1.bgs_[var_58_0] == nil then
				local var_58_1 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_58_0)
				var_58_1.name = var_58_0
				var_58_1.transform.parent = arg_55_1.stage_.transform
				var_58_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_[var_58_0] = var_58_1
			end

			local var_58_2 = 2

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				local var_58_3 = manager.ui.mainCamera.transform.localPosition
				local var_58_4 = Vector3.New(0, 0, 10) + Vector3.New(var_58_3.x, var_58_3.y, 0)
				local var_58_5 = arg_55_1.bgs_.ST37

				var_58_5.transform.localPosition = var_58_4
				var_58_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_6 = var_58_5:GetComponent("SpriteRenderer")

				if var_58_6 and var_58_6.sprite then
					local var_58_7 = (var_58_5.transform.localPosition - var_58_3).z
					local var_58_8 = manager.ui.mainCameraCom_
					local var_58_9 = 2 * var_58_7 * Mathf.Tan(var_58_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_58_10 = var_58_9 * var_58_8.aspect
					local var_58_11 = var_58_6.sprite.bounds.size.x
					local var_58_12 = var_58_6.sprite.bounds.size.y
					local var_58_13 = var_58_10 / var_58_11
					local var_58_14 = var_58_9 / var_58_12
					local var_58_15 = var_58_14 < var_58_13 and var_58_13 or var_58_14

					var_58_5.transform.localScale = Vector3.New(var_58_15, var_58_15, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST37" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_17 = 2

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17
				local var_58_19 = Color.New(0, 0, 0)

				var_58_19.a = Mathf.Lerp(0, 1, var_58_18)
				arg_55_1.mask_.color = var_58_19
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				local var_58_20 = Color.New(0, 0, 0)

				var_58_20.a = 1
				arg_55_1.mask_.color = var_58_20
			end

			local var_58_21 = 2

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_22 = 2

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 then
				local var_58_23 = (arg_55_1.time_ - var_58_21) / var_58_22
				local var_58_24 = Color.New(0, 0, 0)

				var_58_24.a = Mathf.Lerp(1, 0, var_58_23)
				arg_55_1.mask_.color = var_58_24
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 then
				local var_58_25 = Color.New(0, 0, 0)
				local var_58_26 = 0

				arg_55_1.mask_.enabled = false
				var_58_25.a = var_58_26
				arg_55_1.mask_.color = var_58_25
			end

			local var_58_27 = arg_55_1.actors_["1074ui_story"].transform
			local var_58_28 = 2

			if var_58_28 < arg_55_1.time_ and arg_55_1.time_ <= var_58_28 + arg_58_0 then
				arg_55_1.var_.moveOldPos1074ui_story = var_58_27.localPosition
			end

			local var_58_29 = 0.001

			if var_58_28 <= arg_55_1.time_ and arg_55_1.time_ < var_58_28 + var_58_29 then
				local var_58_30 = (arg_55_1.time_ - var_58_28) / var_58_29
				local var_58_31 = Vector3.New(0, 100, 0)

				var_58_27.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1074ui_story, var_58_31, var_58_30)

				local var_58_32 = manager.ui.mainCamera.transform.position - var_58_27.position

				var_58_27.forward = Vector3.New(var_58_32.x, var_58_32.y, var_58_32.z)

				local var_58_33 = var_58_27.localEulerAngles

				var_58_33.z = 0
				var_58_33.x = 0
				var_58_27.localEulerAngles = var_58_33
			end

			if arg_55_1.time_ >= var_58_28 + var_58_29 and arg_55_1.time_ < var_58_28 + var_58_29 + arg_58_0 then
				var_58_27.localPosition = Vector3.New(0, 100, 0)

				local var_58_34 = manager.ui.mainCamera.transform.position - var_58_27.position

				var_58_27.forward = Vector3.New(var_58_34.x, var_58_34.y, var_58_34.z)

				local var_58_35 = var_58_27.localEulerAngles

				var_58_35.z = 0
				var_58_35.x = 0
				var_58_27.localEulerAngles = var_58_35
			end

			local var_58_36 = arg_55_1.actors_["1060ui_story"].transform
			local var_58_37 = 2

			if var_58_37 < arg_55_1.time_ and arg_55_1.time_ <= var_58_37 + arg_58_0 then
				arg_55_1.var_.moveOldPos1060ui_story = var_58_36.localPosition
			end

			local var_58_38 = 0.001

			if var_58_37 <= arg_55_1.time_ and arg_55_1.time_ < var_58_37 + var_58_38 then
				local var_58_39 = (arg_55_1.time_ - var_58_37) / var_58_38
				local var_58_40 = Vector3.New(0, 100, 0)

				var_58_36.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1060ui_story, var_58_40, var_58_39)

				local var_58_41 = manager.ui.mainCamera.transform.position - var_58_36.position

				var_58_36.forward = Vector3.New(var_58_41.x, var_58_41.y, var_58_41.z)

				local var_58_42 = var_58_36.localEulerAngles

				var_58_42.z = 0
				var_58_42.x = 0
				var_58_36.localEulerAngles = var_58_42
			end

			if arg_55_1.time_ >= var_58_37 + var_58_38 and arg_55_1.time_ < var_58_37 + var_58_38 + arg_58_0 then
				var_58_36.localPosition = Vector3.New(0, 100, 0)

				local var_58_43 = manager.ui.mainCamera.transform.position - var_58_36.position

				var_58_36.forward = Vector3.New(var_58_43.x, var_58_43.y, var_58_43.z)

				local var_58_44 = var_58_36.localEulerAngles

				var_58_44.z = 0
				var_58_44.x = 0
				var_58_36.localEulerAngles = var_58_44
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_45 = 4
			local var_58_46 = 0.425

			if var_58_45 < arg_55_1.time_ and arg_55_1.time_ <= var_58_45 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_47 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_47:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_48 = arg_55_1:FormatText(StoryNameCfg[625].name)

				arg_55_1.leftNameTxt_.text = var_58_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_49 = arg_55_1:GetWordFromCfg(910116014)
				local var_58_50 = arg_55_1:FormatText(var_58_49.content)

				arg_55_1.text_.text = var_58_50

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_51 = 17
				local var_58_52 = utf8.len(var_58_50)
				local var_58_53 = var_58_51 <= 0 and var_58_46 or var_58_46 * (var_58_52 / var_58_51)

				if var_58_53 > 0 and var_58_46 < var_58_53 then
					arg_55_1.talkMaxDuration = var_58_53
					var_58_45 = var_58_45 + 0.3

					if var_58_53 + var_58_45 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_53 + var_58_45
					end
				end

				arg_55_1.text_.text = var_58_50
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_54 = var_58_45 + 0.3
			local var_58_55 = math.max(var_58_46, arg_55_1.talkMaxDuration)

			if var_58_54 <= arg_55_1.time_ and arg_55_1.time_ < var_58_54 + var_58_55 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_54) / var_58_55

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_54 + var_58_55 and arg_55_1.time_ < var_58_54 + var_58_55 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play910116015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 910116015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play910116016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1060ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1060ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -1.14, -6.33)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1060ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -1.14, -6.33)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1060ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1060ui_story == nil then
				arg_61_1.var_.characterEffect1060ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1060ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1060ui_story then
				arg_61_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_64_15 = 0
			local var_64_16 = 0.6

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[584].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(910116015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 24
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_23 and arg_61_1.time_ < var_64_15 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play910116016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 910116016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play910116017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_1 = 0
			local var_68_2 = 0.725

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_3 = arg_65_1:FormatText(StoryNameCfg[584].name)

				arg_65_1.leftNameTxt_.text = var_68_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(910116016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 29
				local var_68_7 = utf8.len(var_68_5)
				local var_68_8 = var_68_6 <= 0 and var_68_2 or var_68_2 * (var_68_7 / var_68_6)

				if var_68_8 > 0 and var_68_2 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play910116017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 910116017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play910116018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1060ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1060ui_story == nil then
				arg_69_1.var_.characterEffect1060ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1060ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1060ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1060ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1060ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.85

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[626].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(910116017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 34
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play910116018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 910116018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play910116019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.625

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[626].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(910116018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 25
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play910116019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 910116019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play910116020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1060ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1060ui_story == nil then
				arg_77_1.var_.characterEffect1060ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1060ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1060ui_story then
				arg_77_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 0.525

			if var_80_4 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_6 = arg_77_1:FormatText(StoryNameCfg[584].name)

				arg_77_1.leftNameTxt_.text = var_80_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(910116019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 21
				local var_80_10 = utf8.len(var_80_8)
				local var_80_11 = var_80_9 <= 0 and var_80_5 or var_80_5 * (var_80_10 / var_80_9)

				if var_80_11 > 0 and var_80_5 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play910116020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 910116020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play910116021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1060ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1060ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1060ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, 100, 0)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1060ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1060ui_story == nil then
				arg_81_1.var_.characterEffect1060ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1060ui_story and not isNil(var_84_9) then
					local var_84_13 = Mathf.Lerp(0, 0.5, var_84_12)

					arg_81_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1060ui_story.fillRatio = var_84_13
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1060ui_story then
				local var_84_14 = 0.5

				arg_81_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1060ui_story.fillRatio = var_84_14
			end

			local var_84_15 = 0
			local var_84_16 = 0.425

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(910116020)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 17
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_16 or var_84_16 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_16 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_22 and arg_81_1.time_ < var_84_15 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play910116021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 910116021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play910116022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.65

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[626].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(910116021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 26
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play910116022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910116022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910116023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.15

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[626].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(910116022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 46
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play910116023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910116023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910116024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.975

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[626].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(910116023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 39
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play910116024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910116024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910116025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.575

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[625].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(910116024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 23
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play910116025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910116025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910116026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.475

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[626].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(910116025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 19
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play910116026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910116026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910116027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.45

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(910116026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 18
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play910116027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910116027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910116028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.15

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_2 = arg_109_1:GetWordFromCfg(910116027)
				local var_112_3 = arg_109_1:FormatText(var_112_2.content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 46
				local var_112_5 = utf8.len(var_112_3)
				local var_112_6 = var_112_4 <= 0 and var_112_1 or var_112_1 * (var_112_5 / var_112_4)

				if var_112_6 > 0 and var_112_1 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_7 and arg_109_1.time_ < var_112_0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play910116028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910116028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910116029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.65

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(910116028)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 26
				local var_116_5 = utf8.len(var_116_3)
				local var_116_6 = var_116_4 <= 0 and var_116_1 or var_116_1 * (var_116_5 / var_116_4)

				if var_116_6 > 0 and var_116_1 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_7 and arg_113_1.time_ < var_116_0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play910116029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910116029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910116030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1074ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1074ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1074ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1074ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1074ui_story then
				arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_15 = arg_117_1.actors_["1070ui_story"].transform
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.var_.moveOldPos1070ui_story = var_120_15.localPosition
			end

			local var_120_17 = 0.001

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Vector3.New(0.7, -0.95, -6.05)

				var_120_15.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1070ui_story, var_120_19, var_120_18)

				local var_120_20 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_20.x, var_120_20.y, var_120_20.z)

				local var_120_21 = var_120_15.localEulerAngles

				var_120_21.z = 0
				var_120_21.x = 0
				var_120_15.localEulerAngles = var_120_21
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				var_120_15.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_120_22 = manager.ui.mainCamera.transform.position - var_120_15.position

				var_120_15.forward = Vector3.New(var_120_22.x, var_120_22.y, var_120_22.z)

				local var_120_23 = var_120_15.localEulerAngles

				var_120_23.z = 0
				var_120_23.x = 0
				var_120_15.localEulerAngles = var_120_23
			end

			local var_120_24 = arg_117_1.actors_["1070ui_story"]
			local var_120_25 = 0

			if var_120_25 < arg_117_1.time_ and arg_117_1.time_ <= var_120_25 + arg_120_0 and not isNil(var_120_24) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = var_120_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_26 = 0.200000002980232

			if var_120_25 <= arg_117_1.time_ and arg_117_1.time_ < var_120_25 + var_120_26 and not isNil(var_120_24) then
				local var_120_27 = (arg_117_1.time_ - var_120_25) / var_120_26

				if arg_117_1.var_.characterEffect1070ui_story and not isNil(var_120_24) then
					local var_120_28 = Mathf.Lerp(0, 0.5, var_120_27)

					arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1070ui_story.fillRatio = var_120_28
				end
			end

			if arg_117_1.time_ >= var_120_25 + var_120_26 and arg_117_1.time_ < var_120_25 + var_120_26 + arg_120_0 and not isNil(var_120_24) and arg_117_1.var_.characterEffect1070ui_story then
				local var_120_29 = 0.5

				arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1070ui_story.fillRatio = var_120_29
			end

			local var_120_30 = 0

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_120_31 = 0

			if var_120_31 < arg_117_1.time_ and arg_117_1.time_ <= var_120_31 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_120_32 = 0
			local var_120_33 = 0.3

			if var_120_32 < arg_117_1.time_ and arg_117_1.time_ <= var_120_32 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_34 = arg_117_1:FormatText(StoryNameCfg[410].name)

				arg_117_1.leftNameTxt_.text = var_120_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_35 = arg_117_1:GetWordFromCfg(910116029)
				local var_120_36 = arg_117_1:FormatText(var_120_35.content)

				arg_117_1.text_.text = var_120_36

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_37 = 12
				local var_120_38 = utf8.len(var_120_36)
				local var_120_39 = var_120_37 <= 0 and var_120_33 or var_120_33 * (var_120_38 / var_120_37)

				if var_120_39 > 0 and var_120_33 < var_120_39 then
					arg_117_1.talkMaxDuration = var_120_39

					if var_120_39 + var_120_32 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_39 + var_120_32
					end
				end

				arg_117_1.text_.text = var_120_36
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_40 = math.max(var_120_33, arg_117_1.talkMaxDuration)

			if var_120_32 <= arg_117_1.time_ and arg_117_1.time_ < var_120_32 + var_120_40 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_32) / var_120_40

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_32 + var_120_40 and arg_117_1.time_ < var_120_32 + var_120_40 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play910116030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910116030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910116031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1074ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1074ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1074ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1074ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1074ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.75

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[625].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(910116030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 30
				local var_124_12 = utf8.len(var_124_10)
				local var_124_13 = var_124_11 <= 0 and var_124_7 or var_124_7 * (var_124_12 / var_124_11)

				if var_124_13 > 0 and var_124_7 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play910116031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910116031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910116032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1070ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1070ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0.7, -0.95, -6.05)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1070ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1070ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1070ui_story == nil then
				arg_125_1.var_.characterEffect1070ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1070ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1070ui_story then
				arg_125_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_14 = 0
			local var_128_15 = 0.2

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_16 = arg_125_1:FormatText(StoryNameCfg[318].name)

				arg_125_1.leftNameTxt_.text = var_128_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_17 = arg_125_1:GetWordFromCfg(910116031)
				local var_128_18 = arg_125_1:FormatText(var_128_17.content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_19 = 8
				local var_128_20 = utf8.len(var_128_18)
				local var_128_21 = var_128_19 <= 0 and var_128_15 or var_128_15 * (var_128_20 / var_128_19)

				if var_128_21 > 0 and var_128_15 < var_128_21 then
					arg_125_1.talkMaxDuration = var_128_21

					if var_128_21 + var_128_14 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_14
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_15, arg_125_1.talkMaxDuration)

			if var_128_14 <= arg_125_1.time_ and arg_125_1.time_ < var_128_14 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_14) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_14 + var_128_22 and arg_125_1.time_ < var_128_14 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play910116032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910116032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910116033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1070ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1070ui_story == nil then
				arg_129_1.var_.characterEffect1070ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1070ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1070ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1070ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1070ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.725

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_8 = arg_129_1:FormatText(StoryNameCfg[625].name)

				arg_129_1.leftNameTxt_.text = var_132_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_9 = arg_129_1:GetWordFromCfg(910116032)
				local var_132_10 = arg_129_1:FormatText(var_132_9.content)

				arg_129_1.text_.text = var_132_10

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 29
				local var_132_12 = utf8.len(var_132_10)
				local var_132_13 = var_132_11 <= 0 and var_132_7 or var_132_7 * (var_132_12 / var_132_11)

				if var_132_13 > 0 and var_132_7 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13

					if var_132_13 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_10
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play910116033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910116033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910116034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1070ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1070ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0.7, -0.95, -6.05)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1070ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1070ui_story"]
			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1070ui_story == nil then
				arg_133_1.var_.characterEffect1070ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.200000002980232

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1070ui_story and not isNil(var_136_9) then
					arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1070ui_story then
				arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_136_13 = 0

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_15 = 0
			local var_136_16 = 0.6

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_17 = arg_133_1:FormatText(StoryNameCfg[318].name)

				arg_133_1.leftNameTxt_.text = var_136_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_18 = arg_133_1:GetWordFromCfg(910116033)
				local var_136_19 = arg_133_1:FormatText(var_136_18.content)

				arg_133_1.text_.text = var_136_19

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_20 = 24
				local var_136_21 = utf8.len(var_136_19)
				local var_136_22 = var_136_20 <= 0 and var_136_16 or var_136_16 * (var_136_21 / var_136_20)

				if var_136_22 > 0 and var_136_16 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22

					if var_136_22 + var_136_15 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_15
					end
				end

				arg_133_1.text_.text = var_136_19
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_23 = math.max(var_136_16, arg_133_1.talkMaxDuration)

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_23 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_23

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_23 and arg_133_1.time_ < var_136_15 + var_136_23 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play910116034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910116034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910116035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1070ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1070ui_story == nil then
				arg_137_1.var_.characterEffect1070ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1070ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1070ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1070ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1070ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 1.075

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[625].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(910116034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 43
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play910116035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910116035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910116036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.85

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[625].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(910116035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 34
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play910116036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910116036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910116037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1070ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1070ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0.7, -0.95, -6.05)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1070ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1070ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1070ui_story == nil then
				arg_145_1.var_.characterEffect1070ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect1070ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect1070ui_story then
				arg_145_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_148_15 = 0
			local var_148_16 = 0.375

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[318].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(910116036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 15
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_23 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_23 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_23

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_23 and arg_145_1.time_ < var_148_15 + var_148_23 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play910116037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910116037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910116038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1074ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1074ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1074ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1074ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1074ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1074ui_story then
				arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_15 = arg_149_1.actors_["1070ui_story"]
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.characterEffect1070ui_story == nil then
				arg_149_1.var_.characterEffect1070ui_story = var_152_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_17 = 0.200000002980232

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 and not isNil(var_152_15) then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17

				if arg_149_1.var_.characterEffect1070ui_story and not isNil(var_152_15) then
					local var_152_19 = Mathf.Lerp(0, 0.5, var_152_18)

					arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1070ui_story.fillRatio = var_152_19
				end
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 and not isNil(var_152_15) and arg_149_1.var_.characterEffect1070ui_story then
				local var_152_20 = 0.5

				arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1070ui_story.fillRatio = var_152_20
			end

			local var_152_21 = 0
			local var_152_22 = 0.075

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[410].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(910116037)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 3
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_29 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_29 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_29

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_29 and arg_149_1.time_ < var_152_21 + var_152_29 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play910116038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 910116038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play910116039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1070ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1070ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0.7, -0.95, -6.05)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1070ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1070ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1070ui_story == nil then
				arg_153_1.var_.characterEffect1070ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1070ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1070ui_story then
				arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_156_13 = 0

			if var_156_13 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action476")
			end

			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_156_15 = arg_153_1.actors_["1074ui_story"]
			local var_156_16 = 0

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = var_156_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_17 = 0.200000002980232

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 and not isNil(var_156_15) then
				local var_156_18 = (arg_153_1.time_ - var_156_16) / var_156_17

				if arg_153_1.var_.characterEffect1074ui_story and not isNil(var_156_15) then
					local var_156_19 = Mathf.Lerp(0, 0.5, var_156_18)

					arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1074ui_story.fillRatio = var_156_19
				end
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 and not isNil(var_156_15) and arg_153_1.var_.characterEffect1074ui_story then
				local var_156_20 = 0.5

				arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1074ui_story.fillRatio = var_156_20
			end

			local var_156_21 = 0
			local var_156_22 = 0.65

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_23 = arg_153_1:FormatText(StoryNameCfg[318].name)

				arg_153_1.leftNameTxt_.text = var_156_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(910116038)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 26
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_29 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_29 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_21) / var_156_29

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_21 + var_156_29 and arg_153_1.time_ < var_156_21 + var_156_29 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play910116039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 910116039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play910116040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1074ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1074ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1074ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1074ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1074ui_story == nil then
				arg_157_1.var_.characterEffect1074ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1074ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1074ui_story then
				arg_157_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_15 = arg_157_1.actors_["1070ui_story"]
			local var_160_16 = 0

			if var_160_16 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.characterEffect1070ui_story == nil then
				arg_157_1.var_.characterEffect1070ui_story = var_160_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_17 = 0.200000002980232

			if var_160_16 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 and not isNil(var_160_15) then
				local var_160_18 = (arg_157_1.time_ - var_160_16) / var_160_17

				if arg_157_1.var_.characterEffect1070ui_story and not isNil(var_160_15) then
					local var_160_19 = Mathf.Lerp(0, 0.5, var_160_18)

					arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1070ui_story.fillRatio = var_160_19
				end
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.characterEffect1070ui_story then
				local var_160_20 = 0.5

				arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1070ui_story.fillRatio = var_160_20
			end

			local var_160_21 = 0
			local var_160_22 = 0.825

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[410].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(910116039)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 33
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_22 or var_160_22 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_22 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_21
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_29 = math.max(var_160_22, arg_157_1.talkMaxDuration)

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_29 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_29

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_29 and arg_157_1.time_ < var_160_21 + var_160_29 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play910116040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910116040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910116041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1070ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0.7, -0.95, -6.05)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1070ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1070ui_story == nil then
				arg_161_1.var_.characterEffect1070ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1070ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1070ui_story then
				arg_161_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_15 = arg_161_1.actors_["1074ui_story"]
			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 and not isNil(var_164_15) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = var_164_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_17 = 0.200000002980232

			if var_164_16 <= arg_161_1.time_ and arg_161_1.time_ < var_164_16 + var_164_17 and not isNil(var_164_15) then
				local var_164_18 = (arg_161_1.time_ - var_164_16) / var_164_17

				if arg_161_1.var_.characterEffect1074ui_story and not isNil(var_164_15) then
					local var_164_19 = Mathf.Lerp(0, 0.5, var_164_18)

					arg_161_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1074ui_story.fillRatio = var_164_19
				end
			end

			if arg_161_1.time_ >= var_164_16 + var_164_17 and arg_161_1.time_ < var_164_16 + var_164_17 + arg_164_0 and not isNil(var_164_15) and arg_161_1.var_.characterEffect1074ui_story then
				local var_164_20 = 0.5

				arg_161_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1074ui_story.fillRatio = var_164_20
			end

			local var_164_21 = 0
			local var_164_22 = 0.475

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_23 = arg_161_1:FormatText(StoryNameCfg[318].name)

				arg_161_1.leftNameTxt_.text = var_164_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_24 = arg_161_1:GetWordFromCfg(910116040)
				local var_164_25 = arg_161_1:FormatText(var_164_24.content)

				arg_161_1.text_.text = var_164_25

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 19
				local var_164_27 = utf8.len(var_164_25)
				local var_164_28 = var_164_26 <= 0 and var_164_22 or var_164_22 * (var_164_27 / var_164_26)

				if var_164_28 > 0 and var_164_22 < var_164_28 then
					arg_161_1.talkMaxDuration = var_164_28

					if var_164_28 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_28 + var_164_21
					end
				end

				arg_161_1.text_.text = var_164_25
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_29 = math.max(var_164_22, arg_161_1.talkMaxDuration)

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_29 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_21) / var_164_29

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_21 + var_164_29 and arg_161_1.time_ < var_164_21 + var_164_29 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play910116041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910116041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910116042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.875

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[318].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(910116041)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 35
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_8 and arg_165_1.time_ < var_168_0 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play910116042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910116042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910116043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1074ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1074ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, 100, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1074ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 100, 0)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1074ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1074ui_story and not isNil(var_172_9) then
					local var_172_13 = Mathf.Lerp(0, 0.5, var_172_12)

					arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1074ui_story.fillRatio = var_172_13
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1074ui_story then
				local var_172_14 = 0.5

				arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1074ui_story.fillRatio = var_172_14
			end

			local var_172_15 = arg_169_1.actors_["1070ui_story"].transform
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070ui_story = var_172_15.localPosition
			end

			local var_172_17 = 0.001

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Vector3.New(0, 100, 0)

				var_172_15.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070ui_story, var_172_19, var_172_18)

				local var_172_20 = manager.ui.mainCamera.transform.position - var_172_15.position

				var_172_15.forward = Vector3.New(var_172_20.x, var_172_20.y, var_172_20.z)

				local var_172_21 = var_172_15.localEulerAngles

				var_172_21.z = 0
				var_172_21.x = 0
				var_172_15.localEulerAngles = var_172_21
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				var_172_15.localPosition = Vector3.New(0, 100, 0)

				local var_172_22 = manager.ui.mainCamera.transform.position - var_172_15.position

				var_172_15.forward = Vector3.New(var_172_22.x, var_172_22.y, var_172_22.z)

				local var_172_23 = var_172_15.localEulerAngles

				var_172_23.z = 0
				var_172_23.x = 0
				var_172_15.localEulerAngles = var_172_23
			end

			local var_172_24 = arg_169_1.actors_["1070ui_story"]
			local var_172_25 = 0

			if var_172_25 < arg_169_1.time_ and arg_169_1.time_ <= var_172_25 + arg_172_0 and not isNil(var_172_24) and arg_169_1.var_.characterEffect1070ui_story == nil then
				arg_169_1.var_.characterEffect1070ui_story = var_172_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_26 = 0.200000002980232

			if var_172_25 <= arg_169_1.time_ and arg_169_1.time_ < var_172_25 + var_172_26 and not isNil(var_172_24) then
				local var_172_27 = (arg_169_1.time_ - var_172_25) / var_172_26

				if arg_169_1.var_.characterEffect1070ui_story and not isNil(var_172_24) then
					local var_172_28 = Mathf.Lerp(0, 0.5, var_172_27)

					arg_169_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1070ui_story.fillRatio = var_172_28
				end
			end

			if arg_169_1.time_ >= var_172_25 + var_172_26 and arg_169_1.time_ < var_172_25 + var_172_26 + arg_172_0 and not isNil(var_172_24) and arg_169_1.var_.characterEffect1070ui_story then
				local var_172_29 = 0.5

				arg_169_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1070ui_story.fillRatio = var_172_29
			end

			local var_172_30 = arg_169_1.actors_["1060ui_story"].transform
			local var_172_31 = 0

			if var_172_31 < arg_169_1.time_ and arg_169_1.time_ <= var_172_31 + arg_172_0 then
				arg_169_1.var_.moveOldPos1060ui_story = var_172_30.localPosition
			end

			local var_172_32 = 0.001

			if var_172_31 <= arg_169_1.time_ and arg_169_1.time_ < var_172_31 + var_172_32 then
				local var_172_33 = (arg_169_1.time_ - var_172_31) / var_172_32
				local var_172_34 = Vector3.New(0, -1.14, -6.33)

				var_172_30.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1060ui_story, var_172_34, var_172_33)

				local var_172_35 = manager.ui.mainCamera.transform.position - var_172_30.position

				var_172_30.forward = Vector3.New(var_172_35.x, var_172_35.y, var_172_35.z)

				local var_172_36 = var_172_30.localEulerAngles

				var_172_36.z = 0
				var_172_36.x = 0
				var_172_30.localEulerAngles = var_172_36
			end

			if arg_169_1.time_ >= var_172_31 + var_172_32 and arg_169_1.time_ < var_172_31 + var_172_32 + arg_172_0 then
				var_172_30.localPosition = Vector3.New(0, -1.14, -6.33)

				local var_172_37 = manager.ui.mainCamera.transform.position - var_172_30.position

				var_172_30.forward = Vector3.New(var_172_37.x, var_172_37.y, var_172_37.z)

				local var_172_38 = var_172_30.localEulerAngles

				var_172_38.z = 0
				var_172_38.x = 0
				var_172_30.localEulerAngles = var_172_38
			end

			local var_172_39 = arg_169_1.actors_["1060ui_story"]
			local var_172_40 = 0

			if var_172_40 < arg_169_1.time_ and arg_169_1.time_ <= var_172_40 + arg_172_0 and not isNil(var_172_39) and arg_169_1.var_.characterEffect1060ui_story == nil then
				arg_169_1.var_.characterEffect1060ui_story = var_172_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_41 = 0.200000002980232

			if var_172_40 <= arg_169_1.time_ and arg_169_1.time_ < var_172_40 + var_172_41 and not isNil(var_172_39) then
				local var_172_42 = (arg_169_1.time_ - var_172_40) / var_172_41

				if arg_169_1.var_.characterEffect1060ui_story and not isNil(var_172_39) then
					arg_169_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_40 + var_172_41 and arg_169_1.time_ < var_172_40 + var_172_41 + arg_172_0 and not isNil(var_172_39) and arg_169_1.var_.characterEffect1060ui_story then
				arg_169_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_172_43 = 0

			if var_172_43 < arg_169_1.time_ and arg_169_1.time_ <= var_172_43 + arg_172_0 then
				arg_169_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			local var_172_44 = 0

			if var_172_44 < arg_169_1.time_ and arg_169_1.time_ <= var_172_44 + arg_172_0 then
				arg_169_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_172_45 = 0
			local var_172_46 = 0.375

			if var_172_45 < arg_169_1.time_ and arg_169_1.time_ <= var_172_45 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_47 = arg_169_1:FormatText(StoryNameCfg[584].name)

				arg_169_1.leftNameTxt_.text = var_172_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_48 = arg_169_1:GetWordFromCfg(910116042)
				local var_172_49 = arg_169_1:FormatText(var_172_48.content)

				arg_169_1.text_.text = var_172_49

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_50 = 15
				local var_172_51 = utf8.len(var_172_49)
				local var_172_52 = var_172_50 <= 0 and var_172_46 or var_172_46 * (var_172_51 / var_172_50)

				if var_172_52 > 0 and var_172_46 < var_172_52 then
					arg_169_1.talkMaxDuration = var_172_52

					if var_172_52 + var_172_45 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_52 + var_172_45
					end
				end

				arg_169_1.text_.text = var_172_49
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_53 = math.max(var_172_46, arg_169_1.talkMaxDuration)

			if var_172_45 <= arg_169_1.time_ and arg_169_1.time_ < var_172_45 + var_172_53 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_45) / var_172_53

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_45 + var_172_53 and arg_169_1.time_ < var_172_45 + var_172_53 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play910116043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910116043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910116044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1060ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1060ui_story == nil then
				arg_173_1.var_.characterEffect1060ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1060ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1060ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1060ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1060ui_story.fillRatio = var_176_5
			end

			local var_176_6 = 0
			local var_176_7 = 0.15

			if var_176_6 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_8 = arg_173_1:FormatText(StoryNameCfg[625].name)

				arg_173_1.leftNameTxt_.text = var_176_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_9 = arg_173_1:GetWordFromCfg(910116043)
				local var_176_10 = arg_173_1:FormatText(var_176_9.content)

				arg_173_1.text_.text = var_176_10

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 6
				local var_176_12 = utf8.len(var_176_10)
				local var_176_13 = var_176_11 <= 0 and var_176_7 or var_176_7 * (var_176_12 / var_176_11)

				if var_176_13 > 0 and var_176_7 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_10
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910116044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910116044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910116045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1060ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1060ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1060ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = 0
			local var_180_10 = 0.85

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:GetWordFromCfg(910116044)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 34
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_10 or var_180_10 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_10 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_9
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_16 = math.max(var_180_10, arg_177_1.talkMaxDuration)

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_16 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_9) / var_180_16

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_9 + var_180_16 and arg_177_1.time_ < var_180_9 + var_180_16 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play910116045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910116045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910116046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.775

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[625].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(910116045)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 31
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play910116046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910116046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910116047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.05

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[625].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(910116046)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 42
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play910116047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910116047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910116048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.5

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[625].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(910116047)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 20
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play910116048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910116048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910116049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1070ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1070ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.95, -6.05)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1070ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1070ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1070ui_story == nil then
				arg_193_1.var_.characterEffect1070ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1070ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1070ui_story then
				arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.425

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[318].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(910116048)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 17
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_23 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_23 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_23

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_23 and arg_193_1.time_ < var_196_15 + var_196_23 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play910116049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910116049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910116050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1070ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1070ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, 100, 0)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1070ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, 100, 0)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1070ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1070ui_story == nil then
				arg_197_1.var_.characterEffect1070ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1070ui_story and not isNil(var_200_9) then
					local var_200_13 = Mathf.Lerp(0, 0.5, var_200_12)

					arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1070ui_story.fillRatio = var_200_13
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1070ui_story then
				local var_200_14 = 0.5

				arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1070ui_story.fillRatio = var_200_14
			end

			local var_200_15 = arg_197_1.actors_["1060ui_story"].transform
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060ui_story = var_200_15.localPosition
			end

			local var_200_17 = 0.001

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Vector3.New(0, -1.14, -6.33)

				var_200_15.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060ui_story, var_200_19, var_200_18)

				local var_200_20 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_20.x, var_200_20.y, var_200_20.z)

				local var_200_21 = var_200_15.localEulerAngles

				var_200_21.z = 0
				var_200_21.x = 0
				var_200_15.localEulerAngles = var_200_21
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				var_200_15.localPosition = Vector3.New(0, -1.14, -6.33)

				local var_200_22 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_22.x, var_200_22.y, var_200_22.z)

				local var_200_23 = var_200_15.localEulerAngles

				var_200_23.z = 0
				var_200_23.x = 0
				var_200_15.localEulerAngles = var_200_23
			end

			local var_200_24 = arg_197_1.actors_["1060ui_story"]
			local var_200_25 = 0

			if var_200_25 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect1060ui_story == nil then
				arg_197_1.var_.characterEffect1060ui_story = var_200_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_26 = 0.200000002980232

			if var_200_25 <= arg_197_1.time_ and arg_197_1.time_ < var_200_25 + var_200_26 and not isNil(var_200_24) then
				local var_200_27 = (arg_197_1.time_ - var_200_25) / var_200_26

				if arg_197_1.var_.characterEffect1060ui_story and not isNil(var_200_24) then
					arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_25 + var_200_26 and arg_197_1.time_ < var_200_25 + var_200_26 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect1060ui_story then
				arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_200_28 = 0

			if var_200_28 < arg_197_1.time_ and arg_197_1.time_ <= var_200_28 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			local var_200_29 = 0

			if var_200_29 < arg_197_1.time_ and arg_197_1.time_ <= var_200_29 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_30 = 0
			local var_200_31 = 0.2

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_32 = arg_197_1:FormatText(StoryNameCfg[584].name)

				arg_197_1.leftNameTxt_.text = var_200_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_33 = arg_197_1:GetWordFromCfg(910116049)
				local var_200_34 = arg_197_1:FormatText(var_200_33.content)

				arg_197_1.text_.text = var_200_34

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_35 = 8
				local var_200_36 = utf8.len(var_200_34)
				local var_200_37 = var_200_35 <= 0 and var_200_31 or var_200_31 * (var_200_36 / var_200_35)

				if var_200_37 > 0 and var_200_31 < var_200_37 then
					arg_197_1.talkMaxDuration = var_200_37

					if var_200_37 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_37 + var_200_30
					end
				end

				arg_197_1.text_.text = var_200_34
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_38 = math.max(var_200_31, arg_197_1.talkMaxDuration)

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_38 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_30) / var_200_38

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_30 + var_200_38 and arg_197_1.time_ < var_200_30 + var_200_38 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play910116050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910116050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910116051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1060ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1060ui_story == nil then
				arg_201_1.var_.characterEffect1060ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1060ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1060ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1060ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1060ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.175

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[625].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(910116050)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 7
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play910116051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910116051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910116052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1060ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1060ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0, -1.14, -6.33)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1060ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0, -1.14, -6.33)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1060ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1060ui_story == nil then
				arg_205_1.var_.characterEffect1060ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1060ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1060ui_story then
				arg_205_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_208_14 = 0
			local var_208_15 = 0.25

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_16 = arg_205_1:FormatText(StoryNameCfg[584].name)

				arg_205_1.leftNameTxt_.text = var_208_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_17 = arg_205_1:GetWordFromCfg(910116051)
				local var_208_18 = arg_205_1:FormatText(var_208_17.content)

				arg_205_1.text_.text = var_208_18

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_19 = 10
				local var_208_20 = utf8.len(var_208_18)
				local var_208_21 = var_208_19 <= 0 and var_208_15 or var_208_15 * (var_208_20 / var_208_19)

				if var_208_21 > 0 and var_208_15 < var_208_21 then
					arg_205_1.talkMaxDuration = var_208_21

					if var_208_21 + var_208_14 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_21 + var_208_14
					end
				end

				arg_205_1.text_.text = var_208_18
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = math.max(var_208_15, arg_205_1.talkMaxDuration)

			if var_208_14 <= arg_205_1.time_ and arg_205_1.time_ < var_208_14 + var_208_22 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_14) / var_208_22

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_14 + var_208_22 and arg_205_1.time_ < var_208_14 + var_208_22 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play910116052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910116052
		arg_209_1.duration_ = 7.42

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910116053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = "STblack"

			if arg_209_1.bgs_[var_212_0] == nil then
				local var_212_1 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_212_0)
				var_212_1.name = var_212_0
				var_212_1.transform.parent = arg_209_1.stage_.transform
				var_212_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_[var_212_0] = var_212_1
			end

			local var_212_2 = 2

			if var_212_2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				local var_212_3 = manager.ui.mainCamera.transform.localPosition
				local var_212_4 = Vector3.New(0, 0, 10) + Vector3.New(var_212_3.x, var_212_3.y, 0)
				local var_212_5 = arg_209_1.bgs_.STblack

				var_212_5.transform.localPosition = var_212_4
				var_212_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_6 = var_212_5:GetComponent("SpriteRenderer")

				if var_212_6 and var_212_6.sprite then
					local var_212_7 = (var_212_5.transform.localPosition - var_212_3).z
					local var_212_8 = manager.ui.mainCameraCom_
					local var_212_9 = 2 * var_212_7 * Mathf.Tan(var_212_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_212_10 = var_212_9 * var_212_8.aspect
					local var_212_11 = var_212_6.sprite.bounds.size.x
					local var_212_12 = var_212_6.sprite.bounds.size.y
					local var_212_13 = var_212_10 / var_212_11
					local var_212_14 = var_212_9 / var_212_12
					local var_212_15 = var_212_14 < var_212_13 and var_212_13 or var_212_14

					var_212_5.transform.localScale = Vector3.New(var_212_15, var_212_15, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "STblack" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_17 = 2

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17
				local var_212_19 = Color.New(0, 0, 0)

				var_212_19.a = Mathf.Lerp(0, 1, var_212_18)
				arg_209_1.mask_.color = var_212_19
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 then
				local var_212_20 = Color.New(0, 0, 0)

				var_212_20.a = 1
				arg_209_1.mask_.color = var_212_20
			end

			local var_212_21 = 2

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_22 = 0.425

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_22 then
				local var_212_23 = (arg_209_1.time_ - var_212_21) / var_212_22
				local var_212_24 = Color.New(0, 0, 0)

				var_212_24.a = Mathf.Lerp(1, 0, var_212_23)
				arg_209_1.mask_.color = var_212_24
			end

			if arg_209_1.time_ >= var_212_21 + var_212_22 and arg_209_1.time_ < var_212_21 + var_212_22 + arg_212_0 then
				local var_212_25 = Color.New(0, 0, 0)
				local var_212_26 = 0

				arg_209_1.mask_.enabled = false
				var_212_25.a = var_212_26
				arg_209_1.mask_.color = var_212_25
			end

			local var_212_27 = arg_209_1.actors_["1060ui_story"].transform
			local var_212_28 = 2

			if var_212_28 < arg_209_1.time_ and arg_209_1.time_ <= var_212_28 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060ui_story = var_212_27.localPosition
			end

			local var_212_29 = 0.001

			if var_212_28 <= arg_209_1.time_ and arg_209_1.time_ < var_212_28 + var_212_29 then
				local var_212_30 = (arg_209_1.time_ - var_212_28) / var_212_29
				local var_212_31 = Vector3.New(0, 100, 0)

				var_212_27.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060ui_story, var_212_31, var_212_30)

				local var_212_32 = manager.ui.mainCamera.transform.position - var_212_27.position

				var_212_27.forward = Vector3.New(var_212_32.x, var_212_32.y, var_212_32.z)

				local var_212_33 = var_212_27.localEulerAngles

				var_212_33.z = 0
				var_212_33.x = 0
				var_212_27.localEulerAngles = var_212_33
			end

			if arg_209_1.time_ >= var_212_28 + var_212_29 and arg_209_1.time_ < var_212_28 + var_212_29 + arg_212_0 then
				var_212_27.localPosition = Vector3.New(0, 100, 0)

				local var_212_34 = manager.ui.mainCamera.transform.position - var_212_27.position

				var_212_27.forward = Vector3.New(var_212_34.x, var_212_34.y, var_212_34.z)

				local var_212_35 = var_212_27.localEulerAngles

				var_212_35.z = 0
				var_212_35.x = 0
				var_212_27.localEulerAngles = var_212_35
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_36 = 2.425
			local var_212_37 = 0.425

			if var_212_36 < arg_209_1.time_ and arg_209_1.time_ <= var_212_36 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_38 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_38:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_39 = arg_209_1:GetWordFromCfg(910116052)
				local var_212_40 = arg_209_1:FormatText(var_212_39.content)

				arg_209_1.text_.text = var_212_40

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_41 = 17
				local var_212_42 = utf8.len(var_212_40)
				local var_212_43 = var_212_41 <= 0 and var_212_37 or var_212_37 * (var_212_42 / var_212_41)

				if var_212_43 > 0 and var_212_37 < var_212_43 then
					arg_209_1.talkMaxDuration = var_212_43
					var_212_36 = var_212_36 + 0.3

					if var_212_43 + var_212_36 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_43 + var_212_36
					end
				end

				arg_209_1.text_.text = var_212_40
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_44 = var_212_36 + 0.3
			local var_212_45 = math.max(var_212_37, arg_209_1.talkMaxDuration)

			if var_212_44 <= arg_209_1.time_ and arg_209_1.time_ < var_212_44 + var_212_45 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_44) / var_212_45

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_44 + var_212_45 and arg_209_1.time_ < var_212_44 + var_212_45 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play910116053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 910116053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play910116054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.375

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[410].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:GetWordFromCfg(910116053)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 15
				local var_218_6 = utf8.len(var_218_4)
				local var_218_7 = var_218_5 <= 0 and var_218_1 or var_218_1 * (var_218_6 / var_218_5)

				if var_218_7 > 0 and var_218_1 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_0
					end
				end

				arg_215_1.text_.text = var_218_4
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_1, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_0) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_8 and arg_215_1.time_ < var_218_0 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play910116054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 910116054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play910116055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 0.975

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_2 = arg_219_1:FormatText(StoryNameCfg[318].name)

				arg_219_1.leftNameTxt_.text = var_222_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(910116054)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 39
				local var_222_6 = utf8.len(var_222_4)
				local var_222_7 = var_222_5 <= 0 and var_222_1 or var_222_1 * (var_222_6 / var_222_5)

				if var_222_7 > 0 and var_222_1 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play910116055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 910116055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play910116056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0
			local var_226_1 = 0.35

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_2 = arg_223_1:FormatText(StoryNameCfg[410].name)

				arg_223_1.leftNameTxt_.text = var_226_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(910116055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 14
				local var_226_6 = utf8.len(var_226_4)
				local var_226_7 = var_226_5 <= 0 and var_226_1 or var_226_1 * (var_226_6 / var_226_5)

				if var_226_7 > 0 and var_226_1 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_0
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_1, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_0) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_8 and arg_223_1.time_ < var_226_0 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play910116056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 910116056
		arg_227_1.duration_ = 7

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play910116057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = "ST40"

			if arg_227_1.bgs_[var_230_0] == nil then
				local var_230_1 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_230_0)
				var_230_1.name = var_230_0
				var_230_1.transform.parent = arg_227_1.stage_.transform
				var_230_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_[var_230_0] = var_230_1
			end

			local var_230_2 = 0

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				local var_230_3 = manager.ui.mainCamera.transform.localPosition
				local var_230_4 = Vector3.New(0, 0, 10) + Vector3.New(var_230_3.x, var_230_3.y, 0)
				local var_230_5 = arg_227_1.bgs_.ST40

				var_230_5.transform.localPosition = var_230_4
				var_230_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_6 = var_230_5:GetComponent("SpriteRenderer")

				if var_230_6 and var_230_6.sprite then
					local var_230_7 = (var_230_5.transform.localPosition - var_230_3).z
					local var_230_8 = manager.ui.mainCameraCom_
					local var_230_9 = 2 * var_230_7 * Mathf.Tan(var_230_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_230_10 = var_230_9 * var_230_8.aspect
					local var_230_11 = var_230_6.sprite.bounds.size.x
					local var_230_12 = var_230_6.sprite.bounds.size.y
					local var_230_13 = var_230_10 / var_230_11
					local var_230_14 = var_230_9 / var_230_12
					local var_230_15 = var_230_14 < var_230_13 and var_230_13 or var_230_14

					var_230_5.transform.localScale = Vector3.New(var_230_15, var_230_15, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "ST40" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_17 = 2

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17
				local var_230_19 = Color.New(0, 0, 0)

				var_230_19.a = Mathf.Lerp(1, 0, var_230_18)
				arg_227_1.mask_.color = var_230_19
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 then
				local var_230_20 = Color.New(0, 0, 0)
				local var_230_21 = 0

				arg_227_1.mask_.enabled = false
				var_230_20.a = var_230_21
				arg_227_1.mask_.color = var_230_20
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_22 = 2
			local var_230_23 = 1.275

			if var_230_22 < arg_227_1.time_ and arg_227_1.time_ <= var_230_22 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_24 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_24:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_25 = arg_227_1:GetWordFromCfg(910116056)
				local var_230_26 = arg_227_1:FormatText(var_230_25.content)

				arg_227_1.text_.text = var_230_26

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_27 = 51
				local var_230_28 = utf8.len(var_230_26)
				local var_230_29 = var_230_27 <= 0 and var_230_23 or var_230_23 * (var_230_28 / var_230_27)

				if var_230_29 > 0 and var_230_23 < var_230_29 then
					arg_227_1.talkMaxDuration = var_230_29
					var_230_22 = var_230_22 + 0.3

					if var_230_29 + var_230_22 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_29 + var_230_22
					end
				end

				arg_227_1.text_.text = var_230_26
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_30 = var_230_22 + 0.3
			local var_230_31 = math.max(var_230_23, arg_227_1.talkMaxDuration)

			if var_230_30 <= arg_227_1.time_ and arg_227_1.time_ < var_230_30 + var_230_31 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_30) / var_230_31

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_30 + var_230_31 and arg_227_1.time_ < var_230_30 + var_230_31 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play910116057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910116057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910116058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1074ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1074ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1074ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["1074ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1074ui_story == nil then
				arg_233_1.var_.characterEffect1074ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect1074ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect1074ui_story then
				arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_15 = "1072ui_story"

			if arg_233_1.actors_[var_236_15] == nil then
				local var_236_16 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_236_16) then
					local var_236_17 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_233_1.stage_.transform)

					var_236_17.name = var_236_15
					var_236_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_233_1.actors_[var_236_15] = var_236_17

					local var_236_18 = var_236_17:GetComponentInChildren(typeof(CharacterEffect))

					var_236_18.enabled = true

					local var_236_19 = GameObjectTools.GetOrAddComponent(var_236_17, typeof(DynamicBoneHelper))

					if var_236_19 then
						var_236_19:EnableDynamicBone(false)
					end

					arg_233_1:ShowWeapon(var_236_18.transform, false)

					arg_233_1.var_[var_236_15 .. "Animator"] = var_236_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_233_1.var_[var_236_15 .. "Animator"].applyRootMotion = true
					arg_233_1.var_[var_236_15 .. "LipSync"] = var_236_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_236_20 = arg_233_1.actors_["1072ui_story"].transform
			local var_236_21 = 0

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.var_.moveOldPos1072ui_story = var_236_20.localPosition
			end

			local var_236_22 = 0.001

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_22 then
				local var_236_23 = (arg_233_1.time_ - var_236_21) / var_236_22
				local var_236_24 = Vector3.New(0.7, -0.71, -6)

				var_236_20.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1072ui_story, var_236_24, var_236_23)

				local var_236_25 = manager.ui.mainCamera.transform.position - var_236_20.position

				var_236_20.forward = Vector3.New(var_236_25.x, var_236_25.y, var_236_25.z)

				local var_236_26 = var_236_20.localEulerAngles

				var_236_26.z = 0
				var_236_26.x = 0
				var_236_20.localEulerAngles = var_236_26
			end

			if arg_233_1.time_ >= var_236_21 + var_236_22 and arg_233_1.time_ < var_236_21 + var_236_22 + arg_236_0 then
				var_236_20.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_236_27 = manager.ui.mainCamera.transform.position - var_236_20.position

				var_236_20.forward = Vector3.New(var_236_27.x, var_236_27.y, var_236_27.z)

				local var_236_28 = var_236_20.localEulerAngles

				var_236_28.z = 0
				var_236_28.x = 0
				var_236_20.localEulerAngles = var_236_28
			end

			local var_236_29 = arg_233_1.actors_["1072ui_story"]
			local var_236_30 = 0

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.characterEffect1072ui_story == nil then
				arg_233_1.var_.characterEffect1072ui_story = var_236_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_31 = 0.200000002980232

			if var_236_30 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_31 and not isNil(var_236_29) then
				local var_236_32 = (arg_233_1.time_ - var_236_30) / var_236_31

				if arg_233_1.var_.characterEffect1072ui_story and not isNil(var_236_29) then
					local var_236_33 = Mathf.Lerp(0, 0.5, var_236_32)

					arg_233_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1072ui_story.fillRatio = var_236_33
				end
			end

			if arg_233_1.time_ >= var_236_30 + var_236_31 and arg_233_1.time_ < var_236_30 + var_236_31 + arg_236_0 and not isNil(var_236_29) and arg_233_1.var_.characterEffect1072ui_story then
				local var_236_34 = 0.5

				arg_233_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1072ui_story.fillRatio = var_236_34
			end

			local var_236_35 = 0

			if var_236_35 < arg_233_1.time_ and arg_233_1.time_ <= var_236_35 + arg_236_0 then
				arg_233_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_236_36 = 0
			local var_236_37 = 0.8

			if var_236_36 < arg_233_1.time_ and arg_233_1.time_ <= var_236_36 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_38 = arg_233_1:FormatText(StoryNameCfg[410].name)

				arg_233_1.leftNameTxt_.text = var_236_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_39 = arg_233_1:GetWordFromCfg(910116057)
				local var_236_40 = arg_233_1:FormatText(var_236_39.content)

				arg_233_1.text_.text = var_236_40

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_41 = 32
				local var_236_42 = utf8.len(var_236_40)
				local var_236_43 = var_236_41 <= 0 and var_236_37 or var_236_37 * (var_236_42 / var_236_41)

				if var_236_43 > 0 and var_236_37 < var_236_43 then
					arg_233_1.talkMaxDuration = var_236_43

					if var_236_43 + var_236_36 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_43 + var_236_36
					end
				end

				arg_233_1.text_.text = var_236_40
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_44 = math.max(var_236_37, arg_233_1.talkMaxDuration)

			if var_236_36 <= arg_233_1.time_ and arg_233_1.time_ < var_236_36 + var_236_44 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_36) / var_236_44

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_36 + var_236_44 and arg_233_1.time_ < var_236_36 + var_236_44 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play910116058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910116058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910116059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1072ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1072ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(0.7, -0.71, -6)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1072ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1072ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1072ui_story == nil then
				arg_237_1.var_.characterEffect1072ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1072ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1072ui_story then
				arg_237_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_240_15 = arg_237_1.actors_["1074ui_story"]
			local var_240_16 = 0

			if var_240_16 < arg_237_1.time_ and arg_237_1.time_ <= var_240_16 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1074ui_story == nil then
				arg_237_1.var_.characterEffect1074ui_story = var_240_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_17 = 0.200000002980232

			if var_240_16 <= arg_237_1.time_ and arg_237_1.time_ < var_240_16 + var_240_17 and not isNil(var_240_15) then
				local var_240_18 = (arg_237_1.time_ - var_240_16) / var_240_17

				if arg_237_1.var_.characterEffect1074ui_story and not isNil(var_240_15) then
					local var_240_19 = Mathf.Lerp(0, 0.5, var_240_18)

					arg_237_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1074ui_story.fillRatio = var_240_19
				end
			end

			if arg_237_1.time_ >= var_240_16 + var_240_17 and arg_237_1.time_ < var_240_16 + var_240_17 + arg_240_0 and not isNil(var_240_15) and arg_237_1.var_.characterEffect1074ui_story then
				local var_240_20 = 0.5

				arg_237_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1074ui_story.fillRatio = var_240_20
			end

			local var_240_21 = 0
			local var_240_22 = 0.625

			if var_240_21 < arg_237_1.time_ and arg_237_1.time_ <= var_240_21 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_23 = arg_237_1:FormatText(StoryNameCfg[379].name)

				arg_237_1.leftNameTxt_.text = var_240_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_24 = arg_237_1:GetWordFromCfg(910116058)
				local var_240_25 = arg_237_1:FormatText(var_240_24.content)

				arg_237_1.text_.text = var_240_25

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_26 = 25
				local var_240_27 = utf8.len(var_240_25)
				local var_240_28 = var_240_26 <= 0 and var_240_22 or var_240_22 * (var_240_27 / var_240_26)

				if var_240_28 > 0 and var_240_22 < var_240_28 then
					arg_237_1.talkMaxDuration = var_240_28

					if var_240_28 + var_240_21 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_28 + var_240_21
					end
				end

				arg_237_1.text_.text = var_240_25
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_29 = math.max(var_240_22, arg_237_1.talkMaxDuration)

			if var_240_21 <= arg_237_1.time_ and arg_237_1.time_ < var_240_21 + var_240_29 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_21) / var_240_29

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_21 + var_240_29 and arg_237_1.time_ < var_240_21 + var_240_29 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play910116059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910116059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910116060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1074ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1074ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1074ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1074ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1074ui_story == nil then
				arg_241_1.var_.characterEffect1074ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1074ui_story and not isNil(var_244_9) then
					arg_241_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1074ui_story then
				arg_241_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_244_13 = 0

			if var_244_13 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_244_14 = 0

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_15 = arg_241_1.actors_["1072ui_story"]
			local var_244_16 = 0

			if var_244_16 < arg_241_1.time_ and arg_241_1.time_ <= var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect1072ui_story == nil then
				arg_241_1.var_.characterEffect1072ui_story = var_244_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_17 = 0.200000002980232

			if var_244_16 <= arg_241_1.time_ and arg_241_1.time_ < var_244_16 + var_244_17 and not isNil(var_244_15) then
				local var_244_18 = (arg_241_1.time_ - var_244_16) / var_244_17

				if arg_241_1.var_.characterEffect1072ui_story and not isNil(var_244_15) then
					local var_244_19 = Mathf.Lerp(0, 0.5, var_244_18)

					arg_241_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1072ui_story.fillRatio = var_244_19
				end
			end

			if arg_241_1.time_ >= var_244_16 + var_244_17 and arg_241_1.time_ < var_244_16 + var_244_17 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect1072ui_story then
				local var_244_20 = 0.5

				arg_241_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1072ui_story.fillRatio = var_244_20
			end

			local var_244_21 = 0
			local var_244_22 = 0.525

			if var_244_21 < arg_241_1.time_ and arg_241_1.time_ <= var_244_21 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_23 = arg_241_1:FormatText(StoryNameCfg[410].name)

				arg_241_1.leftNameTxt_.text = var_244_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_24 = arg_241_1:GetWordFromCfg(910116059)
				local var_244_25 = arg_241_1:FormatText(var_244_24.content)

				arg_241_1.text_.text = var_244_25

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_26 = 21
				local var_244_27 = utf8.len(var_244_25)
				local var_244_28 = var_244_26 <= 0 and var_244_22 or var_244_22 * (var_244_27 / var_244_26)

				if var_244_28 > 0 and var_244_22 < var_244_28 then
					arg_241_1.talkMaxDuration = var_244_28

					if var_244_28 + var_244_21 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_28 + var_244_21
					end
				end

				arg_241_1.text_.text = var_244_25
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_29 = math.max(var_244_22, arg_241_1.talkMaxDuration)

			if var_244_21 <= arg_241_1.time_ and arg_241_1.time_ < var_244_21 + var_244_29 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_21) / var_244_29

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_21 + var_244_29 and arg_241_1.time_ < var_244_21 + var_244_29 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play910116060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 910116060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play910116061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1072ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1072ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0.7, -0.71, -6)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1072ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1072ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1072ui_story == nil then
				arg_245_1.var_.characterEffect1072ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect1072ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1072ui_story then
				arg_245_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_248_13 = 0

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_15 = arg_245_1.actors_["1074ui_story"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1074ui_story == nil then
				arg_245_1.var_.characterEffect1074ui_story = var_248_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_17 = 0.200000002980232

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.characterEffect1074ui_story and not isNil(var_248_15) then
					local var_248_19 = Mathf.Lerp(0, 0.5, var_248_18)

					arg_245_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1074ui_story.fillRatio = var_248_19
				end
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1074ui_story then
				local var_248_20 = 0.5

				arg_245_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1074ui_story.fillRatio = var_248_20
			end

			local var_248_21 = 0
			local var_248_22 = 0.975

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_23 = arg_245_1:FormatText(StoryNameCfg[379].name)

				arg_245_1.leftNameTxt_.text = var_248_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_24 = arg_245_1:GetWordFromCfg(910116060)
				local var_248_25 = arg_245_1:FormatText(var_248_24.content)

				arg_245_1.text_.text = var_248_25

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_26 = 39
				local var_248_27 = utf8.len(var_248_25)
				local var_248_28 = var_248_26 <= 0 and var_248_22 or var_248_22 * (var_248_27 / var_248_26)

				if var_248_28 > 0 and var_248_22 < var_248_28 then
					arg_245_1.talkMaxDuration = var_248_28

					if var_248_28 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_28 + var_248_21
					end
				end

				arg_245_1.text_.text = var_248_25
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_29 = math.max(var_248_22, arg_245_1.talkMaxDuration)

			if var_248_21 <= arg_245_1.time_ and arg_245_1.time_ < var_248_21 + var_248_29 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_21) / var_248_29

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_21 + var_248_29 and arg_245_1.time_ < var_248_21 + var_248_29 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play910116061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 910116061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play910116062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1074ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos1074ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1074ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["1074ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1074ui_story == nil then
				arg_249_1.var_.characterEffect1074ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect1074ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect1074ui_story then
				arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_252_13 = arg_249_1.actors_["1072ui_story"]
			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 and not isNil(var_252_13) and arg_249_1.var_.characterEffect1072ui_story == nil then
				arg_249_1.var_.characterEffect1072ui_story = var_252_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_15 = 0.200000002980232

			if var_252_14 <= arg_249_1.time_ and arg_249_1.time_ < var_252_14 + var_252_15 and not isNil(var_252_13) then
				local var_252_16 = (arg_249_1.time_ - var_252_14) / var_252_15

				if arg_249_1.var_.characterEffect1072ui_story and not isNil(var_252_13) then
					local var_252_17 = Mathf.Lerp(0, 0.5, var_252_16)

					arg_249_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1072ui_story.fillRatio = var_252_17
				end
			end

			if arg_249_1.time_ >= var_252_14 + var_252_15 and arg_249_1.time_ < var_252_14 + var_252_15 + arg_252_0 and not isNil(var_252_13) and arg_249_1.var_.characterEffect1072ui_story then
				local var_252_18 = 0.5

				arg_249_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1072ui_story.fillRatio = var_252_18
			end

			local var_252_19 = 0
			local var_252_20 = 0.425

			if var_252_19 < arg_249_1.time_ and arg_249_1.time_ <= var_252_19 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_21 = arg_249_1:FormatText(StoryNameCfg[410].name)

				arg_249_1.leftNameTxt_.text = var_252_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_22 = arg_249_1:GetWordFromCfg(910116061)
				local var_252_23 = arg_249_1:FormatText(var_252_22.content)

				arg_249_1.text_.text = var_252_23

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_24 = 17
				local var_252_25 = utf8.len(var_252_23)
				local var_252_26 = var_252_24 <= 0 and var_252_20 or var_252_20 * (var_252_25 / var_252_24)

				if var_252_26 > 0 and var_252_20 < var_252_26 then
					arg_249_1.talkMaxDuration = var_252_26

					if var_252_26 + var_252_19 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_26 + var_252_19
					end
				end

				arg_249_1.text_.text = var_252_23
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_27 = math.max(var_252_20, arg_249_1.talkMaxDuration)

			if var_252_19 <= arg_249_1.time_ and arg_249_1.time_ < var_252_19 + var_252_27 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_19) / var_252_27

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_19 + var_252_27 and arg_249_1.time_ < var_252_19 + var_252_27 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play910116062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 910116062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play910116063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1072ui_story"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1072ui_story = var_256_0.localPosition
			end

			local var_256_2 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2
				local var_256_4 = Vector3.New(0.7, -0.71, -6)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1072ui_story, var_256_4, var_256_3)

				local var_256_5 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_5.x, var_256_5.y, var_256_5.z)

				local var_256_6 = var_256_0.localEulerAngles

				var_256_6.z = 0
				var_256_6.x = 0
				var_256_0.localEulerAngles = var_256_6
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_256_7 = manager.ui.mainCamera.transform.position - var_256_0.position

				var_256_0.forward = Vector3.New(var_256_7.x, var_256_7.y, var_256_7.z)

				local var_256_8 = var_256_0.localEulerAngles

				var_256_8.z = 0
				var_256_8.x = 0
				var_256_0.localEulerAngles = var_256_8
			end

			local var_256_9 = arg_253_1.actors_["1072ui_story"]
			local var_256_10 = 0

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1072ui_story == nil then
				arg_253_1.var_.characterEffect1072ui_story = var_256_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_11 = 0.200000002980232

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_11 and not isNil(var_256_9) then
				local var_256_12 = (arg_253_1.time_ - var_256_10) / var_256_11

				if arg_253_1.var_.characterEffect1072ui_story and not isNil(var_256_9) then
					arg_253_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_10 + var_256_11 and arg_253_1.time_ < var_256_10 + var_256_11 + arg_256_0 and not isNil(var_256_9) and arg_253_1.var_.characterEffect1072ui_story then
				arg_253_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_256_13 = 0

			if var_256_13 < arg_253_1.time_ and arg_253_1.time_ <= var_256_13 + arg_256_0 then
				arg_253_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_256_14 = 0

			if var_256_14 < arg_253_1.time_ and arg_253_1.time_ <= var_256_14 + arg_256_0 then
				arg_253_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_256_15 = arg_253_1.actors_["1074ui_story"]
			local var_256_16 = 0

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.characterEffect1074ui_story == nil then
				arg_253_1.var_.characterEffect1074ui_story = var_256_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_17 = 0.200000002980232

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_17 and not isNil(var_256_15) then
				local var_256_18 = (arg_253_1.time_ - var_256_16) / var_256_17

				if arg_253_1.var_.characterEffect1074ui_story and not isNil(var_256_15) then
					local var_256_19 = Mathf.Lerp(0, 0.5, var_256_18)

					arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1074ui_story.fillRatio = var_256_19
				end
			end

			if arg_253_1.time_ >= var_256_16 + var_256_17 and arg_253_1.time_ < var_256_16 + var_256_17 + arg_256_0 and not isNil(var_256_15) and arg_253_1.var_.characterEffect1074ui_story then
				local var_256_20 = 0.5

				arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1074ui_story.fillRatio = var_256_20
			end

			local var_256_21 = 0
			local var_256_22 = 0.825

			if var_256_21 < arg_253_1.time_ and arg_253_1.time_ <= var_256_21 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_23 = arg_253_1:FormatText(StoryNameCfg[379].name)

				arg_253_1.leftNameTxt_.text = var_256_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_24 = arg_253_1:GetWordFromCfg(910116062)
				local var_256_25 = arg_253_1:FormatText(var_256_24.content)

				arg_253_1.text_.text = var_256_25

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_26 = 33
				local var_256_27 = utf8.len(var_256_25)
				local var_256_28 = var_256_26 <= 0 and var_256_22 or var_256_22 * (var_256_27 / var_256_26)

				if var_256_28 > 0 and var_256_22 < var_256_28 then
					arg_253_1.talkMaxDuration = var_256_28

					if var_256_28 + var_256_21 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_28 + var_256_21
					end
				end

				arg_253_1.text_.text = var_256_25
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_29 = math.max(var_256_22, arg_253_1.talkMaxDuration)

			if var_256_21 <= arg_253_1.time_ and arg_253_1.time_ < var_256_21 + var_256_29 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_21) / var_256_29

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_21 + var_256_29 and arg_253_1.time_ < var_256_21 + var_256_29 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play910116063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 910116063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play910116064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1074ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos1074ui_story = var_260_0.localPosition
			end

			local var_260_2 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2
				local var_260_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1074ui_story, var_260_4, var_260_3)

				local var_260_5 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_5.x, var_260_5.y, var_260_5.z)

				local var_260_6 = var_260_0.localEulerAngles

				var_260_6.z = 0
				var_260_6.x = 0
				var_260_0.localEulerAngles = var_260_6
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_260_7 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_7.x, var_260_7.y, var_260_7.z)

				local var_260_8 = var_260_0.localEulerAngles

				var_260_8.z = 0
				var_260_8.x = 0
				var_260_0.localEulerAngles = var_260_8
			end

			local var_260_9 = arg_257_1.actors_["1074ui_story"]
			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1074ui_story == nil then
				arg_257_1.var_.characterEffect1074ui_story = var_260_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_11 = 0.200000002980232

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 and not isNil(var_260_9) then
				local var_260_12 = (arg_257_1.time_ - var_260_10) / var_260_11

				if arg_257_1.var_.characterEffect1074ui_story and not isNil(var_260_9) then
					arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 and not isNil(var_260_9) and arg_257_1.var_.characterEffect1074ui_story then
				arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_260_13 = arg_257_1.actors_["1072ui_story"]
			local var_260_14 = 0

			if var_260_14 < arg_257_1.time_ and arg_257_1.time_ <= var_260_14 + arg_260_0 and not isNil(var_260_13) and arg_257_1.var_.characterEffect1072ui_story == nil then
				arg_257_1.var_.characterEffect1072ui_story = var_260_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_15 = 0.200000002980232

			if var_260_14 <= arg_257_1.time_ and arg_257_1.time_ < var_260_14 + var_260_15 and not isNil(var_260_13) then
				local var_260_16 = (arg_257_1.time_ - var_260_14) / var_260_15

				if arg_257_1.var_.characterEffect1072ui_story and not isNil(var_260_13) then
					local var_260_17 = Mathf.Lerp(0, 0.5, var_260_16)

					arg_257_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1072ui_story.fillRatio = var_260_17
				end
			end

			if arg_257_1.time_ >= var_260_14 + var_260_15 and arg_257_1.time_ < var_260_14 + var_260_15 + arg_260_0 and not isNil(var_260_13) and arg_257_1.var_.characterEffect1072ui_story then
				local var_260_18 = 0.5

				arg_257_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1072ui_story.fillRatio = var_260_18
			end

			local var_260_19 = 0
			local var_260_20 = 1

			if var_260_19 < arg_257_1.time_ and arg_257_1.time_ <= var_260_19 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_21 = arg_257_1:FormatText(StoryNameCfg[410].name)

				arg_257_1.leftNameTxt_.text = var_260_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_22 = arg_257_1:GetWordFromCfg(910116063)
				local var_260_23 = arg_257_1:FormatText(var_260_22.content)

				arg_257_1.text_.text = var_260_23

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_24 = 18
				local var_260_25 = utf8.len(var_260_23)
				local var_260_26 = var_260_24 <= 0 and var_260_20 or var_260_20 * (var_260_25 / var_260_24)

				if var_260_26 > 0 and var_260_20 < var_260_26 then
					arg_257_1.talkMaxDuration = var_260_26

					if var_260_26 + var_260_19 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_26 + var_260_19
					end
				end

				arg_257_1.text_.text = var_260_23
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_27 = math.max(var_260_20, arg_257_1.talkMaxDuration)

			if var_260_19 <= arg_257_1.time_ and arg_257_1.time_ < var_260_19 + var_260_27 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_19) / var_260_27

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_19 + var_260_27 and arg_257_1.time_ < var_260_19 + var_260_27 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play910116064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 910116064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play910116065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1072ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1072ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0.7, -0.71, -6)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1072ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1072ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1072ui_story == nil then
				arg_261_1.var_.characterEffect1072ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1072ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1072ui_story then
				arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_15 = arg_261_1.actors_["1074ui_story"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect1074ui_story == nil then
				arg_261_1.var_.characterEffect1074ui_story = var_264_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_17 = 0.200000002980232

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.characterEffect1074ui_story and not isNil(var_264_15) then
					local var_264_19 = Mathf.Lerp(0, 0.5, var_264_18)

					arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1074ui_story.fillRatio = var_264_19
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect1074ui_story then
				local var_264_20 = 0.5

				arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1074ui_story.fillRatio = var_264_20
			end

			local var_264_21 = 0
			local var_264_22 = 1.225

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_23 = arg_261_1:FormatText(StoryNameCfg[379].name)

				arg_261_1.leftNameTxt_.text = var_264_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_24 = arg_261_1:GetWordFromCfg(910116064)
				local var_264_25 = arg_261_1:FormatText(var_264_24.content)

				arg_261_1.text_.text = var_264_25

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_26 = 63
				local var_264_27 = utf8.len(var_264_25)
				local var_264_28 = var_264_26 <= 0 and var_264_22 or var_264_22 * (var_264_27 / var_264_26)

				if var_264_28 > 0 and var_264_22 < var_264_28 then
					arg_261_1.talkMaxDuration = var_264_28

					if var_264_28 + var_264_21 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_28 + var_264_21
					end
				end

				arg_261_1.text_.text = var_264_25
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_29 = math.max(var_264_22, arg_261_1.talkMaxDuration)

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_29 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_21) / var_264_29

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_21 + var_264_29 and arg_261_1.time_ < var_264_21 + var_264_29 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play910116065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 910116065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play910116066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.425

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[379].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(910116065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 65
				local var_268_6 = utf8.len(var_268_4)
				local var_268_7 = var_268_5 <= 0 and var_268_1 or var_268_1 * (var_268_6 / var_268_5)

				if var_268_7 > 0 and var_268_1 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play910116066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 910116066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play910116067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1074ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1074ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1074ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1074ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1074ui_story == nil then
				arg_269_1.var_.characterEffect1074ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1074ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1074ui_story then
				arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_272_13 = arg_269_1.actors_["1072ui_story"]
			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect1072ui_story == nil then
				arg_269_1.var_.characterEffect1072ui_story = var_272_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_15 = 0.200000002980232

			if var_272_14 <= arg_269_1.time_ and arg_269_1.time_ < var_272_14 + var_272_15 and not isNil(var_272_13) then
				local var_272_16 = (arg_269_1.time_ - var_272_14) / var_272_15

				if arg_269_1.var_.characterEffect1072ui_story and not isNil(var_272_13) then
					local var_272_17 = Mathf.Lerp(0, 0.5, var_272_16)

					arg_269_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1072ui_story.fillRatio = var_272_17
				end
			end

			if arg_269_1.time_ >= var_272_14 + var_272_15 and arg_269_1.time_ < var_272_14 + var_272_15 + arg_272_0 and not isNil(var_272_13) and arg_269_1.var_.characterEffect1072ui_story then
				local var_272_18 = 0.5

				arg_269_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1072ui_story.fillRatio = var_272_18
			end

			local var_272_19 = 0
			local var_272_20 = 0.65

			if var_272_19 < arg_269_1.time_ and arg_269_1.time_ <= var_272_19 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_21 = arg_269_1:FormatText(StoryNameCfg[410].name)

				arg_269_1.leftNameTxt_.text = var_272_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_22 = arg_269_1:GetWordFromCfg(910116066)
				local var_272_23 = arg_269_1:FormatText(var_272_22.content)

				arg_269_1.text_.text = var_272_23

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_24 = 31
				local var_272_25 = utf8.len(var_272_23)
				local var_272_26 = var_272_24 <= 0 and var_272_20 or var_272_20 * (var_272_25 / var_272_24)

				if var_272_26 > 0 and var_272_20 < var_272_26 then
					arg_269_1.talkMaxDuration = var_272_26

					if var_272_26 + var_272_19 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_26 + var_272_19
					end
				end

				arg_269_1.text_.text = var_272_23
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_27 = math.max(var_272_20, arg_269_1.talkMaxDuration)

			if var_272_19 <= arg_269_1.time_ and arg_269_1.time_ < var_272_19 + var_272_27 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_19) / var_272_27

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_19 + var_272_27 and arg_269_1.time_ < var_272_19 + var_272_27 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play910116067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 910116067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play910116068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1072ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1072ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0.7, -0.71, -6)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1072ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1072ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1072ui_story == nil then
				arg_273_1.var_.characterEffect1072ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1072ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1072ui_story then
				arg_273_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_276_13 = 0

			if var_276_13 < arg_273_1.time_ and arg_273_1.time_ <= var_276_13 + arg_276_0 then
				arg_273_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_15 = arg_273_1.actors_["1074ui_story"]
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.characterEffect1074ui_story == nil then
				arg_273_1.var_.characterEffect1074ui_story = var_276_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_17 = 0.200000002980232

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 and not isNil(var_276_15) then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17

				if arg_273_1.var_.characterEffect1074ui_story and not isNil(var_276_15) then
					local var_276_19 = Mathf.Lerp(0, 0.5, var_276_18)

					arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1074ui_story.fillRatio = var_276_19
				end
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 and not isNil(var_276_15) and arg_273_1.var_.characterEffect1074ui_story then
				local var_276_20 = 0.5

				arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1074ui_story.fillRatio = var_276_20
			end

			local var_276_21 = 0
			local var_276_22 = 0.925

			if var_276_21 < arg_273_1.time_ and arg_273_1.time_ <= var_276_21 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_23 = arg_273_1:FormatText(StoryNameCfg[379].name)

				arg_273_1.leftNameTxt_.text = var_276_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_24 = arg_273_1:GetWordFromCfg(910116067)
				local var_276_25 = arg_273_1:FormatText(var_276_24.content)

				arg_273_1.text_.text = var_276_25

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_26 = 40
				local var_276_27 = utf8.len(var_276_25)
				local var_276_28 = var_276_26 <= 0 and var_276_22 or var_276_22 * (var_276_27 / var_276_26)

				if var_276_28 > 0 and var_276_22 < var_276_28 then
					arg_273_1.talkMaxDuration = var_276_28

					if var_276_28 + var_276_21 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_28 + var_276_21
					end
				end

				arg_273_1.text_.text = var_276_25
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_29 = math.max(var_276_22, arg_273_1.talkMaxDuration)

			if var_276_21 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_29 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_21) / var_276_29

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_21 + var_276_29 and arg_273_1.time_ < var_276_21 + var_276_29 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play910116068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 910116068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play910116069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.425

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[379].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(910116068)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 17
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play910116069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 910116069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play910116070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_2 = 0
			local var_284_3 = 0.375

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_4 = arg_281_1:FormatText(StoryNameCfg[379].name)

				arg_281_1.leftNameTxt_.text = var_284_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(910116069)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 15
				local var_284_8 = utf8.len(var_284_6)
				local var_284_9 = var_284_7 <= 0 and var_284_3 or var_284_3 * (var_284_8 / var_284_7)

				if var_284_9 > 0 and var_284_3 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play910116070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 910116070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play910116071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1072ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1072ui_story == nil then
				arg_285_1.var_.characterEffect1072ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1072ui_story and not isNil(var_288_0) then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1072ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1072ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1072ui_story.fillRatio = var_288_5
			end

			local var_288_6 = arg_285_1.actors_["1074ui_story"]
			local var_288_7 = 0

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = var_288_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_8 = 0.200000002980232

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_8 and not isNil(var_288_6) then
				local var_288_9 = (arg_285_1.time_ - var_288_7) / var_288_8

				if arg_285_1.var_.characterEffect1074ui_story and not isNil(var_288_6) then
					arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_7 + var_288_8 and arg_285_1.time_ < var_288_7 + var_288_8 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1074ui_story then
				arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_288_10 = 0
			local var_288_11 = 0.25

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_12 = arg_285_1:FormatText(StoryNameCfg[410].name)

				arg_285_1.leftNameTxt_.text = var_288_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(910116070)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_15 = 10
				local var_288_16 = utf8.len(var_288_14)
				local var_288_17 = var_288_15 <= 0 and var_288_11 or var_288_11 * (var_288_16 / var_288_15)

				if var_288_17 > 0 and var_288_11 < var_288_17 then
					arg_285_1.talkMaxDuration = var_288_17

					if var_288_17 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_10
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_18 = math.max(var_288_11, arg_285_1.talkMaxDuration)

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_18 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_10) / var_288_18

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_10 + var_288_18 and arg_285_1.time_ < var_288_10 + var_288_18 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play910116071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 910116071
		arg_289_1.duration_ = 9

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play910116072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = "NI0201"

			if arg_289_1.bgs_[var_292_0] == nil then
				local var_292_1 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_0)
				var_292_1.name = var_292_0
				var_292_1.transform.parent = arg_289_1.stage_.transform
				var_292_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_0] = var_292_1
			end

			local var_292_2 = 2

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				local var_292_3 = manager.ui.mainCamera.transform.localPosition
				local var_292_4 = Vector3.New(0, 0, 10) + Vector3.New(var_292_3.x, var_292_3.y, 0)
				local var_292_5 = arg_289_1.bgs_.NI0201

				var_292_5.transform.localPosition = var_292_4
				var_292_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_6 = var_292_5:GetComponent("SpriteRenderer")

				if var_292_6 and var_292_6.sprite then
					local var_292_7 = (var_292_5.transform.localPosition - var_292_3).z
					local var_292_8 = manager.ui.mainCameraCom_
					local var_292_9 = 2 * var_292_7 * Mathf.Tan(var_292_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_10 = var_292_9 * var_292_8.aspect
					local var_292_11 = var_292_6.sprite.bounds.size.x
					local var_292_12 = var_292_6.sprite.bounds.size.y
					local var_292_13 = var_292_10 / var_292_11
					local var_292_14 = var_292_9 / var_292_12
					local var_292_15 = var_292_14 < var_292_13 and var_292_13 or var_292_14

					var_292_5.transform.localScale = Vector3.New(var_292_15, var_292_15, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "NI0201" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_17 = 2

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17
				local var_292_19 = Color.New(0, 0, 0)

				var_292_19.a = Mathf.Lerp(0, 1, var_292_18)
				arg_289_1.mask_.color = var_292_19
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 then
				local var_292_20 = Color.New(0, 0, 0)

				var_292_20.a = 1
				arg_289_1.mask_.color = var_292_20
			end

			local var_292_21 = 2

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_22 = 2

			if var_292_21 <= arg_289_1.time_ and arg_289_1.time_ < var_292_21 + var_292_22 then
				local var_292_23 = (arg_289_1.time_ - var_292_21) / var_292_22
				local var_292_24 = Color.New(0, 0, 0)

				var_292_24.a = Mathf.Lerp(1, 0, var_292_23)
				arg_289_1.mask_.color = var_292_24
			end

			if arg_289_1.time_ >= var_292_21 + var_292_22 and arg_289_1.time_ < var_292_21 + var_292_22 + arg_292_0 then
				local var_292_25 = Color.New(0, 0, 0)
				local var_292_26 = 0

				arg_289_1.mask_.enabled = false
				var_292_25.a = var_292_26
				arg_289_1.mask_.color = var_292_25
			end

			local var_292_27 = arg_289_1.actors_["1074ui_story"].transform
			local var_292_28 = 2

			if var_292_28 < arg_289_1.time_ and arg_289_1.time_ <= var_292_28 + arg_292_0 then
				arg_289_1.var_.moveOldPos1074ui_story = var_292_27.localPosition
			end

			local var_292_29 = 0.001

			if var_292_28 <= arg_289_1.time_ and arg_289_1.time_ < var_292_28 + var_292_29 then
				local var_292_30 = (arg_289_1.time_ - var_292_28) / var_292_29
				local var_292_31 = Vector3.New(0, 100, 0)

				var_292_27.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1074ui_story, var_292_31, var_292_30)

				local var_292_32 = manager.ui.mainCamera.transform.position - var_292_27.position

				var_292_27.forward = Vector3.New(var_292_32.x, var_292_32.y, var_292_32.z)

				local var_292_33 = var_292_27.localEulerAngles

				var_292_33.z = 0
				var_292_33.x = 0
				var_292_27.localEulerAngles = var_292_33
			end

			if arg_289_1.time_ >= var_292_28 + var_292_29 and arg_289_1.time_ < var_292_28 + var_292_29 + arg_292_0 then
				var_292_27.localPosition = Vector3.New(0, 100, 0)

				local var_292_34 = manager.ui.mainCamera.transform.position - var_292_27.position

				var_292_27.forward = Vector3.New(var_292_34.x, var_292_34.y, var_292_34.z)

				local var_292_35 = var_292_27.localEulerAngles

				var_292_35.z = 0
				var_292_35.x = 0
				var_292_27.localEulerAngles = var_292_35
			end

			local var_292_36 = arg_289_1.actors_["1072ui_story"].transform
			local var_292_37 = 2

			if var_292_37 < arg_289_1.time_ and arg_289_1.time_ <= var_292_37 + arg_292_0 then
				arg_289_1.var_.moveOldPos1072ui_story = var_292_36.localPosition
			end

			local var_292_38 = 0.001

			if var_292_37 <= arg_289_1.time_ and arg_289_1.time_ < var_292_37 + var_292_38 then
				local var_292_39 = (arg_289_1.time_ - var_292_37) / var_292_38
				local var_292_40 = Vector3.New(0, 100, 0)

				var_292_36.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1072ui_story, var_292_40, var_292_39)

				local var_292_41 = manager.ui.mainCamera.transform.position - var_292_36.position

				var_292_36.forward = Vector3.New(var_292_41.x, var_292_41.y, var_292_41.z)

				local var_292_42 = var_292_36.localEulerAngles

				var_292_42.z = 0
				var_292_42.x = 0
				var_292_36.localEulerAngles = var_292_42
			end

			if arg_289_1.time_ >= var_292_37 + var_292_38 and arg_289_1.time_ < var_292_37 + var_292_38 + arg_292_0 then
				var_292_36.localPosition = Vector3.New(0, 100, 0)

				local var_292_43 = manager.ui.mainCamera.transform.position - var_292_36.position

				var_292_36.forward = Vector3.New(var_292_43.x, var_292_43.y, var_292_43.z)

				local var_292_44 = var_292_36.localEulerAngles

				var_292_44.z = 0
				var_292_44.x = 0
				var_292_36.localEulerAngles = var_292_44
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_45 = 4
			local var_292_46 = 0.475

			if var_292_45 < arg_289_1.time_ and arg_289_1.time_ <= var_292_45 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_47 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_47:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_48 = arg_289_1:GetWordFromCfg(910116071)
				local var_292_49 = arg_289_1:FormatText(var_292_48.content)

				arg_289_1.text_.text = var_292_49

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_50 = 19
				local var_292_51 = utf8.len(var_292_49)
				local var_292_52 = var_292_50 <= 0 and var_292_46 or var_292_46 * (var_292_51 / var_292_50)

				if var_292_52 > 0 and var_292_46 < var_292_52 then
					arg_289_1.talkMaxDuration = var_292_52
					var_292_45 = var_292_45 + 0.3

					if var_292_52 + var_292_45 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_52 + var_292_45
					end
				end

				arg_289_1.text_.text = var_292_49
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_53 = var_292_45 + 0.3
			local var_292_54 = math.max(var_292_46, arg_289_1.talkMaxDuration)

			if var_292_53 <= arg_289_1.time_ and arg_289_1.time_ < var_292_53 + var_292_54 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_53) / var_292_54

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_53 + var_292_54 and arg_289_1.time_ < var_292_53 + var_292_54 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play910116072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 910116072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play910116073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.725

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[379].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(910116072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 29
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play910116073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 910116073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play910116074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.8

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[379].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(910116073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 32
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_8 and arg_299_1.time_ < var_302_0 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play910116074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 910116074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play910116075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.275

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:GetWordFromCfg(910116074)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 11
				local var_306_5 = utf8.len(var_306_3)
				local var_306_6 = var_306_4 <= 0 and var_306_1 or var_306_1 * (var_306_5 / var_306_4)

				if var_306_6 > 0 and var_306_1 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_7 and arg_303_1.time_ < var_306_0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play910116075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 910116075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play910116076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.525

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(910116075)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 21
				local var_310_5 = utf8.len(var_310_3)
				local var_310_6 = var_310_4 <= 0 and var_310_1 or var_310_1 * (var_310_5 / var_310_4)

				if var_310_6 > 0 and var_310_1 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_7 and arg_307_1.time_ < var_310_0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play910116076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 910116076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
			arg_311_1.auto_ = false
		end

		function arg_311_1.playNext_(arg_313_0)
			arg_311_1.onStoryFinished_()
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.475

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(910116076)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 19
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/NI0201"
	},
	voices = {}
}
