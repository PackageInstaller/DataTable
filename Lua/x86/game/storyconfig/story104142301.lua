return {
	Play414231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414231001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "H07j"

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
				local var_4_5 = arg_1_1.bgs_.H07j

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
					if iter_4_0 ~= "H07j" then
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

			local var_4_22 = "10089ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10089ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10089ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["10089ui_story"].transform
			local var_4_28 = 1.86666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10089ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -1.12, -5.99)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10089ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10089ui_story"]
			local var_4_37 = 1.86666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10089ui_story == nil then
				arg_1_1.var_.characterEffect10089ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10089ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10089ui_story then
				arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_4_40 = 1.86666666666667

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_41 = 1.86666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_42 = 2
			local var_4_43 = 0.35

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_44 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_44:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_45 = arg_1_1:FormatText(StoryNameCfg[988].name)

				arg_1_1.leftNameTxt_.text = var_4_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_46 = arg_1_1:GetWordFromCfg(414231001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 14
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_43 or var_4_43 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_43 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_42 = var_4_42 + 0.3

					if var_4_50 + var_4_42 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_42
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_42 + 0.3
			local var_4_52 = math.max(var_4_43, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play414231002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 414231002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play414231003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["10089ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect10089ui_story == nil then
				arg_7_1.var_.characterEffect10089ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 and not isNil(var_10_0) then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect10089ui_story and not isNil(var_10_0) then
					local var_10_4 = Mathf.Lerp(0, 0.5, var_10_3)

					arg_7_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_7_1.var_.characterEffect10089ui_story.fillRatio = var_10_4
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect10089ui_story then
				local var_10_5 = 0.5

				arg_7_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_7_1.var_.characterEffect10089ui_story.fillRatio = var_10_5
			end

			local var_10_6 = 0
			local var_10_7 = 0.25

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_8 = arg_7_1:FormatText(StoryNameCfg[980].name)

				arg_7_1.leftNameTxt_.text = var_10_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_9 = arg_7_1:GetWordFromCfg(414231002)
				local var_10_10 = arg_7_1:FormatText(var_10_9.content)

				arg_7_1.text_.text = var_10_10

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_11 = 10
				local var_10_12 = utf8.len(var_10_10)
				local var_10_13 = var_10_11 <= 0 and var_10_7 or var_10_7 * (var_10_12 / var_10_11)

				if var_10_13 > 0 and var_10_7 < var_10_13 then
					arg_7_1.talkMaxDuration = var_10_13

					if var_10_13 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_13 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_10
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_14 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_14 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_14

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_14 and arg_7_1.time_ < var_10_6 + var_10_14 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play414231003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 414231003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play414231004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["10089ui_story"].transform
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.var_.moveOldPos10089ui_story = var_14_0.localPosition
			end

			local var_14_2 = 0.001

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2
				local var_14_4 = Vector3.New(0, -1.12, -5.99)

				var_14_0.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos10089ui_story, var_14_4, var_14_3)

				local var_14_5 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_5.x, var_14_5.y, var_14_5.z)

				local var_14_6 = var_14_0.localEulerAngles

				var_14_6.z = 0
				var_14_6.x = 0
				var_14_0.localEulerAngles = var_14_6
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 then
				var_14_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_14_7 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_7.x, var_14_7.y, var_14_7.z)

				local var_14_8 = var_14_0.localEulerAngles

				var_14_8.z = 0
				var_14_8.x = 0
				var_14_0.localEulerAngles = var_14_8
			end

			local var_14_9 = arg_11_1.actors_["10089ui_story"]
			local var_14_10 = 0

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect10089ui_story == nil then
				arg_11_1.var_.characterEffect10089ui_story = var_14_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_11 = 0.200000002980232

			if var_14_10 <= arg_11_1.time_ and arg_11_1.time_ < var_14_10 + var_14_11 and not isNil(var_14_9) then
				local var_14_12 = (arg_11_1.time_ - var_14_10) / var_14_11

				if arg_11_1.var_.characterEffect10089ui_story and not isNil(var_14_9) then
					arg_11_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_10 + var_14_11 and arg_11_1.time_ < var_14_10 + var_14_11 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect10089ui_story then
				arg_11_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			local var_14_13 = 0

			if var_14_13 < arg_11_1.time_ and arg_11_1.time_ <= var_14_13 + arg_14_0 then
				arg_11_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_14_14 = 0

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_14_15 = 0
			local var_14_16 = 0.2

			if var_14_15 < arg_11_1.time_ and arg_11_1.time_ <= var_14_15 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_17 = arg_11_1:FormatText(StoryNameCfg[988].name)

				arg_11_1.leftNameTxt_.text = var_14_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_18 = arg_11_1:GetWordFromCfg(414231003)
				local var_14_19 = arg_11_1:FormatText(var_14_18.content)

				arg_11_1.text_.text = var_14_19

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_20 = 8
				local var_14_21 = utf8.len(var_14_19)
				local var_14_22 = var_14_20 <= 0 and var_14_16 or var_14_16 * (var_14_21 / var_14_20)

				if var_14_22 > 0 and var_14_16 < var_14_22 then
					arg_11_1.talkMaxDuration = var_14_22

					if var_14_22 + var_14_15 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_22 + var_14_15
					end
				end

				arg_11_1.text_.text = var_14_19
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_23 = math.max(var_14_16, arg_11_1.talkMaxDuration)

			if var_14_15 <= arg_11_1.time_ and arg_11_1.time_ < var_14_15 + var_14_23 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_15) / var_14_23

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_15 + var_14_23 and arg_11_1.time_ < var_14_15 + var_14_23 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
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
	Play414231004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414231004
		arg_15_1.duration_ = 7.78

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414231005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["10089ui_story"].transform
			local var_18_1 = 1

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos10089ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0, 100, 0)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10089ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0, 100, 0)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = arg_15_1.actors_["10089ui_story"]
			local var_18_10 = 1

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect10089ui_story == nil then
				arg_15_1.var_.characterEffect10089ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.200000002980232

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 and not isNil(var_18_9) then
				local var_18_12 = (arg_15_1.time_ - var_18_10) / var_18_11

				if arg_15_1.var_.characterEffect10089ui_story and not isNil(var_18_9) then
					local var_18_13 = Mathf.Lerp(0, 0.5, var_18_12)

					arg_15_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_15_1.var_.characterEffect10089ui_story.fillRatio = var_18_13
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect10089ui_story then
				local var_18_14 = 0.5

				arg_15_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_15_1.var_.characterEffect10089ui_story.fillRatio = var_18_14
			end

			local var_18_15 = 1

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 then
				local var_18_16 = manager.ui.mainCamera.transform.localPosition
				local var_18_17 = Vector3.New(0, 0, 10) + Vector3.New(var_18_16.x, var_18_16.y, 0)
				local var_18_18 = arg_15_1.bgs_.H07j

				var_18_18.transform.localPosition = var_18_17
				var_18_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_18_19 = var_18_18:GetComponent("SpriteRenderer")

				if var_18_19 and var_18_19.sprite then
					local var_18_20 = (var_18_18.transform.localPosition - var_18_16).z
					local var_18_21 = manager.ui.mainCameraCom_
					local var_18_22 = 2 * var_18_20 * Mathf.Tan(var_18_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_18_23 = var_18_22 * var_18_21.aspect
					local var_18_24 = var_18_19.sprite.bounds.size.x
					local var_18_25 = var_18_19.sprite.bounds.size.y
					local var_18_26 = var_18_23 / var_18_24
					local var_18_27 = var_18_22 / var_18_25
					local var_18_28 = var_18_27 < var_18_26 and var_18_26 or var_18_27

					var_18_18.transform.localScale = Vector3.New(var_18_28, var_18_28, 0)
				end

				for iter_18_0, iter_18_1 in pairs(arg_15_1.bgs_) do
					if iter_18_0 ~= "H07j" then
						iter_18_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_18_29 = 0

			if var_18_29 < arg_15_1.time_ and arg_15_1.time_ <= var_18_29 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_30 = 1

			if var_18_29 <= arg_15_1.time_ and arg_15_1.time_ < var_18_29 + var_18_30 then
				local var_18_31 = (arg_15_1.time_ - var_18_29) / var_18_30
				local var_18_32 = Color.New(0, 0, 0)

				var_18_32.a = Mathf.Lerp(0, 1, var_18_31)
				arg_15_1.mask_.color = var_18_32
			end

			if arg_15_1.time_ >= var_18_29 + var_18_30 and arg_15_1.time_ < var_18_29 + var_18_30 + arg_18_0 then
				local var_18_33 = Color.New(0, 0, 0)

				var_18_33.a = 1
				arg_15_1.mask_.color = var_18_33
			end

			local var_18_34 = 1

			if var_18_34 < arg_15_1.time_ and arg_15_1.time_ <= var_18_34 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_35 = 2

			if var_18_34 <= arg_15_1.time_ and arg_15_1.time_ < var_18_34 + var_18_35 then
				local var_18_36 = (arg_15_1.time_ - var_18_34) / var_18_35
				local var_18_37 = Color.New(0, 0, 0)

				var_18_37.a = Mathf.Lerp(1, 0, var_18_36)
				arg_15_1.mask_.color = var_18_37
			end

			if arg_15_1.time_ >= var_18_34 + var_18_35 and arg_15_1.time_ < var_18_34 + var_18_35 + arg_18_0 then
				local var_18_38 = Color.New(0, 0, 0)
				local var_18_39 = 0

				arg_15_1.mask_.enabled = false
				var_18_38.a = var_18_39
				arg_15_1.mask_.color = var_18_38
			end

			if arg_15_1.frameCnt_ <= 1 then
				arg_15_1.dialog_:SetActive(false)
			end

			local var_18_40 = 2.775
			local var_18_41 = 0.225

			if var_18_40 < arg_15_1.time_ and arg_15_1.time_ <= var_18_40 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_42 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_42:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_43 = arg_15_1:FormatText(StoryNameCfg[7].name)

				arg_15_1.leftNameTxt_.text = var_18_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_44 = arg_15_1:GetWordFromCfg(414231004)
				local var_18_45 = arg_15_1:FormatText(var_18_44.content)

				arg_15_1.text_.text = var_18_45

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_46 = 9
				local var_18_47 = utf8.len(var_18_45)
				local var_18_48 = var_18_46 <= 0 and var_18_41 or var_18_41 * (var_18_47 / var_18_46)

				if var_18_48 > 0 and var_18_41 < var_18_48 then
					arg_15_1.talkMaxDuration = var_18_48
					var_18_40 = var_18_40 + 0.3

					if var_18_48 + var_18_40 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_48 + var_18_40
					end
				end

				arg_15_1.text_.text = var_18_45
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_49 = var_18_40 + 0.3
			local var_18_50 = math.max(var_18_41, arg_15_1.talkMaxDuration)

			if var_18_49 <= arg_15_1.time_ and arg_15_1.time_ < var_18_49 + var_18_50 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_49) / var_18_50

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_49 + var_18_50 and arg_15_1.time_ < var_18_49 + var_18_50 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play414231005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414231005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414231006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "102201ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "102201ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = arg_21_1.actors_["102201ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos102201ui_story = var_24_5.localPosition

				local var_24_7 = "102201ui_story"

				arg_21_1:ShowWeapon(arg_21_1.var_[var_24_7 .. "Animator"].transform, false)
			end

			local var_24_8 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_8 then
				local var_24_9 = (arg_21_1.time_ - var_24_6) / var_24_8
				local var_24_10 = Vector3.New(0, -1.08, -6)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos102201ui_story, var_24_10, var_24_9)

				local var_24_11 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_11.x, var_24_11.y, var_24_11.z)

				local var_24_12 = var_24_5.localEulerAngles

				var_24_12.z = 0
				var_24_12.x = 0
				var_24_5.localEulerAngles = var_24_12
			end

			if arg_21_1.time_ >= var_24_6 + var_24_8 and arg_21_1.time_ < var_24_6 + var_24_8 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_24_13 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_13.x, var_24_13.y, var_24_13.z)

				local var_24_14 = var_24_5.localEulerAngles

				var_24_14.z = 0
				var_24_14.x = 0
				var_24_5.localEulerAngles = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["102201ui_story"]
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect102201ui_story == nil then
				arg_21_1.var_.characterEffect102201ui_story = var_24_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_17 = 0.200000002980232

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 and not isNil(var_24_15) then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17

				if arg_21_1.var_.characterEffect102201ui_story and not isNil(var_24_15) then
					arg_21_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 and not isNil(var_24_15) and arg_21_1.var_.characterEffect102201ui_story then
				arg_21_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = 0

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				arg_21_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_24_21 = 0
			local var_24_22 = 0.425

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_23 = arg_21_1:FormatText(StoryNameCfg[259].name)

				arg_21_1.leftNameTxt_.text = var_24_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:GetWordFromCfg(414231005)
				local var_24_25 = arg_21_1:FormatText(var_24_24.content)

				arg_21_1.text_.text = var_24_25

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 17
				local var_24_27 = utf8.len(var_24_25)
				local var_24_28 = var_24_26 <= 0 and var_24_22 or var_24_22 * (var_24_27 / var_24_26)

				if var_24_28 > 0 and var_24_22 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_21
					end
				end

				arg_21_1.text_.text = var_24_25
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_29 = math.max(var_24_22, arg_21_1.talkMaxDuration)

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_29 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_21) / var_24_29

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_21 + var_24_29 and arg_21_1.time_ < var_24_21 + var_24_29 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play414231006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414231006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414231007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["102201ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect102201ui_story == nil then
				arg_25_1.var_.characterEffect102201ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect102201ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_25_1.var_.characterEffect102201ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect102201ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_25_1.var_.characterEffect102201ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.425

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(414231006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 17
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
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
	Play414231007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414231007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414231008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["102201ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect102201ui_story == nil then
				arg_29_1.var_.characterEffect102201ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect102201ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect102201ui_story then
				arg_29_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.125

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_6 = arg_29_1:FormatText(StoryNameCfg[259].name)

				arg_29_1.leftNameTxt_.text = var_32_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(414231007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 5
				local var_32_10 = utf8.len(var_32_8)
				local var_32_11 = var_32_9 <= 0 and var_32_5 or var_32_5 * (var_32_10 / var_32_9)

				if var_32_11 > 0 and var_32_5 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
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
	Play414231008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414231008
		arg_33_1.duration_ = 7.77

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414231009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "H07h"

			if arg_33_1.bgs_[var_36_0] == nil then
				local var_36_1 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_36_0)
				var_36_1.name = var_36_0
				var_36_1.transform.parent = arg_33_1.stage_.transform
				var_36_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_[var_36_0] = var_36_1
			end

			local var_36_2 = 1.26666666666667

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				local var_36_3 = manager.ui.mainCamera.transform.localPosition
				local var_36_4 = Vector3.New(0, 0, 10) + Vector3.New(var_36_3.x, var_36_3.y, 0)
				local var_36_5 = arg_33_1.bgs_.H07h

				var_36_5.transform.localPosition = var_36_4
				var_36_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_6 = var_36_5:GetComponent("SpriteRenderer")

				if var_36_6 and var_36_6.sprite then
					local var_36_7 = (var_36_5.transform.localPosition - var_36_3).z
					local var_36_8 = manager.ui.mainCameraCom_
					local var_36_9 = 2 * var_36_7 * Mathf.Tan(var_36_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_36_10 = var_36_9 * var_36_8.aspect
					local var_36_11 = var_36_6.sprite.bounds.size.x
					local var_36_12 = var_36_6.sprite.bounds.size.y
					local var_36_13 = var_36_10 / var_36_11
					local var_36_14 = var_36_9 / var_36_12
					local var_36_15 = var_36_14 < var_36_13 and var_36_13 or var_36_14

					var_36_5.transform.localScale = Vector3.New(var_36_15, var_36_15, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "H07h" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_17 = 1.26666666666667

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17
				local var_36_19 = Color.New(0, 0, 0)

				var_36_19.a = Mathf.Lerp(0, 1, var_36_18)
				arg_33_1.mask_.color = var_36_19
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 then
				local var_36_20 = Color.New(0, 0, 0)

				var_36_20.a = 1
				arg_33_1.mask_.color = var_36_20
			end

			local var_36_21 = 1.26666666666667

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_22 = 1.6

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_22 then
				local var_36_23 = (arg_33_1.time_ - var_36_21) / var_36_22
				local var_36_24 = Color.New(0, 0, 0)

				var_36_24.a = Mathf.Lerp(1, 0, var_36_23)
				arg_33_1.mask_.color = var_36_24
			end

			if arg_33_1.time_ >= var_36_21 + var_36_22 and arg_33_1.time_ < var_36_21 + var_36_22 + arg_36_0 then
				local var_36_25 = Color.New(0, 0, 0)
				local var_36_26 = 0

				arg_33_1.mask_.enabled = false
				var_36_25.a = var_36_26
				arg_33_1.mask_.color = var_36_25
			end

			local var_36_27 = arg_33_1.actors_["102201ui_story"].transform
			local var_36_28 = 1.26666666666667

			if var_36_28 < arg_33_1.time_ and arg_33_1.time_ <= var_36_28 + arg_36_0 then
				arg_33_1.var_.moveOldPos102201ui_story = var_36_27.localPosition
			end

			local var_36_29 = 0.001

			if var_36_28 <= arg_33_1.time_ and arg_33_1.time_ < var_36_28 + var_36_29 then
				local var_36_30 = (arg_33_1.time_ - var_36_28) / var_36_29
				local var_36_31 = Vector3.New(0, 100, 0)

				var_36_27.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos102201ui_story, var_36_31, var_36_30)

				local var_36_32 = manager.ui.mainCamera.transform.position - var_36_27.position

				var_36_27.forward = Vector3.New(var_36_32.x, var_36_32.y, var_36_32.z)

				local var_36_33 = var_36_27.localEulerAngles

				var_36_33.z = 0
				var_36_33.x = 0
				var_36_27.localEulerAngles = var_36_33
			end

			if arg_33_1.time_ >= var_36_28 + var_36_29 and arg_33_1.time_ < var_36_28 + var_36_29 + arg_36_0 then
				var_36_27.localPosition = Vector3.New(0, 100, 0)

				local var_36_34 = manager.ui.mainCamera.transform.position - var_36_27.position

				var_36_27.forward = Vector3.New(var_36_34.x, var_36_34.y, var_36_34.z)

				local var_36_35 = var_36_27.localEulerAngles

				var_36_35.z = 0
				var_36_35.x = 0
				var_36_27.localEulerAngles = var_36_35
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_36 = 2.76666666666667
			local var_36_37 = 0.225

			if var_36_36 < arg_33_1.time_ and arg_33_1.time_ <= var_36_36 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_38 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_38:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_39 = arg_33_1:FormatText(StoryNameCfg[146].name)

				arg_33_1.leftNameTxt_.text = var_36_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_40 = arg_33_1:GetWordFromCfg(414231008)
				local var_36_41 = arg_33_1:FormatText(var_36_40.content)

				arg_33_1.text_.text = var_36_41

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_42 = 9
				local var_36_43 = utf8.len(var_36_41)
				local var_36_44 = var_36_42 <= 0 and var_36_37 or var_36_37 * (var_36_43 / var_36_42)

				if var_36_44 > 0 and var_36_37 < var_36_44 then
					arg_33_1.talkMaxDuration = var_36_44
					var_36_36 = var_36_36 + 0.3

					if var_36_44 + var_36_36 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_44 + var_36_36
					end
				end

				arg_33_1.text_.text = var_36_41
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_45 = var_36_36 + 0.3
			local var_36_46 = math.max(var_36_37, arg_33_1.talkMaxDuration)

			if var_36_45 <= arg_33_1.time_ and arg_33_1.time_ < var_36_45 + var_36_46 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_45) / var_36_46

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_45 + var_36_46 and arg_33_1.time_ < var_36_45 + var_36_46 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play414231009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414231009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414231010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.825

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[146].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(414231009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 33
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play414231010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414231010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414231011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.725

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(414231010)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 29
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play414231011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414231011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414231012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["102201ui_story"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos102201ui_story = var_50_0.localPosition
			end

			local var_50_2 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2
				local var_50_4 = Vector3.New(0, -1.08, -6)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos102201ui_story, var_50_4, var_50_3)

				local var_50_5 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_5.x, var_50_5.y, var_50_5.z)

				local var_50_6 = var_50_0.localEulerAngles

				var_50_6.z = 0
				var_50_6.x = 0
				var_50_0.localEulerAngles = var_50_6
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_50_7 = manager.ui.mainCamera.transform.position - var_50_0.position

				var_50_0.forward = Vector3.New(var_50_7.x, var_50_7.y, var_50_7.z)

				local var_50_8 = var_50_0.localEulerAngles

				var_50_8.z = 0
				var_50_8.x = 0
				var_50_0.localEulerAngles = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["102201ui_story"]
			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect102201ui_story == nil then
				arg_47_1.var_.characterEffect102201ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_11 = 0.200000002980232

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 and not isNil(var_50_9) then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11

				if arg_47_1.var_.characterEffect102201ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect102201ui_story then
				arg_47_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_50_13 = 0

			if var_50_13 < arg_47_1.time_ and arg_47_1.time_ <= var_50_13 + arg_50_0 then
				arg_47_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			local var_50_15 = 0
			local var_50_16 = 0.3

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_17 = arg_47_1:FormatText(StoryNameCfg[259].name)

				arg_47_1.leftNameTxt_.text = var_50_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_18 = arg_47_1:GetWordFromCfg(414231011)
				local var_50_19 = arg_47_1:FormatText(var_50_18.content)

				arg_47_1.text_.text = var_50_19

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_20 = 12
				local var_50_21 = utf8.len(var_50_19)
				local var_50_22 = var_50_20 <= 0 and var_50_16 or var_50_16 * (var_50_21 / var_50_20)

				if var_50_22 > 0 and var_50_16 < var_50_22 then
					arg_47_1.talkMaxDuration = var_50_22

					if var_50_22 + var_50_15 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_22 + var_50_15
					end
				end

				arg_47_1.text_.text = var_50_19
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_23 = math.max(var_50_16, arg_47_1.talkMaxDuration)

			if var_50_15 <= arg_47_1.time_ and arg_47_1.time_ < var_50_15 + var_50_23 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_15) / var_50_23

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_15 + var_50_23 and arg_47_1.time_ < var_50_15 + var_50_23 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
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
	Play414231012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414231012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
			arg_51_1.auto_ = false
		end

		function arg_51_1.playNext_(arg_53_0)
			arg_51_1.onStoryFinished_()
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["102201ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect102201ui_story == nil then
				arg_51_1.var_.characterEffect102201ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect102201ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_51_1.var_.characterEffect102201ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect102201ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_51_1.var_.characterEffect102201ui_story.fillRatio = var_54_5
			end

			local var_54_6 = arg_51_1.actors_["102201ui_story"].transform
			local var_54_7 = 0

			if var_54_7 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.var_.moveOldPos102201ui_story = var_54_6.localPosition
			end

			local var_54_8 = 0.001

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_8 then
				local var_54_9 = (arg_51_1.time_ - var_54_7) / var_54_8
				local var_54_10 = Vector3.New(0, 100, 0)

				var_54_6.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos102201ui_story, var_54_10, var_54_9)

				local var_54_11 = manager.ui.mainCamera.transform.position - var_54_6.position

				var_54_6.forward = Vector3.New(var_54_11.x, var_54_11.y, var_54_11.z)

				local var_54_12 = var_54_6.localEulerAngles

				var_54_12.z = 0
				var_54_12.x = 0
				var_54_6.localEulerAngles = var_54_12
			end

			if arg_51_1.time_ >= var_54_7 + var_54_8 and arg_51_1.time_ < var_54_7 + var_54_8 + arg_54_0 then
				var_54_6.localPosition = Vector3.New(0, 100, 0)

				local var_54_13 = manager.ui.mainCamera.transform.position - var_54_6.position

				var_54_6.forward = Vector3.New(var_54_13.x, var_54_13.y, var_54_13.z)

				local var_54_14 = var_54_6.localEulerAngles

				var_54_14.z = 0
				var_54_14.x = 0
				var_54_6.localEulerAngles = var_54_14
			end

			local var_54_15 = 0
			local var_54_16 = 0.8

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_17 = arg_51_1:GetWordFromCfg(414231012)
				local var_54_18 = arg_51_1:FormatText(var_54_17.content)

				arg_51_1.text_.text = var_54_18

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 32
				local var_54_20 = utf8.len(var_54_18)
				local var_54_21 = var_54_19 <= 0 and var_54_16 or var_54_16 * (var_54_20 / var_54_19)

				if var_54_21 > 0 and var_54_16 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_18
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_22 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_22 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_22

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_22 and arg_51_1.time_ < var_54_15 + var_54_22 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102201ui_story",
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
	assets = {
		"TextureConfig/Background/H07j",
		"TextureConfig/Background/H07h"
	},
	voices = {}
}
