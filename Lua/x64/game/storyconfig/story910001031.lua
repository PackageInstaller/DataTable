return {
	Play910003001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910003001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910003002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B13"

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
				local var_4_5 = arg_1_1.bgs_.B13

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
					if iter_4_0 ~= "B13" then
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
			local var_4_23 = 0.05

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_25 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(910003001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 2
				local var_4_29 = utf8.len(var_4_27)
				local var_4_30 = var_4_28 <= 0 and var_4_23 or var_4_23 * (var_4_29 / var_4_28)

				if var_4_30 > 0 and var_4_23 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_22 = var_4_22 + 0.3

					if var_4_30 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play910003002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910003002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910003003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.7

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

				local var_10_2 = arg_7_1:GetWordFromCfg(910003002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 28
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
	Play910003003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910003003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910003004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1027ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_11_1.stage_.transform)

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

			local var_14_5 = arg_11_1.actors_["1027ui_story"].transform
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.var_.moveOldPos1027ui_story = var_14_5.localPosition

				local var_14_7 = "1027ui_story"

				arg_11_1:ShowWeapon(arg_11_1.var_[var_14_7 .. "Animator"].transform, false)
			end

			local var_14_8 = 0.001

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_8 then
				local var_14_9 = (arg_11_1.time_ - var_14_6) / var_14_8
				local var_14_10 = Vector3.New(0, -0.81, -5.8)

				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1027ui_story, var_14_10, var_14_9)

				local var_14_11 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_11.x, var_14_11.y, var_14_11.z)

				local var_14_12 = var_14_5.localEulerAngles

				var_14_12.z = 0
				var_14_12.x = 0
				var_14_5.localEulerAngles = var_14_12
			end

			if arg_11_1.time_ >= var_14_6 + var_14_8 and arg_11_1.time_ < var_14_6 + var_14_8 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_14_13 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_13.x, var_14_13.y, var_14_13.z)

				local var_14_14 = var_14_5.localEulerAngles

				var_14_14.z = 0
				var_14_14.x = 0
				var_14_5.localEulerAngles = var_14_14
			end

			local var_14_15 = arg_11_1.actors_["1027ui_story"]
			local var_14_16 = 0

			if var_14_16 < arg_11_1.time_ and arg_11_1.time_ <= var_14_16 + arg_14_0 and not isNil(var_14_15) and arg_11_1.var_.characterEffect1027ui_story == nil then
				arg_11_1.var_.characterEffect1027ui_story = var_14_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_17 = 0.2

			if var_14_16 <= arg_11_1.time_ and arg_11_1.time_ < var_14_16 + var_14_17 and not isNil(var_14_15) then
				local var_14_18 = (arg_11_1.time_ - var_14_16) / var_14_17

				if arg_11_1.var_.characterEffect1027ui_story and not isNil(var_14_15) then
					local var_14_19 = Mathf.Lerp(0, 0.5, var_14_18)

					arg_11_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1027ui_story.fillRatio = var_14_19
				end
			end

			if arg_11_1.time_ >= var_14_16 + var_14_17 and arg_11_1.time_ < var_14_16 + var_14_17 + arg_14_0 and not isNil(var_14_15) and arg_11_1.var_.characterEffect1027ui_story then
				local var_14_20 = 0.5

				arg_11_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1027ui_story.fillRatio = var_14_20
			end

			local var_14_21 = 0

			if var_14_21 < arg_11_1.time_ and arg_11_1.time_ <= var_14_21 + arg_14_0 then
				arg_11_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_14_22 = 0
			local var_14_23 = 0.225

			if var_14_22 < arg_11_1.time_ and arg_11_1.time_ <= var_14_22 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_24 = arg_11_1:FormatText(StoryNameCfg[7].name)

				arg_11_1.leftNameTxt_.text = var_14_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_25 = arg_11_1:GetWordFromCfg(910003003)
				local var_14_26 = arg_11_1:FormatText(var_14_25.content)

				arg_11_1.text_.text = var_14_26

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_27 = 9
				local var_14_28 = utf8.len(var_14_26)
				local var_14_29 = var_14_27 <= 0 and var_14_23 or var_14_23 * (var_14_28 / var_14_27)

				if var_14_29 > 0 and var_14_23 < var_14_29 then
					arg_11_1.talkMaxDuration = var_14_29

					if var_14_29 + var_14_22 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_29 + var_14_22
					end
				end

				arg_11_1.text_.text = var_14_26
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_30 = math.max(var_14_23, arg_11_1.talkMaxDuration)

			if var_14_22 <= arg_11_1.time_ and arg_11_1.time_ < var_14_22 + var_14_30 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_22) / var_14_30

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_22 + var_14_30 and arg_11_1.time_ < var_14_22 + var_14_30 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play910003004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910003004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910003005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.85

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_2 = arg_15_1:GetWordFromCfg(910003004)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 34
				local var_18_5 = utf8.len(var_18_3)
				local var_18_6 = var_18_4 <= 0 and var_18_1 or var_18_1 * (var_18_5 / var_18_4)

				if var_18_6 > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_7 and arg_15_1.time_ < var_18_0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play910003005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910003005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910003006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action436")
			end

			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_22_2 = 0
			local var_22_3 = 0.6

			if var_22_2 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(910003005)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 24
				local var_22_7 = utf8.len(var_22_5)
				local var_22_8 = var_22_6 <= 0 and var_22_3 or var_22_3 * (var_22_7 / var_22_6)

				if var_22_8 > 0 and var_22_3 < var_22_8 then
					arg_19_1.talkMaxDuration = var_22_8

					if var_22_8 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_9 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_9 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_9

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_9 and arg_19_1.time_ < var_22_2 + var_22_9 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play910003006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910003006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910003007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.55

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(910003006)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 22
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play910003007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910003007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910003008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1027ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1027ui_story == nil then
				arg_27_1.var_.characterEffect1027ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1027ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1027ui_story then
				arg_27_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_30_4 = 0

			if var_30_4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action463")
			end

			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_30_6 = 0
			local var_30_7 = 0.45

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_8 = arg_27_1:FormatText(StoryNameCfg[56].name)

				arg_27_1.leftNameTxt_.text = var_30_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_9 = arg_27_1:GetWordFromCfg(910003007)
				local var_30_10 = arg_27_1:FormatText(var_30_9.content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 18
				local var_30_12 = utf8.len(var_30_10)
				local var_30_13 = var_30_11 <= 0 and var_30_7 or var_30_7 * (var_30_12 / var_30_11)

				if var_30_13 > 0 and var_30_7 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play910003008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910003008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910003009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action432")
			end

			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_34_2 = arg_31_1.actors_["1027ui_story"]
			local var_34_3 = 0

			if var_34_3 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1027ui_story == nil then
				arg_31_1.var_.characterEffect1027ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_4 = 0.2

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_4 and not isNil(var_34_2) then
				local var_34_5 = (arg_31_1.time_ - var_34_3) / var_34_4

				if arg_31_1.var_.characterEffect1027ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_3 + var_34_4 and arg_31_1.time_ < var_34_3 + var_34_4 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1027ui_story then
				arg_31_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_34_6 = 0
			local var_34_7 = 0.525

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_8 = arg_31_1:FormatText(StoryNameCfg[56].name)

				arg_31_1.leftNameTxt_.text = var_34_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_9 = arg_31_1:GetWordFromCfg(910003008)
				local var_34_10 = arg_31_1:FormatText(var_34_9.content)

				arg_31_1.text_.text = var_34_10

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_11 = 21
				local var_34_12 = utf8.len(var_34_10)
				local var_34_13 = var_34_11 <= 0 and var_34_7 or var_34_7 * (var_34_12 / var_34_11)

				if var_34_13 > 0 and var_34_7 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_10
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
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

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play910003009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910003009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910003010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action426")
			end

			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_38_2 = arg_35_1.actors_["1027ui_story"]
			local var_38_3 = 0

			if var_38_3 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1027ui_story == nil then
				arg_35_1.var_.characterEffect1027ui_story = var_38_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_4 = 0.2

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_4 and not isNil(var_38_2) then
				local var_38_5 = (arg_35_1.time_ - var_38_3) / var_38_4

				if arg_35_1.var_.characterEffect1027ui_story and not isNil(var_38_2) then
					arg_35_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_3 + var_38_4 and arg_35_1.time_ < var_38_3 + var_38_4 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1027ui_story then
				arg_35_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_38_6 = 0
			local var_38_7 = 0.15

			if var_38_6 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_8 = arg_35_1:FormatText(StoryNameCfg[56].name)

				arg_35_1.leftNameTxt_.text = var_38_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_9 = arg_35_1:GetWordFromCfg(910003009)
				local var_38_10 = arg_35_1:FormatText(var_38_9.content)

				arg_35_1.text_.text = var_38_10

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 6
				local var_38_12 = utf8.len(var_38_10)
				local var_38_13 = var_38_11 <= 0 and var_38_7 or var_38_7 * (var_38_12 / var_38_11)

				if var_38_13 > 0 and var_38_7 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_10
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play910003010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910003010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910003011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1027ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1027ui_story == nil then
				arg_39_1.var_.characterEffect1027ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1027ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1027ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1027ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1027ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.425

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(910003010)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 17
				local var_42_11 = utf8.len(var_42_9)
				local var_42_12 = var_42_10 <= 0 and var_42_7 or var_42_7 * (var_42_11 / var_42_10)

				if var_42_12 > 0 and var_42_7 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_13 and arg_39_1.time_ < var_42_6 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play910003011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910003011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910003012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1027ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1027ui_story == nil then
				arg_43_1.var_.characterEffect1027ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1027ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1027ui_story then
				arg_43_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_46_4 = 0

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_46_5 = 0
			local var_46_6 = 0.475

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_7 = arg_43_1:FormatText(StoryNameCfg[56].name)

				arg_43_1.leftNameTxt_.text = var_46_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:GetWordFromCfg(910003011)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 19
				local var_46_11 = utf8.len(var_46_9)
				local var_46_12 = var_46_10 <= 0 and var_46_6 or var_46_6 * (var_46_11 / var_46_10)

				if var_46_12 > 0 and var_46_6 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_6, arg_43_1.talkMaxDuration)

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_5) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_5 + var_46_13 and arg_43_1.time_ < var_46_5 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play910003012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910003012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910003013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1027ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1027ui_story == nil then
				arg_47_1.var_.characterEffect1027ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1027ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1027ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1027ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1027ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_50_7 = 0
			local var_50_8 = 0.275

			if var_50_7 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_9 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_10 = arg_47_1:GetWordFromCfg(910003012)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 11
				local var_50_13 = utf8.len(var_50_11)
				local var_50_14 = var_50_12 <= 0 and var_50_8 or var_50_8 * (var_50_13 / var_50_12)

				if var_50_14 > 0 and var_50_8 < var_50_14 then
					arg_47_1.talkMaxDuration = var_50_14

					if var_50_14 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_15 and arg_47_1.time_ < var_50_7 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play910003013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910003013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910003014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1027ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1027ui_story == nil then
				arg_51_1.var_.characterEffect1027ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.2

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1027ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1027ui_story then
				arg_51_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_54_4 = 0

			if var_54_4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action467")
			end

			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_54_6 = 0
			local var_54_7 = 0.225

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_8 = arg_51_1:FormatText(StoryNameCfg[56].name)

				arg_51_1.leftNameTxt_.text = var_54_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:GetWordFromCfg(910003013)
				local var_54_10 = arg_51_1:FormatText(var_54_9.content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 9
				local var_54_12 = utf8.len(var_54_10)
				local var_54_13 = var_54_11 <= 0 and var_54_7 or var_54_7 * (var_54_12 / var_54_11)

				if var_54_13 > 0 and var_54_7 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_14 and arg_51_1.time_ < var_54_6 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play910003014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910003014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910003015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1027ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1027ui_story == nil then
				arg_55_1.var_.characterEffect1027ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1027ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1027ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1027ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1027ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_58_7 = 0

			if var_58_7 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_2")
			end

			local var_58_8 = 0
			local var_58_9 = 0.3

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_10 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_11 = arg_55_1:GetWordFromCfg(910003014)
				local var_58_12 = arg_55_1:FormatText(var_58_11.content)

				arg_55_1.text_.text = var_58_12

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 12
				local var_58_14 = utf8.len(var_58_12)
				local var_58_15 = var_58_13 <= 0 and var_58_9 or var_58_9 * (var_58_14 / var_58_13)

				if var_58_15 > 0 and var_58_9 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_12
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play910003015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910003015
		arg_59_1.duration_ = 0.02

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"

			SetActive(arg_59_1.choicesGo_, true)

			for iter_60_0, iter_60_1 in ipairs(arg_59_1.choices_) do
				local var_60_0 = iter_60_0 <= 3

				SetActive(iter_60_1.go, var_60_0)
			end

			arg_59_1.choices_[1].txt.text = arg_59_1:FormatText(StoryChoiceCfg[218].name)
			arg_59_1.choices_[2].txt.text = arg_59_1:FormatText(StoryChoiceCfg[219].name)
			arg_59_1.choices_[3].txt.text = arg_59_1:FormatText(StoryChoiceCfg[220].name)
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910003016(arg_59_1)
			end

			if arg_61_0 == 2 then
				arg_59_0:Play910003017(arg_59_1)
			end

			if arg_61_0 == 3 then
				arg_59_0:Play910003019(arg_59_1)
			end

			arg_59_1:RecordChoiceLog(910003015, 218, 219, 220)
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			return
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play910003016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910003016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
			arg_63_1.auto_ = false
		end

		function arg_63_1.playNext_(arg_65_0)
			arg_63_1.onStoryFinished_()
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1027ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1027ui_story == nil then
				arg_63_1.var_.characterEffect1027ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1027ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1027ui_story then
				arg_63_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_66_4 = 0

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_66_6 = 0
			local var_66_7 = 0.225

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[56].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(910003016)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 19
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
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

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play910003017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910003017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910003018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1027ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1027ui_story == nil then
				arg_67_1.var_.characterEffect1027ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1027ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1027ui_story then
				arg_67_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_70_4 = "1027ui_story"

			if arg_67_1.actors_[var_70_4] == nil then
				local var_70_5 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_70_5) then
					local var_70_6 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_67_1.stage_.transform)

					var_70_6.name = var_70_4
					var_70_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_67_1.actors_[var_70_4] = var_70_6

					local var_70_7 = var_70_6:GetComponentInChildren(typeof(CharacterEffect))

					var_70_7.enabled = true

					local var_70_8 = GameObjectTools.GetOrAddComponent(var_70_6, typeof(DynamicBoneHelper))

					if var_70_8 then
						var_70_8:EnableDynamicBone(false)
					end

					arg_67_1:ShowWeapon(var_70_7.transform, false)

					arg_67_1.var_[var_70_4 .. "Animator"] = var_70_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_67_1.var_[var_70_4 .. "Animator"].applyRootMotion = true
					arg_67_1.var_[var_70_4 .. "LipSync"] = var_70_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_70_10 = "1027ui_story"

			if arg_67_1.actors_[var_70_10] == nil then
				local var_70_11 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_70_11) then
					local var_70_12 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_67_1.stage_.transform)

					var_70_12.name = var_70_10
					var_70_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_67_1.actors_[var_70_10] = var_70_12

					local var_70_13 = var_70_12:GetComponentInChildren(typeof(CharacterEffect))

					var_70_13.enabled = true

					local var_70_14 = GameObjectTools.GetOrAddComponent(var_70_12, typeof(DynamicBoneHelper))

					if var_70_14 then
						var_70_14:EnableDynamicBone(false)
					end

					arg_67_1:ShowWeapon(var_70_13.transform, false)

					arg_67_1.var_[var_70_10 .. "Animator"] = var_70_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_67_1.var_[var_70_10 .. "Animator"].applyRootMotion = true
					arg_67_1.var_[var_70_10 .. "LipSync"] = var_70_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_70_15 = 0

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_70_16 = 0
			local var_70_17 = 0.375

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_18 = arg_67_1:FormatText(StoryNameCfg[56].name)

				arg_67_1.leftNameTxt_.text = var_70_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_19 = arg_67_1:GetWordFromCfg(910003017)
				local var_70_20 = arg_67_1:FormatText(var_70_19.content)

				arg_67_1.text_.text = var_70_20

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_21 = 29
				local var_70_22 = utf8.len(var_70_20)
				local var_70_23 = var_70_21 <= 0 and var_70_17 or var_70_17 * (var_70_22 / var_70_21)

				if var_70_23 > 0 and var_70_17 < var_70_23 then
					arg_67_1.talkMaxDuration = var_70_23

					if var_70_23 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_16
					end
				end

				arg_67_1.text_.text = var_70_20
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_24 = math.max(var_70_17, arg_67_1.talkMaxDuration)

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_24 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_16) / var_70_24

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_16 + var_70_24 and arg_67_1.time_ < var_70_16 + var_70_24 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play910003018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910003018
		arg_71_1.duration_ = 5

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
			local var_74_0 = arg_71_1.actors_["1027ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1027ui_story == nil then
				arg_71_1.var_.characterEffect1027ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1027ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1027ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1027ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1027ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.775

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[7].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_9 = arg_71_1:GetWordFromCfg(910003018)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 31
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play910003019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910003019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
			arg_75_1.auto_ = false
		end

		function arg_75_1.playNext_(arg_77_0)
			arg_75_1.onStoryFinished_()
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1027ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1027ui_story == nil then
				arg_75_1.var_.characterEffect1027ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1027ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1027ui_story then
				arg_75_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_78_4 = "1027ui_story"

			if arg_75_1.actors_[var_78_4] == nil then
				local var_78_5 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_78_5) then
					local var_78_6 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_75_1.stage_.transform)

					var_78_6.name = var_78_4
					var_78_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_4] = var_78_6

					local var_78_7 = var_78_6:GetComponentInChildren(typeof(CharacterEffect))

					var_78_7.enabled = true

					local var_78_8 = GameObjectTools.GetOrAddComponent(var_78_6, typeof(DynamicBoneHelper))

					if var_78_8 then
						var_78_8:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_7.transform, false)

					arg_75_1.var_[var_78_4 .. "Animator"] = var_78_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_4 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_4 .. "LipSync"] = var_78_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			local var_78_10 = "1027ui_story"

			if arg_75_1.actors_[var_78_10] == nil then
				local var_78_11 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_78_11) then
					local var_78_12 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_75_1.stage_.transform)

					var_78_12.name = var_78_10
					var_78_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_10] = var_78_12

					local var_78_13 = var_78_12:GetComponentInChildren(typeof(CharacterEffect))

					var_78_13.enabled = true

					local var_78_14 = GameObjectTools.GetOrAddComponent(var_78_12, typeof(DynamicBoneHelper))

					if var_78_14 then
						var_78_14:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_13.transform, false)

					arg_75_1.var_[var_78_10 .. "Animator"] = var_78_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_10 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_10 .. "LipSync"] = var_78_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_78_16 = 0
			local var_78_17 = 0.3

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_18 = arg_75_1:FormatText(StoryNameCfg[56].name)

				arg_75_1.leftNameTxt_.text = var_78_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_19 = arg_75_1:GetWordFromCfg(910003019)
				local var_78_20 = arg_75_1:FormatText(var_78_19.content)

				arg_75_1.text_.text = var_78_20

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_21 = 22
				local var_78_22 = utf8.len(var_78_20)
				local var_78_23 = var_78_21 <= 0 and var_78_17 or var_78_17 * (var_78_22 / var_78_21)

				if var_78_23 > 0 and var_78_17 < var_78_23 then
					arg_75_1.talkMaxDuration = var_78_23

					if var_78_23 + var_78_16 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_16
					end
				end

				arg_75_1.text_.text = var_78_20
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_24 = math.max(var_78_17, arg_75_1.talkMaxDuration)

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_24 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_16) / var_78_24

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_16 + var_78_24 and arg_75_1.time_ < var_78_16 + var_78_24 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13"
	},
	voices = {}
}
