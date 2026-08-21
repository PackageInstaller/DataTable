return {
	Play930011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 930011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play930011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.15

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_27 = arg_1_1:FormatText(StoryNameCfg[1411].name)

				arg_1_1.leftNameTxt_.text = var_4_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:GetWordFromCfg(930011001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 6
				local var_4_31 = utf8.len(var_4_29)
				local var_4_32 = var_4_30 <= 0 and var_4_25 or var_4_25 * (var_4_31 / var_4_30)

				if var_4_32 > 0 and var_4_25 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_24 = var_4_24 + 0.3

					if var_4_32 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play930011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 930011002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play930011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.5

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[1411].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(930011002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 20
				local var_10_6 = utf8.len(var_10_4)
				local var_10_7 = var_10_5 <= 0 and var_10_1 or var_10_1 * (var_10_6 / var_10_5)

				if var_10_7 > 0 and var_10_1 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_8 and arg_7_1.time_ < var_10_0 + var_10_8 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play930011003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 930011003
		arg_11_1.duration_ = 7

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play930011004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "ST12"

			if arg_11_1.bgs_[var_14_0] == nil then
				local var_14_1 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_14_0)
				var_14_1.name = var_14_0
				var_14_1.transform.parent = arg_11_1.stage_.transform
				var_14_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_[var_14_0] = var_14_1
			end

			local var_14_2 = 0

			if var_14_2 < arg_11_1.time_ and arg_11_1.time_ <= var_14_2 + arg_14_0 then
				local var_14_3 = manager.ui.mainCamera.transform.localPosition
				local var_14_4 = Vector3.New(0, 0, 10) + Vector3.New(var_14_3.x, var_14_3.y, 0)
				local var_14_5 = arg_11_1.bgs_.ST12

				var_14_5.transform.localPosition = var_14_4
				var_14_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_6 = var_14_5:GetComponent("SpriteRenderer")

				if var_14_6 and var_14_6.sprite then
					local var_14_7 = (var_14_5.transform.localPosition - var_14_3).z
					local var_14_8 = manager.ui.mainCameraCom_
					local var_14_9 = 2 * var_14_7 * Mathf.Tan(var_14_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_14_10 = var_14_9 * var_14_8.aspect
					local var_14_11 = var_14_6.sprite.bounds.size.x
					local var_14_12 = var_14_6.sprite.bounds.size.y
					local var_14_13 = var_14_10 / var_14_11
					local var_14_14 = var_14_9 / var_14_12
					local var_14_15 = var_14_14 < var_14_13 and var_14_13 or var_14_14

					var_14_5.transform.localScale = Vector3.New(var_14_15, var_14_15, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "ST12" then
						iter_14_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_14_16 = 2

			if var_14_16 < arg_11_1.time_ and arg_11_1.time_ <= var_14_16 + arg_14_0 then
				arg_11_1.allBtn_.enabled = false
			end

			local var_14_17 = 0.3

			if arg_11_1.time_ >= var_14_16 + var_14_17 and arg_11_1.time_ < var_14_16 + var_14_17 + arg_14_0 then
				arg_11_1.allBtn_.enabled = true
			end

			local var_14_18 = 0

			if var_14_18 < arg_11_1.time_ and arg_11_1.time_ <= var_14_18 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_19 = 2

			if var_14_18 <= arg_11_1.time_ and arg_11_1.time_ < var_14_18 + var_14_19 then
				local var_14_20 = (arg_11_1.time_ - var_14_18) / var_14_19
				local var_14_21 = Color.New(0, 0, 0)

				var_14_21.a = Mathf.Lerp(1, 0, var_14_20)
				arg_11_1.mask_.color = var_14_21
			end

			if arg_11_1.time_ >= var_14_18 + var_14_19 and arg_11_1.time_ < var_14_18 + var_14_19 + arg_14_0 then
				local var_14_22 = Color.New(0, 0, 0)
				local var_14_23 = 0

				arg_11_1.mask_.enabled = false
				var_14_22.a = var_14_23
				arg_11_1.mask_.color = var_14_22
			end

			local var_14_24 = "1019ui_story"

			if arg_11_1.actors_[var_14_24] == nil then
				local var_14_25 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_14_25) then
					local var_14_26 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_11_1.stage_.transform)

					var_14_26.name = var_14_24
					var_14_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_24] = var_14_26

					local var_14_27 = var_14_26:GetComponentInChildren(typeof(CharacterEffect))

					var_14_27.enabled = true

					local var_14_28 = GameObjectTools.GetOrAddComponent(var_14_26, typeof(DynamicBoneHelper))

					if var_14_28 then
						var_14_28:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_27.transform, false)

					arg_11_1.var_[var_14_24 .. "Animator"] = var_14_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_24 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_24 .. "LipSync"] = var_14_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_29 = arg_11_1.actors_["1019ui_story"].transform
			local var_14_30 = 1.76666666666667

			if var_14_30 < arg_11_1.time_ and arg_11_1.time_ <= var_14_30 + arg_14_0 then
				arg_11_1.var_.moveOldPos1019ui_story = var_14_29.localPosition
			end

			local var_14_31 = 0.001

			if var_14_30 <= arg_11_1.time_ and arg_11_1.time_ < var_14_30 + var_14_31 then
				local var_14_32 = (arg_11_1.time_ - var_14_30) / var_14_31
				local var_14_33 = Vector3.New(-0.2, -1.08, -5.9)

				var_14_29.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1019ui_story, var_14_33, var_14_32)

				local var_14_34 = manager.ui.mainCamera.transform.position - var_14_29.position

				var_14_29.forward = Vector3.New(var_14_34.x, var_14_34.y, var_14_34.z)

				local var_14_35 = var_14_29.localEulerAngles

				var_14_35.z = 0
				var_14_35.x = 0
				var_14_29.localEulerAngles = var_14_35
			end

			if arg_11_1.time_ >= var_14_30 + var_14_31 and arg_11_1.time_ < var_14_30 + var_14_31 + arg_14_0 then
				var_14_29.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_14_36 = manager.ui.mainCamera.transform.position - var_14_29.position

				var_14_29.forward = Vector3.New(var_14_36.x, var_14_36.y, var_14_36.z)

				local var_14_37 = var_14_29.localEulerAngles

				var_14_37.z = 0
				var_14_37.x = 0
				var_14_29.localEulerAngles = var_14_37
			end

			local var_14_38 = arg_11_1.actors_["1019ui_story"]
			local var_14_39 = 1.76666666666667

			if var_14_39 < arg_11_1.time_ and arg_11_1.time_ <= var_14_39 + arg_14_0 and not isNil(var_14_38) and arg_11_1.var_.characterEffect1019ui_story == nil then
				arg_11_1.var_.characterEffect1019ui_story = var_14_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_40 = 0.200000002980232

			if var_14_39 <= arg_11_1.time_ and arg_11_1.time_ < var_14_39 + var_14_40 and not isNil(var_14_38) then
				local var_14_41 = (arg_11_1.time_ - var_14_39) / var_14_40

				if arg_11_1.var_.characterEffect1019ui_story and not isNil(var_14_38) then
					arg_11_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_39 + var_14_40 and arg_11_1.time_ < var_14_39 + var_14_40 + arg_14_0 and not isNil(var_14_38) and arg_11_1.var_.characterEffect1019ui_story then
				arg_11_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_14_42 = 1.76666666666667

			if var_14_42 < arg_11_1.time_ and arg_11_1.time_ <= var_14_42 + arg_14_0 then
				arg_11_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_14_43 = 1.76666666666667

			if var_14_43 < arg_11_1.time_ and arg_11_1.time_ <= var_14_43 + arg_14_0 then
				arg_11_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if arg_11_1.frameCnt_ <= 1 then
				arg_11_1.dialog_:SetActive(false)
			end

			local var_14_44 = 2
			local var_14_45 = 0.2

			if var_14_44 < arg_11_1.time_ and arg_11_1.time_ <= var_14_44 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				arg_11_1.dialog_:SetActive(true)

				arg_11_1.dialogCg_.alpha = 0

				local var_14_46 = LeanTween.value(arg_11_1.dialog_, 0, 1, 0.3)

				var_14_46:setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
					arg_11_1.dialogCg_.alpha = arg_15_0
				end))
				var_14_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_11_1.dialog_)
					var_14_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_11_1.duration_ = arg_11_1.duration_ + 0.3

				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_47 = arg_11_1:FormatText(StoryNameCfg[13].name)

				arg_11_1.leftNameTxt_.text = var_14_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_48 = arg_11_1:GetWordFromCfg(930011003)
				local var_14_49 = arg_11_1:FormatText(var_14_48.content)

				arg_11_1.text_.text = var_14_49

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_50 = 8
				local var_14_51 = utf8.len(var_14_49)
				local var_14_52 = var_14_50 <= 0 and var_14_45 or var_14_45 * (var_14_51 / var_14_50)

				if var_14_52 > 0 and var_14_45 < var_14_52 then
					arg_11_1.talkMaxDuration = var_14_52
					var_14_44 = var_14_44 + 0.3

					if var_14_52 + var_14_44 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_52 + var_14_44
					end
				end

				arg_11_1.text_.text = var_14_49
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_53 = var_14_44 + 0.3
			local var_14_54 = math.max(var_14_45, arg_11_1.talkMaxDuration)

			if var_14_53 <= arg_11_1.time_ and arg_11_1.time_ < var_14_53 + var_14_54 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_53) / var_14_54

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_53 + var_14_54 and arg_11_1.time_ < var_14_53 + var_14_54 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play930011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 930011004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play930011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1019ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1019ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_9) then
					local var_20_13 = Mathf.Lerp(0, 0.5, var_20_12)

					arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_13
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1019ui_story then
				local var_20_14 = 0.5

				arg_17_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1019ui_story.fillRatio = var_20_14
			end

			local var_20_15 = 0
			local var_20_16 = 1.825

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(930011004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 73
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_16 or var_20_16 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_16 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_22 and arg_17_1.time_ < var_20_15 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play930011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 930011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play930011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.775

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(930011005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 31
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play930011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 930011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play930011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.6

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(930011006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 24
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
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play930011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 930011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play930011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1019ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1019ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1019ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1019ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1019ui_story then
				arg_29_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_15 = 0
			local var_32_16 = 0.35

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[13].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(930011007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 14
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_23 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_23

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_23 and arg_29_1.time_ < var_32_15 + var_32_23 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play930011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 930011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play930011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1019ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story == nil then
				arg_33_1.var_.characterEffect1019ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1019ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1019ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1019ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.75

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(930011008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 30
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play930011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 930011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play930011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1019ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1019ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1019ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1019ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1019ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_15 = 0
			local var_40_16 = 0.275

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[13].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(930011009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 11
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_23 and arg_37_1.time_ < var_40_15 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play930011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 930011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play930011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1019ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1019ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1019ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_11 = 0
			local var_44_12 = 1.45

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[13].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(930011010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 58
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_19 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_19

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_19 and arg_41_1.time_ < var_44_11 + var_44_19 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play930011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 930011011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play930011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1019ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1019ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1019ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.125

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(930011011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 5
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play930011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 930011012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play930011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1019ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1019ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1019ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1019ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1019ui_story == nil then
				arg_49_1.var_.characterEffect1019ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect1019ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect1019ui_story then
				arg_49_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_52_15 = 0
			local var_52_16 = 0.2

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[13].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(930011012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 8
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_23 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_23 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_23

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_23 and arg_49_1.time_ < var_52_15 + var_52_23 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 930011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play930011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1019ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1019ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1019ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1019ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1019ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 1.075

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(930011013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 43
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play930011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 930011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play930011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.25

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(930011014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 10
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play930011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 930011015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play930011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1019ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1019ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1019ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1019ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1019ui_story == nil then
				arg_61_1.var_.characterEffect1019ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1019ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1019ui_story then
				arg_61_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_15 = 0
			local var_64_16 = 1.875

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[13].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(930011015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 75
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
				actorName = "1019ui_story",
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
	Play930011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 930011016
		arg_65_1.duration_ = 1

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"

			SetActive(arg_65_1.choicesGo_, true)

			for iter_66_0, iter_66_1 in ipairs(arg_65_1.choices_) do
				local var_66_0 = iter_66_0 <= 2

				SetActive(iter_66_1.go, var_66_0)
			end

			arg_65_1.choices_[1].txt.text = arg_65_1:FormatText(StoryChoiceCfg[1492].name)
			arg_65_1.choices_[2].txt.text = arg_65_1:FormatText(StoryChoiceCfg[1493].name)
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play930011017(arg_65_1)
			end

			if arg_67_0 == 2 then
				arg_65_0:Play930011017(arg_65_1)
			end

			arg_65_1:RecordChoiceLog(930011016, 1492, 1493)
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1019ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1019ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1019ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1019ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_7 = 0.5

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play930011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 930011017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play930011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1019ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1019ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1019ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = 0
			local var_72_10 = 0.95

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:GetWordFromCfg(930011017)
				local var_72_12 = arg_69_1:FormatText(var_72_11.content)

				arg_69_1.text_.text = var_72_12

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 38
				local var_72_14 = utf8.len(var_72_12)
				local var_72_15 = var_72_13 <= 0 and var_72_10 or var_72_10 * (var_72_14 / var_72_13)

				if var_72_15 > 0 and var_72_10 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_9 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_9
					end
				end

				arg_69_1.text_.text = var_72_12
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_10, arg_69_1.talkMaxDuration)

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_16 and arg_69_1.time_ < var_72_9 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play930011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 930011018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play930011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1019ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1019ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1019ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1019ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1019ui_story == nil then
				arg_73_1.var_.characterEffect1019ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1019ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1019ui_story then
				arg_73_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_76_15 = 0
			local var_76_16 = 0.3

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[13].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(930011018)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 12
				local var_76_21 = utf8.len(var_76_19)
				local var_76_22 = var_76_20 <= 0 and var_76_16 or var_76_16 * (var_76_21 / var_76_20)

				if var_76_22 > 0 and var_76_16 < var_76_22 then
					arg_73_1.talkMaxDuration = var_76_22

					if var_76_22 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_19
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_23 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_23 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_23

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_23 and arg_73_1.time_ < var_76_15 + var_76_23 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play930011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 930011019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play930011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1019ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1019ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1019ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1019ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1019ui_story.fillRatio = var_80_5
			end

			local var_80_6 = 0
			local var_80_7 = 0.45

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_8 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_9 = arg_77_1:GetWordFromCfg(930011019)
				local var_80_10 = arg_77_1:FormatText(var_80_9.content)

				arg_77_1.text_.text = var_80_10

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 18
				local var_80_12 = utf8.len(var_80_10)
				local var_80_13 = var_80_11 <= 0 and var_80_7 or var_80_7 * (var_80_12 / var_80_11)

				if var_80_13 > 0 and var_80_7 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_10
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play930011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 930011020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play930011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1019ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1019ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1019ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["1019ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1019ui_story == nil then
				arg_81_1.var_.characterEffect1019ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect1019ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect1019ui_story then
				arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_84_13 = 0

			if var_84_13 < arg_81_1.time_ and arg_81_1.time_ <= var_84_13 + arg_84_0 then
				arg_81_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 then
				arg_81_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_15 = 0
			local var_84_16 = 1.025

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_17 = arg_81_1:FormatText(StoryNameCfg[13].name)

				arg_81_1.leftNameTxt_.text = var_84_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_18 = arg_81_1:GetWordFromCfg(930011020)
				local var_84_19 = arg_81_1:FormatText(var_84_18.content)

				arg_81_1.text_.text = var_84_19

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_20 = 41
				local var_84_21 = utf8.len(var_84_19)
				local var_84_22 = var_84_20 <= 0 and var_84_16 or var_84_16 * (var_84_21 / var_84_20)

				if var_84_22 > 0 and var_84_16 < var_84_22 then
					arg_81_1.talkMaxDuration = var_84_22

					if var_84_22 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_22 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_19
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_23 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_23 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_23

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_23 and arg_81_1.time_ < var_84_15 + var_84_23 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 930011021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play930011022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_88_1 = 0
			local var_88_2 = 0.225

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_3 = arg_85_1:FormatText(StoryNameCfg[13].name)

				arg_85_1.leftNameTxt_.text = var_88_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(930011021)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 9
				local var_88_7 = utf8.len(var_88_5)
				local var_88_8 = var_88_6 <= 0 and var_88_2 or var_88_2 * (var_88_7 / var_88_6)

				if var_88_8 > 0 and var_88_2 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play930011022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 930011022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play930011023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1019ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1019ui_story == nil then
				arg_89_1.var_.characterEffect1019ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1019ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1019ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1019ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1019ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 1.75

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(930011022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 70
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play930011023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 930011023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play930011024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.75

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(930011023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 30
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
	Play930011024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 930011024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play930011025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1019ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1019ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1019ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1019ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1019ui_story == nil then
				arg_97_1.var_.characterEffect1019ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1019ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1019ui_story then
				arg_97_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_100_15 = 0
			local var_100_16 = 0.375

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[13].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(930011024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 15
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_23 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_23 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_23

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_23 and arg_97_1.time_ < var_100_15 + var_100_23 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play930011025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 930011025
		arg_101_1.duration_ = 1

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"

			SetActive(arg_101_1.choicesGo_, true)

			for iter_102_0, iter_102_1 in ipairs(arg_101_1.choices_) do
				local var_102_0 = iter_102_0 <= 2

				SetActive(iter_102_1.go, var_102_0)
			end

			arg_101_1.choices_[1].txt.text = arg_101_1:FormatText(StoryChoiceCfg[1494].name)
			arg_101_1.choices_[2].txt.text = arg_101_1:FormatText(StoryChoiceCfg[1495].name)
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play930011026(arg_101_1)
			end

			if arg_103_0 == 2 then
				arg_101_0:Play930011026(arg_101_1)
			end

			arg_101_1:RecordChoiceLog(930011025, 1494, 1495)
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1019ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1019ui_story == nil then
				arg_101_1.var_.characterEffect1019ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1019ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1019ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1019ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1019ui_story.fillRatio = var_104_5
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play930011026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 930011026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play930011027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1019ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1019ui_story == nil then
				arg_105_1.var_.characterEffect1019ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1019ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1019ui_story then
				arg_105_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_108_4 = "1019ui_story"

			if arg_105_1.actors_[var_108_4] == nil then
				local var_108_5 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_108_5) then
					local var_108_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_105_1.stage_.transform)

					var_108_6.name = var_108_4
					var_108_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_4] = var_108_6

					local var_108_7 = var_108_6:GetComponentInChildren(typeof(CharacterEffect))

					var_108_7.enabled = true

					local var_108_8 = GameObjectTools.GetOrAddComponent(var_108_6, typeof(DynamicBoneHelper))

					if var_108_8 then
						var_108_8:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_7.transform, false)

					arg_105_1.var_[var_108_4 .. "Animator"] = var_108_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_4 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_4 .. "LipSync"] = var_108_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_108_10 = "1019ui_story"

			if arg_105_1.actors_[var_108_10] == nil then
				local var_108_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_108_11) then
					local var_108_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_105_1.stage_.transform)

					var_108_12.name = var_108_10
					var_108_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_10] = var_108_12

					local var_108_13 = var_108_12:GetComponentInChildren(typeof(CharacterEffect))

					var_108_13.enabled = true

					local var_108_14 = GameObjectTools.GetOrAddComponent(var_108_12, typeof(DynamicBoneHelper))

					if var_108_14 then
						var_108_14:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_13.transform, false)

					arg_105_1.var_[var_108_10 .. "Animator"] = var_108_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_10 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_10 .. "LipSync"] = var_108_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_16 = 0
			local var_108_17 = 1.1

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[13].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(930011026)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 44
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_24 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_24 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_24

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_24 and arg_105_1.time_ < var_108_16 + var_108_24 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play930011027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 930011027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play930011028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.05

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[13].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(930011027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 42
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play930011028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 930011028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play930011029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1019ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1019ui_story == nil then
				arg_113_1.var_.characterEffect1019ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1019ui_story and not isNil(var_116_0) then
					local var_116_4 = Mathf.Lerp(0, 0.5, var_116_3)

					arg_113_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1019ui_story.fillRatio = var_116_4
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1019ui_story then
				local var_116_5 = 0.5

				arg_113_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1019ui_story.fillRatio = var_116_5
			end

			local var_116_6 = 0
			local var_116_7 = 0.3

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:GetWordFromCfg(930011028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 12
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play930011029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 930011029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play930011030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1019ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1019ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1019ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1019ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1019ui_story and not isNil(var_120_9) then
					arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1019ui_story then
				arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action453")
			end

			local var_120_14 = 0

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_120_15 = 0
			local var_120_16 = 0.3

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[13].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(930011029)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 12
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_23 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_23 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_23

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_23 and arg_117_1.time_ < var_120_15 + var_120_23 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 930011030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play930011031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1019ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1019ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1019ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1019ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1019ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 0.4

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_8 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:GetWordFromCfg(930011030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 16
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
	Play930011031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 930011031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play930011032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1019ui_story"].transform
			local var_128_1 = 0.0333333333333333

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1019ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1019ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = 0
			local var_128_10 = 0.775

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_11 = arg_125_1:GetWordFromCfg(930011031)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 31
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_10 or var_128_10 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_10 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_16 and arg_125_1.time_ < var_128_9 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play930011032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 930011032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play930011033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1019ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1019ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1019ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1019ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1019ui_story == nil then
				arg_129_1.var_.characterEffect1019ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1019ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1019ui_story then
				arg_129_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action3_2")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_15 = 0
			local var_132_16 = 0.275

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[13].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(930011032)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 11
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_23 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_23 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_23

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_23 and arg_129_1.time_ < var_132_15 + var_132_23 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play930011033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 930011033
		arg_133_1.duration_ = 1

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"

			SetActive(arg_133_1.choicesGo_, true)

			for iter_134_0, iter_134_1 in ipairs(arg_133_1.choices_) do
				local var_134_0 = iter_134_0 <= 1

				SetActive(iter_134_1.go, var_134_0)
			end

			arg_133_1.choices_[1].txt.text = arg_133_1:FormatText(StoryChoiceCfg[1510].name)
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play930011034(arg_133_1)
			end

			arg_133_1:RecordChoiceLog(930011033, 1510)
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1019ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1019ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1019ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1019ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			local var_136_7 = 0.6

			if arg_133_1.time_ >= var_136_6 + var_136_7 and arg_133_1.time_ < var_136_6 + var_136_7 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play930011034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 930011034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play930011035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.35

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(930011034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 14
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play930011035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 930011035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play930011036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1019ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1019ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1019ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1019ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1019ui_story == nil then
				arg_141_1.var_.characterEffect1019ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1019ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1019ui_story then
				arg_141_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_144_15 = 0
			local var_144_16 = 1.3

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[13].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(930011035)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 52
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_23 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_23 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_23

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_23 and arg_141_1.time_ < var_144_15 + var_144_23 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play930011036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 930011036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play930011037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1019ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1019ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1019ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1019ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.125

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_8 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_9 = arg_145_1:GetWordFromCfg(930011036)
				local var_148_10 = arg_145_1:FormatText(var_148_9.content)

				arg_145_1.text_.text = var_148_10

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 5
				local var_148_12 = utf8.len(var_148_10)
				local var_148_13 = var_148_11 <= 0 and var_148_7 or var_148_7 * (var_148_12 / var_148_11)

				if var_148_13 > 0 and var_148_7 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_10
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play930011037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 930011037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play930011038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 1.3

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(930011037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 52
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play930011038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 930011038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play930011039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.825

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_2 = arg_153_1:FormatText(StoryNameCfg[7].name)

				arg_153_1.leftNameTxt_.text = var_156_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(930011038)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 33
				local var_156_6 = utf8.len(var_156_4)
				local var_156_7 = var_156_5 <= 0 and var_156_1 or var_156_1 * (var_156_6 / var_156_5)

				if var_156_7 > 0 and var_156_1 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_8 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_8 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_8

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_8 and arg_153_1.time_ < var_156_0 + var_156_8 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play930011039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 930011039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play930011040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1019ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1019ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1019ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1019ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1019ui_story == nil then
				arg_157_1.var_.characterEffect1019ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1019ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1019ui_story then
				arg_157_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_160_15 = 0
			local var_160_16 = 0.8

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[13].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(930011039)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 32
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_23 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_23 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_23

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_23 and arg_157_1.time_ < var_160_15 + var_160_23 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 930011040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play930011041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1019ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_0) then
					local var_164_4 = Mathf.Lerp(0, 0.5, var_164_3)

					arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1019ui_story.fillRatio = var_164_4
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1019ui_story then
				local var_164_5 = 0.5

				arg_161_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1019ui_story.fillRatio = var_164_5
			end

			local var_164_6 = 0
			local var_164_7 = 0.375

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_9 = arg_161_1:GetWordFromCfg(930011040)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 15
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play930011041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 930011041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play930011042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1019ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1019ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1019ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1019ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1019ui_story == nil then
				arg_165_1.var_.characterEffect1019ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1019ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1019ui_story then
				arg_165_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_168_13 = 0

			if var_168_13 < arg_165_1.time_ and arg_165_1.time_ <= var_168_13 + arg_168_0 then
				arg_165_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 then
				arg_165_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_168_15 = 0
			local var_168_16 = 0.2

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[13].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(930011041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 8
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_23 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_23 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_23

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_23 and arg_165_1.time_ < var_168_15 + var_168_23 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play930011042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 930011042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play930011043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1019ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1019ui_story == nil then
				arg_169_1.var_.characterEffect1019ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect1019ui_story and not isNil(var_172_0) then
					local var_172_4 = Mathf.Lerp(0, 0.5, var_172_3)

					arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_4
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1019ui_story then
				local var_172_5 = 0.5

				arg_169_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1019ui_story.fillRatio = var_172_5
			end

			local var_172_6 = 0
			local var_172_7 = 0.775

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_8 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_9 = arg_169_1:GetWordFromCfg(930011042)
				local var_172_10 = arg_169_1:FormatText(var_172_9.content)

				arg_169_1.text_.text = var_172_10

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 31
				local var_172_12 = utf8.len(var_172_10)
				local var_172_13 = var_172_11 <= 0 and var_172_7 or var_172_7 * (var_172_12 / var_172_11)

				if var_172_13 > 0 and var_172_7 < var_172_13 then
					arg_169_1.talkMaxDuration = var_172_13

					if var_172_13 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_13 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_10
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play930011043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 930011043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play930011044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1019ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1019ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1019ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1019ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1019ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1019ui_story then
				arg_173_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_176_15 = 0
			local var_176_16 = 0.425

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[13].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(930011043)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 17
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_23 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_23 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_23

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_23 and arg_173_1.time_ < var_176_15 + var_176_23 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play930011044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 930011044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play930011045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1019ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1019ui_story == nil then
				arg_177_1.var_.characterEffect1019ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1019ui_story and not isNil(var_180_0) then
					local var_180_4 = Mathf.Lerp(0, 0.5, var_180_3)

					arg_177_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1019ui_story.fillRatio = var_180_4
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1019ui_story then
				local var_180_5 = 0.5

				arg_177_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1019ui_story.fillRatio = var_180_5
			end

			local var_180_6 = 0
			local var_180_7 = 0.625

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[7].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_9 = arg_177_1:GetWordFromCfg(930011044)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 25
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play930011045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 930011045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play930011046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.725

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(930011045)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 29
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
	Play930011046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 930011046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play930011047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1019ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1019ui_story == nil then
				arg_185_1.var_.characterEffect1019ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1019ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1019ui_story then
				arg_185_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_188_4 = 0

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_188_5 = 0
			local var_188_6 = 0.175

			if var_188_5 < arg_185_1.time_ and arg_185_1.time_ <= var_188_5 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_7 = arg_185_1:FormatText(StoryNameCfg[13].name)

				arg_185_1.leftNameTxt_.text = var_188_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(930011046)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 7
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_6 or var_188_6 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_6 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_5 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_5
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_6, arg_185_1.talkMaxDuration)

			if var_188_5 <= arg_185_1.time_ and arg_185_1.time_ < var_188_5 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_5) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_5 + var_188_13 and arg_185_1.time_ < var_188_5 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play930011047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 930011047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play930011048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1019ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1019ui_story == nil then
				arg_189_1.var_.characterEffect1019ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1019ui_story and not isNil(var_192_0) then
					local var_192_4 = Mathf.Lerp(0, 0.5, var_192_3)

					arg_189_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1019ui_story.fillRatio = var_192_4
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1019ui_story then
				local var_192_5 = 0.5

				arg_189_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1019ui_story.fillRatio = var_192_5
			end

			local var_192_6 = 0
			local var_192_7 = 1.175

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(930011047)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 47
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play930011048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 930011048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play930011049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 1.075

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:GetWordFromCfg(930011048)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 43
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_8 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_8 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_8

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_8 and arg_193_1.time_ < var_196_0 + var_196_8 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play930011049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 930011049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play930011050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.25

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[36].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(930011049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 10
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play930011050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 930011050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play930011051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1019ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1019ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, 100, 0)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1019ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, 100, 0)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = 0
			local var_204_10 = 1.575

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_11 = arg_201_1:GetWordFromCfg(930011050)
				local var_204_12 = arg_201_1:FormatText(var_204_11.content)

				arg_201_1.text_.text = var_204_12

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 63
				local var_204_14 = utf8.len(var_204_12)
				local var_204_15 = var_204_13 <= 0 and var_204_10 or var_204_10 * (var_204_14 / var_204_13)

				if var_204_15 > 0 and var_204_10 < var_204_15 then
					arg_201_1.talkMaxDuration = var_204_15

					if var_204_15 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_15 + var_204_9
					end
				end

				arg_201_1.text_.text = var_204_12
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_10, arg_201_1.talkMaxDuration)

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_9) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_9 + var_204_16 and arg_201_1.time_ < var_204_9 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play930011051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 930011051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play930011052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1019ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1019ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1019ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["1019ui_story"]
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1019ui_story == nil then
				arg_205_1.var_.characterEffect1019ui_story = var_208_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_11 = 0.200000002980232

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 and not isNil(var_208_9) then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11

				if arg_205_1.var_.characterEffect1019ui_story and not isNil(var_208_9) then
					arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 and not isNil(var_208_9) and arg_205_1.var_.characterEffect1019ui_story then
				arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_208_13 = 0

			if var_208_13 < arg_205_1.time_ and arg_205_1.time_ <= var_208_13 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_208_14 = 0

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_208_15 = 0
			local var_208_16 = 0.25

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[13].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(930011051)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 10
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_23 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_23 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_23

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_23 and arg_205_1.time_ < var_208_15 + var_208_23 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 930011052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play930011053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1019ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1019ui_story == nil then
				arg_209_1.var_.characterEffect1019ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1019ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1019ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1019ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1019ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 1

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[1412].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(930011052)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 40
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play930011053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 930011053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play930011054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1019ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1019ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1019ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1019ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1019ui_story == nil then
				arg_213_1.var_.characterEffect1019ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1019ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1019ui_story then
				arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_216_15 = 0
			local var_216_16 = 0.85

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[13].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(930011053)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 34
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_23 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_23 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_23

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_23 and arg_213_1.time_ < var_216_15 + var_216_23 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play930011054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 930011054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play930011055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1019ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1019ui_story == nil then
				arg_217_1.var_.characterEffect1019ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1019ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1019ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1019ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1019ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 0.075

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_8 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_9 = arg_217_1:GetWordFromCfg(930011054)
				local var_220_10 = arg_217_1:FormatText(var_220_9.content)

				arg_217_1.text_.text = var_220_10

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 3
				local var_220_12 = utf8.len(var_220_10)
				local var_220_13 = var_220_11 <= 0 and var_220_7 or var_220_7 * (var_220_12 / var_220_11)

				if var_220_13 > 0 and var_220_7 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_10
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play930011055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 930011055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play930011056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1019ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1019ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1019ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["1019ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1019ui_story == nil then
				arg_221_1.var_.characterEffect1019ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect1019ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect1019ui_story then
				arg_221_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_224_15 = 0
			local var_224_16 = 0.35

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[13].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(930011055)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 14
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_23 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_23 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_23

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_23 and arg_221_1.time_ < var_224_15 + var_224_23 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play930011056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 930011056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play930011057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1019ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1019ui_story == nil then
				arg_225_1.var_.characterEffect1019ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1019ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1019ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1019ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1019ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.35

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(930011056)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 14
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play930011057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 930011057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play930011058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1019ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1019ui_story == nil then
				arg_229_1.var_.characterEffect1019ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1019ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1019ui_story then
				arg_229_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_232_4 = 0

			if var_232_4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_5 = 0
			local var_232_6 = 0.2

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_7 = arg_229_1:FormatText(StoryNameCfg[13].name)

				arg_229_1.leftNameTxt_.text = var_232_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_8 = arg_229_1:GetWordFromCfg(930011057)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 8
				local var_232_11 = utf8.len(var_232_9)
				local var_232_12 = var_232_10 <= 0 and var_232_6 or var_232_6 * (var_232_11 / var_232_10)

				if var_232_12 > 0 and var_232_6 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12

					if var_232_12 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_13 and arg_229_1.time_ < var_232_5 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play930011058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 930011058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play930011059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1019ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1019ui_story == nil then
				arg_233_1.var_.characterEffect1019ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1019ui_story and not isNil(var_236_0) then
					local var_236_4 = Mathf.Lerp(0, 0.5, var_236_3)

					arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1019ui_story.fillRatio = var_236_4
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1019ui_story then
				local var_236_5 = 0.5

				arg_233_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1019ui_story.fillRatio = var_236_5
			end

			local var_236_6 = 0
			local var_236_7 = 0.15

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_8 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_9 = arg_233_1:GetWordFromCfg(930011058)
				local var_236_10 = arg_233_1:FormatText(var_236_9.content)

				arg_233_1.text_.text = var_236_10

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 6
				local var_236_12 = utf8.len(var_236_10)
				local var_236_13 = var_236_11 <= 0 and var_236_7 or var_236_7 * (var_236_12 / var_236_11)

				if var_236_13 > 0 and var_236_7 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_10
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_14 and arg_233_1.time_ < var_236_6 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play930011059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 930011059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play930011060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1019ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1019ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1019ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["1019ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1019ui_story == nil then
				arg_237_1.var_.characterEffect1019ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect1019ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect1019ui_story then
				arg_237_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_15 = 0
			local var_240_16 = 0.7

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[13].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(930011059)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 28
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_23 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_23 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_23

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_23 and arg_237_1.time_ < var_240_15 + var_240_23 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 930011060
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play930011061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1019ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1019ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1019ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["1019ui_story"]
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1019ui_story == nil then
				arg_241_1.var_.characterEffect1019ui_story = var_244_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_11 = 0.200000002980232

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 and not isNil(var_244_9) then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11

				if arg_241_1.var_.characterEffect1019ui_story and not isNil(var_244_9) then
					local var_244_13 = Mathf.Lerp(0, 0.5, var_244_12)

					arg_241_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1019ui_story.fillRatio = var_244_13
				end
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 and not isNil(var_244_9) and arg_241_1.var_.characterEffect1019ui_story then
				local var_244_14 = 0.5

				arg_241_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1019ui_story.fillRatio = var_244_14
			end

			local var_244_15 = 0
			local var_244_16 = 0.875

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_18 = arg_241_1:GetWordFromCfg(930011060)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 35
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_23 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_23 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_23

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_23 and arg_241_1.time_ < var_244_15 + var_244_23 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play930011061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 930011061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play930011062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.425

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[1412].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(930011061)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 17
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play930011062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 930011062
		arg_249_1.duration_ = 1

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"

			SetActive(arg_249_1.choicesGo_, true)

			for iter_250_0, iter_250_1 in ipairs(arg_249_1.choices_) do
				local var_250_0 = iter_250_0 <= 2

				SetActive(iter_250_1.go, var_250_0)
			end

			arg_249_1.choices_[1].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1496].name)
			arg_249_1.choices_[2].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1497].name)
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play930011063(arg_249_1)
			end

			if arg_251_0 == 2 then
				arg_249_0:Play930011063(arg_249_1)
			end

			arg_249_1:RecordChoiceLog(930011062, 1496, 1497)
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			local var_252_1 = 0.6

			if arg_249_1.time_ >= var_252_0 + var_252_1 and arg_249_1.time_ < var_252_0 + var_252_1 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play930011063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 930011063
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play930011064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.675

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[1412].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(930011063)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 27
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play930011064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 930011064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play930011065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 0.75

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[1412].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(930011064)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 30
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play930011065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 930011065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play930011066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.25

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(930011065)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 10
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play930011066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 930011066
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play930011067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.4

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[1412].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(930011066)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 16
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
	Play930011067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 930011067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play930011068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.1

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[7].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(930011067)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 4
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_8 and arg_269_1.time_ < var_272_0 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play930011068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 930011068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play930011069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.525

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[1412].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:GetWordFromCfg(930011068)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 21
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play930011069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 930011069
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play930011070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.775

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[1412].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(930011069)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 31
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
	Play930011070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 930011070
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play930011071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.125

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[7].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:GetWordFromCfg(930011070)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 5
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play930011071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 930011071
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play930011072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1019ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1019ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1019ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1019ui_story"]
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1019ui_story == nil then
				arg_285_1.var_.characterEffect1019ui_story = var_288_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.200000002980232

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 and not isNil(var_288_9) then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11

				if arg_285_1.var_.characterEffect1019ui_story and not isNil(var_288_9) then
					arg_285_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 and not isNil(var_288_9) and arg_285_1.var_.characterEffect1019ui_story then
				arg_285_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_288_13 = 0

			if var_288_13 < arg_285_1.time_ and arg_285_1.time_ <= var_288_13 + arg_288_0 then
				arg_285_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_15 = 0
			local var_288_16 = 0.8

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[13].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(930011071)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 32
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_23 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_23 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_23

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_23 and arg_285_1.time_ < var_288_15 + var_288_23 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play930011072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 930011072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play930011073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1019ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1019ui_story == nil then
				arg_289_1.var_.characterEffect1019ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1019ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1019ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1019ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1019ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.25

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(930011072)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 10
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play930011073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 930011073
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play930011074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.75

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[1412].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(930011073)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 30
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play930011074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 930011074
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play930011075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1019ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1019ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1019ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, 100, 0)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = 0
			local var_300_10 = 1.425

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_11 = arg_297_1:GetWordFromCfg(930011074)
				local var_300_12 = arg_297_1:FormatText(var_300_11.content)

				arg_297_1.text_.text = var_300_12

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 57
				local var_300_14 = utf8.len(var_300_12)
				local var_300_15 = var_300_13 <= 0 and var_300_10 or var_300_10 * (var_300_14 / var_300_13)

				if var_300_15 > 0 and var_300_10 < var_300_15 then
					arg_297_1.talkMaxDuration = var_300_15

					if var_300_15 + var_300_9 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_15 + var_300_9
					end
				end

				arg_297_1.text_.text = var_300_12
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_10, arg_297_1.talkMaxDuration)

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_9) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_9 + var_300_16 and arg_297_1.time_ < var_300_9 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play930011075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 930011075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play930011076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.325

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(930011075)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 13
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play930011076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 930011076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play930011077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.6

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[1412].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(930011076)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 26
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play930011077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 930011077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play930011078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.1

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(930011077)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 6
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play930011078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 930011078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play930011079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.6

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[1412].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(930011078)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 24
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play930011079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 930011079
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play930011080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.275

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:GetWordFromCfg(930011079)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 11
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play930011080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 930011080
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play930011081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1019ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1019ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1019ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1019ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1019ui_story == nil then
				arg_321_1.var_.characterEffect1019ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1019ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1019ui_story then
				arg_321_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_324_15 = 0
			local var_324_16 = 1.35

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[13].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(930011080)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 56
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_23 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_23 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_23

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_23 and arg_321_1.time_ < var_324_15 + var_324_23 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play930011081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 930011081
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play930011082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 1.825

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[13].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_3 = arg_325_1:GetWordFromCfg(930011081)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 72
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_8 and arg_325_1.time_ < var_328_0 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play930011082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 930011082
		arg_329_1.duration_ = 1

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"

			SetActive(arg_329_1.choicesGo_, true)

			for iter_330_0, iter_330_1 in ipairs(arg_329_1.choices_) do
				local var_330_0 = iter_330_0 <= 4

				SetActive(iter_330_1.go, var_330_0)
			end

			arg_329_1.choices_[1].txt.text = arg_329_1:FormatText(StoryChoiceCfg[1498].name)
			arg_329_1.choices_[2].txt.text = arg_329_1:FormatText(StoryChoiceCfg[1499].name)
			arg_329_1.choices_[3].txt.text = arg_329_1:FormatText(StoryChoiceCfg[1500].name)
			arg_329_1.choices_[4].txt.text = arg_329_1:FormatText(StoryChoiceCfg[1501].name)
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play930011083(arg_329_1)
			end

			if arg_331_0 == 2 then
				arg_329_0:Play930011083(arg_329_1)
			end

			if arg_331_0 == 3 then
				arg_329_0:Play930011083(arg_329_1)
			end

			if arg_331_0 == 4 then
				arg_329_0:Play930011083(arg_329_1)
			end

			arg_329_1:RecordChoiceLog(930011082, 1498, 1499, 1500, 1501)
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1019ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1019ui_story == nil then
				arg_329_1.var_.characterEffect1019ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1019ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1019ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1019ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1019ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.allBtn_.enabled = false
			end

			local var_332_7 = 0.6

			if arg_329_1.time_ >= var_332_6 + var_332_7 and arg_329_1.time_ < var_332_6 + var_332_7 + arg_332_0 then
				arg_329_1.allBtn_.enabled = true
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play930011083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 930011083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play930011084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1019ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1019ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1019ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1019ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1019ui_story == nil then
				arg_333_1.var_.characterEffect1019ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1019ui_story and not isNil(var_336_9) then
					arg_333_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1019ui_story then
				arg_333_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_336_13 = "1019ui_story"

			if arg_333_1.actors_[var_336_13] == nil then
				local var_336_14 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_336_14) then
					local var_336_15 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_333_1.stage_.transform)

					var_336_15.name = var_336_13
					var_336_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_333_1.actors_[var_336_13] = var_336_15

					local var_336_16 = var_336_15:GetComponentInChildren(typeof(CharacterEffect))

					var_336_16.enabled = true

					local var_336_17 = GameObjectTools.GetOrAddComponent(var_336_15, typeof(DynamicBoneHelper))

					if var_336_17 then
						var_336_17:EnableDynamicBone(false)
					end

					arg_333_1:ShowWeapon(var_336_16.transform, false)

					arg_333_1.var_[var_336_13 .. "Animator"] = var_336_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_333_1.var_[var_336_13 .. "Animator"].applyRootMotion = true
					arg_333_1.var_[var_336_13 .. "LipSync"] = var_336_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_336_18 = 0

			if var_336_18 < arg_333_1.time_ and arg_333_1.time_ <= var_336_18 + arg_336_0 then
				arg_333_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_336_19 = "1019ui_story"

			if arg_333_1.actors_[var_336_19] == nil then
				local var_336_20 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_336_20) then
					local var_336_21 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_333_1.stage_.transform)

					var_336_21.name = var_336_19
					var_336_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_333_1.actors_[var_336_19] = var_336_21

					local var_336_22 = var_336_21:GetComponentInChildren(typeof(CharacterEffect))

					var_336_22.enabled = true

					local var_336_23 = GameObjectTools.GetOrAddComponent(var_336_21, typeof(DynamicBoneHelper))

					if var_336_23 then
						var_336_23:EnableDynamicBone(false)
					end

					arg_333_1:ShowWeapon(var_336_22.transform, false)

					arg_333_1.var_[var_336_19 .. "Animator"] = var_336_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_333_1.var_[var_336_19 .. "Animator"].applyRootMotion = true
					arg_333_1.var_[var_336_19 .. "LipSync"] = var_336_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_336_24 = 0

			if var_336_24 < arg_333_1.time_ and arg_333_1.time_ <= var_336_24 + arg_336_0 then
				arg_333_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_336_25 = 0
			local var_336_26 = 0.25

			if var_336_25 < arg_333_1.time_ and arg_333_1.time_ <= var_336_25 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_27 = arg_333_1:FormatText(StoryNameCfg[13].name)

				arg_333_1.leftNameTxt_.text = var_336_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_28 = arg_333_1:GetWordFromCfg(930011083)
				local var_336_29 = arg_333_1:FormatText(var_336_28.content)

				arg_333_1.text_.text = var_336_29

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_30 = 10
				local var_336_31 = utf8.len(var_336_29)
				local var_336_32 = var_336_30 <= 0 and var_336_26 or var_336_26 * (var_336_31 / var_336_30)

				if var_336_32 > 0 and var_336_26 < var_336_32 then
					arg_333_1.talkMaxDuration = var_336_32

					if var_336_32 + var_336_25 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_32 + var_336_25
					end
				end

				arg_333_1.text_.text = var_336_29
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_33 = math.max(var_336_26, arg_333_1.talkMaxDuration)

			if var_336_25 <= arg_333_1.time_ and arg_333_1.time_ < var_336_25 + var_336_33 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_25) / var_336_33

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_25 + var_336_33 and arg_333_1.time_ < var_336_25 + var_336_33 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play930011084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 930011084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play930011085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1019ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1019ui_story == nil then
				arg_337_1.var_.characterEffect1019ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1019ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1019ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1019ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1019ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.375

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(930011084)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 15
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play930011085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 930011085
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play930011086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.875

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[1412].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:GetWordFromCfg(930011085)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 35
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_8 and arg_341_1.time_ < var_344_0 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play930011086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 930011086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play930011087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1019ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1019ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1019ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["1019ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1019ui_story == nil then
				arg_345_1.var_.characterEffect1019ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect1019ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1019ui_story then
				arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_348_15 = 0
			local var_348_16 = 0.575

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[13].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(930011086)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 23
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_23 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_23 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_23

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_23 and arg_345_1.time_ < var_348_15 + var_348_23 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play930011087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 930011087
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play930011088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1019ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1019ui_story == nil then
				arg_349_1.var_.characterEffect1019ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1019ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1019ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1019ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1019ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.15

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[1412].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_9 = arg_349_1:GetWordFromCfg(930011087)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 6
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play930011088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 930011088
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play930011089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.825

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[1412].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:GetWordFromCfg(930011088)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 33
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_8 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_8 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_8

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_8 and arg_353_1.time_ < var_356_0 + var_356_8 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play930011089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 930011089
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play930011090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1019ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1019ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1019ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = 0
			local var_360_10 = 0.75

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_11 = arg_357_1:GetWordFromCfg(930011089)
				local var_360_12 = arg_357_1:FormatText(var_360_11.content)

				arg_357_1.text_.text = var_360_12

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 31
				local var_360_14 = utf8.len(var_360_12)
				local var_360_15 = var_360_13 <= 0 and var_360_10 or var_360_10 * (var_360_14 / var_360_13)

				if var_360_15 > 0 and var_360_10 < var_360_15 then
					arg_357_1.talkMaxDuration = var_360_15

					if var_360_15 + var_360_9 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_15 + var_360_9
					end
				end

				arg_357_1.text_.text = var_360_12
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_10, arg_357_1.talkMaxDuration)

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_9) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_9 + var_360_16 and arg_357_1.time_ < var_360_9 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play930011090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 930011090
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play930011091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.475

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[1412].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(930011090)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 19
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play930011091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 930011091
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play930011092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.45

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(930011091)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 18
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play930011092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 930011092
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play930011093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.8

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[1412].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(930011092)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 32
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_8 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_8 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_8

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_8 and arg_369_1.time_ < var_372_0 + var_372_8 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play930011093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 930011093
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play930011094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.775

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(930011093)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 31
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_8 and arg_373_1.time_ < var_376_0 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play930011094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 930011094
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play930011095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.525

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[1412].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(930011094)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 21
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_8 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_8 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_8

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_8 and arg_377_1.time_ < var_380_0 + var_380_8 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play930011095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 930011095
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play930011096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.475

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(930011095)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 19
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play930011096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 930011096
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play930011097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 0.95

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_2 = arg_385_1:FormatText(StoryNameCfg[1412].name)

				arg_385_1.leftNameTxt_.text = var_388_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:GetWordFromCfg(930011096)
				local var_388_4 = arg_385_1:FormatText(var_388_3.content)

				arg_385_1.text_.text = var_388_4

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 38
				local var_388_6 = utf8.len(var_388_4)
				local var_388_7 = var_388_5 <= 0 and var_388_1 or var_388_1 * (var_388_6 / var_388_5)

				if var_388_7 > 0 and var_388_1 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_0
					end
				end

				arg_385_1.text_.text = var_388_4
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_8 = math.max(var_388_1, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_8 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_0) / var_388_8

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_8 and arg_385_1.time_ < var_388_0 + var_388_8 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play930011097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 930011097
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play930011098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0
			local var_392_1 = 1.65

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_2 = arg_389_1:FormatText(StoryNameCfg[1412].name)

				arg_389_1.leftNameTxt_.text = var_392_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_3 = arg_389_1:GetWordFromCfg(930011097)
				local var_392_4 = arg_389_1:FormatText(var_392_3.content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 66
				local var_392_6 = utf8.len(var_392_4)
				local var_392_7 = var_392_5 <= 0 and var_392_1 or var_392_1 * (var_392_6 / var_392_5)

				if var_392_7 > 0 and var_392_1 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play930011098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 930011098
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play930011099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1019ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1019ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1019ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = arg_393_1.actors_["1019ui_story"]
			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1019ui_story == nil then
				arg_393_1.var_.characterEffect1019ui_story = var_396_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if var_396_10 <= arg_393_1.time_ and arg_393_1.time_ < var_396_10 + var_396_11 and not isNil(var_396_9) then
				local var_396_12 = (arg_393_1.time_ - var_396_10) / var_396_11

				if arg_393_1.var_.characterEffect1019ui_story and not isNil(var_396_9) then
					arg_393_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_10 + var_396_11 and arg_393_1.time_ < var_396_10 + var_396_11 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1019ui_story then
				arg_393_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_396_13 = 0

			if var_396_13 < arg_393_1.time_ and arg_393_1.time_ <= var_396_13 + arg_396_0 then
				arg_393_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_396_15 = 0
			local var_396_16 = 0.35

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[13].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(930011098)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 14
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_23 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_23 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_23

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_23 and arg_393_1.time_ < var_396_15 + var_396_23 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play930011099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 930011099
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play930011100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1019ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1019ui_story == nil then
				arg_397_1.var_.characterEffect1019ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1019ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1019ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1019ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1019ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 1.425

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[1412].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_9 = arg_397_1:GetWordFromCfg(930011099)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 59
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play930011100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 930011100
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play930011101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1019ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1019ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, 100, 0)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1019ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, 100, 0)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = 0
			local var_404_10 = 0.325

			if var_404_9 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_11 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_12 = arg_401_1:GetWordFromCfg(930011100)
				local var_404_13 = arg_401_1:FormatText(var_404_12.content)

				arg_401_1.text_.text = var_404_13

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_14 = 13
				local var_404_15 = utf8.len(var_404_13)
				local var_404_16 = var_404_14 <= 0 and var_404_10 or var_404_10 * (var_404_15 / var_404_14)

				if var_404_16 > 0 and var_404_10 < var_404_16 then
					arg_401_1.talkMaxDuration = var_404_16

					if var_404_16 + var_404_9 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_16 + var_404_9
					end
				end

				arg_401_1.text_.text = var_404_13
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_17 = math.max(var_404_10, arg_401_1.talkMaxDuration)

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_17 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_9) / var_404_17

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_9 + var_404_17 and arg_401_1.time_ < var_404_9 + var_404_17 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play930011101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 930011101
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play930011102(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 1.075

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[1412].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:GetWordFromCfg(930011101)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 45
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_8 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_8 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_8

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_8 and arg_405_1.time_ < var_408_0 + var_408_8 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play930011102 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 930011102
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play930011103(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.65

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[7].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(930011102)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 26
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_8 and arg_409_1.time_ < var_412_0 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play930011103 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 930011103
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play930011104(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 1.35

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[1412].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(930011103)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 70
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_8 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_8 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_8

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_8 and arg_413_1.time_ < var_416_0 + var_416_8 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play930011104 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 930011104
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play930011105(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 1.45

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[1412].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(930011104)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 58
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play930011105 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 930011105
		arg_421_1.duration_ = 1

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"

			SetActive(arg_421_1.choicesGo_, true)

			for iter_422_0, iter_422_1 in ipairs(arg_421_1.choices_) do
				local var_422_0 = iter_422_0 <= 2

				SetActive(iter_422_1.go, var_422_0)
			end

			arg_421_1.choices_[1].txt.text = arg_421_1:FormatText(StoryChoiceCfg[1502].name)
			arg_421_1.choices_[2].txt.text = arg_421_1:FormatText(StoryChoiceCfg[1503].name)
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play930011107(arg_421_1)
			end

			if arg_423_0 == 2 then
				arg_421_0:Play930011106(arg_421_1)
			end

			arg_421_1:RecordChoiceLog(930011105, 1502, 1503)
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.allBtn_.enabled = false
			end

			local var_424_1 = 0.5

			if arg_421_1.time_ >= var_424_0 + var_424_1 and arg_421_1.time_ < var_424_0 + var_424_1 + arg_424_0 then
				arg_421_1.allBtn_.enabled = true
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play930011107 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 930011107
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play930011108(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0
			local var_428_1 = 0.575

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_2 = arg_425_1:FormatText(StoryNameCfg[7].name)

				arg_425_1.leftNameTxt_.text = var_428_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(930011107)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 23
				local var_428_6 = utf8.len(var_428_4)
				local var_428_7 = var_428_5 <= 0 and var_428_1 or var_428_1 * (var_428_6 / var_428_5)

				if var_428_7 > 0 and var_428_1 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_8 and arg_425_1.time_ < var_428_0 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play930011108 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 930011108
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play930011109(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0
			local var_432_1 = 0.25

			if var_432_0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_2 = arg_429_1:FormatText(StoryNameCfg[1412].name)

				arg_429_1.leftNameTxt_.text = var_432_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:GetWordFromCfg(930011108)
				local var_432_4 = arg_429_1:FormatText(var_432_3.content)

				arg_429_1.text_.text = var_432_4

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 10
				local var_432_6 = utf8.len(var_432_4)
				local var_432_7 = var_432_5 <= 0 and var_432_1 or var_432_1 * (var_432_6 / var_432_5)

				if var_432_7 > 0 and var_432_1 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_0
					end
				end

				arg_429_1.text_.text = var_432_4
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_8 = math.max(var_432_1, arg_429_1.talkMaxDuration)

			if var_432_0 <= arg_429_1.time_ and arg_429_1.time_ < var_432_0 + var_432_8 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_0) / var_432_8

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_0 + var_432_8 and arg_429_1.time_ < var_432_0 + var_432_8 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play930011109 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 930011109
		arg_433_1.duration_ = 1

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"

			SetActive(arg_433_1.choicesGo_, true)

			for iter_434_0, iter_434_1 in ipairs(arg_433_1.choices_) do
				local var_434_0 = iter_434_0 <= 1

				SetActive(iter_434_1.go, var_434_0)
			end

			arg_433_1.choices_[1].txt.text = arg_433_1:FormatText(StoryChoiceCfg[1511].name)
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play930011110(arg_433_1)
			end

			arg_433_1:RecordChoiceLog(930011109, 1511)
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0

			if var_436_0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_0 + arg_436_0 then
				arg_433_1.allBtn_.enabled = false
			end

			local var_436_1 = 0.6

			if arg_433_1.time_ >= var_436_0 + var_436_1 and arg_433_1.time_ < var_436_0 + var_436_1 + arg_436_0 then
				arg_433_1.allBtn_.enabled = true
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play930011110 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 930011110
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play930011111(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0
			local var_440_1 = 0.275

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_2 = arg_437_1:FormatText(StoryNameCfg[1412].name)

				arg_437_1.leftNameTxt_.text = var_440_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:GetWordFromCfg(930011110)
				local var_440_4 = arg_437_1:FormatText(var_440_3.content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 11
				local var_440_6 = utf8.len(var_440_4)
				local var_440_7 = var_440_5 <= 0 and var_440_1 or var_440_1 * (var_440_6 / var_440_5)

				if var_440_7 > 0 and var_440_1 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_0
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_1, arg_437_1.talkMaxDuration)

			if var_440_0 <= arg_437_1.time_ and arg_437_1.time_ < var_440_0 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_0) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_0 + var_440_8 and arg_437_1.time_ < var_440_0 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play930011111 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 930011111
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play930011112(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 1.3

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_2 = arg_441_1:FormatText(StoryNameCfg[1412].name)

				arg_441_1.leftNameTxt_.text = var_444_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(930011111)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 52
				local var_444_6 = utf8.len(var_444_4)
				local var_444_7 = var_444_5 <= 0 and var_444_1 or var_444_1 * (var_444_6 / var_444_5)

				if var_444_7 > 0 and var_444_1 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play930011112 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 930011112
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play930011113(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0
			local var_448_1 = 1.35

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_2 = arg_445_1:FormatText(StoryNameCfg[1412].name)

				arg_445_1.leftNameTxt_.text = var_448_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:GetWordFromCfg(930011112)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 54
				local var_448_6 = utf8.len(var_448_4)
				local var_448_7 = var_448_5 <= 0 and var_448_1 or var_448_1 * (var_448_6 / var_448_5)

				if var_448_7 > 0 and var_448_1 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_0
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_8 = math.max(var_448_1, arg_445_1.talkMaxDuration)

			if var_448_0 <= arg_445_1.time_ and arg_445_1.time_ < var_448_0 + var_448_8 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_0) / var_448_8

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_0 + var_448_8 and arg_445_1.time_ < var_448_0 + var_448_8 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play930011113 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 930011113
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play930011114(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.15

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:GetWordFromCfg(930011113)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 6
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_8 and arg_449_1.time_ < var_452_0 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play930011114 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 930011114
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play930011115(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.875

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(930011114)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 35
				local var_456_5 = utf8.len(var_456_3)
				local var_456_6 = var_456_4 <= 0 and var_456_1 or var_456_1 * (var_456_5 / var_456_4)

				if var_456_6 > 0 and var_456_1 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_7 and arg_453_1.time_ < var_456_0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play930011115 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 930011115
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play930011116(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.55

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(930011115)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 22
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play930011116 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 930011116
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play930011117(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.675

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[1412].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(930011116)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 27
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_8 and arg_461_1.time_ < var_464_0 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play930011117 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 930011117
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play930011118(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.6

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(930011117)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 24
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_8 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_8 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_8

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_8 and arg_465_1.time_ < var_468_0 + var_468_8 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play930011118 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 930011118
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play930011119(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0
			local var_472_1 = 0.2

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_2 = arg_469_1:FormatText(StoryNameCfg[1412].name)

				arg_469_1.leftNameTxt_.text = var_472_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:GetWordFromCfg(930011118)
				local var_472_4 = arg_469_1:FormatText(var_472_3.content)

				arg_469_1.text_.text = var_472_4

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 8
				local var_472_6 = utf8.len(var_472_4)
				local var_472_7 = var_472_5 <= 0 and var_472_1 or var_472_1 * (var_472_6 / var_472_5)

				if var_472_7 > 0 and var_472_1 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_4
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play930011119 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 930011119
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play930011120(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1019ui_story"].transform
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.var_.moveOldPos1019ui_story = var_476_0.localPosition
			end

			local var_476_2 = 0.001

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2
				local var_476_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_476_0.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1019ui_story, var_476_4, var_476_3)

				local var_476_5 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_5.x, var_476_5.y, var_476_5.z)

				local var_476_6 = var_476_0.localEulerAngles

				var_476_6.z = 0
				var_476_6.x = 0
				var_476_0.localEulerAngles = var_476_6
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 then
				var_476_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_476_7 = manager.ui.mainCamera.transform.position - var_476_0.position

				var_476_0.forward = Vector3.New(var_476_7.x, var_476_7.y, var_476_7.z)

				local var_476_8 = var_476_0.localEulerAngles

				var_476_8.z = 0
				var_476_8.x = 0
				var_476_0.localEulerAngles = var_476_8
			end

			local var_476_9 = arg_473_1.actors_["1019ui_story"]
			local var_476_10 = 0

			if var_476_10 < arg_473_1.time_ and arg_473_1.time_ <= var_476_10 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1019ui_story == nil then
				arg_473_1.var_.characterEffect1019ui_story = var_476_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_11 = 0.200000002980232

			if var_476_10 <= arg_473_1.time_ and arg_473_1.time_ < var_476_10 + var_476_11 and not isNil(var_476_9) then
				local var_476_12 = (arg_473_1.time_ - var_476_10) / var_476_11

				if arg_473_1.var_.characterEffect1019ui_story and not isNil(var_476_9) then
					arg_473_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_10 + var_476_11 and arg_473_1.time_ < var_476_10 + var_476_11 + arg_476_0 and not isNil(var_476_9) and arg_473_1.var_.characterEffect1019ui_story then
				arg_473_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_476_13 = 0

			if var_476_13 < arg_473_1.time_ and arg_473_1.time_ <= var_476_13 + arg_476_0 then
				arg_473_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_476_14 = 0

			if var_476_14 < arg_473_1.time_ and arg_473_1.time_ <= var_476_14 + arg_476_0 then
				arg_473_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_476_15 = 0
			local var_476_16 = 0.275

			if var_476_15 < arg_473_1.time_ and arg_473_1.time_ <= var_476_15 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_17 = arg_473_1:FormatText(StoryNameCfg[13].name)

				arg_473_1.leftNameTxt_.text = var_476_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_18 = arg_473_1:GetWordFromCfg(930011119)
				local var_476_19 = arg_473_1:FormatText(var_476_18.content)

				arg_473_1.text_.text = var_476_19

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_20 = 11
				local var_476_21 = utf8.len(var_476_19)
				local var_476_22 = var_476_20 <= 0 and var_476_16 or var_476_16 * (var_476_21 / var_476_20)

				if var_476_22 > 0 and var_476_16 < var_476_22 then
					arg_473_1.talkMaxDuration = var_476_22

					if var_476_22 + var_476_15 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_22 + var_476_15
					end
				end

				arg_473_1.text_.text = var_476_19
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_23 = math.max(var_476_16, arg_473_1.talkMaxDuration)

			if var_476_15 <= arg_473_1.time_ and arg_473_1.time_ < var_476_15 + var_476_23 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_15) / var_476_23

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_15 + var_476_23 and arg_473_1.time_ < var_476_15 + var_476_23 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play930011120 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 930011120
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play930011121(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1019ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1019ui_story == nil then
				arg_477_1.var_.characterEffect1019ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect1019ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1019ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1019ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1019ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 0.35

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_9 = arg_477_1:GetWordFromCfg(930011120)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 14
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play930011121 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 930011121
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play930011122(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.2

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[1412].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(930011121)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 8
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_8 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_8 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_8

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_8 and arg_481_1.time_ < var_484_0 + var_484_8 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play930011122 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 930011122
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play930011123(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1019ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1019ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1019ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1019ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1019ui_story == nil then
				arg_485_1.var_.characterEffect1019ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1019ui_story and not isNil(var_488_9) then
					arg_485_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1019ui_story then
				arg_485_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_488_13 = 0

			if var_488_13 < arg_485_1.time_ and arg_485_1.time_ <= var_488_13 + arg_488_0 then
				arg_485_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_488_14 = 0

			if var_488_14 < arg_485_1.time_ and arg_485_1.time_ <= var_488_14 + arg_488_0 then
				arg_485_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_488_15 = 0
			local var_488_16 = 0.225

			if var_488_15 < arg_485_1.time_ and arg_485_1.time_ <= var_488_15 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_17 = arg_485_1:FormatText(StoryNameCfg[13].name)

				arg_485_1.leftNameTxt_.text = var_488_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_18 = arg_485_1:GetWordFromCfg(930011122)
				local var_488_19 = arg_485_1:FormatText(var_488_18.content)

				arg_485_1.text_.text = var_488_19

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_20 = 9
				local var_488_21 = utf8.len(var_488_19)
				local var_488_22 = var_488_20 <= 0 and var_488_16 or var_488_16 * (var_488_21 / var_488_20)

				if var_488_22 > 0 and var_488_16 < var_488_22 then
					arg_485_1.talkMaxDuration = var_488_22

					if var_488_22 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_22 + var_488_15
					end
				end

				arg_485_1.text_.text = var_488_19
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_23 = math.max(var_488_16, arg_485_1.talkMaxDuration)

			if var_488_15 <= arg_485_1.time_ and arg_485_1.time_ < var_488_15 + var_488_23 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_15) / var_488_23

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_15 + var_488_23 and arg_485_1.time_ < var_488_15 + var_488_23 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play930011123 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 930011123
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play930011124(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1019ui_story"].transform
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.var_.moveOldPos1019ui_story = var_492_0.localPosition
			end

			local var_492_2 = 0.001

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2
				local var_492_4 = Vector3.New(0, 100, 0)

				var_492_0.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1019ui_story, var_492_4, var_492_3)

				local var_492_5 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_5.x, var_492_5.y, var_492_5.z)

				local var_492_6 = var_492_0.localEulerAngles

				var_492_6.z = 0
				var_492_6.x = 0
				var_492_0.localEulerAngles = var_492_6
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 then
				var_492_0.localPosition = Vector3.New(0, 100, 0)

				local var_492_7 = manager.ui.mainCamera.transform.position - var_492_0.position

				var_492_0.forward = Vector3.New(var_492_7.x, var_492_7.y, var_492_7.z)

				local var_492_8 = var_492_0.localEulerAngles

				var_492_8.z = 0
				var_492_8.x = 0
				var_492_0.localEulerAngles = var_492_8
			end

			local var_492_9 = arg_489_1.actors_["1019ui_story"]
			local var_492_10 = 0

			if var_492_10 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 and not isNil(var_492_9) and arg_489_1.var_.characterEffect1019ui_story == nil then
				arg_489_1.var_.characterEffect1019ui_story = var_492_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_11 = 0.200000002980232

			if var_492_10 <= arg_489_1.time_ and arg_489_1.time_ < var_492_10 + var_492_11 and not isNil(var_492_9) then
				local var_492_12 = (arg_489_1.time_ - var_492_10) / var_492_11

				if arg_489_1.var_.characterEffect1019ui_story and not isNil(var_492_9) then
					local var_492_13 = Mathf.Lerp(0, 0.5, var_492_12)

					arg_489_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1019ui_story.fillRatio = var_492_13
				end
			end

			if arg_489_1.time_ >= var_492_10 + var_492_11 and arg_489_1.time_ < var_492_10 + var_492_11 + arg_492_0 and not isNil(var_492_9) and arg_489_1.var_.characterEffect1019ui_story then
				local var_492_14 = 0.5

				arg_489_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1019ui_story.fillRatio = var_492_14
			end

			local var_492_15 = 0
			local var_492_16 = 1.375

			if var_492_15 < arg_489_1.time_ and arg_489_1.time_ <= var_492_15 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_17 = arg_489_1:GetWordFromCfg(930011123)
				local var_492_18 = arg_489_1:FormatText(var_492_17.content)

				arg_489_1.text_.text = var_492_18

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_19 = 55
				local var_492_20 = utf8.len(var_492_18)
				local var_492_21 = var_492_19 <= 0 and var_492_16 or var_492_16 * (var_492_20 / var_492_19)

				if var_492_21 > 0 and var_492_16 < var_492_21 then
					arg_489_1.talkMaxDuration = var_492_21

					if var_492_21 + var_492_15 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_21 + var_492_15
					end
				end

				arg_489_1.text_.text = var_492_18
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_22 = math.max(var_492_16, arg_489_1.talkMaxDuration)

			if var_492_15 <= arg_489_1.time_ and arg_489_1.time_ < var_492_15 + var_492_22 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_15) / var_492_22

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_15 + var_492_22 and arg_489_1.time_ < var_492_15 + var_492_22 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play930011124 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 930011124
		arg_493_1.duration_ = 9

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play930011125(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = "ST05"

			if arg_493_1.bgs_[var_496_0] == nil then
				local var_496_1 = Object.Instantiate(arg_493_1.paintGo_)

				var_496_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_496_0)
				var_496_1.name = var_496_0
				var_496_1.transform.parent = arg_493_1.stage_.transform
				var_496_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.bgs_[var_496_0] = var_496_1
			end

			local var_496_2 = 1.999999999999

			if var_496_2 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				local var_496_3 = manager.ui.mainCamera.transform.localPosition
				local var_496_4 = Vector3.New(0, 0, 10) + Vector3.New(var_496_3.x, var_496_3.y, 0)
				local var_496_5 = arg_493_1.bgs_.ST05

				var_496_5.transform.localPosition = var_496_4
				var_496_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_496_6 = var_496_5:GetComponent("SpriteRenderer")

				if var_496_6 and var_496_6.sprite then
					local var_496_7 = (var_496_5.transform.localPosition - var_496_3).z
					local var_496_8 = manager.ui.mainCameraCom_
					local var_496_9 = 2 * var_496_7 * Mathf.Tan(var_496_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_496_10 = var_496_9 * var_496_8.aspect
					local var_496_11 = var_496_6.sprite.bounds.size.x
					local var_496_12 = var_496_6.sprite.bounds.size.y
					local var_496_13 = var_496_10 / var_496_11
					local var_496_14 = var_496_9 / var_496_12
					local var_496_15 = var_496_14 < var_496_13 and var_496_13 or var_496_14

					var_496_5.transform.localScale = Vector3.New(var_496_15, var_496_15, 0)
				end

				for iter_496_0, iter_496_1 in pairs(arg_493_1.bgs_) do
					if iter_496_0 ~= "ST05" then
						iter_496_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_496_16 = 3.999999999999

			if var_496_16 < arg_493_1.time_ and arg_493_1.time_ <= var_496_16 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			local var_496_17 = 0.3

			if arg_493_1.time_ >= var_496_16 + var_496_17 and arg_493_1.time_ < var_496_16 + var_496_17 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_18 = 0

			if var_496_18 < arg_493_1.time_ and arg_493_1.time_ <= var_496_18 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_19 = 2

			if var_496_18 <= arg_493_1.time_ and arg_493_1.time_ < var_496_18 + var_496_19 then
				local var_496_20 = (arg_493_1.time_ - var_496_18) / var_496_19
				local var_496_21 = Color.New(0, 0, 0)

				var_496_21.a = Mathf.Lerp(0, 1, var_496_20)
				arg_493_1.mask_.color = var_496_21
			end

			if arg_493_1.time_ >= var_496_18 + var_496_19 and arg_493_1.time_ < var_496_18 + var_496_19 + arg_496_0 then
				local var_496_22 = Color.New(0, 0, 0)

				var_496_22.a = 1
				arg_493_1.mask_.color = var_496_22
			end

			local var_496_23 = 2

			if var_496_23 < arg_493_1.time_ and arg_493_1.time_ <= var_496_23 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_24 = 2

			if var_496_23 <= arg_493_1.time_ and arg_493_1.time_ < var_496_23 + var_496_24 then
				local var_496_25 = (arg_493_1.time_ - var_496_23) / var_496_24
				local var_496_26 = Color.New(0, 0, 0)

				var_496_26.a = Mathf.Lerp(1, 0, var_496_25)
				arg_493_1.mask_.color = var_496_26
			end

			if arg_493_1.time_ >= var_496_23 + var_496_24 and arg_493_1.time_ < var_496_23 + var_496_24 + arg_496_0 then
				local var_496_27 = Color.New(0, 0, 0)
				local var_496_28 = 0

				arg_493_1.mask_.enabled = false
				var_496_27.a = var_496_28
				arg_493_1.mask_.color = var_496_27
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_29 = 3.999999999999
			local var_496_30 = 1.175

			if var_496_29 < arg_493_1.time_ and arg_493_1.time_ <= var_496_29 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_31 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_31:setOnUpdate(LuaHelper.FloatAction(function(arg_497_0)
					arg_493_1.dialogCg_.alpha = arg_497_0
				end))
				var_496_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_32 = arg_493_1:GetWordFromCfg(930011124)
				local var_496_33 = arg_493_1:FormatText(var_496_32.content)

				arg_493_1.text_.text = var_496_33

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_34 = 47
				local var_496_35 = utf8.len(var_496_33)
				local var_496_36 = var_496_34 <= 0 and var_496_30 or var_496_30 * (var_496_35 / var_496_34)

				if var_496_36 > 0 and var_496_30 < var_496_36 then
					arg_493_1.talkMaxDuration = var_496_36
					var_496_29 = var_496_29 + 0.3

					if var_496_36 + var_496_29 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_36 + var_496_29
					end
				end

				arg_493_1.text_.text = var_496_33
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_37 = var_496_29 + 0.3
			local var_496_38 = math.max(var_496_30, arg_493_1.talkMaxDuration)

			if var_496_37 <= arg_493_1.time_ and arg_493_1.time_ < var_496_37 + var_496_38 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_37) / var_496_38

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_37 + var_496_38 and arg_493_1.time_ < var_496_37 + var_496_38 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST05",
				frequency = 25,
				className = "StoryShakeNode",
				duration = 0.2,
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0.1)
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play930011125 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 930011125
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play930011126(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.2

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(930011125)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 48
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play930011126 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 930011126
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play930011127(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = "1044ui_story"

			if arg_503_1.actors_[var_506_0] == nil then
				local var_506_1 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_506_1) then
					local var_506_2 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_503_1.stage_.transform)

					var_506_2.name = var_506_0
					var_506_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_503_1.actors_[var_506_0] = var_506_2

					local var_506_3 = var_506_2:GetComponentInChildren(typeof(CharacterEffect))

					var_506_3.enabled = true

					local var_506_4 = GameObjectTools.GetOrAddComponent(var_506_2, typeof(DynamicBoneHelper))

					if var_506_4 then
						var_506_4:EnableDynamicBone(false)
					end

					arg_503_1:ShowWeapon(var_506_3.transform, false)

					arg_503_1.var_[var_506_0 .. "Animator"] = var_506_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_503_1.var_[var_506_0 .. "Animator"].applyRootMotion = true
					arg_503_1.var_[var_506_0 .. "LipSync"] = var_506_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_506_5 = arg_503_1.actors_["1044ui_story"].transform
			local var_506_6 = 0

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.var_.moveOldPos1044ui_story = var_506_5.localPosition
			end

			local var_506_7 = 0.001

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_7 then
				local var_506_8 = (arg_503_1.time_ - var_506_6) / var_506_7
				local var_506_9 = Vector3.New(0, -1, -5.93)

				var_506_5.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1044ui_story, var_506_9, var_506_8)

				local var_506_10 = manager.ui.mainCamera.transform.position - var_506_5.position

				var_506_5.forward = Vector3.New(var_506_10.x, var_506_10.y, var_506_10.z)

				local var_506_11 = var_506_5.localEulerAngles

				var_506_11.z = 0
				var_506_11.x = 0
				var_506_5.localEulerAngles = var_506_11
			end

			if arg_503_1.time_ >= var_506_6 + var_506_7 and arg_503_1.time_ < var_506_6 + var_506_7 + arg_506_0 then
				var_506_5.localPosition = Vector3.New(0, -1, -5.93)

				local var_506_12 = manager.ui.mainCamera.transform.position - var_506_5.position

				var_506_5.forward = Vector3.New(var_506_12.x, var_506_12.y, var_506_12.z)

				local var_506_13 = var_506_5.localEulerAngles

				var_506_13.z = 0
				var_506_13.x = 0
				var_506_5.localEulerAngles = var_506_13
			end

			local var_506_14 = arg_503_1.actors_["1044ui_story"]
			local var_506_15 = 0

			if var_506_15 < arg_503_1.time_ and arg_503_1.time_ <= var_506_15 + arg_506_0 and not isNil(var_506_14) and arg_503_1.var_.characterEffect1044ui_story == nil then
				arg_503_1.var_.characterEffect1044ui_story = var_506_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_16 = 0.200000002980232

			if var_506_15 <= arg_503_1.time_ and arg_503_1.time_ < var_506_15 + var_506_16 and not isNil(var_506_14) then
				local var_506_17 = (arg_503_1.time_ - var_506_15) / var_506_16

				if arg_503_1.var_.characterEffect1044ui_story and not isNil(var_506_14) then
					arg_503_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_15 + var_506_16 and arg_503_1.time_ < var_506_15 + var_506_16 + arg_506_0 and not isNil(var_506_14) and arg_503_1.var_.characterEffect1044ui_story then
				arg_503_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_506_18 = 0

			if var_506_18 < arg_503_1.time_ and arg_503_1.time_ <= var_506_18 + arg_506_0 then
				arg_503_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_506_19 = 0

			if var_506_19 < arg_503_1.time_ and arg_503_1.time_ <= var_506_19 + arg_506_0 then
				arg_503_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_506_20 = 0
			local var_506_21 = 0.825

			if var_506_20 < arg_503_1.time_ and arg_503_1.time_ <= var_506_20 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_22 = arg_503_1:FormatText(StoryNameCfg[1367].name)

				arg_503_1.leftNameTxt_.text = var_506_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_23 = arg_503_1:GetWordFromCfg(930011126)
				local var_506_24 = arg_503_1:FormatText(var_506_23.content)

				arg_503_1.text_.text = var_506_24

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_25 = 33
				local var_506_26 = utf8.len(var_506_24)
				local var_506_27 = var_506_25 <= 0 and var_506_21 or var_506_21 * (var_506_26 / var_506_25)

				if var_506_27 > 0 and var_506_21 < var_506_27 then
					arg_503_1.talkMaxDuration = var_506_27

					if var_506_27 + var_506_20 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_27 + var_506_20
					end
				end

				arg_503_1.text_.text = var_506_24
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_28 = math.max(var_506_21, arg_503_1.talkMaxDuration)

			if var_506_20 <= arg_503_1.time_ and arg_503_1.time_ < var_506_20 + var_506_28 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_20) / var_506_28

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_20 + var_506_28 and arg_503_1.time_ < var_506_20 + var_506_28 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play930011127 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 930011127
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play930011128(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1044ui_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1044ui_story == nil then
				arg_507_1.var_.characterEffect1044ui_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect1044ui_story and not isNil(var_510_0) then
					local var_510_4 = Mathf.Lerp(0, 0.5, var_510_3)

					arg_507_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1044ui_story.fillRatio = var_510_4
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1044ui_story then
				local var_510_5 = 0.5

				arg_507_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1044ui_story.fillRatio = var_510_5
			end

			local var_510_6 = 0
			local var_510_7 = 0.2

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_8 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_9 = arg_507_1:GetWordFromCfg(930011127)
				local var_510_10 = arg_507_1:FormatText(var_510_9.content)

				arg_507_1.text_.text = var_510_10

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_11 = 8
				local var_510_12 = utf8.len(var_510_10)
				local var_510_13 = var_510_11 <= 0 and var_510_7 or var_510_7 * (var_510_12 / var_510_11)

				if var_510_13 > 0 and var_510_7 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_6
					end
				end

				arg_507_1.text_.text = var_510_10
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_14 = math.max(var_510_7, arg_507_1.talkMaxDuration)

			if var_510_6 <= arg_507_1.time_ and arg_507_1.time_ < var_510_6 + var_510_14 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_6) / var_510_14

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_6 + var_510_14 and arg_507_1.time_ < var_510_6 + var_510_14 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play930011128 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 930011128
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play930011129(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1044ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos1044ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -1, -5.93)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1044ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = arg_511_1.actors_["1044ui_story"]
			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect1044ui_story == nil then
				arg_511_1.var_.characterEffect1044ui_story = var_514_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_11 = 0.200000002980232

			if var_514_10 <= arg_511_1.time_ and arg_511_1.time_ < var_514_10 + var_514_11 and not isNil(var_514_9) then
				local var_514_12 = (arg_511_1.time_ - var_514_10) / var_514_11

				if arg_511_1.var_.characterEffect1044ui_story and not isNil(var_514_9) then
					arg_511_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_10 + var_514_11 and arg_511_1.time_ < var_514_10 + var_514_11 + arg_514_0 and not isNil(var_514_9) and arg_511_1.var_.characterEffect1044ui_story then
				arg_511_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_514_13 = 0

			if var_514_13 < arg_511_1.time_ and arg_511_1.time_ <= var_514_13 + arg_514_0 then
				arg_511_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_514_14 = 0

			if var_514_14 < arg_511_1.time_ and arg_511_1.time_ <= var_514_14 + arg_514_0 then
				arg_511_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_514_15 = 0
			local var_514_16 = 0.175

			if var_514_15 < arg_511_1.time_ and arg_511_1.time_ <= var_514_15 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_17 = arg_511_1:FormatText(StoryNameCfg[1367].name)

				arg_511_1.leftNameTxt_.text = var_514_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_18 = arg_511_1:GetWordFromCfg(930011128)
				local var_514_19 = arg_511_1:FormatText(var_514_18.content)

				arg_511_1.text_.text = var_514_19

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_20 = 7
				local var_514_21 = utf8.len(var_514_19)
				local var_514_22 = var_514_20 <= 0 and var_514_16 or var_514_16 * (var_514_21 / var_514_20)

				if var_514_22 > 0 and var_514_16 < var_514_22 then
					arg_511_1.talkMaxDuration = var_514_22

					if var_514_22 + var_514_15 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_22 + var_514_15
					end
				end

				arg_511_1.text_.text = var_514_19
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_23 = math.max(var_514_16, arg_511_1.talkMaxDuration)

			if var_514_15 <= arg_511_1.time_ and arg_511_1.time_ < var_514_15 + var_514_23 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_15) / var_514_23

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_15 + var_514_23 and arg_511_1.time_ < var_514_15 + var_514_23 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_511_1:InitPlayNodeList()
	end,
	Play930011129 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 930011129
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play930011130(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1044ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1044ui_story == nil then
				arg_515_1.var_.characterEffect1044ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1044ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1044ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1044ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1044ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 0.1

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(930011129)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 4
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play930011130 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 930011130
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play930011131(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = arg_519_1.actors_["1044ui_story"].transform
			local var_522_1 = 0

			if var_522_1 < arg_519_1.time_ and arg_519_1.time_ <= var_522_1 + arg_522_0 then
				arg_519_1.var_.moveOldPos1044ui_story = var_522_0.localPosition
			end

			local var_522_2 = 0.001

			if var_522_1 <= arg_519_1.time_ and arg_519_1.time_ < var_522_1 + var_522_2 then
				local var_522_3 = (arg_519_1.time_ - var_522_1) / var_522_2
				local var_522_4 = Vector3.New(0, -1, -5.93)

				var_522_0.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1044ui_story, var_522_4, var_522_3)

				local var_522_5 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_5.x, var_522_5.y, var_522_5.z)

				local var_522_6 = var_522_0.localEulerAngles

				var_522_6.z = 0
				var_522_6.x = 0
				var_522_0.localEulerAngles = var_522_6
			end

			if arg_519_1.time_ >= var_522_1 + var_522_2 and arg_519_1.time_ < var_522_1 + var_522_2 + arg_522_0 then
				var_522_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_522_7 = manager.ui.mainCamera.transform.position - var_522_0.position

				var_522_0.forward = Vector3.New(var_522_7.x, var_522_7.y, var_522_7.z)

				local var_522_8 = var_522_0.localEulerAngles

				var_522_8.z = 0
				var_522_8.x = 0
				var_522_0.localEulerAngles = var_522_8
			end

			local var_522_9 = arg_519_1.actors_["1044ui_story"]
			local var_522_10 = 0

			if var_522_10 < arg_519_1.time_ and arg_519_1.time_ <= var_522_10 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect1044ui_story == nil then
				arg_519_1.var_.characterEffect1044ui_story = var_522_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_11 = 0.200000002980232

			if var_522_10 <= arg_519_1.time_ and arg_519_1.time_ < var_522_10 + var_522_11 and not isNil(var_522_9) then
				local var_522_12 = (arg_519_1.time_ - var_522_10) / var_522_11

				if arg_519_1.var_.characterEffect1044ui_story and not isNil(var_522_9) then
					arg_519_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= var_522_10 + var_522_11 and arg_519_1.time_ < var_522_10 + var_522_11 + arg_522_0 and not isNil(var_522_9) and arg_519_1.var_.characterEffect1044ui_story then
				arg_519_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_522_13 = 0

			if var_522_13 < arg_519_1.time_ and arg_519_1.time_ <= var_522_13 + arg_522_0 then
				arg_519_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_522_14 = 0

			if var_522_14 < arg_519_1.time_ and arg_519_1.time_ <= var_522_14 + arg_522_0 then
				arg_519_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_522_15 = 0
			local var_522_16 = 0.275

			if var_522_15 < arg_519_1.time_ and arg_519_1.time_ <= var_522_15 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_17 = arg_519_1:FormatText(StoryNameCfg[1367].name)

				arg_519_1.leftNameTxt_.text = var_522_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_18 = arg_519_1:GetWordFromCfg(930011130)
				local var_522_19 = arg_519_1:FormatText(var_522_18.content)

				arg_519_1.text_.text = var_522_19

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_20 = 11
				local var_522_21 = utf8.len(var_522_19)
				local var_522_22 = var_522_20 <= 0 and var_522_16 or var_522_16 * (var_522_21 / var_522_20)

				if var_522_22 > 0 and var_522_16 < var_522_22 then
					arg_519_1.talkMaxDuration = var_522_22

					if var_522_22 + var_522_15 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_22 + var_522_15
					end
				end

				arg_519_1.text_.text = var_522_19
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_23 = math.max(var_522_16, arg_519_1.talkMaxDuration)

			if var_522_15 <= arg_519_1.time_ and arg_519_1.time_ < var_522_15 + var_522_23 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_15) / var_522_23

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_15 + var_522_23 and arg_519_1.time_ < var_522_15 + var_522_23 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play930011131 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 930011131
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play930011132(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1044ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1044ui_story == nil then
				arg_523_1.var_.characterEffect1044ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 and not isNil(var_526_0) then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect1044ui_story and not isNil(var_526_0) then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1044ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and not isNil(var_526_0) and arg_523_1.var_.characterEffect1044ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1044ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 0.225

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_8 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_9 = arg_523_1:GetWordFromCfg(930011131)
				local var_526_10 = arg_523_1:FormatText(var_526_9.content)

				arg_523_1.text_.text = var_526_10

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_11 = 9
				local var_526_12 = utf8.len(var_526_10)
				local var_526_13 = var_526_11 <= 0 and var_526_7 or var_526_7 * (var_526_12 / var_526_11)

				if var_526_13 > 0 and var_526_7 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_10
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_14 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_14 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_14

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_14 and arg_523_1.time_ < var_526_6 + var_526_14 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play930011132 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 930011132
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play930011133(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1044ui_story"].transform
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 then
				arg_527_1.var_.moveOldPos1044ui_story = var_530_0.localPosition
			end

			local var_530_2 = 0.001

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2
				local var_530_4 = Vector3.New(0, -1, -5.93)

				var_530_0.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1044ui_story, var_530_4, var_530_3)

				local var_530_5 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_5.x, var_530_5.y, var_530_5.z)

				local var_530_6 = var_530_0.localEulerAngles

				var_530_6.z = 0
				var_530_6.x = 0
				var_530_0.localEulerAngles = var_530_6
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 then
				var_530_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_530_7 = manager.ui.mainCamera.transform.position - var_530_0.position

				var_530_0.forward = Vector3.New(var_530_7.x, var_530_7.y, var_530_7.z)

				local var_530_8 = var_530_0.localEulerAngles

				var_530_8.z = 0
				var_530_8.x = 0
				var_530_0.localEulerAngles = var_530_8
			end

			local var_530_9 = arg_527_1.actors_["1044ui_story"]
			local var_530_10 = 0

			if var_530_10 < arg_527_1.time_ and arg_527_1.time_ <= var_530_10 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1044ui_story == nil then
				arg_527_1.var_.characterEffect1044ui_story = var_530_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_11 = 0.200000002980232

			if var_530_10 <= arg_527_1.time_ and arg_527_1.time_ < var_530_10 + var_530_11 and not isNil(var_530_9) then
				local var_530_12 = (arg_527_1.time_ - var_530_10) / var_530_11

				if arg_527_1.var_.characterEffect1044ui_story and not isNil(var_530_9) then
					arg_527_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= var_530_10 + var_530_11 and arg_527_1.time_ < var_530_10 + var_530_11 + arg_530_0 and not isNil(var_530_9) and arg_527_1.var_.characterEffect1044ui_story then
				arg_527_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_530_13 = 0

			if var_530_13 < arg_527_1.time_ and arg_527_1.time_ <= var_530_13 + arg_530_0 then
				arg_527_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_1")
			end

			local var_530_14 = 0

			if var_530_14 < arg_527_1.time_ and arg_527_1.time_ <= var_530_14 + arg_530_0 then
				arg_527_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_530_15 = 0
			local var_530_16 = 0.2

			if var_530_15 < arg_527_1.time_ and arg_527_1.time_ <= var_530_15 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_17 = arg_527_1:FormatText(StoryNameCfg[1367].name)

				arg_527_1.leftNameTxt_.text = var_530_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_18 = arg_527_1:GetWordFromCfg(930011132)
				local var_530_19 = arg_527_1:FormatText(var_530_18.content)

				arg_527_1.text_.text = var_530_19

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_20 = 8
				local var_530_21 = utf8.len(var_530_19)
				local var_530_22 = var_530_20 <= 0 and var_530_16 or var_530_16 * (var_530_21 / var_530_20)

				if var_530_22 > 0 and var_530_16 < var_530_22 then
					arg_527_1.talkMaxDuration = var_530_22

					if var_530_22 + var_530_15 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_22 + var_530_15
					end
				end

				arg_527_1.text_.text = var_530_19
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_23 = math.max(var_530_16, arg_527_1.talkMaxDuration)

			if var_530_15 <= arg_527_1.time_ and arg_527_1.time_ < var_530_15 + var_530_23 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_15) / var_530_23

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_15 + var_530_23 and arg_527_1.time_ < var_530_15 + var_530_23 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play930011133 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 930011133
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play930011134(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1044ui_story"]
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1044ui_story == nil then
				arg_531_1.var_.characterEffect1044ui_story = var_534_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 and not isNil(var_534_0) then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2

				if arg_531_1.var_.characterEffect1044ui_story and not isNil(var_534_0) then
					local var_534_4 = Mathf.Lerp(0, 0.5, var_534_3)

					arg_531_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1044ui_story.fillRatio = var_534_4
				end
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 and not isNil(var_534_0) and arg_531_1.var_.characterEffect1044ui_story then
				local var_534_5 = 0.5

				arg_531_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1044ui_story.fillRatio = var_534_5
			end

			local var_534_6 = 0
			local var_534_7 = 0.15

			if var_534_6 < arg_531_1.time_ and arg_531_1.time_ <= var_534_6 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_8 = arg_531_1:FormatText(StoryNameCfg[7].name)

				arg_531_1.leftNameTxt_.text = var_534_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_9 = arg_531_1:GetWordFromCfg(930011133)
				local var_534_10 = arg_531_1:FormatText(var_534_9.content)

				arg_531_1.text_.text = var_534_10

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_11 = 6
				local var_534_12 = utf8.len(var_534_10)
				local var_534_13 = var_534_11 <= 0 and var_534_7 or var_534_7 * (var_534_12 / var_534_11)

				if var_534_13 > 0 and var_534_7 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13

					if var_534_13 + var_534_6 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_6
					end
				end

				arg_531_1.text_.text = var_534_10
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_14 = math.max(var_534_7, arg_531_1.talkMaxDuration)

			if var_534_6 <= arg_531_1.time_ and arg_531_1.time_ < var_534_6 + var_534_14 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_6) / var_534_14

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_6 + var_534_14 and arg_531_1.time_ < var_534_6 + var_534_14 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play930011134 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 930011134
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play930011135(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1044ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos1044ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0, -1, -5.93)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1044ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = arg_535_1.actors_["1044ui_story"]
			local var_538_10 = 0

			if var_538_10 < arg_535_1.time_ and arg_535_1.time_ <= var_538_10 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect1044ui_story == nil then
				arg_535_1.var_.characterEffect1044ui_story = var_538_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_11 = 0.200000002980232

			if var_538_10 <= arg_535_1.time_ and arg_535_1.time_ < var_538_10 + var_538_11 and not isNil(var_538_9) then
				local var_538_12 = (arg_535_1.time_ - var_538_10) / var_538_11

				if arg_535_1.var_.characterEffect1044ui_story and not isNil(var_538_9) then
					arg_535_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= var_538_10 + var_538_11 and arg_535_1.time_ < var_538_10 + var_538_11 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect1044ui_story then
				arg_535_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_538_13 = 0

			if var_538_13 < arg_535_1.time_ and arg_535_1.time_ <= var_538_13 + arg_538_0 then
				arg_535_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_2")
			end

			local var_538_14 = 0

			if var_538_14 < arg_535_1.time_ and arg_535_1.time_ <= var_538_14 + arg_538_0 then
				arg_535_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_538_15 = 0
			local var_538_16 = 0.2

			if var_538_15 < arg_535_1.time_ and arg_535_1.time_ <= var_538_15 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_17 = arg_535_1:FormatText(StoryNameCfg[1367].name)

				arg_535_1.leftNameTxt_.text = var_538_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_18 = arg_535_1:GetWordFromCfg(930011134)
				local var_538_19 = arg_535_1:FormatText(var_538_18.content)

				arg_535_1.text_.text = var_538_19

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_20 = 8
				local var_538_21 = utf8.len(var_538_19)
				local var_538_22 = var_538_20 <= 0 and var_538_16 or var_538_16 * (var_538_21 / var_538_20)

				if var_538_22 > 0 and var_538_16 < var_538_22 then
					arg_535_1.talkMaxDuration = var_538_22

					if var_538_22 + var_538_15 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_22 + var_538_15
					end
				end

				arg_535_1.text_.text = var_538_19
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_23 = math.max(var_538_16, arg_535_1.talkMaxDuration)

			if var_538_15 <= arg_535_1.time_ and arg_535_1.time_ < var_538_15 + var_538_23 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_15) / var_538_23

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_15 + var_538_23 and arg_535_1.time_ < var_538_15 + var_538_23 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play930011135 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 930011135
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play930011136(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["1044ui_story"].transform
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 then
				arg_539_1.var_.moveOldPos1044ui_story = var_542_0.localPosition
			end

			local var_542_2 = 0.001

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2
				local var_542_4 = Vector3.New(0, 100, 0)

				var_542_0.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1044ui_story, var_542_4, var_542_3)

				local var_542_5 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_5.x, var_542_5.y, var_542_5.z)

				local var_542_6 = var_542_0.localEulerAngles

				var_542_6.z = 0
				var_542_6.x = 0
				var_542_0.localEulerAngles = var_542_6
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 then
				var_542_0.localPosition = Vector3.New(0, 100, 0)

				local var_542_7 = manager.ui.mainCamera.transform.position - var_542_0.position

				var_542_0.forward = Vector3.New(var_542_7.x, var_542_7.y, var_542_7.z)

				local var_542_8 = var_542_0.localEulerAngles

				var_542_8.z = 0
				var_542_8.x = 0
				var_542_0.localEulerAngles = var_542_8
			end

			local var_542_9 = arg_539_1.actors_["1044ui_story"]
			local var_542_10 = 0

			if var_542_10 < arg_539_1.time_ and arg_539_1.time_ <= var_542_10 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect1044ui_story == nil then
				arg_539_1.var_.characterEffect1044ui_story = var_542_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_11 = 0.200000002980232

			if var_542_10 <= arg_539_1.time_ and arg_539_1.time_ < var_542_10 + var_542_11 and not isNil(var_542_9) then
				local var_542_12 = (arg_539_1.time_ - var_542_10) / var_542_11

				if arg_539_1.var_.characterEffect1044ui_story and not isNil(var_542_9) then
					local var_542_13 = Mathf.Lerp(0, 0.5, var_542_12)

					arg_539_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1044ui_story.fillRatio = var_542_13
				end
			end

			if arg_539_1.time_ >= var_542_10 + var_542_11 and arg_539_1.time_ < var_542_10 + var_542_11 + arg_542_0 and not isNil(var_542_9) and arg_539_1.var_.characterEffect1044ui_story then
				local var_542_14 = 0.5

				arg_539_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1044ui_story.fillRatio = var_542_14
			end

			local var_542_15 = 0
			local var_542_16 = 1.525

			if var_542_15 < arg_539_1.time_ and arg_539_1.time_ <= var_542_15 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_17 = arg_539_1:GetWordFromCfg(930011135)
				local var_542_18 = arg_539_1:FormatText(var_542_17.content)

				arg_539_1.text_.text = var_542_18

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_19 = 61
				local var_542_20 = utf8.len(var_542_18)
				local var_542_21 = var_542_19 <= 0 and var_542_16 or var_542_16 * (var_542_20 / var_542_19)

				if var_542_21 > 0 and var_542_16 < var_542_21 then
					arg_539_1.talkMaxDuration = var_542_21

					if var_542_21 + var_542_15 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_21 + var_542_15
					end
				end

				arg_539_1.text_.text = var_542_18
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_22 = math.max(var_542_16, arg_539_1.talkMaxDuration)

			if var_542_15 <= arg_539_1.time_ and arg_539_1.time_ < var_542_15 + var_542_22 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_15) / var_542_22

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_15 + var_542_22 and arg_539_1.time_ < var_542_15 + var_542_22 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play930011136 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 930011136
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play930011137(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0
			local var_546_1 = 1.1

			if var_546_0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_2 = arg_543_1:FormatText(StoryNameCfg[7].name)

				arg_543_1.leftNameTxt_.text = var_546_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_3 = arg_543_1:GetWordFromCfg(930011136)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_5 = 46
				local var_546_6 = utf8.len(var_546_4)
				local var_546_7 = var_546_5 <= 0 and var_546_1 or var_546_1 * (var_546_6 / var_546_5)

				if var_546_7 > 0 and var_546_1 < var_546_7 then
					arg_543_1.talkMaxDuration = var_546_7

					if var_546_7 + var_546_0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_0
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_8 = math.max(var_546_1, arg_543_1.talkMaxDuration)

			if var_546_0 <= arg_543_1.time_ and arg_543_1.time_ < var_546_0 + var_546_8 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_0) / var_546_8

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_0 + var_546_8 and arg_543_1.time_ < var_546_0 + var_546_8 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play930011137 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 930011137
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play930011138(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1044ui_story"].transform
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.var_.moveOldPos1044ui_story = var_550_0.localPosition
			end

			local var_550_2 = 0.001

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2
				local var_550_4 = Vector3.New(0, -1, -5.93)

				var_550_0.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1044ui_story, var_550_4, var_550_3)

				local var_550_5 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_5.x, var_550_5.y, var_550_5.z)

				local var_550_6 = var_550_0.localEulerAngles

				var_550_6.z = 0
				var_550_6.x = 0
				var_550_0.localEulerAngles = var_550_6
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 then
				var_550_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_550_7 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_7.x, var_550_7.y, var_550_7.z)

				local var_550_8 = var_550_0.localEulerAngles

				var_550_8.z = 0
				var_550_8.x = 0
				var_550_0.localEulerAngles = var_550_8
			end

			local var_550_9 = arg_547_1.actors_["1044ui_story"]
			local var_550_10 = 0

			if var_550_10 < arg_547_1.time_ and arg_547_1.time_ <= var_550_10 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect1044ui_story == nil then
				arg_547_1.var_.characterEffect1044ui_story = var_550_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_11 = 0.200000002980232

			if var_550_10 <= arg_547_1.time_ and arg_547_1.time_ < var_550_10 + var_550_11 and not isNil(var_550_9) then
				local var_550_12 = (arg_547_1.time_ - var_550_10) / var_550_11

				if arg_547_1.var_.characterEffect1044ui_story and not isNil(var_550_9) then
					arg_547_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= var_550_10 + var_550_11 and arg_547_1.time_ < var_550_10 + var_550_11 + arg_550_0 and not isNil(var_550_9) and arg_547_1.var_.characterEffect1044ui_story then
				arg_547_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_550_13 = 0

			if var_550_13 < arg_547_1.time_ and arg_547_1.time_ <= var_550_13 + arg_550_0 then
				arg_547_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_1")
			end

			local var_550_14 = 0

			if var_550_14 < arg_547_1.time_ and arg_547_1.time_ <= var_550_14 + arg_550_0 then
				arg_547_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_550_15 = 0
			local var_550_16 = 1.1

			if var_550_15 < arg_547_1.time_ and arg_547_1.time_ <= var_550_15 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_17 = arg_547_1:FormatText(StoryNameCfg[1367].name)

				arg_547_1.leftNameTxt_.text = var_550_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_18 = arg_547_1:GetWordFromCfg(930011137)
				local var_550_19 = arg_547_1:FormatText(var_550_18.content)

				arg_547_1.text_.text = var_550_19

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_20 = 44
				local var_550_21 = utf8.len(var_550_19)
				local var_550_22 = var_550_20 <= 0 and var_550_16 or var_550_16 * (var_550_21 / var_550_20)

				if var_550_22 > 0 and var_550_16 < var_550_22 then
					arg_547_1.talkMaxDuration = var_550_22

					if var_550_22 + var_550_15 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_22 + var_550_15
					end
				end

				arg_547_1.text_.text = var_550_19
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_23 = math.max(var_550_16, arg_547_1.talkMaxDuration)

			if var_550_15 <= arg_547_1.time_ and arg_547_1.time_ < var_550_15 + var_550_23 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_15) / var_550_23

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_15 + var_550_23 and arg_547_1.time_ < var_550_15 + var_550_23 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play930011138 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 930011138
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play930011139(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_2")
			end

			local var_554_1 = 0
			local var_554_2 = 0.55

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_3 = arg_551_1:FormatText(StoryNameCfg[1367].name)

				arg_551_1.leftNameTxt_.text = var_554_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_4 = arg_551_1:GetWordFromCfg(930011138)
				local var_554_5 = arg_551_1:FormatText(var_554_4.content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_6 = 22
				local var_554_7 = utf8.len(var_554_5)
				local var_554_8 = var_554_6 <= 0 and var_554_2 or var_554_2 * (var_554_7 / var_554_6)

				if var_554_8 > 0 and var_554_2 < var_554_8 then
					arg_551_1.talkMaxDuration = var_554_8

					if var_554_8 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_9 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_9 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_9

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_9 and arg_551_1.time_ < var_554_1 + var_554_9 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play930011139 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 930011139
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play930011140(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1044ui_story"]
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1044ui_story == nil then
				arg_555_1.var_.characterEffect1044ui_story = var_558_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 and not isNil(var_558_0) then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2

				if arg_555_1.var_.characterEffect1044ui_story and not isNil(var_558_0) then
					local var_558_4 = Mathf.Lerp(0, 0.5, var_558_3)

					arg_555_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_555_1.var_.characterEffect1044ui_story.fillRatio = var_558_4
				end
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 and not isNil(var_558_0) and arg_555_1.var_.characterEffect1044ui_story then
				local var_558_5 = 0.5

				arg_555_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_555_1.var_.characterEffect1044ui_story.fillRatio = var_558_5
			end

			local var_558_6 = 0
			local var_558_7 = 0.225

			if var_558_6 < arg_555_1.time_ and arg_555_1.time_ <= var_558_6 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_8 = arg_555_1:FormatText(StoryNameCfg[7].name)

				arg_555_1.leftNameTxt_.text = var_558_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_9 = arg_555_1:GetWordFromCfg(930011139)
				local var_558_10 = arg_555_1:FormatText(var_558_9.content)

				arg_555_1.text_.text = var_558_10

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_11 = 9
				local var_558_12 = utf8.len(var_558_10)
				local var_558_13 = var_558_11 <= 0 and var_558_7 or var_558_7 * (var_558_12 / var_558_11)

				if var_558_13 > 0 and var_558_7 < var_558_13 then
					arg_555_1.talkMaxDuration = var_558_13

					if var_558_13 + var_558_6 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_13 + var_558_6
					end
				end

				arg_555_1.text_.text = var_558_10
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_14 = math.max(var_558_7, arg_555_1.talkMaxDuration)

			if var_558_6 <= arg_555_1.time_ and arg_555_1.time_ < var_558_6 + var_558_14 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_6) / var_558_14

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_6 + var_558_14 and arg_555_1.time_ < var_558_6 + var_558_14 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play930011140 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 930011140
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play930011141(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = arg_559_1.actors_["1044ui_story"]
			local var_562_1 = 0

			if var_562_1 < arg_559_1.time_ and arg_559_1.time_ <= var_562_1 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect1044ui_story == nil then
				arg_559_1.var_.characterEffect1044ui_story = var_562_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_2 = 0.200000002980232

			if var_562_1 <= arg_559_1.time_ and arg_559_1.time_ < var_562_1 + var_562_2 and not isNil(var_562_0) then
				local var_562_3 = (arg_559_1.time_ - var_562_1) / var_562_2

				if arg_559_1.var_.characterEffect1044ui_story and not isNil(var_562_0) then
					arg_559_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= var_562_1 + var_562_2 and arg_559_1.time_ < var_562_1 + var_562_2 + arg_562_0 and not isNil(var_562_0) and arg_559_1.var_.characterEffect1044ui_story then
				arg_559_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_562_4 = 0

			if var_562_4 < arg_559_1.time_ and arg_559_1.time_ <= var_562_4 + arg_562_0 then
				arg_559_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_562_5 = 0
			local var_562_6 = 0.5

			if var_562_5 < arg_559_1.time_ and arg_559_1.time_ <= var_562_5 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_7 = arg_559_1:FormatText(StoryNameCfg[1367].name)

				arg_559_1.leftNameTxt_.text = var_562_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_8 = arg_559_1:GetWordFromCfg(930011140)
				local var_562_9 = arg_559_1:FormatText(var_562_8.content)

				arg_559_1.text_.text = var_562_9

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_10 = 20
				local var_562_11 = utf8.len(var_562_9)
				local var_562_12 = var_562_10 <= 0 and var_562_6 or var_562_6 * (var_562_11 / var_562_10)

				if var_562_12 > 0 and var_562_6 < var_562_12 then
					arg_559_1.talkMaxDuration = var_562_12

					if var_562_12 + var_562_5 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_12 + var_562_5
					end
				end

				arg_559_1.text_.text = var_562_9
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_13 = math.max(var_562_6, arg_559_1.talkMaxDuration)

			if var_562_5 <= arg_559_1.time_ and arg_559_1.time_ < var_562_5 + var_562_13 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_5) / var_562_13

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_5 + var_562_13 and arg_559_1.time_ < var_562_5 + var_562_13 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play930011141 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 930011141
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play930011142(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1044ui_story"].transform
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.var_.moveOldPos1044ui_story = var_566_0.localPosition
			end

			local var_566_2 = 0.001

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2
				local var_566_4 = Vector3.New(0, 100, 0)

				var_566_0.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos1044ui_story, var_566_4, var_566_3)

				local var_566_5 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_5.x, var_566_5.y, var_566_5.z)

				local var_566_6 = var_566_0.localEulerAngles

				var_566_6.z = 0
				var_566_6.x = 0
				var_566_0.localEulerAngles = var_566_6
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 then
				var_566_0.localPosition = Vector3.New(0, 100, 0)

				local var_566_7 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_7.x, var_566_7.y, var_566_7.z)

				local var_566_8 = var_566_0.localEulerAngles

				var_566_8.z = 0
				var_566_8.x = 0
				var_566_0.localEulerAngles = var_566_8
			end

			local var_566_9 = arg_563_1.actors_["1044ui_story"]
			local var_566_10 = 0

			if var_566_10 < arg_563_1.time_ and arg_563_1.time_ <= var_566_10 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect1044ui_story == nil then
				arg_563_1.var_.characterEffect1044ui_story = var_566_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_11 = 0.200000002980232

			if var_566_10 <= arg_563_1.time_ and arg_563_1.time_ < var_566_10 + var_566_11 and not isNil(var_566_9) then
				local var_566_12 = (arg_563_1.time_ - var_566_10) / var_566_11

				if arg_563_1.var_.characterEffect1044ui_story and not isNil(var_566_9) then
					local var_566_13 = Mathf.Lerp(0, 0.5, var_566_12)

					arg_563_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1044ui_story.fillRatio = var_566_13
				end
			end

			if arg_563_1.time_ >= var_566_10 + var_566_11 and arg_563_1.time_ < var_566_10 + var_566_11 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect1044ui_story then
				local var_566_14 = 0.5

				arg_563_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1044ui_story.fillRatio = var_566_14
			end

			local var_566_15 = 0
			local var_566_16 = 1.225

			if var_566_15 < arg_563_1.time_ and arg_563_1.time_ <= var_566_15 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, false)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_17 = arg_563_1:GetWordFromCfg(930011141)
				local var_566_18 = arg_563_1:FormatText(var_566_17.content)

				arg_563_1.text_.text = var_566_18

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_19 = 49
				local var_566_20 = utf8.len(var_566_18)
				local var_566_21 = var_566_19 <= 0 and var_566_16 or var_566_16 * (var_566_20 / var_566_19)

				if var_566_21 > 0 and var_566_16 < var_566_21 then
					arg_563_1.talkMaxDuration = var_566_21

					if var_566_21 + var_566_15 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_21 + var_566_15
					end
				end

				arg_563_1.text_.text = var_566_18
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_22 = math.max(var_566_16, arg_563_1.talkMaxDuration)

			if var_566_15 <= arg_563_1.time_ and arg_563_1.time_ < var_566_15 + var_566_22 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_15) / var_566_22

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_15 + var_566_22 and arg_563_1.time_ < var_566_15 + var_566_22 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_563_1:InitPlayNodeList()
	end,
	Play930011142 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 930011142
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play930011143(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0
			local var_570_1 = 0.225

			if var_570_0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_2 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:GetWordFromCfg(930011142)
				local var_570_4 = arg_567_1:FormatText(var_570_3.content)

				arg_567_1.text_.text = var_570_4

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 9
				local var_570_6 = utf8.len(var_570_4)
				local var_570_7 = var_570_5 <= 0 and var_570_1 or var_570_1 * (var_570_6 / var_570_5)

				if var_570_7 > 0 and var_570_1 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_0
					end
				end

				arg_567_1.text_.text = var_570_4
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_8 = math.max(var_570_1, arg_567_1.talkMaxDuration)

			if var_570_0 <= arg_567_1.time_ and arg_567_1.time_ < var_570_0 + var_570_8 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_0) / var_570_8

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_0 + var_570_8 and arg_567_1.time_ < var_570_0 + var_570_8 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play930011143 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 930011143
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play930011144(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["1044ui_story"].transform
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.var_.moveOldPos1044ui_story = var_574_0.localPosition
			end

			local var_574_2 = 0.001

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2
				local var_574_4 = Vector3.New(0, -1, -5.93)

				var_574_0.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1044ui_story, var_574_4, var_574_3)

				local var_574_5 = manager.ui.mainCamera.transform.position - var_574_0.position

				var_574_0.forward = Vector3.New(var_574_5.x, var_574_5.y, var_574_5.z)

				local var_574_6 = var_574_0.localEulerAngles

				var_574_6.z = 0
				var_574_6.x = 0
				var_574_0.localEulerAngles = var_574_6
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 then
				var_574_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_574_7 = manager.ui.mainCamera.transform.position - var_574_0.position

				var_574_0.forward = Vector3.New(var_574_7.x, var_574_7.y, var_574_7.z)

				local var_574_8 = var_574_0.localEulerAngles

				var_574_8.z = 0
				var_574_8.x = 0
				var_574_0.localEulerAngles = var_574_8
			end

			local var_574_9 = arg_571_1.actors_["1044ui_story"]
			local var_574_10 = 0

			if var_574_10 < arg_571_1.time_ and arg_571_1.time_ <= var_574_10 + arg_574_0 and not isNil(var_574_9) and arg_571_1.var_.characterEffect1044ui_story == nil then
				arg_571_1.var_.characterEffect1044ui_story = var_574_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_11 = 0.200000002980232

			if var_574_10 <= arg_571_1.time_ and arg_571_1.time_ < var_574_10 + var_574_11 and not isNil(var_574_9) then
				local var_574_12 = (arg_571_1.time_ - var_574_10) / var_574_11

				if arg_571_1.var_.characterEffect1044ui_story and not isNil(var_574_9) then
					arg_571_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_10 + var_574_11 and arg_571_1.time_ < var_574_10 + var_574_11 + arg_574_0 and not isNil(var_574_9) and arg_571_1.var_.characterEffect1044ui_story then
				arg_571_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_574_13 = 0

			if var_574_13 < arg_571_1.time_ and arg_571_1.time_ <= var_574_13 + arg_574_0 then
				arg_571_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_574_14 = 0

			if var_574_14 < arg_571_1.time_ and arg_571_1.time_ <= var_574_14 + arg_574_0 then
				arg_571_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_574_15 = 0
			local var_574_16 = 0.15

			if var_574_15 < arg_571_1.time_ and arg_571_1.time_ <= var_574_15 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_17 = arg_571_1:FormatText(StoryNameCfg[1367].name)

				arg_571_1.leftNameTxt_.text = var_574_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_18 = arg_571_1:GetWordFromCfg(930011143)
				local var_574_19 = arg_571_1:FormatText(var_574_18.content)

				arg_571_1.text_.text = var_574_19

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_20 = 6
				local var_574_21 = utf8.len(var_574_19)
				local var_574_22 = var_574_20 <= 0 and var_574_16 or var_574_16 * (var_574_21 / var_574_20)

				if var_574_22 > 0 and var_574_16 < var_574_22 then
					arg_571_1.talkMaxDuration = var_574_22

					if var_574_22 + var_574_15 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_22 + var_574_15
					end
				end

				arg_571_1.text_.text = var_574_19
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_23 = math.max(var_574_16, arg_571_1.talkMaxDuration)

			if var_574_15 <= arg_571_1.time_ and arg_571_1.time_ < var_574_15 + var_574_23 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_15) / var_574_23

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_15 + var_574_23 and arg_571_1.time_ < var_574_15 + var_574_23 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play930011144 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 930011144
		arg_575_1.duration_ = 5

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play930011145(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["1044ui_story"].transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPos1044ui_story = var_578_0.localPosition
			end

			local var_578_2 = 0.001

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2
				local var_578_4 = Vector3.New(0, 100, 0)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1044ui_story, var_578_4, var_578_3)

				local var_578_5 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_5.x, var_578_5.y, var_578_5.z)

				local var_578_6 = var_578_0.localEulerAngles

				var_578_6.z = 0
				var_578_6.x = 0
				var_578_0.localEulerAngles = var_578_6
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(0, 100, 0)

				local var_578_7 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_7.x, var_578_7.y, var_578_7.z)

				local var_578_8 = var_578_0.localEulerAngles

				var_578_8.z = 0
				var_578_8.x = 0
				var_578_0.localEulerAngles = var_578_8
			end

			local var_578_9 = arg_575_1.actors_["1044ui_story"]
			local var_578_10 = 0

			if var_578_10 < arg_575_1.time_ and arg_575_1.time_ <= var_578_10 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect1044ui_story == nil then
				arg_575_1.var_.characterEffect1044ui_story = var_578_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_11 = 0.200000002980232

			if var_578_10 <= arg_575_1.time_ and arg_575_1.time_ < var_578_10 + var_578_11 and not isNil(var_578_9) then
				local var_578_12 = (arg_575_1.time_ - var_578_10) / var_578_11

				if arg_575_1.var_.characterEffect1044ui_story and not isNil(var_578_9) then
					local var_578_13 = Mathf.Lerp(0, 0.5, var_578_12)

					arg_575_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_575_1.var_.characterEffect1044ui_story.fillRatio = var_578_13
				end
			end

			if arg_575_1.time_ >= var_578_10 + var_578_11 and arg_575_1.time_ < var_578_10 + var_578_11 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect1044ui_story then
				local var_578_14 = 0.5

				arg_575_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_575_1.var_.characterEffect1044ui_story.fillRatio = var_578_14
			end

			local var_578_15 = 0
			local var_578_16 = 1.025

			if var_578_15 < arg_575_1.time_ and arg_575_1.time_ <= var_578_15 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, false)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_17 = arg_575_1:GetWordFromCfg(930011144)
				local var_578_18 = arg_575_1:FormatText(var_578_17.content)

				arg_575_1.text_.text = var_578_18

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_19 = 41
				local var_578_20 = utf8.len(var_578_18)
				local var_578_21 = var_578_19 <= 0 and var_578_16 or var_578_16 * (var_578_20 / var_578_19)

				if var_578_21 > 0 and var_578_16 < var_578_21 then
					arg_575_1.talkMaxDuration = var_578_21

					if var_578_21 + var_578_15 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_21 + var_578_15
					end
				end

				arg_575_1.text_.text = var_578_18
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)
				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_22 = math.max(var_578_16, arg_575_1.talkMaxDuration)

			if var_578_15 <= arg_575_1.time_ and arg_575_1.time_ < var_578_15 + var_578_22 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_15) / var_578_22

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_15 + var_578_22 and arg_575_1.time_ < var_578_15 + var_578_22 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play930011145 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 930011145
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play930011146(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.425

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_2 = arg_579_1:FormatText(StoryNameCfg[7].name)

				arg_579_1.leftNameTxt_.text = var_582_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(930011145)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_5 = 17
				local var_582_6 = utf8.len(var_582_4)
				local var_582_7 = var_582_5 <= 0 and var_582_1 or var_582_1 * (var_582_6 / var_582_5)

				if var_582_7 > 0 and var_582_1 < var_582_7 then
					arg_579_1.talkMaxDuration = var_582_7

					if var_582_7 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_8 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_8 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_8

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_8 and arg_579_1.time_ < var_582_0 + var_582_8 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play930011146 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 930011146
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play930011147(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["1044ui_story"].transform
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.var_.moveOldPos1044ui_story = var_586_0.localPosition
			end

			local var_586_2 = 0.001

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2
				local var_586_4 = Vector3.New(0, -1, -5.93)

				var_586_0.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1044ui_story, var_586_4, var_586_3)

				local var_586_5 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_5.x, var_586_5.y, var_586_5.z)

				local var_586_6 = var_586_0.localEulerAngles

				var_586_6.z = 0
				var_586_6.x = 0
				var_586_0.localEulerAngles = var_586_6
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 then
				var_586_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_586_7 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_7.x, var_586_7.y, var_586_7.z)

				local var_586_8 = var_586_0.localEulerAngles

				var_586_8.z = 0
				var_586_8.x = 0
				var_586_0.localEulerAngles = var_586_8
			end

			local var_586_9 = arg_583_1.actors_["1044ui_story"]
			local var_586_10 = 0

			if var_586_10 < arg_583_1.time_ and arg_583_1.time_ <= var_586_10 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect1044ui_story == nil then
				arg_583_1.var_.characterEffect1044ui_story = var_586_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_11 = 0.200000002980232

			if var_586_10 <= arg_583_1.time_ and arg_583_1.time_ < var_586_10 + var_586_11 and not isNil(var_586_9) then
				local var_586_12 = (arg_583_1.time_ - var_586_10) / var_586_11

				if arg_583_1.var_.characterEffect1044ui_story and not isNil(var_586_9) then
					arg_583_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= var_586_10 + var_586_11 and arg_583_1.time_ < var_586_10 + var_586_11 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect1044ui_story then
				arg_583_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_586_13 = 0

			if var_586_13 < arg_583_1.time_ and arg_583_1.time_ <= var_586_13 + arg_586_0 then
				arg_583_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_586_14 = 0

			if var_586_14 < arg_583_1.time_ and arg_583_1.time_ <= var_586_14 + arg_586_0 then
				arg_583_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_586_15 = 0
			local var_586_16 = 0.275

			if var_586_15 < arg_583_1.time_ and arg_583_1.time_ <= var_586_15 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_17 = arg_583_1:FormatText(StoryNameCfg[1367].name)

				arg_583_1.leftNameTxt_.text = var_586_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_18 = arg_583_1:GetWordFromCfg(930011146)
				local var_586_19 = arg_583_1:FormatText(var_586_18.content)

				arg_583_1.text_.text = var_586_19

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_20 = 11
				local var_586_21 = utf8.len(var_586_19)
				local var_586_22 = var_586_20 <= 0 and var_586_16 or var_586_16 * (var_586_21 / var_586_20)

				if var_586_22 > 0 and var_586_16 < var_586_22 then
					arg_583_1.talkMaxDuration = var_586_22

					if var_586_22 + var_586_15 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_22 + var_586_15
					end
				end

				arg_583_1.text_.text = var_586_19
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_23 = math.max(var_586_16, arg_583_1.talkMaxDuration)

			if var_586_15 <= arg_583_1.time_ and arg_583_1.time_ < var_586_15 + var_586_23 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_15) / var_586_23

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_15 + var_586_23 and arg_583_1.time_ < var_586_15 + var_586_23 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play930011147 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 930011147
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play930011148(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["1044ui_story"]
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect1044ui_story == nil then
				arg_587_1.var_.characterEffect1044ui_story = var_590_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_2 = 0.200000002980232

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 and not isNil(var_590_0) then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2

				if arg_587_1.var_.characterEffect1044ui_story and not isNil(var_590_0) then
					local var_590_4 = Mathf.Lerp(0, 0.5, var_590_3)

					arg_587_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1044ui_story.fillRatio = var_590_4
				end
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 and not isNil(var_590_0) and arg_587_1.var_.characterEffect1044ui_story then
				local var_590_5 = 0.5

				arg_587_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1044ui_story.fillRatio = var_590_5
			end

			local var_590_6 = 0
			local var_590_7 = 0.6

			if var_590_6 < arg_587_1.time_ and arg_587_1.time_ <= var_590_6 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				local var_590_8 = arg_587_1:FormatText(StoryNameCfg[7].name)

				arg_587_1.leftNameTxt_.text = var_590_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, true)
				arg_587_1.iconController_:SetSelectedState("hero")

				arg_587_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_587_1.callingController_:SetSelectedState("normal")

				arg_587_1.keyicon_.color = Color.New(1, 1, 1)
				arg_587_1.icon_.color = Color.New(1, 1, 1)

				local var_590_9 = arg_587_1:GetWordFromCfg(930011147)
				local var_590_10 = arg_587_1:FormatText(var_590_9.content)

				arg_587_1.text_.text = var_590_10

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_11 = 26
				local var_590_12 = utf8.len(var_590_10)
				local var_590_13 = var_590_11 <= 0 and var_590_7 or var_590_7 * (var_590_12 / var_590_11)

				if var_590_13 > 0 and var_590_7 < var_590_13 then
					arg_587_1.talkMaxDuration = var_590_13

					if var_590_13 + var_590_6 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_13 + var_590_6
					end
				end

				arg_587_1.text_.text = var_590_10
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_14 = math.max(var_590_7, arg_587_1.talkMaxDuration)

			if var_590_6 <= arg_587_1.time_ and arg_587_1.time_ < var_590_6 + var_590_14 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_6) / var_590_14

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_6 + var_590_14 and arg_587_1.time_ < var_590_6 + var_590_14 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play930011148 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 930011148
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play930011149(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = arg_591_1.actors_["1044ui_story"].transform
			local var_594_1 = 0

			if var_594_1 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.var_.moveOldPos1044ui_story = var_594_0.localPosition
			end

			local var_594_2 = 0.001

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_2 then
				local var_594_3 = (arg_591_1.time_ - var_594_1) / var_594_2
				local var_594_4 = Vector3.New(0, -1, -5.93)

				var_594_0.localPosition = Vector3.Lerp(arg_591_1.var_.moveOldPos1044ui_story, var_594_4, var_594_3)

				local var_594_5 = manager.ui.mainCamera.transform.position - var_594_0.position

				var_594_0.forward = Vector3.New(var_594_5.x, var_594_5.y, var_594_5.z)

				local var_594_6 = var_594_0.localEulerAngles

				var_594_6.z = 0
				var_594_6.x = 0
				var_594_0.localEulerAngles = var_594_6
			end

			if arg_591_1.time_ >= var_594_1 + var_594_2 and arg_591_1.time_ < var_594_1 + var_594_2 + arg_594_0 then
				var_594_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_594_7 = manager.ui.mainCamera.transform.position - var_594_0.position

				var_594_0.forward = Vector3.New(var_594_7.x, var_594_7.y, var_594_7.z)

				local var_594_8 = var_594_0.localEulerAngles

				var_594_8.z = 0
				var_594_8.x = 0
				var_594_0.localEulerAngles = var_594_8
			end

			local var_594_9 = arg_591_1.actors_["1044ui_story"]
			local var_594_10 = 0

			if var_594_10 < arg_591_1.time_ and arg_591_1.time_ <= var_594_10 + arg_594_0 and not isNil(var_594_9) and arg_591_1.var_.characterEffect1044ui_story == nil then
				arg_591_1.var_.characterEffect1044ui_story = var_594_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_11 = 0.200000002980232

			if var_594_10 <= arg_591_1.time_ and arg_591_1.time_ < var_594_10 + var_594_11 and not isNil(var_594_9) then
				local var_594_12 = (arg_591_1.time_ - var_594_10) / var_594_11

				if arg_591_1.var_.characterEffect1044ui_story and not isNil(var_594_9) then
					arg_591_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_591_1.time_ >= var_594_10 + var_594_11 and arg_591_1.time_ < var_594_10 + var_594_11 + arg_594_0 and not isNil(var_594_9) and arg_591_1.var_.characterEffect1044ui_story then
				arg_591_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_594_13 = 0

			if var_594_13 < arg_591_1.time_ and arg_591_1.time_ <= var_594_13 + arg_594_0 then
				arg_591_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_594_14 = 0
			local var_594_15 = 0.3

			if var_594_14 < arg_591_1.time_ and arg_591_1.time_ <= var_594_14 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_16 = arg_591_1:FormatText(StoryNameCfg[1367].name)

				arg_591_1.leftNameTxt_.text = var_594_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, false)
				arg_591_1.callingController_:SetSelectedState("normal")

				local var_594_17 = arg_591_1:GetWordFromCfg(930011148)
				local var_594_18 = arg_591_1:FormatText(var_594_17.content)

				arg_591_1.text_.text = var_594_18

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_19 = 12
				local var_594_20 = utf8.len(var_594_18)
				local var_594_21 = var_594_19 <= 0 and var_594_15 or var_594_15 * (var_594_20 / var_594_19)

				if var_594_21 > 0 and var_594_15 < var_594_21 then
					arg_591_1.talkMaxDuration = var_594_21

					if var_594_21 + var_594_14 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_21 + var_594_14
					end
				end

				arg_591_1.text_.text = var_594_18
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_22 = math.max(var_594_15, arg_591_1.talkMaxDuration)

			if var_594_14 <= arg_591_1.time_ and arg_591_1.time_ < var_594_14 + var_594_22 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_14) / var_594_22

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_14 + var_594_22 and arg_591_1.time_ < var_594_14 + var_594_22 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_591_1:InitPlayNodeList()
	end,
	Play930011149 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 930011149
		arg_595_1.duration_ = 5

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play930011150(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = arg_595_1.actors_["1044ui_story"]
			local var_598_1 = 0

			if var_598_1 < arg_595_1.time_ and arg_595_1.time_ <= var_598_1 + arg_598_0 and not isNil(var_598_0) and arg_595_1.var_.characterEffect1044ui_story == nil then
				arg_595_1.var_.characterEffect1044ui_story = var_598_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_2 = 0.200000002980232

			if var_598_1 <= arg_595_1.time_ and arg_595_1.time_ < var_598_1 + var_598_2 and not isNil(var_598_0) then
				local var_598_3 = (arg_595_1.time_ - var_598_1) / var_598_2

				if arg_595_1.var_.characterEffect1044ui_story and not isNil(var_598_0) then
					local var_598_4 = Mathf.Lerp(0, 0.5, var_598_3)

					arg_595_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_595_1.var_.characterEffect1044ui_story.fillRatio = var_598_4
				end
			end

			if arg_595_1.time_ >= var_598_1 + var_598_2 and arg_595_1.time_ < var_598_1 + var_598_2 + arg_598_0 and not isNil(var_598_0) and arg_595_1.var_.characterEffect1044ui_story then
				local var_598_5 = 0.5

				arg_595_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_595_1.var_.characterEffect1044ui_story.fillRatio = var_598_5
			end

			local var_598_6 = 0
			local var_598_7 = 0.675

			if var_598_6 < arg_595_1.time_ and arg_595_1.time_ <= var_598_6 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_8 = arg_595_1:FormatText(StoryNameCfg[7].name)

				arg_595_1.leftNameTxt_.text = var_598_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_9 = arg_595_1:GetWordFromCfg(930011149)
				local var_598_10 = arg_595_1:FormatText(var_598_9.content)

				arg_595_1.text_.text = var_598_10

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_11 = 27
				local var_598_12 = utf8.len(var_598_10)
				local var_598_13 = var_598_11 <= 0 and var_598_7 or var_598_7 * (var_598_12 / var_598_11)

				if var_598_13 > 0 and var_598_7 < var_598_13 then
					arg_595_1.talkMaxDuration = var_598_13

					if var_598_13 + var_598_6 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_13 + var_598_6
					end
				end

				arg_595_1.text_.text = var_598_10
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)
				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_14 = math.max(var_598_7, arg_595_1.talkMaxDuration)

			if var_598_6 <= arg_595_1.time_ and arg_595_1.time_ < var_598_6 + var_598_14 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_6) / var_598_14

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_6 + var_598_14 and arg_595_1.time_ < var_598_6 + var_598_14 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play930011150 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 930011150
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play930011151(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = arg_599_1.actors_["1044ui_story"].transform
			local var_602_1 = 0

			if var_602_1 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.var_.moveOldPos1044ui_story = var_602_0.localPosition
			end

			local var_602_2 = 0.001

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_2 then
				local var_602_3 = (arg_599_1.time_ - var_602_1) / var_602_2
				local var_602_4 = Vector3.New(0, -1, -5.93)

				var_602_0.localPosition = Vector3.Lerp(arg_599_1.var_.moveOldPos1044ui_story, var_602_4, var_602_3)

				local var_602_5 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_5.x, var_602_5.y, var_602_5.z)

				local var_602_6 = var_602_0.localEulerAngles

				var_602_6.z = 0
				var_602_6.x = 0
				var_602_0.localEulerAngles = var_602_6
			end

			if arg_599_1.time_ >= var_602_1 + var_602_2 and arg_599_1.time_ < var_602_1 + var_602_2 + arg_602_0 then
				var_602_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_602_7 = manager.ui.mainCamera.transform.position - var_602_0.position

				var_602_0.forward = Vector3.New(var_602_7.x, var_602_7.y, var_602_7.z)

				local var_602_8 = var_602_0.localEulerAngles

				var_602_8.z = 0
				var_602_8.x = 0
				var_602_0.localEulerAngles = var_602_8
			end

			local var_602_9 = arg_599_1.actors_["1044ui_story"]
			local var_602_10 = 0

			if var_602_10 < arg_599_1.time_ and arg_599_1.time_ <= var_602_10 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect1044ui_story == nil then
				arg_599_1.var_.characterEffect1044ui_story = var_602_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_11 = 0.200000002980232

			if var_602_10 <= arg_599_1.time_ and arg_599_1.time_ < var_602_10 + var_602_11 and not isNil(var_602_9) then
				local var_602_12 = (arg_599_1.time_ - var_602_10) / var_602_11

				if arg_599_1.var_.characterEffect1044ui_story and not isNil(var_602_9) then
					arg_599_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_599_1.time_ >= var_602_10 + var_602_11 and arg_599_1.time_ < var_602_10 + var_602_11 + arg_602_0 and not isNil(var_602_9) and arg_599_1.var_.characterEffect1044ui_story then
				arg_599_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_602_13 = 0

			if var_602_13 < arg_599_1.time_ and arg_599_1.time_ <= var_602_13 + arg_602_0 then
				arg_599_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_602_14 = 0

			if var_602_14 < arg_599_1.time_ and arg_599_1.time_ <= var_602_14 + arg_602_0 then
				arg_599_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_602_15 = 0
			local var_602_16 = 0.325

			if var_602_15 < arg_599_1.time_ and arg_599_1.time_ <= var_602_15 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_17 = arg_599_1:FormatText(StoryNameCfg[1367].name)

				arg_599_1.leftNameTxt_.text = var_602_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_18 = arg_599_1:GetWordFromCfg(930011150)
				local var_602_19 = arg_599_1:FormatText(var_602_18.content)

				arg_599_1.text_.text = var_602_19

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_20 = 13
				local var_602_21 = utf8.len(var_602_19)
				local var_602_22 = var_602_20 <= 0 and var_602_16 or var_602_16 * (var_602_21 / var_602_20)

				if var_602_22 > 0 and var_602_16 < var_602_22 then
					arg_599_1.talkMaxDuration = var_602_22

					if var_602_22 + var_602_15 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_22 + var_602_15
					end
				end

				arg_599_1.text_.text = var_602_19
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_23 = math.max(var_602_16, arg_599_1.talkMaxDuration)

			if var_602_15 <= arg_599_1.time_ and arg_599_1.time_ < var_602_15 + var_602_23 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_15) / var_602_23

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_15 + var_602_23 and arg_599_1.time_ < var_602_15 + var_602_23 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_599_1:InitPlayNodeList()
	end,
	Play930011151 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 930011151
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play930011152(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = arg_603_1.actors_["1044ui_story"]
			local var_606_1 = 0

			if var_606_1 < arg_603_1.time_ and arg_603_1.time_ <= var_606_1 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1044ui_story == nil then
				arg_603_1.var_.characterEffect1044ui_story = var_606_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if var_606_1 <= arg_603_1.time_ and arg_603_1.time_ < var_606_1 + var_606_2 and not isNil(var_606_0) then
				local var_606_3 = (arg_603_1.time_ - var_606_1) / var_606_2

				if arg_603_1.var_.characterEffect1044ui_story and not isNil(var_606_0) then
					local var_606_4 = Mathf.Lerp(0, 0.5, var_606_3)

					arg_603_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1044ui_story.fillRatio = var_606_4
				end
			end

			if arg_603_1.time_ >= var_606_1 + var_606_2 and arg_603_1.time_ < var_606_1 + var_606_2 + arg_606_0 and not isNil(var_606_0) and arg_603_1.var_.characterEffect1044ui_story then
				local var_606_5 = 0.5

				arg_603_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1044ui_story.fillRatio = var_606_5
			end

			local var_606_6 = 0
			local var_606_7 = 0.425

			if var_606_6 < arg_603_1.time_ and arg_603_1.time_ <= var_606_6 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_8 = arg_603_1:FormatText(StoryNameCfg[7].name)

				arg_603_1.leftNameTxt_.text = var_606_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_9 = arg_603_1:GetWordFromCfg(930011151)
				local var_606_10 = arg_603_1:FormatText(var_606_9.content)

				arg_603_1.text_.text = var_606_10

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_11 = 17
				local var_606_12 = utf8.len(var_606_10)
				local var_606_13 = var_606_11 <= 0 and var_606_7 or var_606_7 * (var_606_12 / var_606_11)

				if var_606_13 > 0 and var_606_7 < var_606_13 then
					arg_603_1.talkMaxDuration = var_606_13

					if var_606_13 + var_606_6 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_13 + var_606_6
					end
				end

				arg_603_1.text_.text = var_606_10
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_14 = math.max(var_606_7, arg_603_1.talkMaxDuration)

			if var_606_6 <= arg_603_1.time_ and arg_603_1.time_ < var_606_6 + var_606_14 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_6) / var_606_14

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_6 + var_606_14 and arg_603_1.time_ < var_606_6 + var_606_14 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play930011152 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 930011152
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play930011153(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1044ui_story"].transform
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				arg_607_1.var_.moveOldPos1044ui_story = var_610_0.localPosition
			end

			local var_610_2 = 0.001

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2
				local var_610_4 = Vector3.New(0, -1, -5.93)

				var_610_0.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1044ui_story, var_610_4, var_610_3)

				local var_610_5 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_5.x, var_610_5.y, var_610_5.z)

				local var_610_6 = var_610_0.localEulerAngles

				var_610_6.z = 0
				var_610_6.x = 0
				var_610_0.localEulerAngles = var_610_6
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 then
				var_610_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_610_7 = manager.ui.mainCamera.transform.position - var_610_0.position

				var_610_0.forward = Vector3.New(var_610_7.x, var_610_7.y, var_610_7.z)

				local var_610_8 = var_610_0.localEulerAngles

				var_610_8.z = 0
				var_610_8.x = 0
				var_610_0.localEulerAngles = var_610_8
			end

			local var_610_9 = arg_607_1.actors_["1044ui_story"]
			local var_610_10 = 0

			if var_610_10 < arg_607_1.time_ and arg_607_1.time_ <= var_610_10 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1044ui_story == nil then
				arg_607_1.var_.characterEffect1044ui_story = var_610_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_11 = 0.200000002980232

			if var_610_10 <= arg_607_1.time_ and arg_607_1.time_ < var_610_10 + var_610_11 and not isNil(var_610_9) then
				local var_610_12 = (arg_607_1.time_ - var_610_10) / var_610_11

				if arg_607_1.var_.characterEffect1044ui_story and not isNil(var_610_9) then
					arg_607_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_10 + var_610_11 and arg_607_1.time_ < var_610_10 + var_610_11 + arg_610_0 and not isNil(var_610_9) and arg_607_1.var_.characterEffect1044ui_story then
				arg_607_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_610_13 = 0

			if var_610_13 < arg_607_1.time_ and arg_607_1.time_ <= var_610_13 + arg_610_0 then
				arg_607_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_610_14 = 0

			if var_610_14 < arg_607_1.time_ and arg_607_1.time_ <= var_610_14 + arg_610_0 then
				arg_607_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_610_15 = 0
			local var_610_16 = 0.05

			if var_610_15 < arg_607_1.time_ and arg_607_1.time_ <= var_610_15 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_17 = arg_607_1:FormatText(StoryNameCfg[1367].name)

				arg_607_1.leftNameTxt_.text = var_610_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_18 = arg_607_1:GetWordFromCfg(930011152)
				local var_610_19 = arg_607_1:FormatText(var_610_18.content)

				arg_607_1.text_.text = var_610_19

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_20 = 2
				local var_610_21 = utf8.len(var_610_19)
				local var_610_22 = var_610_20 <= 0 and var_610_16 or var_610_16 * (var_610_21 / var_610_20)

				if var_610_22 > 0 and var_610_16 < var_610_22 then
					arg_607_1.talkMaxDuration = var_610_22

					if var_610_22 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_22 + var_610_15
					end
				end

				arg_607_1.text_.text = var_610_19
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_23 = math.max(var_610_16, arg_607_1.talkMaxDuration)

			if var_610_15 <= arg_607_1.time_ and arg_607_1.time_ < var_610_15 + var_610_23 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_15) / var_610_23

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_15 + var_610_23 and arg_607_1.time_ < var_610_15 + var_610_23 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play930011153 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 930011153
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play930011154(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1044ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1044ui_story == nil then
				arg_611_1.var_.characterEffect1044ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1044ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1044ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1044ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1044ui_story.fillRatio = var_614_5
			end

			local var_614_6 = 0
			local var_614_7 = 1.15

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[7].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_9 = arg_611_1:GetWordFromCfg(930011153)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 46
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_14 and arg_611_1.time_ < var_614_6 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play930011154 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 930011154
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play930011155(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1044ui_story"].transform
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 then
				arg_615_1.var_.moveOldPos1044ui_story = var_618_0.localPosition
			end

			local var_618_2 = 0.001

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2
				local var_618_4 = Vector3.New(0, -1, -5.93)

				var_618_0.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1044ui_story, var_618_4, var_618_3)

				local var_618_5 = manager.ui.mainCamera.transform.position - var_618_0.position

				var_618_0.forward = Vector3.New(var_618_5.x, var_618_5.y, var_618_5.z)

				local var_618_6 = var_618_0.localEulerAngles

				var_618_6.z = 0
				var_618_6.x = 0
				var_618_0.localEulerAngles = var_618_6
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 then
				var_618_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_618_7 = manager.ui.mainCamera.transform.position - var_618_0.position

				var_618_0.forward = Vector3.New(var_618_7.x, var_618_7.y, var_618_7.z)

				local var_618_8 = var_618_0.localEulerAngles

				var_618_8.z = 0
				var_618_8.x = 0
				var_618_0.localEulerAngles = var_618_8
			end

			local var_618_9 = arg_615_1.actors_["1044ui_story"]
			local var_618_10 = 0

			if var_618_10 < arg_615_1.time_ and arg_615_1.time_ <= var_618_10 + arg_618_0 and not isNil(var_618_9) and arg_615_1.var_.characterEffect1044ui_story == nil then
				arg_615_1.var_.characterEffect1044ui_story = var_618_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_11 = 0.200000002980232

			if var_618_10 <= arg_615_1.time_ and arg_615_1.time_ < var_618_10 + var_618_11 and not isNil(var_618_9) then
				local var_618_12 = (arg_615_1.time_ - var_618_10) / var_618_11

				if arg_615_1.var_.characterEffect1044ui_story and not isNil(var_618_9) then
					arg_615_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_615_1.time_ >= var_618_10 + var_618_11 and arg_615_1.time_ < var_618_10 + var_618_11 + arg_618_0 and not isNil(var_618_9) and arg_615_1.var_.characterEffect1044ui_story then
				arg_615_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_618_13 = 0

			if var_618_13 < arg_615_1.time_ and arg_615_1.time_ <= var_618_13 + arg_618_0 then
				arg_615_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_618_14 = 0

			if var_618_14 < arg_615_1.time_ and arg_615_1.time_ <= var_618_14 + arg_618_0 then
				arg_615_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_618_15 = 0
			local var_618_16 = 0.575

			if var_618_15 < arg_615_1.time_ and arg_615_1.time_ <= var_618_15 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_17 = arg_615_1:FormatText(StoryNameCfg[1367].name)

				arg_615_1.leftNameTxt_.text = var_618_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_18 = arg_615_1:GetWordFromCfg(930011154)
				local var_618_19 = arg_615_1:FormatText(var_618_18.content)

				arg_615_1.text_.text = var_618_19

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_20 = 23
				local var_618_21 = utf8.len(var_618_19)
				local var_618_22 = var_618_20 <= 0 and var_618_16 or var_618_16 * (var_618_21 / var_618_20)

				if var_618_22 > 0 and var_618_16 < var_618_22 then
					arg_615_1.talkMaxDuration = var_618_22

					if var_618_22 + var_618_15 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_22 + var_618_15
					end
				end

				arg_615_1.text_.text = var_618_19
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_23 = math.max(var_618_16, arg_615_1.talkMaxDuration)

			if var_618_15 <= arg_615_1.time_ and arg_615_1.time_ < var_618_15 + var_618_23 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_15) / var_618_23

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_15 + var_618_23 and arg_615_1.time_ < var_618_15 + var_618_23 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_615_1:InitPlayNodeList()
	end,
	Play930011155 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 930011155
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play930011156(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1044ui_story"]
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1044ui_story == nil then
				arg_619_1.var_.characterEffect1044ui_story = var_622_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 and not isNil(var_622_0) then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2

				if arg_619_1.var_.characterEffect1044ui_story and not isNil(var_622_0) then
					local var_622_4 = Mathf.Lerp(0, 0.5, var_622_3)

					arg_619_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_619_1.var_.characterEffect1044ui_story.fillRatio = var_622_4
				end
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 and not isNil(var_622_0) and arg_619_1.var_.characterEffect1044ui_story then
				local var_622_5 = 0.5

				arg_619_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_619_1.var_.characterEffect1044ui_story.fillRatio = var_622_5
			end

			local var_622_6 = 0
			local var_622_7 = 1.4

			if var_622_6 < arg_619_1.time_ and arg_619_1.time_ <= var_622_6 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_8 = arg_619_1:FormatText(StoryNameCfg[7].name)

				arg_619_1.leftNameTxt_.text = var_622_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, true)
				arg_619_1.iconController_:SetSelectedState("hero")

				arg_619_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_619_1.callingController_:SetSelectedState("normal")

				arg_619_1.keyicon_.color = Color.New(1, 1, 1)
				arg_619_1.icon_.color = Color.New(1, 1, 1)

				local var_622_9 = arg_619_1:GetWordFromCfg(930011155)
				local var_622_10 = arg_619_1:FormatText(var_622_9.content)

				arg_619_1.text_.text = var_622_10

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_11 = 56
				local var_622_12 = utf8.len(var_622_10)
				local var_622_13 = var_622_11 <= 0 and var_622_7 or var_622_7 * (var_622_12 / var_622_11)

				if var_622_13 > 0 and var_622_7 < var_622_13 then
					arg_619_1.talkMaxDuration = var_622_13

					if var_622_13 + var_622_6 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_13 + var_622_6
					end
				end

				arg_619_1.text_.text = var_622_10
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_14 = math.max(var_622_7, arg_619_1.talkMaxDuration)

			if var_622_6 <= arg_619_1.time_ and arg_619_1.time_ < var_622_6 + var_622_14 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_6) / var_622_14

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_6 + var_622_14 and arg_619_1.time_ < var_622_6 + var_622_14 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play930011156 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 930011156
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play930011157(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = arg_623_1.actors_["1044ui_story"]
			local var_626_1 = 0

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1044ui_story == nil then
				arg_623_1.var_.characterEffect1044ui_story = var_626_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_2 and not isNil(var_626_0) then
				local var_626_3 = (arg_623_1.time_ - var_626_1) / var_626_2

				if arg_623_1.var_.characterEffect1044ui_story and not isNil(var_626_0) then
					arg_623_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= var_626_1 + var_626_2 and arg_623_1.time_ < var_626_1 + var_626_2 + arg_626_0 and not isNil(var_626_0) and arg_623_1.var_.characterEffect1044ui_story then
				arg_623_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_626_4 = 0
			local var_626_5 = 0.625

			if var_626_4 < arg_623_1.time_ and arg_623_1.time_ <= var_626_4 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_6 = arg_623_1:FormatText(StoryNameCfg[1367].name)

				arg_623_1.leftNameTxt_.text = var_626_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_7 = arg_623_1:GetWordFromCfg(930011156)
				local var_626_8 = arg_623_1:FormatText(var_626_7.content)

				arg_623_1.text_.text = var_626_8

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_9 = 25
				local var_626_10 = utf8.len(var_626_8)
				local var_626_11 = var_626_9 <= 0 and var_626_5 or var_626_5 * (var_626_10 / var_626_9)

				if var_626_11 > 0 and var_626_5 < var_626_11 then
					arg_623_1.talkMaxDuration = var_626_11

					if var_626_11 + var_626_4 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_11 + var_626_4
					end
				end

				arg_623_1.text_.text = var_626_8
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_12 = math.max(var_626_5, arg_623_1.talkMaxDuration)

			if var_626_4 <= arg_623_1.time_ and arg_623_1.time_ < var_626_4 + var_626_12 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_4) / var_626_12

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_4 + var_626_12 and arg_623_1.time_ < var_626_4 + var_626_12 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play930011157 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 930011157
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play930011158(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1044ui_story"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1044ui_story == nil then
				arg_627_1.var_.characterEffect1044ui_story = var_630_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.200000002980232

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.characterEffect1044ui_story and not isNil(var_630_0) then
					local var_630_4 = Mathf.Lerp(0, 0.5, var_630_3)

					arg_627_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1044ui_story.fillRatio = var_630_4
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1044ui_story then
				local var_630_5 = 0.5

				arg_627_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1044ui_story.fillRatio = var_630_5
			end

			local var_630_6 = 0
			local var_630_7 = 1.1

			if var_630_6 < arg_627_1.time_ and arg_627_1.time_ <= var_630_6 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_8 = arg_627_1:FormatText(StoryNameCfg[7].name)

				arg_627_1.leftNameTxt_.text = var_630_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_9 = arg_627_1:GetWordFromCfg(930011157)
				local var_630_10 = arg_627_1:FormatText(var_630_9.content)

				arg_627_1.text_.text = var_630_10

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_11 = 44
				local var_630_12 = utf8.len(var_630_10)
				local var_630_13 = var_630_11 <= 0 and var_630_7 or var_630_7 * (var_630_12 / var_630_11)

				if var_630_13 > 0 and var_630_7 < var_630_13 then
					arg_627_1.talkMaxDuration = var_630_13

					if var_630_13 + var_630_6 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_13 + var_630_6
					end
				end

				arg_627_1.text_.text = var_630_10
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_14 = math.max(var_630_7, arg_627_1.talkMaxDuration)

			if var_630_6 <= arg_627_1.time_ and arg_627_1.time_ < var_630_6 + var_630_14 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_6) / var_630_14

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_6 + var_630_14 and arg_627_1.time_ < var_630_6 + var_630_14 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play930011158 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 930011158
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play930011159(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1044ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1044ui_story == nil then
				arg_631_1.var_.characterEffect1044ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1044ui_story and not isNil(var_634_0) then
					arg_631_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1044ui_story then
				arg_631_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_634_4 = 0

			if var_634_4 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_634_5 = 0
			local var_634_6 = 0.2

			if var_634_5 < arg_631_1.time_ and arg_631_1.time_ <= var_634_5 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_7 = arg_631_1:FormatText(StoryNameCfg[1367].name)

				arg_631_1.leftNameTxt_.text = var_634_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_8 = arg_631_1:GetWordFromCfg(930011158)
				local var_634_9 = arg_631_1:FormatText(var_634_8.content)

				arg_631_1.text_.text = var_634_9

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_10 = 8
				local var_634_11 = utf8.len(var_634_9)
				local var_634_12 = var_634_10 <= 0 and var_634_6 or var_634_6 * (var_634_11 / var_634_10)

				if var_634_12 > 0 and var_634_6 < var_634_12 then
					arg_631_1.talkMaxDuration = var_634_12

					if var_634_12 + var_634_5 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_5
					end
				end

				arg_631_1.text_.text = var_634_9
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_13 = math.max(var_634_6, arg_631_1.talkMaxDuration)

			if var_634_5 <= arg_631_1.time_ and arg_631_1.time_ < var_634_5 + var_634_13 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_5) / var_634_13

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_5 + var_634_13 and arg_631_1.time_ < var_634_5 + var_634_13 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play930011159 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 930011159
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play930011160(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["1044ui_story"]
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect1044ui_story == nil then
				arg_635_1.var_.characterEffect1044ui_story = var_638_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 and not isNil(var_638_0) then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2

				if arg_635_1.var_.characterEffect1044ui_story and not isNil(var_638_0) then
					local var_638_4 = Mathf.Lerp(0, 0.5, var_638_3)

					arg_635_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1044ui_story.fillRatio = var_638_4
				end
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 and not isNil(var_638_0) and arg_635_1.var_.characterEffect1044ui_story then
				local var_638_5 = 0.5

				arg_635_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1044ui_story.fillRatio = var_638_5
			end

			local var_638_6 = 0
			local var_638_7 = 1.325

			if var_638_6 < arg_635_1.time_ and arg_635_1.time_ <= var_638_6 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				local var_638_8 = arg_635_1:FormatText(StoryNameCfg[7].name)

				arg_635_1.leftNameTxt_.text = var_638_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_9 = arg_635_1:GetWordFromCfg(930011159)
				local var_638_10 = arg_635_1:FormatText(var_638_9.content)

				arg_635_1.text_.text = var_638_10

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_11 = 53
				local var_638_12 = utf8.len(var_638_10)
				local var_638_13 = var_638_11 <= 0 and var_638_7 or var_638_7 * (var_638_12 / var_638_11)

				if var_638_13 > 0 and var_638_7 < var_638_13 then
					arg_635_1.talkMaxDuration = var_638_13

					if var_638_13 + var_638_6 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_13 + var_638_6
					end
				end

				arg_635_1.text_.text = var_638_10
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_14 = math.max(var_638_7, arg_635_1.talkMaxDuration)

			if var_638_6 <= arg_635_1.time_ and arg_635_1.time_ < var_638_6 + var_638_14 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_6) / var_638_14

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_6 + var_638_14 and arg_635_1.time_ < var_638_6 + var_638_14 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play930011160 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 930011160
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play930011161(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 1.25

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				local var_642_2 = arg_639_1:FormatText(StoryNameCfg[7].name)

				arg_639_1.leftNameTxt_.text = var_642_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_3 = arg_639_1:GetWordFromCfg(930011160)
				local var_642_4 = arg_639_1:FormatText(var_642_3.content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 50
				local var_642_6 = utf8.len(var_642_4)
				local var_642_7 = var_642_5 <= 0 and var_642_1 or var_642_1 * (var_642_6 / var_642_5)

				if var_642_7 > 0 and var_642_1 < var_642_7 then
					arg_639_1.talkMaxDuration = var_642_7

					if var_642_7 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_8 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_8 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_8

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_8 and arg_639_1.time_ < var_642_0 + var_642_8 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play930011161 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 930011161
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play930011162(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1044ui_story"].transform
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 then
				arg_643_1.var_.moveOldPos1044ui_story = var_646_0.localPosition
			end

			local var_646_2 = 0.001

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2
				local var_646_4 = Vector3.New(0, 100, 0)

				var_646_0.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1044ui_story, var_646_4, var_646_3)

				local var_646_5 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_5.x, var_646_5.y, var_646_5.z)

				local var_646_6 = var_646_0.localEulerAngles

				var_646_6.z = 0
				var_646_6.x = 0
				var_646_0.localEulerAngles = var_646_6
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 then
				var_646_0.localPosition = Vector3.New(0, 100, 0)

				local var_646_7 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_7.x, var_646_7.y, var_646_7.z)

				local var_646_8 = var_646_0.localEulerAngles

				var_646_8.z = 0
				var_646_8.x = 0
				var_646_0.localEulerAngles = var_646_8
			end

			local var_646_9 = 0
			local var_646_10 = 1.55

			if var_646_9 < arg_643_1.time_ and arg_643_1.time_ <= var_646_9 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, false)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_11 = arg_643_1:GetWordFromCfg(930011161)
				local var_646_12 = arg_643_1:FormatText(var_646_11.content)

				arg_643_1.text_.text = var_646_12

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_13 = 62
				local var_646_14 = utf8.len(var_646_12)
				local var_646_15 = var_646_13 <= 0 and var_646_10 or var_646_10 * (var_646_14 / var_646_13)

				if var_646_15 > 0 and var_646_10 < var_646_15 then
					arg_643_1.talkMaxDuration = var_646_15

					if var_646_15 + var_646_9 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_15 + var_646_9
					end
				end

				arg_643_1.text_.text = var_646_12
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_16 = math.max(var_646_10, arg_643_1.talkMaxDuration)

			if var_646_9 <= arg_643_1.time_ and arg_643_1.time_ < var_646_9 + var_646_16 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_9) / var_646_16

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_9 + var_646_16 and arg_643_1.time_ < var_646_9 + var_646_16 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play930011162 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 930011162
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play930011163(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["1044ui_story"].transform
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 then
				arg_647_1.var_.moveOldPos1044ui_story = var_650_0.localPosition
			end

			local var_650_2 = 0.001

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2
				local var_650_4 = Vector3.New(0, -1, -5.93)

				var_650_0.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1044ui_story, var_650_4, var_650_3)

				local var_650_5 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_5.x, var_650_5.y, var_650_5.z)

				local var_650_6 = var_650_0.localEulerAngles

				var_650_6.z = 0
				var_650_6.x = 0
				var_650_0.localEulerAngles = var_650_6
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 then
				var_650_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_650_7 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_7.x, var_650_7.y, var_650_7.z)

				local var_650_8 = var_650_0.localEulerAngles

				var_650_8.z = 0
				var_650_8.x = 0
				var_650_0.localEulerAngles = var_650_8
			end

			local var_650_9 = arg_647_1.actors_["1044ui_story"]
			local var_650_10 = 0

			if var_650_10 < arg_647_1.time_ and arg_647_1.time_ <= var_650_10 + arg_650_0 and not isNil(var_650_9) and arg_647_1.var_.characterEffect1044ui_story == nil then
				arg_647_1.var_.characterEffect1044ui_story = var_650_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_11 = 0.200000002980232

			if var_650_10 <= arg_647_1.time_ and arg_647_1.time_ < var_650_10 + var_650_11 and not isNil(var_650_9) then
				local var_650_12 = (arg_647_1.time_ - var_650_10) / var_650_11

				if arg_647_1.var_.characterEffect1044ui_story and not isNil(var_650_9) then
					arg_647_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_647_1.time_ >= var_650_10 + var_650_11 and arg_647_1.time_ < var_650_10 + var_650_11 + arg_650_0 and not isNil(var_650_9) and arg_647_1.var_.characterEffect1044ui_story then
				arg_647_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_650_13 = 0

			if var_650_13 < arg_647_1.time_ and arg_647_1.time_ <= var_650_13 + arg_650_0 then
				arg_647_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_650_14 = 0

			if var_650_14 < arg_647_1.time_ and arg_647_1.time_ <= var_650_14 + arg_650_0 then
				arg_647_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_650_15 = 0
			local var_650_16 = 0.425

			if var_650_15 < arg_647_1.time_ and arg_647_1.time_ <= var_650_15 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_17 = arg_647_1:FormatText(StoryNameCfg[1367].name)

				arg_647_1.leftNameTxt_.text = var_650_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_18 = arg_647_1:GetWordFromCfg(930011162)
				local var_650_19 = arg_647_1:FormatText(var_650_18.content)

				arg_647_1.text_.text = var_650_19

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_20 = 17
				local var_650_21 = utf8.len(var_650_19)
				local var_650_22 = var_650_20 <= 0 and var_650_16 or var_650_16 * (var_650_21 / var_650_20)

				if var_650_22 > 0 and var_650_16 < var_650_22 then
					arg_647_1.talkMaxDuration = var_650_22

					if var_650_22 + var_650_15 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_22 + var_650_15
					end
				end

				arg_647_1.text_.text = var_650_19
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_23 = math.max(var_650_16, arg_647_1.talkMaxDuration)

			if var_650_15 <= arg_647_1.time_ and arg_647_1.time_ < var_650_15 + var_650_23 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_15) / var_650_23

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_15 + var_650_23 and arg_647_1.time_ < var_650_15 + var_650_23 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play930011163 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 930011163
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play930011164(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = arg_651_1.actors_["1044ui_story"]
			local var_654_1 = 0

			if var_654_1 < arg_651_1.time_ and arg_651_1.time_ <= var_654_1 + arg_654_0 and not isNil(var_654_0) and arg_651_1.var_.characterEffect1044ui_story == nil then
				arg_651_1.var_.characterEffect1044ui_story = var_654_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_654_2 = 0.200000002980232

			if var_654_1 <= arg_651_1.time_ and arg_651_1.time_ < var_654_1 + var_654_2 and not isNil(var_654_0) then
				local var_654_3 = (arg_651_1.time_ - var_654_1) / var_654_2

				if arg_651_1.var_.characterEffect1044ui_story and not isNil(var_654_0) then
					local var_654_4 = Mathf.Lerp(0, 0.5, var_654_3)

					arg_651_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_651_1.var_.characterEffect1044ui_story.fillRatio = var_654_4
				end
			end

			if arg_651_1.time_ >= var_654_1 + var_654_2 and arg_651_1.time_ < var_654_1 + var_654_2 + arg_654_0 and not isNil(var_654_0) and arg_651_1.var_.characterEffect1044ui_story then
				local var_654_5 = 0.5

				arg_651_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_651_1.var_.characterEffect1044ui_story.fillRatio = var_654_5
			end

			local var_654_6 = 0
			local var_654_7 = 1.225

			if var_654_6 < arg_651_1.time_ and arg_651_1.time_ <= var_654_6 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_8 = arg_651_1:FormatText(StoryNameCfg[7].name)

				arg_651_1.leftNameTxt_.text = var_654_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_9 = arg_651_1:GetWordFromCfg(930011163)
				local var_654_10 = arg_651_1:FormatText(var_654_9.content)

				arg_651_1.text_.text = var_654_10

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_11 = 49
				local var_654_12 = utf8.len(var_654_10)
				local var_654_13 = var_654_11 <= 0 and var_654_7 or var_654_7 * (var_654_12 / var_654_11)

				if var_654_13 > 0 and var_654_7 < var_654_13 then
					arg_651_1.talkMaxDuration = var_654_13

					if var_654_13 + var_654_6 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_13 + var_654_6
					end
				end

				arg_651_1.text_.text = var_654_10
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_14 = math.max(var_654_7, arg_651_1.talkMaxDuration)

			if var_654_6 <= arg_651_1.time_ and arg_651_1.time_ < var_654_6 + var_654_14 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_6) / var_654_14

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_6 + var_654_14 and arg_651_1.time_ < var_654_6 + var_654_14 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play930011164 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 930011164
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play930011165(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = arg_655_1.actors_["1044ui_story"].transform
			local var_658_1 = 0

			if var_658_1 < arg_655_1.time_ and arg_655_1.time_ <= var_658_1 + arg_658_0 then
				arg_655_1.var_.moveOldPos1044ui_story = var_658_0.localPosition
			end

			local var_658_2 = 0.001

			if var_658_1 <= arg_655_1.time_ and arg_655_1.time_ < var_658_1 + var_658_2 then
				local var_658_3 = (arg_655_1.time_ - var_658_1) / var_658_2
				local var_658_4 = Vector3.New(0, 100, 0)

				var_658_0.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos1044ui_story, var_658_4, var_658_3)

				local var_658_5 = manager.ui.mainCamera.transform.position - var_658_0.position

				var_658_0.forward = Vector3.New(var_658_5.x, var_658_5.y, var_658_5.z)

				local var_658_6 = var_658_0.localEulerAngles

				var_658_6.z = 0
				var_658_6.x = 0
				var_658_0.localEulerAngles = var_658_6
			end

			if arg_655_1.time_ >= var_658_1 + var_658_2 and arg_655_1.time_ < var_658_1 + var_658_2 + arg_658_0 then
				var_658_0.localPosition = Vector3.New(0, 100, 0)

				local var_658_7 = manager.ui.mainCamera.transform.position - var_658_0.position

				var_658_0.forward = Vector3.New(var_658_7.x, var_658_7.y, var_658_7.z)

				local var_658_8 = var_658_0.localEulerAngles

				var_658_8.z = 0
				var_658_8.x = 0
				var_658_0.localEulerAngles = var_658_8
			end

			local var_658_9 = 0
			local var_658_10 = 0.975

			if var_658_9 < arg_655_1.time_ and arg_655_1.time_ <= var_658_9 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, false)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_11 = arg_655_1:GetWordFromCfg(930011164)
				local var_658_12 = arg_655_1:FormatText(var_658_11.content)

				arg_655_1.text_.text = var_658_12

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_13 = 39
				local var_658_14 = utf8.len(var_658_12)
				local var_658_15 = var_658_13 <= 0 and var_658_10 or var_658_10 * (var_658_14 / var_658_13)

				if var_658_15 > 0 and var_658_10 < var_658_15 then
					arg_655_1.talkMaxDuration = var_658_15

					if var_658_15 + var_658_9 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_15 + var_658_9
					end
				end

				arg_655_1.text_.text = var_658_12
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_16 = math.max(var_658_10, arg_655_1.talkMaxDuration)

			if var_658_9 <= arg_655_1.time_ and arg_655_1.time_ < var_658_9 + var_658_16 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_9) / var_658_16

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_9 + var_658_16 and arg_655_1.time_ < var_658_9 + var_658_16 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_655_1:InitPlayNodeList()
	end,
	Play930011165 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 930011165
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play930011166(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["1044ui_story"].transform
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				arg_659_1.var_.moveOldPos1044ui_story = var_662_0.localPosition
			end

			local var_662_2 = 0.001

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2
				local var_662_4 = Vector3.New(0, -1, -5.93)

				var_662_0.localPosition = Vector3.Lerp(arg_659_1.var_.moveOldPos1044ui_story, var_662_4, var_662_3)

				local var_662_5 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_5.x, var_662_5.y, var_662_5.z)

				local var_662_6 = var_662_0.localEulerAngles

				var_662_6.z = 0
				var_662_6.x = 0
				var_662_0.localEulerAngles = var_662_6
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 then
				var_662_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_662_7 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_7.x, var_662_7.y, var_662_7.z)

				local var_662_8 = var_662_0.localEulerAngles

				var_662_8.z = 0
				var_662_8.x = 0
				var_662_0.localEulerAngles = var_662_8
			end

			local var_662_9 = arg_659_1.actors_["1044ui_story"]
			local var_662_10 = 0

			if var_662_10 < arg_659_1.time_ and arg_659_1.time_ <= var_662_10 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect1044ui_story == nil then
				arg_659_1.var_.characterEffect1044ui_story = var_662_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_11 = 0.200000002980232

			if var_662_10 <= arg_659_1.time_ and arg_659_1.time_ < var_662_10 + var_662_11 and not isNil(var_662_9) then
				local var_662_12 = (arg_659_1.time_ - var_662_10) / var_662_11

				if arg_659_1.var_.characterEffect1044ui_story and not isNil(var_662_9) then
					arg_659_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= var_662_10 + var_662_11 and arg_659_1.time_ < var_662_10 + var_662_11 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect1044ui_story then
				arg_659_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_662_13 = 0

			if var_662_13 < arg_659_1.time_ and arg_659_1.time_ <= var_662_13 + arg_662_0 then
				arg_659_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_662_14 = 0

			if var_662_14 < arg_659_1.time_ and arg_659_1.time_ <= var_662_14 + arg_662_0 then
				arg_659_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_662_15 = 0
			local var_662_16 = 0.45

			if var_662_15 < arg_659_1.time_ and arg_659_1.time_ <= var_662_15 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_17 = arg_659_1:FormatText(StoryNameCfg[1367].name)

				arg_659_1.leftNameTxt_.text = var_662_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_18 = arg_659_1:GetWordFromCfg(930011165)
				local var_662_19 = arg_659_1:FormatText(var_662_18.content)

				arg_659_1.text_.text = var_662_19

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_20 = 18
				local var_662_21 = utf8.len(var_662_19)
				local var_662_22 = var_662_20 <= 0 and var_662_16 or var_662_16 * (var_662_21 / var_662_20)

				if var_662_22 > 0 and var_662_16 < var_662_22 then
					arg_659_1.talkMaxDuration = var_662_22

					if var_662_22 + var_662_15 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_22 + var_662_15
					end
				end

				arg_659_1.text_.text = var_662_19
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_23 = math.max(var_662_16, arg_659_1.talkMaxDuration)

			if var_662_15 <= arg_659_1.time_ and arg_659_1.time_ < var_662_15 + var_662_23 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_15) / var_662_23

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_15 + var_662_23 and arg_659_1.time_ < var_662_15 + var_662_23 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_659_1:InitPlayNodeList()
	end,
	Play930011166 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 930011166
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play930011167(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["1044ui_story"]
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1044ui_story == nil then
				arg_663_1.var_.characterEffect1044ui_story = var_666_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 and not isNil(var_666_0) then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2

				if arg_663_1.var_.characterEffect1044ui_story and not isNil(var_666_0) then
					local var_666_4 = Mathf.Lerp(0, 0.5, var_666_3)

					arg_663_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1044ui_story.fillRatio = var_666_4
				end
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1044ui_story then
				local var_666_5 = 0.5

				arg_663_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1044ui_story.fillRatio = var_666_5
			end

			local var_666_6 = 0
			local var_666_7 = 1.275

			if var_666_6 < arg_663_1.time_ and arg_663_1.time_ <= var_666_6 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_8 = arg_663_1:FormatText(StoryNameCfg[7].name)

				arg_663_1.leftNameTxt_.text = var_666_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_9 = arg_663_1:GetWordFromCfg(930011166)
				local var_666_10 = arg_663_1:FormatText(var_666_9.content)

				arg_663_1.text_.text = var_666_10

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_11 = 51
				local var_666_12 = utf8.len(var_666_10)
				local var_666_13 = var_666_11 <= 0 and var_666_7 or var_666_7 * (var_666_12 / var_666_11)

				if var_666_13 > 0 and var_666_7 < var_666_13 then
					arg_663_1.talkMaxDuration = var_666_13

					if var_666_13 + var_666_6 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_13 + var_666_6
					end
				end

				arg_663_1.text_.text = var_666_10
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_14 = math.max(var_666_7, arg_663_1.talkMaxDuration)

			if var_666_6 <= arg_663_1.time_ and arg_663_1.time_ < var_666_6 + var_666_14 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_6) / var_666_14

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_6 + var_666_14 and arg_663_1.time_ < var_666_6 + var_666_14 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play930011167 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 930011167
		arg_667_1.duration_ = 5

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play930011168(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			local var_670_0 = arg_667_1.actors_["1044ui_story"]
			local var_670_1 = 0

			if var_670_1 < arg_667_1.time_ and arg_667_1.time_ <= var_670_1 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect1044ui_story == nil then
				arg_667_1.var_.characterEffect1044ui_story = var_670_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_670_2 = 0.200000002980232

			if var_670_1 <= arg_667_1.time_ and arg_667_1.time_ < var_670_1 + var_670_2 and not isNil(var_670_0) then
				local var_670_3 = (arg_667_1.time_ - var_670_1) / var_670_2

				if arg_667_1.var_.characterEffect1044ui_story and not isNil(var_670_0) then
					arg_667_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_667_1.time_ >= var_670_1 + var_670_2 and arg_667_1.time_ < var_670_1 + var_670_2 + arg_670_0 and not isNil(var_670_0) and arg_667_1.var_.characterEffect1044ui_story then
				arg_667_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_670_4 = 0

			if var_670_4 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_670_5 = 0
			local var_670_6 = 0.25

			if var_670_5 < arg_667_1.time_ and arg_667_1.time_ <= var_670_5 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0
				arg_667_1.dialogCg_.alpha = 1

				arg_667_1.dialog_:SetActive(true)
				SetActive(arg_667_1.leftNameGo_, true)

				local var_670_7 = arg_667_1:FormatText(StoryNameCfg[1367].name)

				arg_667_1.leftNameTxt_.text = var_670_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_667_1.leftNameTxt_.transform)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1.leftNameTxt_.text)
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_8 = arg_667_1:GetWordFromCfg(930011167)
				local var_670_9 = arg_667_1:FormatText(var_670_8.content)

				arg_667_1.text_.text = var_670_9

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_10 = 10
				local var_670_11 = utf8.len(var_670_9)
				local var_670_12 = var_670_10 <= 0 and var_670_6 or var_670_6 * (var_670_11 / var_670_10)

				if var_670_12 > 0 and var_670_6 < var_670_12 then
					arg_667_1.talkMaxDuration = var_670_12

					if var_670_12 + var_670_5 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_12 + var_670_5
					end
				end

				arg_667_1.text_.text = var_670_9
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_13 = math.max(var_670_6, arg_667_1.talkMaxDuration)

			if var_670_5 <= arg_667_1.time_ and arg_667_1.time_ < var_670_5 + var_670_13 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_5) / var_670_13

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_5 + var_670_13 and arg_667_1.time_ < var_670_5 + var_670_13 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {}

		arg_667_1:InitPlayNodeList()
	end,
	Play930011168 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 930011168
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play930011169(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0

			if var_674_0 < arg_671_1.time_ and arg_671_1.time_ <= var_674_0 + arg_674_0 then
				arg_671_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action432")
			end

			local var_674_1 = 0

			if var_674_1 < arg_671_1.time_ and arg_671_1.time_ <= var_674_1 + arg_674_0 then
				arg_671_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_674_2 = 0
			local var_674_3 = 0.775

			if var_674_2 < arg_671_1.time_ and arg_671_1.time_ <= var_674_2 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, true)

				local var_674_4 = arg_671_1:FormatText(StoryNameCfg[1367].name)

				arg_671_1.leftNameTxt_.text = var_674_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_671_1.leftNameTxt_.transform)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1.leftNameTxt_.text)
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_5 = arg_671_1:GetWordFromCfg(930011168)
				local var_674_6 = arg_671_1:FormatText(var_674_5.content)

				arg_671_1.text_.text = var_674_6

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_7 = 31
				local var_674_8 = utf8.len(var_674_6)
				local var_674_9 = var_674_7 <= 0 and var_674_3 or var_674_3 * (var_674_8 / var_674_7)

				if var_674_9 > 0 and var_674_3 < var_674_9 then
					arg_671_1.talkMaxDuration = var_674_9

					if var_674_9 + var_674_2 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_9 + var_674_2
					end
				end

				arg_671_1.text_.text = var_674_6
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_10 = math.max(var_674_3, arg_671_1.talkMaxDuration)

			if var_674_2 <= arg_671_1.time_ and arg_671_1.time_ < var_674_2 + var_674_10 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - var_674_2) / var_674_10

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= var_674_2 + var_674_10 and arg_671_1.time_ < var_674_2 + var_674_10 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play930011169 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 930011169
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play930011170(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0

			if var_678_0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_0 + arg_678_0 then
				arg_675_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_2")
			end

			local var_678_1 = 0

			if var_678_1 < arg_675_1.time_ and arg_675_1.time_ <= var_678_1 + arg_678_0 then
				arg_675_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_678_2 = 0
			local var_678_3 = 0.6

			if var_678_2 < arg_675_1.time_ and arg_675_1.time_ <= var_678_2 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				local var_678_4 = arg_675_1:FormatText(StoryNameCfg[1367].name)

				arg_675_1.leftNameTxt_.text = var_678_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_5 = arg_675_1:GetWordFromCfg(930011169)
				local var_678_6 = arg_675_1:FormatText(var_678_5.content)

				arg_675_1.text_.text = var_678_6

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_7 = 24
				local var_678_8 = utf8.len(var_678_6)
				local var_678_9 = var_678_7 <= 0 and var_678_3 or var_678_3 * (var_678_8 / var_678_7)

				if var_678_9 > 0 and var_678_3 < var_678_9 then
					arg_675_1.talkMaxDuration = var_678_9

					if var_678_9 + var_678_2 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_9 + var_678_2
					end
				end

				arg_675_1.text_.text = var_678_6
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_10 = math.max(var_678_3, arg_675_1.talkMaxDuration)

			if var_678_2 <= arg_675_1.time_ and arg_675_1.time_ < var_678_2 + var_678_10 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_2) / var_678_10

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_2 + var_678_10 and arg_675_1.time_ < var_678_2 + var_678_10 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play930011170 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 930011170
		arg_679_1.duration_ = 5

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play930011171(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			local var_682_0 = arg_679_1.actors_["1044ui_story"].transform
			local var_682_1 = 0

			if var_682_1 < arg_679_1.time_ and arg_679_1.time_ <= var_682_1 + arg_682_0 then
				arg_679_1.var_.moveOldPos1044ui_story = var_682_0.localPosition
			end

			local var_682_2 = 0.001

			if var_682_1 <= arg_679_1.time_ and arg_679_1.time_ < var_682_1 + var_682_2 then
				local var_682_3 = (arg_679_1.time_ - var_682_1) / var_682_2
				local var_682_4 = Vector3.New(0, 100, 0)

				var_682_0.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos1044ui_story, var_682_4, var_682_3)

				local var_682_5 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_5.x, var_682_5.y, var_682_5.z)

				local var_682_6 = var_682_0.localEulerAngles

				var_682_6.z = 0
				var_682_6.x = 0
				var_682_0.localEulerAngles = var_682_6
			end

			if arg_679_1.time_ >= var_682_1 + var_682_2 and arg_679_1.time_ < var_682_1 + var_682_2 + arg_682_0 then
				var_682_0.localPosition = Vector3.New(0, 100, 0)

				local var_682_7 = manager.ui.mainCamera.transform.position - var_682_0.position

				var_682_0.forward = Vector3.New(var_682_7.x, var_682_7.y, var_682_7.z)

				local var_682_8 = var_682_0.localEulerAngles

				var_682_8.z = 0
				var_682_8.x = 0
				var_682_0.localEulerAngles = var_682_8
			end

			local var_682_9 = arg_679_1.actors_["1044ui_story"]
			local var_682_10 = 0

			if var_682_10 < arg_679_1.time_ and arg_679_1.time_ <= var_682_10 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect1044ui_story == nil then
				arg_679_1.var_.characterEffect1044ui_story = var_682_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_682_11 = 0.200000002980232

			if var_682_10 <= arg_679_1.time_ and arg_679_1.time_ < var_682_10 + var_682_11 and not isNil(var_682_9) then
				local var_682_12 = (arg_679_1.time_ - var_682_10) / var_682_11

				if arg_679_1.var_.characterEffect1044ui_story and not isNil(var_682_9) then
					local var_682_13 = Mathf.Lerp(0, 0.5, var_682_12)

					arg_679_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_679_1.var_.characterEffect1044ui_story.fillRatio = var_682_13
				end
			end

			if arg_679_1.time_ >= var_682_10 + var_682_11 and arg_679_1.time_ < var_682_10 + var_682_11 + arg_682_0 and not isNil(var_682_9) and arg_679_1.var_.characterEffect1044ui_story then
				local var_682_14 = 0.5

				arg_679_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_679_1.var_.characterEffect1044ui_story.fillRatio = var_682_14
			end

			local var_682_15 = 0
			local var_682_16 = 1.375

			if var_682_15 < arg_679_1.time_ and arg_679_1.time_ <= var_682_15 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, false)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_17 = arg_679_1:GetWordFromCfg(930011170)
				local var_682_18 = arg_679_1:FormatText(var_682_17.content)

				arg_679_1.text_.text = var_682_18

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_19 = 55
				local var_682_20 = utf8.len(var_682_18)
				local var_682_21 = var_682_19 <= 0 and var_682_16 or var_682_16 * (var_682_20 / var_682_19)

				if var_682_21 > 0 and var_682_16 < var_682_21 then
					arg_679_1.talkMaxDuration = var_682_21

					if var_682_21 + var_682_15 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_21 + var_682_15
					end
				end

				arg_679_1.text_.text = var_682_18
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)
				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_22 = math.max(var_682_16, arg_679_1.talkMaxDuration)

			if var_682_15 <= arg_679_1.time_ and arg_679_1.time_ < var_682_15 + var_682_22 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_15) / var_682_22

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_15 + var_682_22 and arg_679_1.time_ < var_682_15 + var_682_22 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play930011171 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 930011171
		arg_683_1.duration_ = 5

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play930011172(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			local var_686_0 = 0
			local var_686_1 = 0.325

			if var_686_0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_0 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				local var_686_2 = arg_683_1:FormatText(StoryNameCfg[7].name)

				arg_683_1.leftNameTxt_.text = var_686_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, true)
				arg_683_1.iconController_:SetSelectedState("hero")

				arg_683_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_683_1.callingController_:SetSelectedState("normal")

				arg_683_1.keyicon_.color = Color.New(1, 1, 1)
				arg_683_1.icon_.color = Color.New(1, 1, 1)

				local var_686_3 = arg_683_1:GetWordFromCfg(930011171)
				local var_686_4 = arg_683_1:FormatText(var_686_3.content)

				arg_683_1.text_.text = var_686_4

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_5 = 13
				local var_686_6 = utf8.len(var_686_4)
				local var_686_7 = var_686_5 <= 0 and var_686_1 or var_686_1 * (var_686_6 / var_686_5)

				if var_686_7 > 0 and var_686_1 < var_686_7 then
					arg_683_1.talkMaxDuration = var_686_7

					if var_686_7 + var_686_0 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_7 + var_686_0
					end
				end

				arg_683_1.text_.text = var_686_4
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)
				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_8 = math.max(var_686_1, arg_683_1.talkMaxDuration)

			if var_686_0 <= arg_683_1.time_ and arg_683_1.time_ < var_686_0 + var_686_8 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_0) / var_686_8

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_0 + var_686_8 and arg_683_1.time_ < var_686_0 + var_686_8 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {}

		arg_683_1:InitPlayNodeList()
	end,
	Play930011172 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 930011172
		arg_687_1.duration_ = 5

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play930011173(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			local var_690_0 = arg_687_1.actors_["1044ui_story"].transform
			local var_690_1 = 0

			if var_690_1 < arg_687_1.time_ and arg_687_1.time_ <= var_690_1 + arg_690_0 then
				arg_687_1.var_.moveOldPos1044ui_story = var_690_0.localPosition
			end

			local var_690_2 = 0.001

			if var_690_1 <= arg_687_1.time_ and arg_687_1.time_ < var_690_1 + var_690_2 then
				local var_690_3 = (arg_687_1.time_ - var_690_1) / var_690_2
				local var_690_4 = Vector3.New(0, -1, -5.93)

				var_690_0.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos1044ui_story, var_690_4, var_690_3)

				local var_690_5 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_5.x, var_690_5.y, var_690_5.z)

				local var_690_6 = var_690_0.localEulerAngles

				var_690_6.z = 0
				var_690_6.x = 0
				var_690_0.localEulerAngles = var_690_6
			end

			if arg_687_1.time_ >= var_690_1 + var_690_2 and arg_687_1.time_ < var_690_1 + var_690_2 + arg_690_0 then
				var_690_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_690_7 = manager.ui.mainCamera.transform.position - var_690_0.position

				var_690_0.forward = Vector3.New(var_690_7.x, var_690_7.y, var_690_7.z)

				local var_690_8 = var_690_0.localEulerAngles

				var_690_8.z = 0
				var_690_8.x = 0
				var_690_0.localEulerAngles = var_690_8
			end

			local var_690_9 = arg_687_1.actors_["1044ui_story"]
			local var_690_10 = 0

			if var_690_10 < arg_687_1.time_ and arg_687_1.time_ <= var_690_10 + arg_690_0 and not isNil(var_690_9) and arg_687_1.var_.characterEffect1044ui_story == nil then
				arg_687_1.var_.characterEffect1044ui_story = var_690_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_690_11 = 0.200000002980232

			if var_690_10 <= arg_687_1.time_ and arg_687_1.time_ < var_690_10 + var_690_11 and not isNil(var_690_9) then
				local var_690_12 = (arg_687_1.time_ - var_690_10) / var_690_11

				if arg_687_1.var_.characterEffect1044ui_story and not isNil(var_690_9) then
					arg_687_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_687_1.time_ >= var_690_10 + var_690_11 and arg_687_1.time_ < var_690_10 + var_690_11 + arg_690_0 and not isNil(var_690_9) and arg_687_1.var_.characterEffect1044ui_story then
				arg_687_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_690_13 = 0

			if var_690_13 < arg_687_1.time_ and arg_687_1.time_ <= var_690_13 + arg_690_0 then
				arg_687_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_690_14 = 0

			if var_690_14 < arg_687_1.time_ and arg_687_1.time_ <= var_690_14 + arg_690_0 then
				arg_687_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_690_15 = 0
			local var_690_16 = 0.125

			if var_690_15 < arg_687_1.time_ and arg_687_1.time_ <= var_690_15 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				local var_690_17 = arg_687_1:FormatText(StoryNameCfg[1367].name)

				arg_687_1.leftNameTxt_.text = var_690_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_18 = arg_687_1:GetWordFromCfg(930011172)
				local var_690_19 = arg_687_1:FormatText(var_690_18.content)

				arg_687_1.text_.text = var_690_19

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_20 = 5
				local var_690_21 = utf8.len(var_690_19)
				local var_690_22 = var_690_20 <= 0 and var_690_16 or var_690_16 * (var_690_21 / var_690_20)

				if var_690_22 > 0 and var_690_16 < var_690_22 then
					arg_687_1.talkMaxDuration = var_690_22

					if var_690_22 + var_690_15 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_22 + var_690_15
					end
				end

				arg_687_1.text_.text = var_690_19
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)
				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_23 = math.max(var_690_16, arg_687_1.talkMaxDuration)

			if var_690_15 <= arg_687_1.time_ and arg_687_1.time_ < var_690_15 + var_690_23 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_15) / var_690_23

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_15 + var_690_23 and arg_687_1.time_ < var_690_15 + var_690_23 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play930011173 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 930011173
		arg_691_1.duration_ = 5

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play930011174(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			local var_694_0 = arg_691_1.actors_["1044ui_story"]
			local var_694_1 = 0

			if var_694_1 < arg_691_1.time_ and arg_691_1.time_ <= var_694_1 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect1044ui_story == nil then
				arg_691_1.var_.characterEffect1044ui_story = var_694_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_694_2 = 0.200000002980232

			if var_694_1 <= arg_691_1.time_ and arg_691_1.time_ < var_694_1 + var_694_2 and not isNil(var_694_0) then
				local var_694_3 = (arg_691_1.time_ - var_694_1) / var_694_2

				if arg_691_1.var_.characterEffect1044ui_story and not isNil(var_694_0) then
					local var_694_4 = Mathf.Lerp(0, 0.5, var_694_3)

					arg_691_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_691_1.var_.characterEffect1044ui_story.fillRatio = var_694_4
				end
			end

			if arg_691_1.time_ >= var_694_1 + var_694_2 and arg_691_1.time_ < var_694_1 + var_694_2 + arg_694_0 and not isNil(var_694_0) and arg_691_1.var_.characterEffect1044ui_story then
				local var_694_5 = 0.5

				arg_691_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_691_1.var_.characterEffect1044ui_story.fillRatio = var_694_5
			end

			local var_694_6 = 0
			local var_694_7 = 0.975

			if var_694_6 < arg_691_1.time_ and arg_691_1.time_ <= var_694_6 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				local var_694_8 = arg_691_1:FormatText(StoryNameCfg[7].name)

				arg_691_1.leftNameTxt_.text = var_694_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, true)
				arg_691_1.iconController_:SetSelectedState("hero")

				arg_691_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_691_1.callingController_:SetSelectedState("normal")

				arg_691_1.keyicon_.color = Color.New(1, 1, 1)
				arg_691_1.icon_.color = Color.New(1, 1, 1)

				local var_694_9 = arg_691_1:GetWordFromCfg(930011173)
				local var_694_10 = arg_691_1:FormatText(var_694_9.content)

				arg_691_1.text_.text = var_694_10

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_11 = 39
				local var_694_12 = utf8.len(var_694_10)
				local var_694_13 = var_694_11 <= 0 and var_694_7 or var_694_7 * (var_694_12 / var_694_11)

				if var_694_13 > 0 and var_694_7 < var_694_13 then
					arg_691_1.talkMaxDuration = var_694_13

					if var_694_13 + var_694_6 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_6
					end
				end

				arg_691_1.text_.text = var_694_10
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)
				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_14 = math.max(var_694_7, arg_691_1.talkMaxDuration)

			if var_694_6 <= arg_691_1.time_ and arg_691_1.time_ < var_694_6 + var_694_14 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_6) / var_694_14

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_6 + var_694_14 and arg_691_1.time_ < var_694_6 + var_694_14 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {}

		arg_691_1:InitPlayNodeList()
	end,
	Play930011174 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 930011174
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play930011175(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = arg_695_1.actors_["1044ui_story"].transform
			local var_698_1 = 0

			if var_698_1 < arg_695_1.time_ and arg_695_1.time_ <= var_698_1 + arg_698_0 then
				arg_695_1.var_.moveOldPos1044ui_story = var_698_0.localPosition
			end

			local var_698_2 = 0.001

			if var_698_1 <= arg_695_1.time_ and arg_695_1.time_ < var_698_1 + var_698_2 then
				local var_698_3 = (arg_695_1.time_ - var_698_1) / var_698_2
				local var_698_4 = Vector3.New(0, -1, -5.93)

				var_698_0.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1044ui_story, var_698_4, var_698_3)

				local var_698_5 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_5.x, var_698_5.y, var_698_5.z)

				local var_698_6 = var_698_0.localEulerAngles

				var_698_6.z = 0
				var_698_6.x = 0
				var_698_0.localEulerAngles = var_698_6
			end

			if arg_695_1.time_ >= var_698_1 + var_698_2 and arg_695_1.time_ < var_698_1 + var_698_2 + arg_698_0 then
				var_698_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_698_7 = manager.ui.mainCamera.transform.position - var_698_0.position

				var_698_0.forward = Vector3.New(var_698_7.x, var_698_7.y, var_698_7.z)

				local var_698_8 = var_698_0.localEulerAngles

				var_698_8.z = 0
				var_698_8.x = 0
				var_698_0.localEulerAngles = var_698_8
			end

			local var_698_9 = arg_695_1.actors_["1044ui_story"]
			local var_698_10 = 0

			if var_698_10 < arg_695_1.time_ and arg_695_1.time_ <= var_698_10 + arg_698_0 and not isNil(var_698_9) and arg_695_1.var_.characterEffect1044ui_story == nil then
				arg_695_1.var_.characterEffect1044ui_story = var_698_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_698_11 = 0.200000002980232

			if var_698_10 <= arg_695_1.time_ and arg_695_1.time_ < var_698_10 + var_698_11 and not isNil(var_698_9) then
				local var_698_12 = (arg_695_1.time_ - var_698_10) / var_698_11

				if arg_695_1.var_.characterEffect1044ui_story and not isNil(var_698_9) then
					arg_695_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_695_1.time_ >= var_698_10 + var_698_11 and arg_695_1.time_ < var_698_10 + var_698_11 + arg_698_0 and not isNil(var_698_9) and arg_695_1.var_.characterEffect1044ui_story then
				arg_695_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_698_13 = 0

			if var_698_13 < arg_695_1.time_ and arg_695_1.time_ <= var_698_13 + arg_698_0 then
				arg_695_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_698_14 = 0

			if var_698_14 < arg_695_1.time_ and arg_695_1.time_ <= var_698_14 + arg_698_0 then
				arg_695_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_698_15 = 0
			local var_698_16 = 0.725

			if var_698_15 < arg_695_1.time_ and arg_695_1.time_ <= var_698_15 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				local var_698_17 = arg_695_1:FormatText(StoryNameCfg[1367].name)

				arg_695_1.leftNameTxt_.text = var_698_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_18 = arg_695_1:GetWordFromCfg(930011174)
				local var_698_19 = arg_695_1:FormatText(var_698_18.content)

				arg_695_1.text_.text = var_698_19

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_20 = 29
				local var_698_21 = utf8.len(var_698_19)
				local var_698_22 = var_698_20 <= 0 and var_698_16 or var_698_16 * (var_698_21 / var_698_20)

				if var_698_22 > 0 and var_698_16 < var_698_22 then
					arg_695_1.talkMaxDuration = var_698_22

					if var_698_22 + var_698_15 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_22 + var_698_15
					end
				end

				arg_695_1.text_.text = var_698_19
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_23 = math.max(var_698_16, arg_695_1.talkMaxDuration)

			if var_698_15 <= arg_695_1.time_ and arg_695_1.time_ < var_698_15 + var_698_23 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_15) / var_698_23

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_15 + var_698_23 and arg_695_1.time_ < var_698_15 + var_698_23 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play930011175 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 930011175
		arg_699_1.duration_ = 5

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play930011176(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = arg_699_1.actors_["1044ui_story"].transform
			local var_702_1 = 0

			if var_702_1 < arg_699_1.time_ and arg_699_1.time_ <= var_702_1 + arg_702_0 then
				arg_699_1.var_.moveOldPos1044ui_story = var_702_0.localPosition
			end

			local var_702_2 = 0.001

			if var_702_1 <= arg_699_1.time_ and arg_699_1.time_ < var_702_1 + var_702_2 then
				local var_702_3 = (arg_699_1.time_ - var_702_1) / var_702_2
				local var_702_4 = Vector3.New(0, 100, 0)

				var_702_0.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos1044ui_story, var_702_4, var_702_3)

				local var_702_5 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_5.x, var_702_5.y, var_702_5.z)

				local var_702_6 = var_702_0.localEulerAngles

				var_702_6.z = 0
				var_702_6.x = 0
				var_702_0.localEulerAngles = var_702_6
			end

			if arg_699_1.time_ >= var_702_1 + var_702_2 and arg_699_1.time_ < var_702_1 + var_702_2 + arg_702_0 then
				var_702_0.localPosition = Vector3.New(0, 100, 0)

				local var_702_7 = manager.ui.mainCamera.transform.position - var_702_0.position

				var_702_0.forward = Vector3.New(var_702_7.x, var_702_7.y, var_702_7.z)

				local var_702_8 = var_702_0.localEulerAngles

				var_702_8.z = 0
				var_702_8.x = 0
				var_702_0.localEulerAngles = var_702_8
			end

			local var_702_9 = arg_699_1.actors_["1044ui_story"]
			local var_702_10 = 0

			if var_702_10 < arg_699_1.time_ and arg_699_1.time_ <= var_702_10 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect1044ui_story == nil then
				arg_699_1.var_.characterEffect1044ui_story = var_702_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_702_11 = 0.200000002980232

			if var_702_10 <= arg_699_1.time_ and arg_699_1.time_ < var_702_10 + var_702_11 and not isNil(var_702_9) then
				local var_702_12 = (arg_699_1.time_ - var_702_10) / var_702_11

				if arg_699_1.var_.characterEffect1044ui_story and not isNil(var_702_9) then
					local var_702_13 = Mathf.Lerp(0, 0.5, var_702_12)

					arg_699_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_699_1.var_.characterEffect1044ui_story.fillRatio = var_702_13
				end
			end

			if arg_699_1.time_ >= var_702_10 + var_702_11 and arg_699_1.time_ < var_702_10 + var_702_11 + arg_702_0 and not isNil(var_702_9) and arg_699_1.var_.characterEffect1044ui_story then
				local var_702_14 = 0.5

				arg_699_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_699_1.var_.characterEffect1044ui_story.fillRatio = var_702_14
			end

			local var_702_15 = 0
			local var_702_16 = 0.875

			if var_702_15 < arg_699_1.time_ and arg_699_1.time_ <= var_702_15 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, false)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_17 = arg_699_1:GetWordFromCfg(930011175)
				local var_702_18 = arg_699_1:FormatText(var_702_17.content)

				arg_699_1.text_.text = var_702_18

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_19 = 35
				local var_702_20 = utf8.len(var_702_18)
				local var_702_21 = var_702_19 <= 0 and var_702_16 or var_702_16 * (var_702_20 / var_702_19)

				if var_702_21 > 0 and var_702_16 < var_702_21 then
					arg_699_1.talkMaxDuration = var_702_21

					if var_702_21 + var_702_15 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_21 + var_702_15
					end
				end

				arg_699_1.text_.text = var_702_18
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)
				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_22 = math.max(var_702_16, arg_699_1.talkMaxDuration)

			if var_702_15 <= arg_699_1.time_ and arg_699_1.time_ < var_702_15 + var_702_22 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_15) / var_702_22

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_15 + var_702_22 and arg_699_1.time_ < var_702_15 + var_702_22 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play930011176 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 930011176
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play930011177(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 0
			local var_706_1 = 0.55

			if var_706_0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				local var_706_2 = arg_703_1:FormatText(StoryNameCfg[7].name)

				arg_703_1.leftNameTxt_.text = var_706_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_3 = arg_703_1:GetWordFromCfg(930011176)
				local var_706_4 = arg_703_1:FormatText(var_706_3.content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_5 = 22
				local var_706_6 = utf8.len(var_706_4)
				local var_706_7 = var_706_5 <= 0 and var_706_1 or var_706_1 * (var_706_6 / var_706_5)

				if var_706_7 > 0 and var_706_1 < var_706_7 then
					arg_703_1.talkMaxDuration = var_706_7

					if var_706_7 + var_706_0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_7 + var_706_0
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_8 = math.max(var_706_1, arg_703_1.talkMaxDuration)

			if var_706_0 <= arg_703_1.time_ and arg_703_1.time_ < var_706_0 + var_706_8 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_0) / var_706_8

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_0 + var_706_8 and arg_703_1.time_ < var_706_0 + var_706_8 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play930011177 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 930011177
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play930011178(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = arg_707_1.actors_["1044ui_story"].transform
			local var_710_1 = 0

			if var_710_1 < arg_707_1.time_ and arg_707_1.time_ <= var_710_1 + arg_710_0 then
				arg_707_1.var_.moveOldPos1044ui_story = var_710_0.localPosition
			end

			local var_710_2 = 0.001

			if var_710_1 <= arg_707_1.time_ and arg_707_1.time_ < var_710_1 + var_710_2 then
				local var_710_3 = (arg_707_1.time_ - var_710_1) / var_710_2
				local var_710_4 = Vector3.New(0, -1, -5.93)

				var_710_0.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos1044ui_story, var_710_4, var_710_3)

				local var_710_5 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_5.x, var_710_5.y, var_710_5.z)

				local var_710_6 = var_710_0.localEulerAngles

				var_710_6.z = 0
				var_710_6.x = 0
				var_710_0.localEulerAngles = var_710_6
			end

			if arg_707_1.time_ >= var_710_1 + var_710_2 and arg_707_1.time_ < var_710_1 + var_710_2 + arg_710_0 then
				var_710_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_710_7 = manager.ui.mainCamera.transform.position - var_710_0.position

				var_710_0.forward = Vector3.New(var_710_7.x, var_710_7.y, var_710_7.z)

				local var_710_8 = var_710_0.localEulerAngles

				var_710_8.z = 0
				var_710_8.x = 0
				var_710_0.localEulerAngles = var_710_8
			end

			local var_710_9 = arg_707_1.actors_["1044ui_story"]
			local var_710_10 = 0

			if var_710_10 < arg_707_1.time_ and arg_707_1.time_ <= var_710_10 + arg_710_0 and not isNil(var_710_9) and arg_707_1.var_.characterEffect1044ui_story == nil then
				arg_707_1.var_.characterEffect1044ui_story = var_710_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_710_11 = 0.200000002980232

			if var_710_10 <= arg_707_1.time_ and arg_707_1.time_ < var_710_10 + var_710_11 and not isNil(var_710_9) then
				local var_710_12 = (arg_707_1.time_ - var_710_10) / var_710_11

				if arg_707_1.var_.characterEffect1044ui_story and not isNil(var_710_9) then
					arg_707_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_707_1.time_ >= var_710_10 + var_710_11 and arg_707_1.time_ < var_710_10 + var_710_11 + arg_710_0 and not isNil(var_710_9) and arg_707_1.var_.characterEffect1044ui_story then
				arg_707_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_710_13 = 0

			if var_710_13 < arg_707_1.time_ and arg_707_1.time_ <= var_710_13 + arg_710_0 then
				arg_707_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action484")
			end

			local var_710_14 = 0

			if var_710_14 < arg_707_1.time_ and arg_707_1.time_ <= var_710_14 + arg_710_0 then
				arg_707_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_710_15 = 0
			local var_710_16 = 0.4

			if var_710_15 < arg_707_1.time_ and arg_707_1.time_ <= var_710_15 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				local var_710_17 = arg_707_1:FormatText(StoryNameCfg[1367].name)

				arg_707_1.leftNameTxt_.text = var_710_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_18 = arg_707_1:GetWordFromCfg(930011177)
				local var_710_19 = arg_707_1:FormatText(var_710_18.content)

				arg_707_1.text_.text = var_710_19

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_20 = 16
				local var_710_21 = utf8.len(var_710_19)
				local var_710_22 = var_710_20 <= 0 and var_710_16 or var_710_16 * (var_710_21 / var_710_20)

				if var_710_22 > 0 and var_710_16 < var_710_22 then
					arg_707_1.talkMaxDuration = var_710_22

					if var_710_22 + var_710_15 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_22 + var_710_15
					end
				end

				arg_707_1.text_.text = var_710_19
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_23 = math.max(var_710_16, arg_707_1.talkMaxDuration)

			if var_710_15 <= arg_707_1.time_ and arg_707_1.time_ < var_710_15 + var_710_23 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_15) / var_710_23

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_15 + var_710_23 and arg_707_1.time_ < var_710_15 + var_710_23 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play930011178 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 930011178
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play930011179(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = arg_711_1.actors_["1044ui_story"]
			local var_714_1 = 0

			if var_714_1 < arg_711_1.time_ and arg_711_1.time_ <= var_714_1 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1044ui_story == nil then
				arg_711_1.var_.characterEffect1044ui_story = var_714_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_714_2 = 0.200000002980232

			if var_714_1 <= arg_711_1.time_ and arg_711_1.time_ < var_714_1 + var_714_2 and not isNil(var_714_0) then
				local var_714_3 = (arg_711_1.time_ - var_714_1) / var_714_2

				if arg_711_1.var_.characterEffect1044ui_story and not isNil(var_714_0) then
					local var_714_4 = Mathf.Lerp(0, 0.5, var_714_3)

					arg_711_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_711_1.var_.characterEffect1044ui_story.fillRatio = var_714_4
				end
			end

			if arg_711_1.time_ >= var_714_1 + var_714_2 and arg_711_1.time_ < var_714_1 + var_714_2 + arg_714_0 and not isNil(var_714_0) and arg_711_1.var_.characterEffect1044ui_story then
				local var_714_5 = 0.5

				arg_711_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_711_1.var_.characterEffect1044ui_story.fillRatio = var_714_5
			end

			local var_714_6 = 0
			local var_714_7 = 0.075

			if var_714_6 < arg_711_1.time_ and arg_711_1.time_ <= var_714_6 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				local var_714_8 = arg_711_1:FormatText(StoryNameCfg[7].name)

				arg_711_1.leftNameTxt_.text = var_714_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, true)
				arg_711_1.iconController_:SetSelectedState("hero")

				arg_711_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_711_1.callingController_:SetSelectedState("normal")

				arg_711_1.keyicon_.color = Color.New(1, 1, 1)
				arg_711_1.icon_.color = Color.New(1, 1, 1)

				local var_714_9 = arg_711_1:GetWordFromCfg(930011178)
				local var_714_10 = arg_711_1:FormatText(var_714_9.content)

				arg_711_1.text_.text = var_714_10

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_11 = 3
				local var_714_12 = utf8.len(var_714_10)
				local var_714_13 = var_714_11 <= 0 and var_714_7 or var_714_7 * (var_714_12 / var_714_11)

				if var_714_13 > 0 and var_714_7 < var_714_13 then
					arg_711_1.talkMaxDuration = var_714_13

					if var_714_13 + var_714_6 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_13 + var_714_6
					end
				end

				arg_711_1.text_.text = var_714_10
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_14 = math.max(var_714_7, arg_711_1.talkMaxDuration)

			if var_714_6 <= arg_711_1.time_ and arg_711_1.time_ < var_714_6 + var_714_14 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_6) / var_714_14

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_6 + var_714_14 and arg_711_1.time_ < var_714_6 + var_714_14 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play930011179 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 930011179
		arg_715_1.duration_ = 5

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play930011180(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = arg_715_1.actors_["1044ui_story"].transform
			local var_718_1 = 0

			if var_718_1 < arg_715_1.time_ and arg_715_1.time_ <= var_718_1 + arg_718_0 then
				arg_715_1.var_.moveOldPos1044ui_story = var_718_0.localPosition
			end

			local var_718_2 = 0.001

			if var_718_1 <= arg_715_1.time_ and arg_715_1.time_ < var_718_1 + var_718_2 then
				local var_718_3 = (arg_715_1.time_ - var_718_1) / var_718_2
				local var_718_4 = Vector3.New(0, 100, 0)

				var_718_0.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos1044ui_story, var_718_4, var_718_3)

				local var_718_5 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_5.x, var_718_5.y, var_718_5.z)

				local var_718_6 = var_718_0.localEulerAngles

				var_718_6.z = 0
				var_718_6.x = 0
				var_718_0.localEulerAngles = var_718_6
			end

			if arg_715_1.time_ >= var_718_1 + var_718_2 and arg_715_1.time_ < var_718_1 + var_718_2 + arg_718_0 then
				var_718_0.localPosition = Vector3.New(0, 100, 0)

				local var_718_7 = manager.ui.mainCamera.transform.position - var_718_0.position

				var_718_0.forward = Vector3.New(var_718_7.x, var_718_7.y, var_718_7.z)

				local var_718_8 = var_718_0.localEulerAngles

				var_718_8.z = 0
				var_718_8.x = 0
				var_718_0.localEulerAngles = var_718_8
			end

			local var_718_9 = 0
			local var_718_10 = 1.35

			if var_718_9 < arg_715_1.time_ and arg_715_1.time_ <= var_718_9 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, false)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_11 = arg_715_1:GetWordFromCfg(930011179)
				local var_718_12 = arg_715_1:FormatText(var_718_11.content)

				arg_715_1.text_.text = var_718_12

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_13 = 54
				local var_718_14 = utf8.len(var_718_12)
				local var_718_15 = var_718_13 <= 0 and var_718_10 or var_718_10 * (var_718_14 / var_718_13)

				if var_718_15 > 0 and var_718_10 < var_718_15 then
					arg_715_1.talkMaxDuration = var_718_15

					if var_718_15 + var_718_9 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_15 + var_718_9
					end
				end

				arg_715_1.text_.text = var_718_12
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)
				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_16 = math.max(var_718_10, arg_715_1.talkMaxDuration)

			if var_718_9 <= arg_715_1.time_ and arg_715_1.time_ < var_718_9 + var_718_16 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_9) / var_718_16

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_9 + var_718_16 and arg_715_1.time_ < var_718_9 + var_718_16 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play930011180 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 930011180
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play930011181(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = "1028ui_story"

			if arg_719_1.actors_[var_722_0] == nil then
				local var_722_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_722_1) then
					local var_722_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_719_1.stage_.transform)

					var_722_2.name = var_722_0
					var_722_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_719_1.actors_[var_722_0] = var_722_2

					local var_722_3 = var_722_2:GetComponentInChildren(typeof(CharacterEffect))

					var_722_3.enabled = true

					local var_722_4 = GameObjectTools.GetOrAddComponent(var_722_2, typeof(DynamicBoneHelper))

					if var_722_4 then
						var_722_4:EnableDynamicBone(false)
					end

					arg_719_1:ShowWeapon(var_722_3.transform, false)

					arg_719_1.var_[var_722_0 .. "Animator"] = var_722_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_719_1.var_[var_722_0 .. "Animator"].applyRootMotion = true
					arg_719_1.var_[var_722_0 .. "LipSync"] = var_722_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_722_5 = arg_719_1.actors_["1028ui_story"].transform
			local var_722_6 = 0

			if var_722_6 < arg_719_1.time_ and arg_719_1.time_ <= var_722_6 + arg_722_0 then
				arg_719_1.var_.moveOldPos1028ui_story = var_722_5.localPosition
			end

			local var_722_7 = 0.001

			if var_722_6 <= arg_719_1.time_ and arg_719_1.time_ < var_722_6 + var_722_7 then
				local var_722_8 = (arg_719_1.time_ - var_722_6) / var_722_7
				local var_722_9 = Vector3.New(0, -0.9, -5.9)

				var_722_5.localPosition = Vector3.Lerp(arg_719_1.var_.moveOldPos1028ui_story, var_722_9, var_722_8)

				local var_722_10 = manager.ui.mainCamera.transform.position - var_722_5.position

				var_722_5.forward = Vector3.New(var_722_10.x, var_722_10.y, var_722_10.z)

				local var_722_11 = var_722_5.localEulerAngles

				var_722_11.z = 0
				var_722_11.x = 0
				var_722_5.localEulerAngles = var_722_11
			end

			if arg_719_1.time_ >= var_722_6 + var_722_7 and arg_719_1.time_ < var_722_6 + var_722_7 + arg_722_0 then
				var_722_5.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_722_12 = manager.ui.mainCamera.transform.position - var_722_5.position

				var_722_5.forward = Vector3.New(var_722_12.x, var_722_12.y, var_722_12.z)

				local var_722_13 = var_722_5.localEulerAngles

				var_722_13.z = 0
				var_722_13.x = 0
				var_722_5.localEulerAngles = var_722_13
			end

			local var_722_14 = arg_719_1.actors_["1028ui_story"]
			local var_722_15 = 0

			if var_722_15 < arg_719_1.time_ and arg_719_1.time_ <= var_722_15 + arg_722_0 and not isNil(var_722_14) and arg_719_1.var_.characterEffect1028ui_story == nil then
				arg_719_1.var_.characterEffect1028ui_story = var_722_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_722_16 = 0.200000002980232

			if var_722_15 <= arg_719_1.time_ and arg_719_1.time_ < var_722_15 + var_722_16 and not isNil(var_722_14) then
				local var_722_17 = (arg_719_1.time_ - var_722_15) / var_722_16

				if arg_719_1.var_.characterEffect1028ui_story and not isNil(var_722_14) then
					arg_719_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_719_1.time_ >= var_722_15 + var_722_16 and arg_719_1.time_ < var_722_15 + var_722_16 + arg_722_0 and not isNil(var_722_14) and arg_719_1.var_.characterEffect1028ui_story then
				arg_719_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_722_18 = 0

			if var_722_18 < arg_719_1.time_ and arg_719_1.time_ <= var_722_18 + arg_722_0 then
				arg_719_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			local var_722_19 = 0

			if var_722_19 < arg_719_1.time_ and arg_719_1.time_ <= var_722_19 + arg_722_0 then
				arg_719_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_722_20 = 0
			local var_722_21 = 0.375

			if var_722_20 < arg_719_1.time_ and arg_719_1.time_ <= var_722_20 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				local var_722_22 = arg_719_1:FormatText(StoryNameCfg[327].name)

				arg_719_1.leftNameTxt_.text = var_722_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_23 = arg_719_1:GetWordFromCfg(930011180)
				local var_722_24 = arg_719_1:FormatText(var_722_23.content)

				arg_719_1.text_.text = var_722_24

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_25 = 15
				local var_722_26 = utf8.len(var_722_24)
				local var_722_27 = var_722_25 <= 0 and var_722_21 or var_722_21 * (var_722_26 / var_722_25)

				if var_722_27 > 0 and var_722_21 < var_722_27 then
					arg_719_1.talkMaxDuration = var_722_27

					if var_722_27 + var_722_20 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_27 + var_722_20
					end
				end

				arg_719_1.text_.text = var_722_24
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_28 = math.max(var_722_21, arg_719_1.talkMaxDuration)

			if var_722_20 <= arg_719_1.time_ and arg_719_1.time_ < var_722_20 + var_722_28 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_20) / var_722_28

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_20 + var_722_28 and arg_719_1.time_ < var_722_20 + var_722_28 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_719_1:InitPlayNodeList()
	end,
	Play930011181 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 930011181
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play930011182(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = "1248ui_story"

			if arg_723_1.actors_[var_726_0] == nil then
				local var_726_1 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_726_1) then
					local var_726_2 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_723_1.stage_.transform)

					var_726_2.name = var_726_0
					var_726_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_723_1.actors_[var_726_0] = var_726_2

					local var_726_3 = var_726_2:GetComponentInChildren(typeof(CharacterEffect))

					var_726_3.enabled = true

					local var_726_4 = GameObjectTools.GetOrAddComponent(var_726_2, typeof(DynamicBoneHelper))

					if var_726_4 then
						var_726_4:EnableDynamicBone(false)
					end

					arg_723_1:ShowWeapon(var_726_3.transform, false)

					arg_723_1.var_[var_726_0 .. "Animator"] = var_726_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_723_1.var_[var_726_0 .. "Animator"].applyRootMotion = true
					arg_723_1.var_[var_726_0 .. "LipSync"] = var_726_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_726_5 = arg_723_1.actors_["1248ui_story"].transform
			local var_726_6 = 0

			if var_726_6 < arg_723_1.time_ and arg_723_1.time_ <= var_726_6 + arg_726_0 then
				arg_723_1.var_.moveOldPos1248ui_story = var_726_5.localPosition
			end

			local var_726_7 = 0.001

			if var_726_6 <= arg_723_1.time_ and arg_723_1.time_ < var_726_6 + var_726_7 then
				local var_726_8 = (arg_723_1.time_ - var_726_6) / var_726_7
				local var_726_9 = Vector3.New(0.7, -0.775, -6.18)

				var_726_5.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1248ui_story, var_726_9, var_726_8)

				local var_726_10 = manager.ui.mainCamera.transform.position - var_726_5.position

				var_726_5.forward = Vector3.New(var_726_10.x, var_726_10.y, var_726_10.z)

				local var_726_11 = var_726_5.localEulerAngles

				var_726_11.z = 0
				var_726_11.x = 0
				var_726_5.localEulerAngles = var_726_11
			end

			if arg_723_1.time_ >= var_726_6 + var_726_7 and arg_723_1.time_ < var_726_6 + var_726_7 + arg_726_0 then
				var_726_5.localPosition = Vector3.New(0.7, -0.775, -6.18)

				local var_726_12 = manager.ui.mainCamera.transform.position - var_726_5.position

				var_726_5.forward = Vector3.New(var_726_12.x, var_726_12.y, var_726_12.z)

				local var_726_13 = var_726_5.localEulerAngles

				var_726_13.z = 0
				var_726_13.x = 0
				var_726_5.localEulerAngles = var_726_13
			end

			local var_726_14 = arg_723_1.actors_["1028ui_story"].transform
			local var_726_15 = 0

			if var_726_15 < arg_723_1.time_ and arg_723_1.time_ <= var_726_15 + arg_726_0 then
				arg_723_1.var_.moveOldPos1028ui_story = var_726_14.localPosition
			end

			local var_726_16 = 0.001

			if var_726_15 <= arg_723_1.time_ and arg_723_1.time_ < var_726_15 + var_726_16 then
				local var_726_17 = (arg_723_1.time_ - var_726_15) / var_726_16
				local var_726_18 = Vector3.New(-0.7, -0.9, -5.9)

				var_726_14.localPosition = Vector3.Lerp(arg_723_1.var_.moveOldPos1028ui_story, var_726_18, var_726_17)

				local var_726_19 = manager.ui.mainCamera.transform.position - var_726_14.position

				var_726_14.forward = Vector3.New(var_726_19.x, var_726_19.y, var_726_19.z)

				local var_726_20 = var_726_14.localEulerAngles

				var_726_20.z = 0
				var_726_20.x = 0
				var_726_14.localEulerAngles = var_726_20
			end

			if arg_723_1.time_ >= var_726_15 + var_726_16 and arg_723_1.time_ < var_726_15 + var_726_16 + arg_726_0 then
				var_726_14.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_726_21 = manager.ui.mainCamera.transform.position - var_726_14.position

				var_726_14.forward = Vector3.New(var_726_21.x, var_726_21.y, var_726_21.z)

				local var_726_22 = var_726_14.localEulerAngles

				var_726_22.z = 0
				var_726_22.x = 0
				var_726_14.localEulerAngles = var_726_22
			end

			local var_726_23 = arg_723_1.actors_["1248ui_story"]
			local var_726_24 = 0

			if var_726_24 < arg_723_1.time_ and arg_723_1.time_ <= var_726_24 + arg_726_0 and not isNil(var_726_23) and arg_723_1.var_.characterEffect1248ui_story == nil then
				arg_723_1.var_.characterEffect1248ui_story = var_726_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_25 = 0.200000002980232

			if var_726_24 <= arg_723_1.time_ and arg_723_1.time_ < var_726_24 + var_726_25 and not isNil(var_726_23) then
				local var_726_26 = (arg_723_1.time_ - var_726_24) / var_726_25

				if arg_723_1.var_.characterEffect1248ui_story and not isNil(var_726_23) then
					arg_723_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_723_1.time_ >= var_726_24 + var_726_25 and arg_723_1.time_ < var_726_24 + var_726_25 + arg_726_0 and not isNil(var_726_23) and arg_723_1.var_.characterEffect1248ui_story then
				arg_723_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_726_27 = arg_723_1.actors_["1028ui_story"]
			local var_726_28 = 0

			if var_726_28 < arg_723_1.time_ and arg_723_1.time_ <= var_726_28 + arg_726_0 and not isNil(var_726_27) and arg_723_1.var_.characterEffect1028ui_story == nil then
				arg_723_1.var_.characterEffect1028ui_story = var_726_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_29 = 0.200000002980232

			if var_726_28 <= arg_723_1.time_ and arg_723_1.time_ < var_726_28 + var_726_29 and not isNil(var_726_27) then
				local var_726_30 = (arg_723_1.time_ - var_726_28) / var_726_29

				if arg_723_1.var_.characterEffect1028ui_story and not isNil(var_726_27) then
					local var_726_31 = Mathf.Lerp(0, 0.5, var_726_30)

					arg_723_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_723_1.var_.characterEffect1028ui_story.fillRatio = var_726_31
				end
			end

			if arg_723_1.time_ >= var_726_28 + var_726_29 and arg_723_1.time_ < var_726_28 + var_726_29 + arg_726_0 and not isNil(var_726_27) and arg_723_1.var_.characterEffect1028ui_story then
				local var_726_32 = 0.5

				arg_723_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_723_1.var_.characterEffect1028ui_story.fillRatio = var_726_32
			end

			local var_726_33 = 0

			if var_726_33 < arg_723_1.time_ and arg_723_1.time_ <= var_726_33 + arg_726_0 then
				arg_723_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_1")
			end

			local var_726_34 = 0

			if var_726_34 < arg_723_1.time_ and arg_723_1.time_ <= var_726_34 + arg_726_0 then
				arg_723_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_726_35 = 0
			local var_726_36 = 0.725

			if var_726_35 < arg_723_1.time_ and arg_723_1.time_ <= var_726_35 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				local var_726_37 = arg_723_1:FormatText(StoryNameCfg[8].name)

				arg_723_1.leftNameTxt_.text = var_726_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_38 = arg_723_1:GetWordFromCfg(930011181)
				local var_726_39 = arg_723_1:FormatText(var_726_38.content)

				arg_723_1.text_.text = var_726_39

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_40 = 29
				local var_726_41 = utf8.len(var_726_39)
				local var_726_42 = var_726_40 <= 0 and var_726_36 or var_726_36 * (var_726_41 / var_726_40)

				if var_726_42 > 0 and var_726_36 < var_726_42 then
					arg_723_1.talkMaxDuration = var_726_42

					if var_726_42 + var_726_35 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_42 + var_726_35
					end
				end

				arg_723_1.text_.text = var_726_39
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_43 = math.max(var_726_36, arg_723_1.talkMaxDuration)

			if var_726_35 <= arg_723_1.time_ and arg_723_1.time_ < var_726_35 + var_726_43 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_35) / var_726_43

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_35 + var_726_43 and arg_723_1.time_ < var_726_35 + var_726_43 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_723_1:InitPlayNodeList()
	end,
	Play930011182 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 930011182
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play930011183(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["1028ui_story"]
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect1028ui_story == nil then
				arg_727_1.var_.characterEffect1028ui_story = var_730_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_2 = 0.200000002980232

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 and not isNil(var_730_0) then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2

				if arg_727_1.var_.characterEffect1028ui_story and not isNil(var_730_0) then
					arg_727_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect1028ui_story then
				arg_727_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_730_4 = arg_727_1.actors_["1248ui_story"]
			local var_730_5 = 0

			if var_730_5 < arg_727_1.time_ and arg_727_1.time_ <= var_730_5 + arg_730_0 and not isNil(var_730_4) and arg_727_1.var_.characterEffect1248ui_story == nil then
				arg_727_1.var_.characterEffect1248ui_story = var_730_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_6 = 0.200000002980232

			if var_730_5 <= arg_727_1.time_ and arg_727_1.time_ < var_730_5 + var_730_6 and not isNil(var_730_4) then
				local var_730_7 = (arg_727_1.time_ - var_730_5) / var_730_6

				if arg_727_1.var_.characterEffect1248ui_story and not isNil(var_730_4) then
					local var_730_8 = Mathf.Lerp(0, 0.5, var_730_7)

					arg_727_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_727_1.var_.characterEffect1248ui_story.fillRatio = var_730_8
				end
			end

			if arg_727_1.time_ >= var_730_5 + var_730_6 and arg_727_1.time_ < var_730_5 + var_730_6 + arg_730_0 and not isNil(var_730_4) and arg_727_1.var_.characterEffect1248ui_story then
				local var_730_9 = 0.5

				arg_727_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_727_1.var_.characterEffect1248ui_story.fillRatio = var_730_9
			end

			local var_730_10 = 0

			if var_730_10 < arg_727_1.time_ and arg_727_1.time_ <= var_730_10 + arg_730_0 then
				arg_727_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action467")
			end

			local var_730_11 = 0

			if var_730_11 < arg_727_1.time_ and arg_727_1.time_ <= var_730_11 + arg_730_0 then
				arg_727_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_730_12 = 0
			local var_730_13 = 0.675

			if var_730_12 < arg_727_1.time_ and arg_727_1.time_ <= var_730_12 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_14 = arg_727_1:FormatText(StoryNameCfg[327].name)

				arg_727_1.leftNameTxt_.text = var_730_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_15 = arg_727_1:GetWordFromCfg(930011182)
				local var_730_16 = arg_727_1:FormatText(var_730_15.content)

				arg_727_1.text_.text = var_730_16

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_17 = 27
				local var_730_18 = utf8.len(var_730_16)
				local var_730_19 = var_730_17 <= 0 and var_730_13 or var_730_13 * (var_730_18 / var_730_17)

				if var_730_19 > 0 and var_730_13 < var_730_19 then
					arg_727_1.talkMaxDuration = var_730_19

					if var_730_19 + var_730_12 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_19 + var_730_12
					end
				end

				arg_727_1.text_.text = var_730_16
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_20 = math.max(var_730_13, arg_727_1.talkMaxDuration)

			if var_730_12 <= arg_727_1.time_ and arg_727_1.time_ < var_730_12 + var_730_20 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_12) / var_730_20

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_12 + var_730_20 and arg_727_1.time_ < var_730_12 + var_730_20 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play930011183 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 930011183
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play930011184(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = arg_731_1.actors_["1248ui_story"].transform
			local var_734_1 = 0

			if var_734_1 < arg_731_1.time_ and arg_731_1.time_ <= var_734_1 + arg_734_0 then
				arg_731_1.var_.moveOldPos1248ui_story = var_734_0.localPosition
			end

			local var_734_2 = 0.001

			if var_734_1 <= arg_731_1.time_ and arg_731_1.time_ < var_734_1 + var_734_2 then
				local var_734_3 = (arg_731_1.time_ - var_734_1) / var_734_2
				local var_734_4 = Vector3.New(0.7, -0.775, -6.18)

				var_734_0.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos1248ui_story, var_734_4, var_734_3)

				local var_734_5 = manager.ui.mainCamera.transform.position - var_734_0.position

				var_734_0.forward = Vector3.New(var_734_5.x, var_734_5.y, var_734_5.z)

				local var_734_6 = var_734_0.localEulerAngles

				var_734_6.z = 0
				var_734_6.x = 0
				var_734_0.localEulerAngles = var_734_6
			end

			if arg_731_1.time_ >= var_734_1 + var_734_2 and arg_731_1.time_ < var_734_1 + var_734_2 + arg_734_0 then
				var_734_0.localPosition = Vector3.New(0.7, -0.775, -6.18)

				local var_734_7 = manager.ui.mainCamera.transform.position - var_734_0.position

				var_734_0.forward = Vector3.New(var_734_7.x, var_734_7.y, var_734_7.z)

				local var_734_8 = var_734_0.localEulerAngles

				var_734_8.z = 0
				var_734_8.x = 0
				var_734_0.localEulerAngles = var_734_8
			end

			local var_734_9 = arg_731_1.actors_["1248ui_story"]
			local var_734_10 = 0

			if var_734_10 < arg_731_1.time_ and arg_731_1.time_ <= var_734_10 + arg_734_0 and not isNil(var_734_9) and arg_731_1.var_.characterEffect1248ui_story == nil then
				arg_731_1.var_.characterEffect1248ui_story = var_734_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_11 = 0.200000002980232

			if var_734_10 <= arg_731_1.time_ and arg_731_1.time_ < var_734_10 + var_734_11 and not isNil(var_734_9) then
				local var_734_12 = (arg_731_1.time_ - var_734_10) / var_734_11

				if arg_731_1.var_.characterEffect1248ui_story and not isNil(var_734_9) then
					arg_731_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_731_1.time_ >= var_734_10 + var_734_11 and arg_731_1.time_ < var_734_10 + var_734_11 + arg_734_0 and not isNil(var_734_9) and arg_731_1.var_.characterEffect1248ui_story then
				arg_731_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_734_13 = arg_731_1.actors_["1028ui_story"]
			local var_734_14 = 0

			if var_734_14 < arg_731_1.time_ and arg_731_1.time_ <= var_734_14 + arg_734_0 and not isNil(var_734_13) and arg_731_1.var_.characterEffect1028ui_story == nil then
				arg_731_1.var_.characterEffect1028ui_story = var_734_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_15 = 0.200000002980232

			if var_734_14 <= arg_731_1.time_ and arg_731_1.time_ < var_734_14 + var_734_15 and not isNil(var_734_13) then
				local var_734_16 = (arg_731_1.time_ - var_734_14) / var_734_15

				if arg_731_1.var_.characterEffect1028ui_story and not isNil(var_734_13) then
					local var_734_17 = Mathf.Lerp(0, 0.5, var_734_16)

					arg_731_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_731_1.var_.characterEffect1028ui_story.fillRatio = var_734_17
				end
			end

			if arg_731_1.time_ >= var_734_14 + var_734_15 and arg_731_1.time_ < var_734_14 + var_734_15 + arg_734_0 and not isNil(var_734_13) and arg_731_1.var_.characterEffect1028ui_story then
				local var_734_18 = 0.5

				arg_731_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_731_1.var_.characterEffect1028ui_story.fillRatio = var_734_18
			end

			local var_734_19 = 0

			if var_734_19 < arg_731_1.time_ and arg_731_1.time_ <= var_734_19 + arg_734_0 then
				arg_731_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248actionlink/1248action472")
			end

			local var_734_20 = 0

			if var_734_20 < arg_731_1.time_ and arg_731_1.time_ <= var_734_20 + arg_734_0 then
				arg_731_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_734_21 = 0
			local var_734_22 = 0.15

			if var_734_21 < arg_731_1.time_ and arg_731_1.time_ <= var_734_21 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_23 = arg_731_1:FormatText(StoryNameCfg[8].name)

				arg_731_1.leftNameTxt_.text = var_734_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_24 = arg_731_1:GetWordFromCfg(930011183)
				local var_734_25 = arg_731_1:FormatText(var_734_24.content)

				arg_731_1.text_.text = var_734_25

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_26 = 6
				local var_734_27 = utf8.len(var_734_25)
				local var_734_28 = var_734_26 <= 0 and var_734_22 or var_734_22 * (var_734_27 / var_734_26)

				if var_734_28 > 0 and var_734_22 < var_734_28 then
					arg_731_1.talkMaxDuration = var_734_28

					if var_734_28 + var_734_21 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_28 + var_734_21
					end
				end

				arg_731_1.text_.text = var_734_25
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_29 = math.max(var_734_22, arg_731_1.talkMaxDuration)

			if var_734_21 <= arg_731_1.time_ and arg_731_1.time_ < var_734_21 + var_734_29 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_21) / var_734_29

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_21 + var_734_29 and arg_731_1.time_ < var_734_21 + var_734_29 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	Play930011184 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 930011184
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play930011185(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = arg_735_1.actors_["1248ui_story"].transform
			local var_738_1 = 0

			if var_738_1 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 then
				arg_735_1.var_.moveOldPos1248ui_story = var_738_0.localPosition
			end

			local var_738_2 = 0.001

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_2 then
				local var_738_3 = (arg_735_1.time_ - var_738_1) / var_738_2
				local var_738_4 = Vector3.New(0, 100, 0)

				var_738_0.localPosition = Vector3.Lerp(arg_735_1.var_.moveOldPos1248ui_story, var_738_4, var_738_3)

				local var_738_5 = manager.ui.mainCamera.transform.position - var_738_0.position

				var_738_0.forward = Vector3.New(var_738_5.x, var_738_5.y, var_738_5.z)

				local var_738_6 = var_738_0.localEulerAngles

				var_738_6.z = 0
				var_738_6.x = 0
				var_738_0.localEulerAngles = var_738_6
			end

			if arg_735_1.time_ >= var_738_1 + var_738_2 and arg_735_1.time_ < var_738_1 + var_738_2 + arg_738_0 then
				var_738_0.localPosition = Vector3.New(0, 100, 0)

				local var_738_7 = manager.ui.mainCamera.transform.position - var_738_0.position

				var_738_0.forward = Vector3.New(var_738_7.x, var_738_7.y, var_738_7.z)

				local var_738_8 = var_738_0.localEulerAngles

				var_738_8.z = 0
				var_738_8.x = 0
				var_738_0.localEulerAngles = var_738_8
			end

			local var_738_9 = arg_735_1.actors_["1028ui_story"].transform
			local var_738_10 = 0

			if var_738_10 < arg_735_1.time_ and arg_735_1.time_ <= var_738_10 + arg_738_0 then
				arg_735_1.var_.moveOldPos1028ui_story = var_738_9.localPosition
			end

			local var_738_11 = 0.001

			if var_738_10 <= arg_735_1.time_ and arg_735_1.time_ < var_738_10 + var_738_11 then
				local var_738_12 = (arg_735_1.time_ - var_738_10) / var_738_11
				local var_738_13 = Vector3.New(0, 100, 0)

				var_738_9.localPosition = Vector3.Lerp(arg_735_1.var_.moveOldPos1028ui_story, var_738_13, var_738_12)

				local var_738_14 = manager.ui.mainCamera.transform.position - var_738_9.position

				var_738_9.forward = Vector3.New(var_738_14.x, var_738_14.y, var_738_14.z)

				local var_738_15 = var_738_9.localEulerAngles

				var_738_15.z = 0
				var_738_15.x = 0
				var_738_9.localEulerAngles = var_738_15
			end

			if arg_735_1.time_ >= var_738_10 + var_738_11 and arg_735_1.time_ < var_738_10 + var_738_11 + arg_738_0 then
				var_738_9.localPosition = Vector3.New(0, 100, 0)

				local var_738_16 = manager.ui.mainCamera.transform.position - var_738_9.position

				var_738_9.forward = Vector3.New(var_738_16.x, var_738_16.y, var_738_16.z)

				local var_738_17 = var_738_9.localEulerAngles

				var_738_17.z = 0
				var_738_17.x = 0
				var_738_9.localEulerAngles = var_738_17
			end

			local var_738_18 = arg_735_1.actors_["1248ui_story"]
			local var_738_19 = 0

			if var_738_19 < arg_735_1.time_ and arg_735_1.time_ <= var_738_19 + arg_738_0 and not isNil(var_738_18) and arg_735_1.var_.characterEffect1248ui_story == nil then
				arg_735_1.var_.characterEffect1248ui_story = var_738_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_20 = 0.200000002980232

			if var_738_19 <= arg_735_1.time_ and arg_735_1.time_ < var_738_19 + var_738_20 and not isNil(var_738_18) then
				local var_738_21 = (arg_735_1.time_ - var_738_19) / var_738_20

				if arg_735_1.var_.characterEffect1248ui_story and not isNil(var_738_18) then
					local var_738_22 = Mathf.Lerp(0, 0.5, var_738_21)

					arg_735_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_735_1.var_.characterEffect1248ui_story.fillRatio = var_738_22
				end
			end

			if arg_735_1.time_ >= var_738_19 + var_738_20 and arg_735_1.time_ < var_738_19 + var_738_20 + arg_738_0 and not isNil(var_738_18) and arg_735_1.var_.characterEffect1248ui_story then
				local var_738_23 = 0.5

				arg_735_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_735_1.var_.characterEffect1248ui_story.fillRatio = var_738_23
			end

			local var_738_24 = 0
			local var_738_25 = 0.625

			if var_738_24 < arg_735_1.time_ and arg_735_1.time_ <= var_738_24 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, false)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_26 = arg_735_1:GetWordFromCfg(930011184)
				local var_738_27 = arg_735_1:FormatText(var_738_26.content)

				arg_735_1.text_.text = var_738_27

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_28 = 25
				local var_738_29 = utf8.len(var_738_27)
				local var_738_30 = var_738_28 <= 0 and var_738_25 or var_738_25 * (var_738_29 / var_738_28)

				if var_738_30 > 0 and var_738_25 < var_738_30 then
					arg_735_1.talkMaxDuration = var_738_30

					if var_738_30 + var_738_24 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_30 + var_738_24
					end
				end

				arg_735_1.text_.text = var_738_27
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_31 = math.max(var_738_25, arg_735_1.talkMaxDuration)

			if var_738_24 <= arg_735_1.time_ and arg_735_1.time_ < var_738_24 + var_738_31 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_24) / var_738_31

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_24 + var_738_31 and arg_735_1.time_ < var_738_24 + var_738_31 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_735_1:InitPlayNodeList()
	end,
	Play930011185 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 930011185
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play930011186(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = arg_739_1.actors_["1028ui_story"].transform
			local var_742_1 = 0

			if var_742_1 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 then
				arg_739_1.var_.moveOldPos1028ui_story = var_742_0.localPosition
			end

			local var_742_2 = 0.001

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_2 then
				local var_742_3 = (arg_739_1.time_ - var_742_1) / var_742_2
				local var_742_4 = Vector3.New(-0.7, -0.9, -5.9)

				var_742_0.localPosition = Vector3.Lerp(arg_739_1.var_.moveOldPos1028ui_story, var_742_4, var_742_3)

				local var_742_5 = manager.ui.mainCamera.transform.position - var_742_0.position

				var_742_0.forward = Vector3.New(var_742_5.x, var_742_5.y, var_742_5.z)

				local var_742_6 = var_742_0.localEulerAngles

				var_742_6.z = 0
				var_742_6.x = 0
				var_742_0.localEulerAngles = var_742_6
			end

			if arg_739_1.time_ >= var_742_1 + var_742_2 and arg_739_1.time_ < var_742_1 + var_742_2 + arg_742_0 then
				var_742_0.localPosition = Vector3.New(-0.7, -0.9, -5.9)

				local var_742_7 = manager.ui.mainCamera.transform.position - var_742_0.position

				var_742_0.forward = Vector3.New(var_742_7.x, var_742_7.y, var_742_7.z)

				local var_742_8 = var_742_0.localEulerAngles

				var_742_8.z = 0
				var_742_8.x = 0
				var_742_0.localEulerAngles = var_742_8
			end

			local var_742_9 = arg_739_1.actors_["1028ui_story"]
			local var_742_10 = 0

			if var_742_10 < arg_739_1.time_ and arg_739_1.time_ <= var_742_10 + arg_742_0 and not isNil(var_742_9) and arg_739_1.var_.characterEffect1028ui_story == nil then
				arg_739_1.var_.characterEffect1028ui_story = var_742_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_11 = 0.200000002980232

			if var_742_10 <= arg_739_1.time_ and arg_739_1.time_ < var_742_10 + var_742_11 and not isNil(var_742_9) then
				local var_742_12 = (arg_739_1.time_ - var_742_10) / var_742_11

				if arg_739_1.var_.characterEffect1028ui_story and not isNil(var_742_9) then
					arg_739_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_739_1.time_ >= var_742_10 + var_742_11 and arg_739_1.time_ < var_742_10 + var_742_11 + arg_742_0 and not isNil(var_742_9) and arg_739_1.var_.characterEffect1028ui_story then
				arg_739_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_742_13 = 0

			if var_742_13 < arg_739_1.time_ and arg_739_1.time_ <= var_742_13 + arg_742_0 then
				arg_739_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_742_14 = 0

			if var_742_14 < arg_739_1.time_ and arg_739_1.time_ <= var_742_14 + arg_742_0 then
				arg_739_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_742_15 = 0
			local var_742_16 = 0.5

			if var_742_15 < arg_739_1.time_ and arg_739_1.time_ <= var_742_15 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_17 = arg_739_1:FormatText(StoryNameCfg[327].name)

				arg_739_1.leftNameTxt_.text = var_742_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_18 = arg_739_1:GetWordFromCfg(930011185)
				local var_742_19 = arg_739_1:FormatText(var_742_18.content)

				arg_739_1.text_.text = var_742_19

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_20 = 20
				local var_742_21 = utf8.len(var_742_19)
				local var_742_22 = var_742_20 <= 0 and var_742_16 or var_742_16 * (var_742_21 / var_742_20)

				if var_742_22 > 0 and var_742_16 < var_742_22 then
					arg_739_1.talkMaxDuration = var_742_22

					if var_742_22 + var_742_15 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_22 + var_742_15
					end
				end

				arg_739_1.text_.text = var_742_19
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_23 = math.max(var_742_16, arg_739_1.talkMaxDuration)

			if var_742_15 <= arg_739_1.time_ and arg_739_1.time_ < var_742_15 + var_742_23 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_15) / var_742_23

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_15 + var_742_23 and arg_739_1.time_ < var_742_15 + var_742_23 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_739_1:InitPlayNodeList()
	end,
	Play930011186 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 930011186
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play930011187(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = arg_743_1.actors_["1044ui_story"].transform
			local var_746_1 = 0

			if var_746_1 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 then
				arg_743_1.var_.moveOldPos1044ui_story = var_746_0.localPosition
			end

			local var_746_2 = 0.001

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_2 then
				local var_746_3 = (arg_743_1.time_ - var_746_1) / var_746_2
				local var_746_4 = Vector3.New(0.7, -1, -5.93)

				var_746_0.localPosition = Vector3.Lerp(arg_743_1.var_.moveOldPos1044ui_story, var_746_4, var_746_3)

				local var_746_5 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_5.x, var_746_5.y, var_746_5.z)

				local var_746_6 = var_746_0.localEulerAngles

				var_746_6.z = 0
				var_746_6.x = 0
				var_746_0.localEulerAngles = var_746_6
			end

			if arg_743_1.time_ >= var_746_1 + var_746_2 and arg_743_1.time_ < var_746_1 + var_746_2 + arg_746_0 then
				var_746_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_746_7 = manager.ui.mainCamera.transform.position - var_746_0.position

				var_746_0.forward = Vector3.New(var_746_7.x, var_746_7.y, var_746_7.z)

				local var_746_8 = var_746_0.localEulerAngles

				var_746_8.z = 0
				var_746_8.x = 0
				var_746_0.localEulerAngles = var_746_8
			end

			local var_746_9 = arg_743_1.actors_["1044ui_story"]
			local var_746_10 = 0

			if var_746_10 < arg_743_1.time_ and arg_743_1.time_ <= var_746_10 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect1044ui_story == nil then
				arg_743_1.var_.characterEffect1044ui_story = var_746_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_11 = 0.200000002980232

			if var_746_10 <= arg_743_1.time_ and arg_743_1.time_ < var_746_10 + var_746_11 and not isNil(var_746_9) then
				local var_746_12 = (arg_743_1.time_ - var_746_10) / var_746_11

				if arg_743_1.var_.characterEffect1044ui_story and not isNil(var_746_9) then
					arg_743_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_743_1.time_ >= var_746_10 + var_746_11 and arg_743_1.time_ < var_746_10 + var_746_11 + arg_746_0 and not isNil(var_746_9) and arg_743_1.var_.characterEffect1044ui_story then
				arg_743_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_746_13 = arg_743_1.actors_["1028ui_story"]
			local var_746_14 = 0

			if var_746_14 < arg_743_1.time_ and arg_743_1.time_ <= var_746_14 + arg_746_0 and not isNil(var_746_13) and arg_743_1.var_.characterEffect1028ui_story == nil then
				arg_743_1.var_.characterEffect1028ui_story = var_746_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_15 = 0.200000002980232

			if var_746_14 <= arg_743_1.time_ and arg_743_1.time_ < var_746_14 + var_746_15 and not isNil(var_746_13) then
				local var_746_16 = (arg_743_1.time_ - var_746_14) / var_746_15

				if arg_743_1.var_.characterEffect1028ui_story and not isNil(var_746_13) then
					local var_746_17 = Mathf.Lerp(0, 0.5, var_746_16)

					arg_743_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_743_1.var_.characterEffect1028ui_story.fillRatio = var_746_17
				end
			end

			if arg_743_1.time_ >= var_746_14 + var_746_15 and arg_743_1.time_ < var_746_14 + var_746_15 + arg_746_0 and not isNil(var_746_13) and arg_743_1.var_.characterEffect1028ui_story then
				local var_746_18 = 0.5

				arg_743_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_743_1.var_.characterEffect1028ui_story.fillRatio = var_746_18
			end

			local var_746_19 = 0

			if var_746_19 < arg_743_1.time_ and arg_743_1.time_ <= var_746_19 + arg_746_0 then
				arg_743_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_746_20 = 0

			if var_746_20 < arg_743_1.time_ and arg_743_1.time_ <= var_746_20 + arg_746_0 then
				arg_743_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_746_21 = 0
			local var_746_22 = 0.8

			if var_746_21 < arg_743_1.time_ and arg_743_1.time_ <= var_746_21 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_23 = arg_743_1:FormatText(StoryNameCfg[1367].name)

				arg_743_1.leftNameTxt_.text = var_746_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_24 = arg_743_1:GetWordFromCfg(930011186)
				local var_746_25 = arg_743_1:FormatText(var_746_24.content)

				arg_743_1.text_.text = var_746_25

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_26 = 32
				local var_746_27 = utf8.len(var_746_25)
				local var_746_28 = var_746_26 <= 0 and var_746_22 or var_746_22 * (var_746_27 / var_746_26)

				if var_746_28 > 0 and var_746_22 < var_746_28 then
					arg_743_1.talkMaxDuration = var_746_28

					if var_746_28 + var_746_21 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_28 + var_746_21
					end
				end

				arg_743_1.text_.text = var_746_25
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_29 = math.max(var_746_22, arg_743_1.talkMaxDuration)

			if var_746_21 <= arg_743_1.time_ and arg_743_1.time_ < var_746_21 + var_746_29 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_21) / var_746_29

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_21 + var_746_29 and arg_743_1.time_ < var_746_21 + var_746_29 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_743_1:InitPlayNodeList()
	end,
	Play930011187 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 930011187
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play930011188(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = arg_747_1.actors_["1028ui_story"]
			local var_750_1 = 0

			if var_750_1 < arg_747_1.time_ and arg_747_1.time_ <= var_750_1 + arg_750_0 and not isNil(var_750_0) and arg_747_1.var_.characterEffect1028ui_story == nil then
				arg_747_1.var_.characterEffect1028ui_story = var_750_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_2 = 0.200000002980232

			if var_750_1 <= arg_747_1.time_ and arg_747_1.time_ < var_750_1 + var_750_2 and not isNil(var_750_0) then
				local var_750_3 = (arg_747_1.time_ - var_750_1) / var_750_2

				if arg_747_1.var_.characterEffect1028ui_story and not isNil(var_750_0) then
					arg_747_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_747_1.time_ >= var_750_1 + var_750_2 and arg_747_1.time_ < var_750_1 + var_750_2 + arg_750_0 and not isNil(var_750_0) and arg_747_1.var_.characterEffect1028ui_story then
				arg_747_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_750_4 = arg_747_1.actors_["1044ui_story"]
			local var_750_5 = 0

			if var_750_5 < arg_747_1.time_ and arg_747_1.time_ <= var_750_5 + arg_750_0 and not isNil(var_750_4) and arg_747_1.var_.characterEffect1044ui_story == nil then
				arg_747_1.var_.characterEffect1044ui_story = var_750_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_6 = 0.200000002980232

			if var_750_5 <= arg_747_1.time_ and arg_747_1.time_ < var_750_5 + var_750_6 and not isNil(var_750_4) then
				local var_750_7 = (arg_747_1.time_ - var_750_5) / var_750_6

				if arg_747_1.var_.characterEffect1044ui_story and not isNil(var_750_4) then
					local var_750_8 = Mathf.Lerp(0, 0.5, var_750_7)

					arg_747_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_747_1.var_.characterEffect1044ui_story.fillRatio = var_750_8
				end
			end

			if arg_747_1.time_ >= var_750_5 + var_750_6 and arg_747_1.time_ < var_750_5 + var_750_6 + arg_750_0 and not isNil(var_750_4) and arg_747_1.var_.characterEffect1044ui_story then
				local var_750_9 = 0.5

				arg_747_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_747_1.var_.characterEffect1044ui_story.fillRatio = var_750_9
			end

			local var_750_10 = 0

			if var_750_10 < arg_747_1.time_ and arg_747_1.time_ <= var_750_10 + arg_750_0 then
				arg_747_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			local var_750_11 = 0

			if var_750_11 < arg_747_1.time_ and arg_747_1.time_ <= var_750_11 + arg_750_0 then
				arg_747_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_750_12 = 0
			local var_750_13 = 0.825

			if var_750_12 < arg_747_1.time_ and arg_747_1.time_ <= var_750_12 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_14 = arg_747_1:FormatText(StoryNameCfg[327].name)

				arg_747_1.leftNameTxt_.text = var_750_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, false)
				arg_747_1.callingController_:SetSelectedState("normal")

				local var_750_15 = arg_747_1:GetWordFromCfg(930011187)
				local var_750_16 = arg_747_1:FormatText(var_750_15.content)

				arg_747_1.text_.text = var_750_16

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_17 = 33
				local var_750_18 = utf8.len(var_750_16)
				local var_750_19 = var_750_17 <= 0 and var_750_13 or var_750_13 * (var_750_18 / var_750_17)

				if var_750_19 > 0 and var_750_13 < var_750_19 then
					arg_747_1.talkMaxDuration = var_750_19

					if var_750_19 + var_750_12 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_19 + var_750_12
					end
				end

				arg_747_1.text_.text = var_750_16
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_20 = math.max(var_750_13, arg_747_1.talkMaxDuration)

			if var_750_12 <= arg_747_1.time_ and arg_747_1.time_ < var_750_12 + var_750_20 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_12) / var_750_20

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_12 + var_750_20 and arg_747_1.time_ < var_750_12 + var_750_20 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play930011188 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 930011188
		arg_751_1.duration_ = 5

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play930011189(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = arg_751_1.actors_["1044ui_story"].transform
			local var_754_1 = 0

			if var_754_1 < arg_751_1.time_ and arg_751_1.time_ <= var_754_1 + arg_754_0 then
				arg_751_1.var_.moveOldPos1044ui_story = var_754_0.localPosition
			end

			local var_754_2 = 0.001

			if var_754_1 <= arg_751_1.time_ and arg_751_1.time_ < var_754_1 + var_754_2 then
				local var_754_3 = (arg_751_1.time_ - var_754_1) / var_754_2
				local var_754_4 = Vector3.New(0.7, -1, -5.93)

				var_754_0.localPosition = Vector3.Lerp(arg_751_1.var_.moveOldPos1044ui_story, var_754_4, var_754_3)

				local var_754_5 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_5.x, var_754_5.y, var_754_5.z)

				local var_754_6 = var_754_0.localEulerAngles

				var_754_6.z = 0
				var_754_6.x = 0
				var_754_0.localEulerAngles = var_754_6
			end

			if arg_751_1.time_ >= var_754_1 + var_754_2 and arg_751_1.time_ < var_754_1 + var_754_2 + arg_754_0 then
				var_754_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_754_7 = manager.ui.mainCamera.transform.position - var_754_0.position

				var_754_0.forward = Vector3.New(var_754_7.x, var_754_7.y, var_754_7.z)

				local var_754_8 = var_754_0.localEulerAngles

				var_754_8.z = 0
				var_754_8.x = 0
				var_754_0.localEulerAngles = var_754_8
			end

			local var_754_9 = arg_751_1.actors_["1044ui_story"]
			local var_754_10 = 0

			if var_754_10 < arg_751_1.time_ and arg_751_1.time_ <= var_754_10 + arg_754_0 and not isNil(var_754_9) and arg_751_1.var_.characterEffect1044ui_story == nil then
				arg_751_1.var_.characterEffect1044ui_story = var_754_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_11 = 0.200000002980232

			if var_754_10 <= arg_751_1.time_ and arg_751_1.time_ < var_754_10 + var_754_11 and not isNil(var_754_9) then
				local var_754_12 = (arg_751_1.time_ - var_754_10) / var_754_11

				if arg_751_1.var_.characterEffect1044ui_story and not isNil(var_754_9) then
					arg_751_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_751_1.time_ >= var_754_10 + var_754_11 and arg_751_1.time_ < var_754_10 + var_754_11 + arg_754_0 and not isNil(var_754_9) and arg_751_1.var_.characterEffect1044ui_story then
				arg_751_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_754_13 = arg_751_1.actors_["1028ui_story"]
			local var_754_14 = 0

			if var_754_14 < arg_751_1.time_ and arg_751_1.time_ <= var_754_14 + arg_754_0 and not isNil(var_754_13) and arg_751_1.var_.characterEffect1028ui_story == nil then
				arg_751_1.var_.characterEffect1028ui_story = var_754_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_15 = 0.200000002980232

			if var_754_14 <= arg_751_1.time_ and arg_751_1.time_ < var_754_14 + var_754_15 and not isNil(var_754_13) then
				local var_754_16 = (arg_751_1.time_ - var_754_14) / var_754_15

				if arg_751_1.var_.characterEffect1028ui_story and not isNil(var_754_13) then
					local var_754_17 = Mathf.Lerp(0, 0.5, var_754_16)

					arg_751_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_751_1.var_.characterEffect1028ui_story.fillRatio = var_754_17
				end
			end

			if arg_751_1.time_ >= var_754_14 + var_754_15 and arg_751_1.time_ < var_754_14 + var_754_15 + arg_754_0 and not isNil(var_754_13) and arg_751_1.var_.characterEffect1028ui_story then
				local var_754_18 = 0.5

				arg_751_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_751_1.var_.characterEffect1028ui_story.fillRatio = var_754_18
			end

			local var_754_19 = 0

			if var_754_19 < arg_751_1.time_ and arg_751_1.time_ <= var_754_19 + arg_754_0 then
				arg_751_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_1")
			end

			local var_754_20 = 0

			if var_754_20 < arg_751_1.time_ and arg_751_1.time_ <= var_754_20 + arg_754_0 then
				arg_751_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_754_21 = 0
			local var_754_22 = 0.675

			if var_754_21 < arg_751_1.time_ and arg_751_1.time_ <= var_754_21 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				local var_754_23 = arg_751_1:FormatText(StoryNameCfg[1367].name)

				arg_751_1.leftNameTxt_.text = var_754_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_24 = arg_751_1:GetWordFromCfg(930011188)
				local var_754_25 = arg_751_1:FormatText(var_754_24.content)

				arg_751_1.text_.text = var_754_25

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_26 = 27
				local var_754_27 = utf8.len(var_754_25)
				local var_754_28 = var_754_26 <= 0 and var_754_22 or var_754_22 * (var_754_27 / var_754_26)

				if var_754_28 > 0 and var_754_22 < var_754_28 then
					arg_751_1.talkMaxDuration = var_754_28

					if var_754_28 + var_754_21 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_28 + var_754_21
					end
				end

				arg_751_1.text_.text = var_754_25
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)
				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_29 = math.max(var_754_22, arg_751_1.talkMaxDuration)

			if var_754_21 <= arg_751_1.time_ and arg_751_1.time_ < var_754_21 + var_754_29 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_21) / var_754_29

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_21 + var_754_29 and arg_751_1.time_ < var_754_21 + var_754_29 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_751_1:InitPlayNodeList()
	end,
	Play930011189 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 930011189
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play930011190(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = arg_755_1.actors_["1044ui_story"].transform
			local var_758_1 = 0

			if var_758_1 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1.var_.moveOldPos1044ui_story = var_758_0.localPosition
			end

			local var_758_2 = 0.001

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_2 then
				local var_758_3 = (arg_755_1.time_ - var_758_1) / var_758_2
				local var_758_4 = Vector3.New(0, 100, 0)

				var_758_0.localPosition = Vector3.Lerp(arg_755_1.var_.moveOldPos1044ui_story, var_758_4, var_758_3)

				local var_758_5 = manager.ui.mainCamera.transform.position - var_758_0.position

				var_758_0.forward = Vector3.New(var_758_5.x, var_758_5.y, var_758_5.z)

				local var_758_6 = var_758_0.localEulerAngles

				var_758_6.z = 0
				var_758_6.x = 0
				var_758_0.localEulerAngles = var_758_6
			end

			if arg_755_1.time_ >= var_758_1 + var_758_2 and arg_755_1.time_ < var_758_1 + var_758_2 + arg_758_0 then
				var_758_0.localPosition = Vector3.New(0, 100, 0)

				local var_758_7 = manager.ui.mainCamera.transform.position - var_758_0.position

				var_758_0.forward = Vector3.New(var_758_7.x, var_758_7.y, var_758_7.z)

				local var_758_8 = var_758_0.localEulerAngles

				var_758_8.z = 0
				var_758_8.x = 0
				var_758_0.localEulerAngles = var_758_8
			end

			local var_758_9 = arg_755_1.actors_["1028ui_story"].transform
			local var_758_10 = 0

			if var_758_10 < arg_755_1.time_ and arg_755_1.time_ <= var_758_10 + arg_758_0 then
				arg_755_1.var_.moveOldPos1028ui_story = var_758_9.localPosition
			end

			local var_758_11 = 0.001

			if var_758_10 <= arg_755_1.time_ and arg_755_1.time_ < var_758_10 + var_758_11 then
				local var_758_12 = (arg_755_1.time_ - var_758_10) / var_758_11
				local var_758_13 = Vector3.New(0, 100, 0)

				var_758_9.localPosition = Vector3.Lerp(arg_755_1.var_.moveOldPos1028ui_story, var_758_13, var_758_12)

				local var_758_14 = manager.ui.mainCamera.transform.position - var_758_9.position

				var_758_9.forward = Vector3.New(var_758_14.x, var_758_14.y, var_758_14.z)

				local var_758_15 = var_758_9.localEulerAngles

				var_758_15.z = 0
				var_758_15.x = 0
				var_758_9.localEulerAngles = var_758_15
			end

			if arg_755_1.time_ >= var_758_10 + var_758_11 and arg_755_1.time_ < var_758_10 + var_758_11 + arg_758_0 then
				var_758_9.localPosition = Vector3.New(0, 100, 0)

				local var_758_16 = manager.ui.mainCamera.transform.position - var_758_9.position

				var_758_9.forward = Vector3.New(var_758_16.x, var_758_16.y, var_758_16.z)

				local var_758_17 = var_758_9.localEulerAngles

				var_758_17.z = 0
				var_758_17.x = 0
				var_758_9.localEulerAngles = var_758_17
			end

			local var_758_18 = arg_755_1.actors_["1044ui_story"]
			local var_758_19 = 0

			if var_758_19 < arg_755_1.time_ and arg_755_1.time_ <= var_758_19 + arg_758_0 and not isNil(var_758_18) and arg_755_1.var_.characterEffect1044ui_story == nil then
				arg_755_1.var_.characterEffect1044ui_story = var_758_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_20 = 0.200000002980232

			if var_758_19 <= arg_755_1.time_ and arg_755_1.time_ < var_758_19 + var_758_20 and not isNil(var_758_18) then
				local var_758_21 = (arg_755_1.time_ - var_758_19) / var_758_20

				if arg_755_1.var_.characterEffect1044ui_story and not isNil(var_758_18) then
					local var_758_22 = Mathf.Lerp(0, 0.5, var_758_21)

					arg_755_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_755_1.var_.characterEffect1044ui_story.fillRatio = var_758_22
				end
			end

			if arg_755_1.time_ >= var_758_19 + var_758_20 and arg_755_1.time_ < var_758_19 + var_758_20 + arg_758_0 and not isNil(var_758_18) and arg_755_1.var_.characterEffect1044ui_story then
				local var_758_23 = 0.5

				arg_755_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_755_1.var_.characterEffect1044ui_story.fillRatio = var_758_23
			end

			local var_758_24 = 0
			local var_758_25 = 1.35

			if var_758_24 < arg_755_1.time_ and arg_755_1.time_ <= var_758_24 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, false)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_755_1.iconTrs_.gameObject, false)
				arg_755_1.callingController_:SetSelectedState("normal")

				local var_758_26 = arg_755_1:GetWordFromCfg(930011189)
				local var_758_27 = arg_755_1:FormatText(var_758_26.content)

				arg_755_1.text_.text = var_758_27

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_28 = 54
				local var_758_29 = utf8.len(var_758_27)
				local var_758_30 = var_758_28 <= 0 and var_758_25 or var_758_25 * (var_758_29 / var_758_28)

				if var_758_30 > 0 and var_758_25 < var_758_30 then
					arg_755_1.talkMaxDuration = var_758_30

					if var_758_30 + var_758_24 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_30 + var_758_24
					end
				end

				arg_755_1.text_.text = var_758_27
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_31 = math.max(var_758_25, arg_755_1.talkMaxDuration)

			if var_758_24 <= arg_755_1.time_ and arg_755_1.time_ < var_758_24 + var_758_31 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_24) / var_758_31

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_24 + var_758_31 and arg_755_1.time_ < var_758_24 + var_758_31 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_755_1:InitPlayNodeList()
	end,
	Play930011190 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 930011190
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play930011191(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = arg_759_1.actors_["1028ui_story"].transform
			local var_762_1 = 0

			if var_762_1 < arg_759_1.time_ and arg_759_1.time_ <= var_762_1 + arg_762_0 then
				arg_759_1.var_.moveOldPos1028ui_story = var_762_0.localPosition
			end

			local var_762_2 = 0.001

			if var_762_1 <= arg_759_1.time_ and arg_759_1.time_ < var_762_1 + var_762_2 then
				local var_762_3 = (arg_759_1.time_ - var_762_1) / var_762_2
				local var_762_4 = Vector3.New(0, -0.9, -5.9)

				var_762_0.localPosition = Vector3.Lerp(arg_759_1.var_.moveOldPos1028ui_story, var_762_4, var_762_3)

				local var_762_5 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_5.x, var_762_5.y, var_762_5.z)

				local var_762_6 = var_762_0.localEulerAngles

				var_762_6.z = 0
				var_762_6.x = 0
				var_762_0.localEulerAngles = var_762_6
			end

			if arg_759_1.time_ >= var_762_1 + var_762_2 and arg_759_1.time_ < var_762_1 + var_762_2 + arg_762_0 then
				var_762_0.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_762_7 = manager.ui.mainCamera.transform.position - var_762_0.position

				var_762_0.forward = Vector3.New(var_762_7.x, var_762_7.y, var_762_7.z)

				local var_762_8 = var_762_0.localEulerAngles

				var_762_8.z = 0
				var_762_8.x = 0
				var_762_0.localEulerAngles = var_762_8
			end

			local var_762_9 = arg_759_1.actors_["1028ui_story"]
			local var_762_10 = 0

			if var_762_10 < arg_759_1.time_ and arg_759_1.time_ <= var_762_10 + arg_762_0 and not isNil(var_762_9) and arg_759_1.var_.characterEffect1028ui_story == nil then
				arg_759_1.var_.characterEffect1028ui_story = var_762_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_762_11 = 0.200000002980232

			if var_762_10 <= arg_759_1.time_ and arg_759_1.time_ < var_762_10 + var_762_11 and not isNil(var_762_9) then
				local var_762_12 = (arg_759_1.time_ - var_762_10) / var_762_11

				if arg_759_1.var_.characterEffect1028ui_story and not isNil(var_762_9) then
					arg_759_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_759_1.time_ >= var_762_10 + var_762_11 and arg_759_1.time_ < var_762_10 + var_762_11 + arg_762_0 and not isNil(var_762_9) and arg_759_1.var_.characterEffect1028ui_story then
				arg_759_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_762_13 = 0

			if var_762_13 < arg_759_1.time_ and arg_759_1.time_ <= var_762_13 + arg_762_0 then
				arg_759_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_2")
			end

			local var_762_14 = 0

			if var_762_14 < arg_759_1.time_ and arg_759_1.time_ <= var_762_14 + arg_762_0 then
				arg_759_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_762_15 = 0
			local var_762_16 = 0.625

			if var_762_15 < arg_759_1.time_ and arg_759_1.time_ <= var_762_15 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				local var_762_17 = arg_759_1:FormatText(StoryNameCfg[327].name)

				arg_759_1.leftNameTxt_.text = var_762_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, false)
				arg_759_1.callingController_:SetSelectedState("normal")

				local var_762_18 = arg_759_1:GetWordFromCfg(930011190)
				local var_762_19 = arg_759_1:FormatText(var_762_18.content)

				arg_759_1.text_.text = var_762_19

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_20 = 25
				local var_762_21 = utf8.len(var_762_19)
				local var_762_22 = var_762_20 <= 0 and var_762_16 or var_762_16 * (var_762_21 / var_762_20)

				if var_762_22 > 0 and var_762_16 < var_762_22 then
					arg_759_1.talkMaxDuration = var_762_22

					if var_762_22 + var_762_15 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_22 + var_762_15
					end
				end

				arg_759_1.text_.text = var_762_19
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_23 = math.max(var_762_16, arg_759_1.talkMaxDuration)

			if var_762_15 <= arg_759_1.time_ and arg_759_1.time_ < var_762_15 + var_762_23 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_15) / var_762_23

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_15 + var_762_23 and arg_759_1.time_ < var_762_15 + var_762_23 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_759_1:InitPlayNodeList()
	end,
	Play930011191 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 930011191
		arg_763_1.duration_ = 5

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play930011192(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = arg_763_1.actors_["1028ui_story"]
			local var_766_1 = 0

			if var_766_1 < arg_763_1.time_ and arg_763_1.time_ <= var_766_1 + arg_766_0 and not isNil(var_766_0) and arg_763_1.var_.characterEffect1028ui_story == nil then
				arg_763_1.var_.characterEffect1028ui_story = var_766_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_766_2 = 0.200000002980232

			if var_766_1 <= arg_763_1.time_ and arg_763_1.time_ < var_766_1 + var_766_2 and not isNil(var_766_0) then
				local var_766_3 = (arg_763_1.time_ - var_766_1) / var_766_2

				if arg_763_1.var_.characterEffect1028ui_story and not isNil(var_766_0) then
					local var_766_4 = Mathf.Lerp(0, 0.5, var_766_3)

					arg_763_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_763_1.var_.characterEffect1028ui_story.fillRatio = var_766_4
				end
			end

			if arg_763_1.time_ >= var_766_1 + var_766_2 and arg_763_1.time_ < var_766_1 + var_766_2 + arg_766_0 and not isNil(var_766_0) and arg_763_1.var_.characterEffect1028ui_story then
				local var_766_5 = 0.5

				arg_763_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_763_1.var_.characterEffect1028ui_story.fillRatio = var_766_5
			end

			local var_766_6 = 0
			local var_766_7 = 0.825

			if var_766_6 < arg_763_1.time_ and arg_763_1.time_ <= var_766_6 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				local var_766_8 = arg_763_1:FormatText(StoryNameCfg[7].name)

				arg_763_1.leftNameTxt_.text = var_766_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, true)
				arg_763_1.iconController_:SetSelectedState("hero")

				arg_763_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_763_1.callingController_:SetSelectedState("normal")

				arg_763_1.keyicon_.color = Color.New(1, 1, 1)
				arg_763_1.icon_.color = Color.New(1, 1, 1)

				local var_766_9 = arg_763_1:GetWordFromCfg(930011191)
				local var_766_10 = arg_763_1:FormatText(var_766_9.content)

				arg_763_1.text_.text = var_766_10

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_11 = 33
				local var_766_12 = utf8.len(var_766_10)
				local var_766_13 = var_766_11 <= 0 and var_766_7 or var_766_7 * (var_766_12 / var_766_11)

				if var_766_13 > 0 and var_766_7 < var_766_13 then
					arg_763_1.talkMaxDuration = var_766_13

					if var_766_13 + var_766_6 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_13 + var_766_6
					end
				end

				arg_763_1.text_.text = var_766_10
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)
				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_14 = math.max(var_766_7, arg_763_1.talkMaxDuration)

			if var_766_6 <= arg_763_1.time_ and arg_763_1.time_ < var_766_6 + var_766_14 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_6) / var_766_14

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_6 + var_766_14 and arg_763_1.time_ < var_766_6 + var_766_14 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play930011192 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 930011192
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play930011193(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = arg_767_1.actors_["1028ui_story"].transform
			local var_770_1 = 0

			if var_770_1 < arg_767_1.time_ and arg_767_1.time_ <= var_770_1 + arg_770_0 then
				arg_767_1.var_.moveOldPos1028ui_story = var_770_0.localPosition
			end

			local var_770_2 = 0.001

			if var_770_1 <= arg_767_1.time_ and arg_767_1.time_ < var_770_1 + var_770_2 then
				local var_770_3 = (arg_767_1.time_ - var_770_1) / var_770_2
				local var_770_4 = Vector3.New(0, 100, 0)

				var_770_0.localPosition = Vector3.Lerp(arg_767_1.var_.moveOldPos1028ui_story, var_770_4, var_770_3)

				local var_770_5 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_5.x, var_770_5.y, var_770_5.z)

				local var_770_6 = var_770_0.localEulerAngles

				var_770_6.z = 0
				var_770_6.x = 0
				var_770_0.localEulerAngles = var_770_6
			end

			if arg_767_1.time_ >= var_770_1 + var_770_2 and arg_767_1.time_ < var_770_1 + var_770_2 + arg_770_0 then
				var_770_0.localPosition = Vector3.New(0, 100, 0)

				local var_770_7 = manager.ui.mainCamera.transform.position - var_770_0.position

				var_770_0.forward = Vector3.New(var_770_7.x, var_770_7.y, var_770_7.z)

				local var_770_8 = var_770_0.localEulerAngles

				var_770_8.z = 0
				var_770_8.x = 0
				var_770_0.localEulerAngles = var_770_8
			end

			local var_770_9 = 0
			local var_770_10 = 0.625

			if var_770_9 < arg_767_1.time_ and arg_767_1.time_ <= var_770_9 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, false)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_767_1.iconTrs_.gameObject, false)
				arg_767_1.callingController_:SetSelectedState("normal")

				local var_770_11 = arg_767_1:GetWordFromCfg(930011192)
				local var_770_12 = arg_767_1:FormatText(var_770_11.content)

				arg_767_1.text_.text = var_770_12

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_13 = 25
				local var_770_14 = utf8.len(var_770_12)
				local var_770_15 = var_770_13 <= 0 and var_770_10 or var_770_10 * (var_770_14 / var_770_13)

				if var_770_15 > 0 and var_770_10 < var_770_15 then
					arg_767_1.talkMaxDuration = var_770_15

					if var_770_15 + var_770_9 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_15 + var_770_9
					end
				end

				arg_767_1.text_.text = var_770_12
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_16 = math.max(var_770_10, arg_767_1.talkMaxDuration)

			if var_770_9 <= arg_767_1.time_ and arg_767_1.time_ < var_770_9 + var_770_16 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_9) / var_770_16

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_9 + var_770_16 and arg_767_1.time_ < var_770_9 + var_770_16 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_767_1:InitPlayNodeList()
	end,
	Play930011193 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 930011193
		arg_771_1.duration_ = 5

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play930011194(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0
			local var_774_1 = 1.15

			if var_774_0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_0 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0
				arg_771_1.dialogCg_.alpha = 1

				arg_771_1.dialog_:SetActive(true)
				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_2 = arg_771_1:GetWordFromCfg(930011193)
				local var_774_3 = arg_771_1:FormatText(var_774_2.content)

				arg_771_1.text_.text = var_774_3

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_4 = 46
				local var_774_5 = utf8.len(var_774_3)
				local var_774_6 = var_774_4 <= 0 and var_774_1 or var_774_1 * (var_774_5 / var_774_4)

				if var_774_6 > 0 and var_774_1 < var_774_6 then
					arg_771_1.talkMaxDuration = var_774_6

					if var_774_6 + var_774_0 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_6 + var_774_0
					end
				end

				arg_771_1.text_.text = var_774_3
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_7 = math.max(var_774_1, arg_771_1.talkMaxDuration)

			if var_774_0 <= arg_771_1.time_ and arg_771_1.time_ < var_774_0 + var_774_7 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_0) / var_774_7

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_0 + var_774_7 and arg_771_1.time_ < var_774_0 + var_774_7 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play930011194 = function(arg_775_0, arg_775_1)
		arg_775_1.time_ = 0
		arg_775_1.frameCnt_ = 0
		arg_775_1.state_ = "playing"
		arg_775_1.curTalkId_ = 930011194
		arg_775_1.duration_ = 5

		SetActive(arg_775_1.tipsGo_, false)

		function arg_775_1.onSingleLineFinish_()
			arg_775_1.onSingleLineUpdate_ = nil
			arg_775_1.onSingleLineFinish_ = nil
			arg_775_1.state_ = "waiting"
		end

		function arg_775_1.playNext_(arg_777_0)
			if arg_777_0 == 1 then
				arg_775_0:Play930011195(arg_775_1)
			end
		end

		function arg_775_1.onSingleLineUpdate_(arg_778_0)
			local var_778_0 = arg_775_1.actors_["1248ui_story"].transform
			local var_778_1 = 0

			if var_778_1 < arg_775_1.time_ and arg_775_1.time_ <= var_778_1 + arg_778_0 then
				arg_775_1.var_.moveOldPos1248ui_story = var_778_0.localPosition
			end

			local var_778_2 = 0.001

			if var_778_1 <= arg_775_1.time_ and arg_775_1.time_ < var_778_1 + var_778_2 then
				local var_778_3 = (arg_775_1.time_ - var_778_1) / var_778_2
				local var_778_4 = Vector3.New(-0.7, -0.775, -6.18)

				var_778_0.localPosition = Vector3.Lerp(arg_775_1.var_.moveOldPos1248ui_story, var_778_4, var_778_3)

				local var_778_5 = manager.ui.mainCamera.transform.position - var_778_0.position

				var_778_0.forward = Vector3.New(var_778_5.x, var_778_5.y, var_778_5.z)

				local var_778_6 = var_778_0.localEulerAngles

				var_778_6.z = 0
				var_778_6.x = 0
				var_778_0.localEulerAngles = var_778_6
			end

			if arg_775_1.time_ >= var_778_1 + var_778_2 and arg_775_1.time_ < var_778_1 + var_778_2 + arg_778_0 then
				var_778_0.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_778_7 = manager.ui.mainCamera.transform.position - var_778_0.position

				var_778_0.forward = Vector3.New(var_778_7.x, var_778_7.y, var_778_7.z)

				local var_778_8 = var_778_0.localEulerAngles

				var_778_8.z = 0
				var_778_8.x = 0
				var_778_0.localEulerAngles = var_778_8
			end

			local var_778_9 = arg_775_1.actors_["1248ui_story"]
			local var_778_10 = 0

			if var_778_10 < arg_775_1.time_ and arg_775_1.time_ <= var_778_10 + arg_778_0 and not isNil(var_778_9) and arg_775_1.var_.characterEffect1248ui_story == nil then
				arg_775_1.var_.characterEffect1248ui_story = var_778_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_778_11 = 0.200000002980232

			if var_778_10 <= arg_775_1.time_ and arg_775_1.time_ < var_778_10 + var_778_11 and not isNil(var_778_9) then
				local var_778_12 = (arg_775_1.time_ - var_778_10) / var_778_11

				if arg_775_1.var_.characterEffect1248ui_story and not isNil(var_778_9) then
					arg_775_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_775_1.time_ >= var_778_10 + var_778_11 and arg_775_1.time_ < var_778_10 + var_778_11 + arg_778_0 and not isNil(var_778_9) and arg_775_1.var_.characterEffect1248ui_story then
				arg_775_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_778_13 = 0

			if var_778_13 < arg_775_1.time_ and arg_775_1.time_ <= var_778_13 + arg_778_0 then
				arg_775_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_1")
			end

			local var_778_14 = 0

			if var_778_14 < arg_775_1.time_ and arg_775_1.time_ <= var_778_14 + arg_778_0 then
				arg_775_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_778_15 = 0
			local var_778_16 = 0.45

			if var_778_15 < arg_775_1.time_ and arg_775_1.time_ <= var_778_15 + arg_778_0 then
				arg_775_1.talkMaxDuration = 0
				arg_775_1.dialogCg_.alpha = 1

				arg_775_1.dialog_:SetActive(true)
				SetActive(arg_775_1.leftNameGo_, true)

				local var_778_17 = arg_775_1:FormatText(StoryNameCfg[8].name)

				arg_775_1.leftNameTxt_.text = var_778_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_775_1.leftNameTxt_.transform)

				arg_775_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_775_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_775_1:RecordName(arg_775_1.leftNameTxt_.text)
				SetActive(arg_775_1.iconTrs_.gameObject, false)
				arg_775_1.callingController_:SetSelectedState("normal")

				local var_778_18 = arg_775_1:GetWordFromCfg(930011194)
				local var_778_19 = arg_775_1:FormatText(var_778_18.content)

				arg_775_1.text_.text = var_778_19

				LuaForUtil.ClearLinePrefixSymbol(arg_775_1.text_)

				local var_778_20 = 20
				local var_778_21 = utf8.len(var_778_19)
				local var_778_22 = var_778_20 <= 0 and var_778_16 or var_778_16 * (var_778_21 / var_778_20)

				if var_778_22 > 0 and var_778_16 < var_778_22 then
					arg_775_1.talkMaxDuration = var_778_22

					if var_778_22 + var_778_15 > arg_775_1.duration_ then
						arg_775_1.duration_ = var_778_22 + var_778_15
					end
				end

				arg_775_1.text_.text = var_778_19
				arg_775_1.typewritter.percent = 0

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(false)
				arg_775_1:RecordContent(arg_775_1.text_.text)
			end

			local var_778_23 = math.max(var_778_16, arg_775_1.talkMaxDuration)

			if var_778_15 <= arg_775_1.time_ and arg_775_1.time_ < var_778_15 + var_778_23 then
				arg_775_1.typewritter.percent = (arg_775_1.time_ - var_778_15) / var_778_23

				arg_775_1.typewritter:SetDirty()
			end

			if arg_775_1.time_ >= var_778_15 + var_778_23 and arg_775_1.time_ < var_778_15 + var_778_23 + arg_778_0 then
				arg_775_1.typewritter.percent = 1

				arg_775_1.typewritter:SetDirty()
				arg_775_1:ShowNextGo(true)
			end
		end

		arg_775_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_775_1:InitPlayNodeList()
	end,
	Play930011195 = function(arg_779_0, arg_779_1)
		arg_779_1.time_ = 0
		arg_779_1.frameCnt_ = 0
		arg_779_1.state_ = "playing"
		arg_779_1.curTalkId_ = 930011195
		arg_779_1.duration_ = 5

		SetActive(arg_779_1.tipsGo_, false)

		function arg_779_1.onSingleLineFinish_()
			arg_779_1.onSingleLineUpdate_ = nil
			arg_779_1.onSingleLineFinish_ = nil
			arg_779_1.state_ = "waiting"
		end

		function arg_779_1.playNext_(arg_781_0)
			if arg_781_0 == 1 then
				arg_779_0:Play930011196(arg_779_1)
			end
		end

		function arg_779_1.onSingleLineUpdate_(arg_782_0)
			local var_782_0 = arg_779_1.actors_["1028ui_story"].transform
			local var_782_1 = 0

			if var_782_1 < arg_779_1.time_ and arg_779_1.time_ <= var_782_1 + arg_782_0 then
				arg_779_1.var_.moveOldPos1028ui_story = var_782_0.localPosition
			end

			local var_782_2 = 0.001

			if var_782_1 <= arg_779_1.time_ and arg_779_1.time_ < var_782_1 + var_782_2 then
				local var_782_3 = (arg_779_1.time_ - var_782_1) / var_782_2
				local var_782_4 = Vector3.New(0.7, -0.9, -5.9)

				var_782_0.localPosition = Vector3.Lerp(arg_779_1.var_.moveOldPos1028ui_story, var_782_4, var_782_3)

				local var_782_5 = manager.ui.mainCamera.transform.position - var_782_0.position

				var_782_0.forward = Vector3.New(var_782_5.x, var_782_5.y, var_782_5.z)

				local var_782_6 = var_782_0.localEulerAngles

				var_782_6.z = 0
				var_782_6.x = 0
				var_782_0.localEulerAngles = var_782_6
			end

			if arg_779_1.time_ >= var_782_1 + var_782_2 and arg_779_1.time_ < var_782_1 + var_782_2 + arg_782_0 then
				var_782_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_782_7 = manager.ui.mainCamera.transform.position - var_782_0.position

				var_782_0.forward = Vector3.New(var_782_7.x, var_782_7.y, var_782_7.z)

				local var_782_8 = var_782_0.localEulerAngles

				var_782_8.z = 0
				var_782_8.x = 0
				var_782_0.localEulerAngles = var_782_8
			end

			local var_782_9 = arg_779_1.actors_["1028ui_story"]
			local var_782_10 = 0

			if var_782_10 < arg_779_1.time_ and arg_779_1.time_ <= var_782_10 + arg_782_0 and not isNil(var_782_9) and arg_779_1.var_.characterEffect1028ui_story == nil then
				arg_779_1.var_.characterEffect1028ui_story = var_782_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_782_11 = 0.200000002980232

			if var_782_10 <= arg_779_1.time_ and arg_779_1.time_ < var_782_10 + var_782_11 and not isNil(var_782_9) then
				local var_782_12 = (arg_779_1.time_ - var_782_10) / var_782_11

				if arg_779_1.var_.characterEffect1028ui_story and not isNil(var_782_9) then
					arg_779_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_779_1.time_ >= var_782_10 + var_782_11 and arg_779_1.time_ < var_782_10 + var_782_11 + arg_782_0 and not isNil(var_782_9) and arg_779_1.var_.characterEffect1028ui_story then
				arg_779_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_782_13 = arg_779_1.actors_["1248ui_story"]
			local var_782_14 = 0

			if var_782_14 < arg_779_1.time_ and arg_779_1.time_ <= var_782_14 + arg_782_0 and not isNil(var_782_13) and arg_779_1.var_.characterEffect1248ui_story == nil then
				arg_779_1.var_.characterEffect1248ui_story = var_782_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_782_15 = 0.200000002980232

			if var_782_14 <= arg_779_1.time_ and arg_779_1.time_ < var_782_14 + var_782_15 and not isNil(var_782_13) then
				local var_782_16 = (arg_779_1.time_ - var_782_14) / var_782_15

				if arg_779_1.var_.characterEffect1248ui_story and not isNil(var_782_13) then
					local var_782_17 = Mathf.Lerp(0, 0.5, var_782_16)

					arg_779_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_779_1.var_.characterEffect1248ui_story.fillRatio = var_782_17
				end
			end

			if arg_779_1.time_ >= var_782_14 + var_782_15 and arg_779_1.time_ < var_782_14 + var_782_15 + arg_782_0 and not isNil(var_782_13) and arg_779_1.var_.characterEffect1248ui_story then
				local var_782_18 = 0.5

				arg_779_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_779_1.var_.characterEffect1248ui_story.fillRatio = var_782_18
			end

			local var_782_19 = 0

			if var_782_19 < arg_779_1.time_ and arg_779_1.time_ <= var_782_19 + arg_782_0 then
				arg_779_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_782_20 = 0

			if var_782_20 < arg_779_1.time_ and arg_779_1.time_ <= var_782_20 + arg_782_0 then
				arg_779_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_782_21 = 0
			local var_782_22 = 0.6

			if var_782_21 < arg_779_1.time_ and arg_779_1.time_ <= var_782_21 + arg_782_0 then
				arg_779_1.talkMaxDuration = 0
				arg_779_1.dialogCg_.alpha = 1

				arg_779_1.dialog_:SetActive(true)
				SetActive(arg_779_1.leftNameGo_, true)

				local var_782_23 = arg_779_1:FormatText(StoryNameCfg[327].name)

				arg_779_1.leftNameTxt_.text = var_782_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_779_1.leftNameTxt_.transform)

				arg_779_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_779_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_779_1:RecordName(arg_779_1.leftNameTxt_.text)
				SetActive(arg_779_1.iconTrs_.gameObject, false)
				arg_779_1.callingController_:SetSelectedState("normal")

				local var_782_24 = arg_779_1:GetWordFromCfg(930011195)
				local var_782_25 = arg_779_1:FormatText(var_782_24.content)

				arg_779_1.text_.text = var_782_25

				LuaForUtil.ClearLinePrefixSymbol(arg_779_1.text_)

				local var_782_26 = 26
				local var_782_27 = utf8.len(var_782_25)
				local var_782_28 = var_782_26 <= 0 and var_782_22 or var_782_22 * (var_782_27 / var_782_26)

				if var_782_28 > 0 and var_782_22 < var_782_28 then
					arg_779_1.talkMaxDuration = var_782_28

					if var_782_28 + var_782_21 > arg_779_1.duration_ then
						arg_779_1.duration_ = var_782_28 + var_782_21
					end
				end

				arg_779_1.text_.text = var_782_25
				arg_779_1.typewritter.percent = 0

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(false)
				arg_779_1:RecordContent(arg_779_1.text_.text)
			end

			local var_782_29 = math.max(var_782_22, arg_779_1.talkMaxDuration)

			if var_782_21 <= arg_779_1.time_ and arg_779_1.time_ < var_782_21 + var_782_29 then
				arg_779_1.typewritter.percent = (arg_779_1.time_ - var_782_21) / var_782_29

				arg_779_1.typewritter:SetDirty()
			end

			if arg_779_1.time_ >= var_782_21 + var_782_29 and arg_779_1.time_ < var_782_21 + var_782_29 + arg_782_0 then
				arg_779_1.typewritter.percent = 1

				arg_779_1.typewritter:SetDirty()
				arg_779_1:ShowNextGo(true)
			end
		end

		arg_779_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_779_1:InitPlayNodeList()
	end,
	Play930011196 = function(arg_783_0, arg_783_1)
		arg_783_1.time_ = 0
		arg_783_1.frameCnt_ = 0
		arg_783_1.state_ = "playing"
		arg_783_1.curTalkId_ = 930011196
		arg_783_1.duration_ = 5

		SetActive(arg_783_1.tipsGo_, false)

		function arg_783_1.onSingleLineFinish_()
			arg_783_1.onSingleLineUpdate_ = nil
			arg_783_1.onSingleLineFinish_ = nil
			arg_783_1.state_ = "waiting"
		end

		function arg_783_1.playNext_(arg_785_0)
			if arg_785_0 == 1 then
				arg_783_0:Play930011197(arg_783_1)
			end
		end

		function arg_783_1.onSingleLineUpdate_(arg_786_0)
			local var_786_0 = arg_783_1.actors_["1044ui_story"].transform
			local var_786_1 = 0

			if var_786_1 < arg_783_1.time_ and arg_783_1.time_ <= var_786_1 + arg_786_0 then
				arg_783_1.var_.moveOldPos1044ui_story = var_786_0.localPosition
			end

			local var_786_2 = 0.001

			if var_786_1 <= arg_783_1.time_ and arg_783_1.time_ < var_786_1 + var_786_2 then
				local var_786_3 = (arg_783_1.time_ - var_786_1) / var_786_2
				local var_786_4 = Vector3.New(-0.7, -1, -5.93)

				var_786_0.localPosition = Vector3.Lerp(arg_783_1.var_.moveOldPos1044ui_story, var_786_4, var_786_3)

				local var_786_5 = manager.ui.mainCamera.transform.position - var_786_0.position

				var_786_0.forward = Vector3.New(var_786_5.x, var_786_5.y, var_786_5.z)

				local var_786_6 = var_786_0.localEulerAngles

				var_786_6.z = 0
				var_786_6.x = 0
				var_786_0.localEulerAngles = var_786_6
			end

			if arg_783_1.time_ >= var_786_1 + var_786_2 and arg_783_1.time_ < var_786_1 + var_786_2 + arg_786_0 then
				var_786_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_786_7 = manager.ui.mainCamera.transform.position - var_786_0.position

				var_786_0.forward = Vector3.New(var_786_7.x, var_786_7.y, var_786_7.z)

				local var_786_8 = var_786_0.localEulerAngles

				var_786_8.z = 0
				var_786_8.x = 0
				var_786_0.localEulerAngles = var_786_8
			end

			local var_786_9 = arg_783_1.actors_["1248ui_story"].transform
			local var_786_10 = 0

			if var_786_10 < arg_783_1.time_ and arg_783_1.time_ <= var_786_10 + arg_786_0 then
				arg_783_1.var_.moveOldPos1248ui_story = var_786_9.localPosition
			end

			local var_786_11 = 0.001

			if var_786_10 <= arg_783_1.time_ and arg_783_1.time_ < var_786_10 + var_786_11 then
				local var_786_12 = (arg_783_1.time_ - var_786_10) / var_786_11
				local var_786_13 = Vector3.New(0, 100, 0)

				var_786_9.localPosition = Vector3.Lerp(arg_783_1.var_.moveOldPos1248ui_story, var_786_13, var_786_12)

				local var_786_14 = manager.ui.mainCamera.transform.position - var_786_9.position

				var_786_9.forward = Vector3.New(var_786_14.x, var_786_14.y, var_786_14.z)

				local var_786_15 = var_786_9.localEulerAngles

				var_786_15.z = 0
				var_786_15.x = 0
				var_786_9.localEulerAngles = var_786_15
			end

			if arg_783_1.time_ >= var_786_10 + var_786_11 and arg_783_1.time_ < var_786_10 + var_786_11 + arg_786_0 then
				var_786_9.localPosition = Vector3.New(0, 100, 0)

				local var_786_16 = manager.ui.mainCamera.transform.position - var_786_9.position

				var_786_9.forward = Vector3.New(var_786_16.x, var_786_16.y, var_786_16.z)

				local var_786_17 = var_786_9.localEulerAngles

				var_786_17.z = 0
				var_786_17.x = 0
				var_786_9.localEulerAngles = var_786_17
			end

			local var_786_18 = arg_783_1.actors_["1044ui_story"]
			local var_786_19 = 0

			if var_786_19 < arg_783_1.time_ and arg_783_1.time_ <= var_786_19 + arg_786_0 and not isNil(var_786_18) and arg_783_1.var_.characterEffect1044ui_story == nil then
				arg_783_1.var_.characterEffect1044ui_story = var_786_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_20 = 0.200000002980232

			if var_786_19 <= arg_783_1.time_ and arg_783_1.time_ < var_786_19 + var_786_20 and not isNil(var_786_18) then
				local var_786_21 = (arg_783_1.time_ - var_786_19) / var_786_20

				if arg_783_1.var_.characterEffect1044ui_story and not isNil(var_786_18) then
					arg_783_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_783_1.time_ >= var_786_19 + var_786_20 and arg_783_1.time_ < var_786_19 + var_786_20 + arg_786_0 and not isNil(var_786_18) and arg_783_1.var_.characterEffect1044ui_story then
				arg_783_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_786_22 = arg_783_1.actors_["1028ui_story"]
			local var_786_23 = 0

			if var_786_23 < arg_783_1.time_ and arg_783_1.time_ <= var_786_23 + arg_786_0 and not isNil(var_786_22) and arg_783_1.var_.characterEffect1028ui_story == nil then
				arg_783_1.var_.characterEffect1028ui_story = var_786_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_786_24 = 0.200000002980232

			if var_786_23 <= arg_783_1.time_ and arg_783_1.time_ < var_786_23 + var_786_24 and not isNil(var_786_22) then
				local var_786_25 = (arg_783_1.time_ - var_786_23) / var_786_24

				if arg_783_1.var_.characterEffect1028ui_story and not isNil(var_786_22) then
					local var_786_26 = Mathf.Lerp(0, 0.5, var_786_25)

					arg_783_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_783_1.var_.characterEffect1028ui_story.fillRatio = var_786_26
				end
			end

			if arg_783_1.time_ >= var_786_23 + var_786_24 and arg_783_1.time_ < var_786_23 + var_786_24 + arg_786_0 and not isNil(var_786_22) and arg_783_1.var_.characterEffect1028ui_story then
				local var_786_27 = 0.5

				arg_783_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_783_1.var_.characterEffect1028ui_story.fillRatio = var_786_27
			end

			local var_786_28 = 0

			if var_786_28 < arg_783_1.time_ and arg_783_1.time_ <= var_786_28 + arg_786_0 then
				arg_783_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_786_29 = 0

			if var_786_29 < arg_783_1.time_ and arg_783_1.time_ <= var_786_29 + arg_786_0 then
				arg_783_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_786_30 = 0
			local var_786_31 = 0.55

			if var_786_30 < arg_783_1.time_ and arg_783_1.time_ <= var_786_30 + arg_786_0 then
				arg_783_1.talkMaxDuration = 0
				arg_783_1.dialogCg_.alpha = 1

				arg_783_1.dialog_:SetActive(true)
				SetActive(arg_783_1.leftNameGo_, true)

				local var_786_32 = arg_783_1:FormatText(StoryNameCfg[1367].name)

				arg_783_1.leftNameTxt_.text = var_786_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_783_1.leftNameTxt_.transform)

				arg_783_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_783_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_783_1:RecordName(arg_783_1.leftNameTxt_.text)
				SetActive(arg_783_1.iconTrs_.gameObject, false)
				arg_783_1.callingController_:SetSelectedState("normal")

				local var_786_33 = arg_783_1:GetWordFromCfg(930011196)
				local var_786_34 = arg_783_1:FormatText(var_786_33.content)

				arg_783_1.text_.text = var_786_34

				LuaForUtil.ClearLinePrefixSymbol(arg_783_1.text_)

				local var_786_35 = 22
				local var_786_36 = utf8.len(var_786_34)
				local var_786_37 = var_786_35 <= 0 and var_786_31 or var_786_31 * (var_786_36 / var_786_35)

				if var_786_37 > 0 and var_786_31 < var_786_37 then
					arg_783_1.talkMaxDuration = var_786_37

					if var_786_37 + var_786_30 > arg_783_1.duration_ then
						arg_783_1.duration_ = var_786_37 + var_786_30
					end
				end

				arg_783_1.text_.text = var_786_34
				arg_783_1.typewritter.percent = 0

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(false)
				arg_783_1:RecordContent(arg_783_1.text_.text)
			end

			local var_786_38 = math.max(var_786_31, arg_783_1.talkMaxDuration)

			if var_786_30 <= arg_783_1.time_ and arg_783_1.time_ < var_786_30 + var_786_38 then
				arg_783_1.typewritter.percent = (arg_783_1.time_ - var_786_30) / var_786_38

				arg_783_1.typewritter:SetDirty()
			end

			if arg_783_1.time_ >= var_786_30 + var_786_38 and arg_783_1.time_ < var_786_30 + var_786_38 + arg_786_0 then
				arg_783_1.typewritter.percent = 1

				arg_783_1.typewritter:SetDirty()
				arg_783_1:ShowNextGo(true)
			end
		end

		arg_783_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_783_1:InitPlayNodeList()
	end,
	Play930011197 = function(arg_787_0, arg_787_1)
		arg_787_1.time_ = 0
		arg_787_1.frameCnt_ = 0
		arg_787_1.state_ = "playing"
		arg_787_1.curTalkId_ = 930011197
		arg_787_1.duration_ = 5

		SetActive(arg_787_1.tipsGo_, false)

		function arg_787_1.onSingleLineFinish_()
			arg_787_1.onSingleLineUpdate_ = nil
			arg_787_1.onSingleLineFinish_ = nil
			arg_787_1.state_ = "waiting"
		end

		function arg_787_1.playNext_(arg_789_0)
			if arg_789_0 == 1 then
				arg_787_0:Play930011198(arg_787_1)
			end
		end

		function arg_787_1.onSingleLineUpdate_(arg_790_0)
			local var_790_0 = arg_787_1.actors_["1028ui_story"].transform
			local var_790_1 = 0

			if var_790_1 < arg_787_1.time_ and arg_787_1.time_ <= var_790_1 + arg_790_0 then
				arg_787_1.var_.moveOldPos1028ui_story = var_790_0.localPosition
			end

			local var_790_2 = 0.001

			if var_790_1 <= arg_787_1.time_ and arg_787_1.time_ < var_790_1 + var_790_2 then
				local var_790_3 = (arg_787_1.time_ - var_790_1) / var_790_2
				local var_790_4 = Vector3.New(0.7, -0.9, -5.9)

				var_790_0.localPosition = Vector3.Lerp(arg_787_1.var_.moveOldPos1028ui_story, var_790_4, var_790_3)

				local var_790_5 = manager.ui.mainCamera.transform.position - var_790_0.position

				var_790_0.forward = Vector3.New(var_790_5.x, var_790_5.y, var_790_5.z)

				local var_790_6 = var_790_0.localEulerAngles

				var_790_6.z = 0
				var_790_6.x = 0
				var_790_0.localEulerAngles = var_790_6
			end

			if arg_787_1.time_ >= var_790_1 + var_790_2 and arg_787_1.time_ < var_790_1 + var_790_2 + arg_790_0 then
				var_790_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_790_7 = manager.ui.mainCamera.transform.position - var_790_0.position

				var_790_0.forward = Vector3.New(var_790_7.x, var_790_7.y, var_790_7.z)

				local var_790_8 = var_790_0.localEulerAngles

				var_790_8.z = 0
				var_790_8.x = 0
				var_790_0.localEulerAngles = var_790_8
			end

			local var_790_9 = arg_787_1.actors_["1028ui_story"]
			local var_790_10 = 0

			if var_790_10 < arg_787_1.time_ and arg_787_1.time_ <= var_790_10 + arg_790_0 and not isNil(var_790_9) and arg_787_1.var_.characterEffect1028ui_story == nil then
				arg_787_1.var_.characterEffect1028ui_story = var_790_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_790_11 = 0.200000002980232

			if var_790_10 <= arg_787_1.time_ and arg_787_1.time_ < var_790_10 + var_790_11 and not isNil(var_790_9) then
				local var_790_12 = (arg_787_1.time_ - var_790_10) / var_790_11

				if arg_787_1.var_.characterEffect1028ui_story and not isNil(var_790_9) then
					arg_787_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_787_1.time_ >= var_790_10 + var_790_11 and arg_787_1.time_ < var_790_10 + var_790_11 + arg_790_0 and not isNil(var_790_9) and arg_787_1.var_.characterEffect1028ui_story then
				arg_787_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_790_13 = arg_787_1.actors_["1044ui_story"]
			local var_790_14 = 0

			if var_790_14 < arg_787_1.time_ and arg_787_1.time_ <= var_790_14 + arg_790_0 and not isNil(var_790_13) and arg_787_1.var_.characterEffect1044ui_story == nil then
				arg_787_1.var_.characterEffect1044ui_story = var_790_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_790_15 = 0.200000002980232

			if var_790_14 <= arg_787_1.time_ and arg_787_1.time_ < var_790_14 + var_790_15 and not isNil(var_790_13) then
				local var_790_16 = (arg_787_1.time_ - var_790_14) / var_790_15

				if arg_787_1.var_.characterEffect1044ui_story and not isNil(var_790_13) then
					local var_790_17 = Mathf.Lerp(0, 0.5, var_790_16)

					arg_787_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_787_1.var_.characterEffect1044ui_story.fillRatio = var_790_17
				end
			end

			if arg_787_1.time_ >= var_790_14 + var_790_15 and arg_787_1.time_ < var_790_14 + var_790_15 + arg_790_0 and not isNil(var_790_13) and arg_787_1.var_.characterEffect1044ui_story then
				local var_790_18 = 0.5

				arg_787_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_787_1.var_.characterEffect1044ui_story.fillRatio = var_790_18
			end

			local var_790_19 = 0

			if var_790_19 < arg_787_1.time_ and arg_787_1.time_ <= var_790_19 + arg_790_0 then
				arg_787_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			local var_790_20 = 0

			if var_790_20 < arg_787_1.time_ and arg_787_1.time_ <= var_790_20 + arg_790_0 then
				arg_787_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_790_21 = 0
			local var_790_22 = 0.875

			if var_790_21 < arg_787_1.time_ and arg_787_1.time_ <= var_790_21 + arg_790_0 then
				arg_787_1.talkMaxDuration = 0
				arg_787_1.dialogCg_.alpha = 1

				arg_787_1.dialog_:SetActive(true)
				SetActive(arg_787_1.leftNameGo_, true)

				local var_790_23 = arg_787_1:FormatText(StoryNameCfg[327].name)

				arg_787_1.leftNameTxt_.text = var_790_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_787_1.leftNameTxt_.transform)

				arg_787_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_787_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_787_1:RecordName(arg_787_1.leftNameTxt_.text)
				SetActive(arg_787_1.iconTrs_.gameObject, false)
				arg_787_1.callingController_:SetSelectedState("normal")

				local var_790_24 = arg_787_1:GetWordFromCfg(930011197)
				local var_790_25 = arg_787_1:FormatText(var_790_24.content)

				arg_787_1.text_.text = var_790_25

				LuaForUtil.ClearLinePrefixSymbol(arg_787_1.text_)

				local var_790_26 = 35
				local var_790_27 = utf8.len(var_790_25)
				local var_790_28 = var_790_26 <= 0 and var_790_22 or var_790_22 * (var_790_27 / var_790_26)

				if var_790_28 > 0 and var_790_22 < var_790_28 then
					arg_787_1.talkMaxDuration = var_790_28

					if var_790_28 + var_790_21 > arg_787_1.duration_ then
						arg_787_1.duration_ = var_790_28 + var_790_21
					end
				end

				arg_787_1.text_.text = var_790_25
				arg_787_1.typewritter.percent = 0

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(false)
				arg_787_1:RecordContent(arg_787_1.text_.text)
			end

			local var_790_29 = math.max(var_790_22, arg_787_1.talkMaxDuration)

			if var_790_21 <= arg_787_1.time_ and arg_787_1.time_ < var_790_21 + var_790_29 then
				arg_787_1.typewritter.percent = (arg_787_1.time_ - var_790_21) / var_790_29

				arg_787_1.typewritter:SetDirty()
			end

			if arg_787_1.time_ >= var_790_21 + var_790_29 and arg_787_1.time_ < var_790_21 + var_790_29 + arg_790_0 then
				arg_787_1.typewritter.percent = 1

				arg_787_1.typewritter:SetDirty()
				arg_787_1:ShowNextGo(true)
			end
		end

		arg_787_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_787_1:InitPlayNodeList()
	end,
	Play930011198 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 930011198
		arg_791_1.duration_ = 5

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play930011199(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			local var_794_0 = arg_791_1.actors_["1248ui_story"].transform
			local var_794_1 = 0

			if var_794_1 < arg_791_1.time_ and arg_791_1.time_ <= var_794_1 + arg_794_0 then
				arg_791_1.var_.moveOldPos1248ui_story = var_794_0.localPosition
			end

			local var_794_2 = 0.001

			if var_794_1 <= arg_791_1.time_ and arg_791_1.time_ < var_794_1 + var_794_2 then
				local var_794_3 = (arg_791_1.time_ - var_794_1) / var_794_2
				local var_794_4 = Vector3.New(-0.7, -0.775, -6.18)

				var_794_0.localPosition = Vector3.Lerp(arg_791_1.var_.moveOldPos1248ui_story, var_794_4, var_794_3)

				local var_794_5 = manager.ui.mainCamera.transform.position - var_794_0.position

				var_794_0.forward = Vector3.New(var_794_5.x, var_794_5.y, var_794_5.z)

				local var_794_6 = var_794_0.localEulerAngles

				var_794_6.z = 0
				var_794_6.x = 0
				var_794_0.localEulerAngles = var_794_6
			end

			if arg_791_1.time_ >= var_794_1 + var_794_2 and arg_791_1.time_ < var_794_1 + var_794_2 + arg_794_0 then
				var_794_0.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_794_7 = manager.ui.mainCamera.transform.position - var_794_0.position

				var_794_0.forward = Vector3.New(var_794_7.x, var_794_7.y, var_794_7.z)

				local var_794_8 = var_794_0.localEulerAngles

				var_794_8.z = 0
				var_794_8.x = 0
				var_794_0.localEulerAngles = var_794_8
			end

			local var_794_9 = arg_791_1.actors_["1044ui_story"].transform
			local var_794_10 = 0

			if var_794_10 < arg_791_1.time_ and arg_791_1.time_ <= var_794_10 + arg_794_0 then
				arg_791_1.var_.moveOldPos1044ui_story = var_794_9.localPosition
			end

			local var_794_11 = 0.001

			if var_794_10 <= arg_791_1.time_ and arg_791_1.time_ < var_794_10 + var_794_11 then
				local var_794_12 = (arg_791_1.time_ - var_794_10) / var_794_11
				local var_794_13 = Vector3.New(0, 100, 0)

				var_794_9.localPosition = Vector3.Lerp(arg_791_1.var_.moveOldPos1044ui_story, var_794_13, var_794_12)

				local var_794_14 = manager.ui.mainCamera.transform.position - var_794_9.position

				var_794_9.forward = Vector3.New(var_794_14.x, var_794_14.y, var_794_14.z)

				local var_794_15 = var_794_9.localEulerAngles

				var_794_15.z = 0
				var_794_15.x = 0
				var_794_9.localEulerAngles = var_794_15
			end

			if arg_791_1.time_ >= var_794_10 + var_794_11 and arg_791_1.time_ < var_794_10 + var_794_11 + arg_794_0 then
				var_794_9.localPosition = Vector3.New(0, 100, 0)

				local var_794_16 = manager.ui.mainCamera.transform.position - var_794_9.position

				var_794_9.forward = Vector3.New(var_794_16.x, var_794_16.y, var_794_16.z)

				local var_794_17 = var_794_9.localEulerAngles

				var_794_17.z = 0
				var_794_17.x = 0
				var_794_9.localEulerAngles = var_794_17
			end

			local var_794_18 = arg_791_1.actors_["1248ui_story"]
			local var_794_19 = 0

			if var_794_19 < arg_791_1.time_ and arg_791_1.time_ <= var_794_19 + arg_794_0 and not isNil(var_794_18) and arg_791_1.var_.characterEffect1248ui_story == nil then
				arg_791_1.var_.characterEffect1248ui_story = var_794_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_20 = 0.200000002980232

			if var_794_19 <= arg_791_1.time_ and arg_791_1.time_ < var_794_19 + var_794_20 and not isNil(var_794_18) then
				local var_794_21 = (arg_791_1.time_ - var_794_19) / var_794_20

				if arg_791_1.var_.characterEffect1248ui_story and not isNil(var_794_18) then
					arg_791_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_791_1.time_ >= var_794_19 + var_794_20 and arg_791_1.time_ < var_794_19 + var_794_20 + arg_794_0 and not isNil(var_794_18) and arg_791_1.var_.characterEffect1248ui_story then
				arg_791_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_794_22 = arg_791_1.actors_["1028ui_story"]
			local var_794_23 = 0

			if var_794_23 < arg_791_1.time_ and arg_791_1.time_ <= var_794_23 + arg_794_0 and not isNil(var_794_22) and arg_791_1.var_.characterEffect1028ui_story == nil then
				arg_791_1.var_.characterEffect1028ui_story = var_794_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_794_24 = 0.200000002980232

			if var_794_23 <= arg_791_1.time_ and arg_791_1.time_ < var_794_23 + var_794_24 and not isNil(var_794_22) then
				local var_794_25 = (arg_791_1.time_ - var_794_23) / var_794_24

				if arg_791_1.var_.characterEffect1028ui_story and not isNil(var_794_22) then
					local var_794_26 = Mathf.Lerp(0, 0.5, var_794_25)

					arg_791_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_791_1.var_.characterEffect1028ui_story.fillRatio = var_794_26
				end
			end

			if arg_791_1.time_ >= var_794_23 + var_794_24 and arg_791_1.time_ < var_794_23 + var_794_24 + arg_794_0 and not isNil(var_794_22) and arg_791_1.var_.characterEffect1028ui_story then
				local var_794_27 = 0.5

				arg_791_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_791_1.var_.characterEffect1028ui_story.fillRatio = var_794_27
			end

			local var_794_28 = 0

			if var_794_28 < arg_791_1.time_ and arg_791_1.time_ <= var_794_28 + arg_794_0 then
				arg_791_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248actionlink/1248action445")
			end

			local var_794_29 = 0

			if var_794_29 < arg_791_1.time_ and arg_791_1.time_ <= var_794_29 + arg_794_0 then
				arg_791_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_794_30 = 0
			local var_794_31 = 0.325

			if var_794_30 < arg_791_1.time_ and arg_791_1.time_ <= var_794_30 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				local var_794_32 = arg_791_1:FormatText(StoryNameCfg[8].name)

				arg_791_1.leftNameTxt_.text = var_794_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, false)
				arg_791_1.callingController_:SetSelectedState("normal")

				local var_794_33 = arg_791_1:GetWordFromCfg(930011198)
				local var_794_34 = arg_791_1:FormatText(var_794_33.content)

				arg_791_1.text_.text = var_794_34

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_35 = 13
				local var_794_36 = utf8.len(var_794_34)
				local var_794_37 = var_794_35 <= 0 and var_794_31 or var_794_31 * (var_794_36 / var_794_35)

				if var_794_37 > 0 and var_794_31 < var_794_37 then
					arg_791_1.talkMaxDuration = var_794_37

					if var_794_37 + var_794_30 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_37 + var_794_30
					end
				end

				arg_791_1.text_.text = var_794_34
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)
				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_38 = math.max(var_794_31, arg_791_1.talkMaxDuration)

			if var_794_30 <= arg_791_1.time_ and arg_791_1.time_ < var_794_30 + var_794_38 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_30) / var_794_38

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_30 + var_794_38 and arg_791_1.time_ < var_794_30 + var_794_38 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_791_1:InitPlayNodeList()
	end,
	Play930011199 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 930011199
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play930011200(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = arg_795_1.actors_["1028ui_story"].transform
			local var_798_1 = 0

			if var_798_1 < arg_795_1.time_ and arg_795_1.time_ <= var_798_1 + arg_798_0 then
				arg_795_1.var_.moveOldPos1028ui_story = var_798_0.localPosition
			end

			local var_798_2 = 0.001

			if var_798_1 <= arg_795_1.time_ and arg_795_1.time_ < var_798_1 + var_798_2 then
				local var_798_3 = (arg_795_1.time_ - var_798_1) / var_798_2
				local var_798_4 = Vector3.New(0.7, -0.9, -5.9)

				var_798_0.localPosition = Vector3.Lerp(arg_795_1.var_.moveOldPos1028ui_story, var_798_4, var_798_3)

				local var_798_5 = manager.ui.mainCamera.transform.position - var_798_0.position

				var_798_0.forward = Vector3.New(var_798_5.x, var_798_5.y, var_798_5.z)

				local var_798_6 = var_798_0.localEulerAngles

				var_798_6.z = 0
				var_798_6.x = 0
				var_798_0.localEulerAngles = var_798_6
			end

			if arg_795_1.time_ >= var_798_1 + var_798_2 and arg_795_1.time_ < var_798_1 + var_798_2 + arg_798_0 then
				var_798_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_798_7 = manager.ui.mainCamera.transform.position - var_798_0.position

				var_798_0.forward = Vector3.New(var_798_7.x, var_798_7.y, var_798_7.z)

				local var_798_8 = var_798_0.localEulerAngles

				var_798_8.z = 0
				var_798_8.x = 0
				var_798_0.localEulerAngles = var_798_8
			end

			local var_798_9 = arg_795_1.actors_["1028ui_story"]
			local var_798_10 = 0

			if var_798_10 < arg_795_1.time_ and arg_795_1.time_ <= var_798_10 + arg_798_0 and not isNil(var_798_9) and arg_795_1.var_.characterEffect1028ui_story == nil then
				arg_795_1.var_.characterEffect1028ui_story = var_798_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_798_11 = 0.200000002980232

			if var_798_10 <= arg_795_1.time_ and arg_795_1.time_ < var_798_10 + var_798_11 and not isNil(var_798_9) then
				local var_798_12 = (arg_795_1.time_ - var_798_10) / var_798_11

				if arg_795_1.var_.characterEffect1028ui_story and not isNil(var_798_9) then
					arg_795_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_795_1.time_ >= var_798_10 + var_798_11 and arg_795_1.time_ < var_798_10 + var_798_11 + arg_798_0 and not isNil(var_798_9) and arg_795_1.var_.characterEffect1028ui_story then
				arg_795_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_798_13 = arg_795_1.actors_["1248ui_story"]
			local var_798_14 = 0

			if var_798_14 < arg_795_1.time_ and arg_795_1.time_ <= var_798_14 + arg_798_0 and not isNil(var_798_13) and arg_795_1.var_.characterEffect1248ui_story == nil then
				arg_795_1.var_.characterEffect1248ui_story = var_798_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_798_15 = 0.200000002980232

			if var_798_14 <= arg_795_1.time_ and arg_795_1.time_ < var_798_14 + var_798_15 and not isNil(var_798_13) then
				local var_798_16 = (arg_795_1.time_ - var_798_14) / var_798_15

				if arg_795_1.var_.characterEffect1248ui_story and not isNil(var_798_13) then
					local var_798_17 = Mathf.Lerp(0, 0.5, var_798_16)

					arg_795_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_795_1.var_.characterEffect1248ui_story.fillRatio = var_798_17
				end
			end

			if arg_795_1.time_ >= var_798_14 + var_798_15 and arg_795_1.time_ < var_798_14 + var_798_15 + arg_798_0 and not isNil(var_798_13) and arg_795_1.var_.characterEffect1248ui_story then
				local var_798_18 = 0.5

				arg_795_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_795_1.var_.characterEffect1248ui_story.fillRatio = var_798_18
			end

			local var_798_19 = 0

			if var_798_19 < arg_795_1.time_ and arg_795_1.time_ <= var_798_19 + arg_798_0 then
				arg_795_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			local var_798_20 = 0

			if var_798_20 < arg_795_1.time_ and arg_795_1.time_ <= var_798_20 + arg_798_0 then
				arg_795_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_798_21 = 0
			local var_798_22 = 0.625

			if var_798_21 < arg_795_1.time_ and arg_795_1.time_ <= var_798_21 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, true)

				local var_798_23 = arg_795_1:FormatText(StoryNameCfg[327].name)

				arg_795_1.leftNameTxt_.text = var_798_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_795_1.leftNameTxt_.transform)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1.leftNameTxt_.text)
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_24 = arg_795_1:GetWordFromCfg(930011199)
				local var_798_25 = arg_795_1:FormatText(var_798_24.content)

				arg_795_1.text_.text = var_798_25

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_26 = 27
				local var_798_27 = utf8.len(var_798_25)
				local var_798_28 = var_798_26 <= 0 and var_798_22 or var_798_22 * (var_798_27 / var_798_26)

				if var_798_28 > 0 and var_798_22 < var_798_28 then
					arg_795_1.talkMaxDuration = var_798_28

					if var_798_28 + var_798_21 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_28 + var_798_21
					end
				end

				arg_795_1.text_.text = var_798_25
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_29 = math.max(var_798_22, arg_795_1.talkMaxDuration)

			if var_798_21 <= arg_795_1.time_ and arg_795_1.time_ < var_798_21 + var_798_29 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_21) / var_798_29

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_21 + var_798_29 and arg_795_1.time_ < var_798_21 + var_798_29 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_795_1:InitPlayNodeList()
	end,
	Play930011200 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 930011200
		arg_799_1.duration_ = 5

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play930011201(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = arg_799_1.actors_["1248ui_story"].transform
			local var_802_1 = 0

			if var_802_1 < arg_799_1.time_ and arg_799_1.time_ <= var_802_1 + arg_802_0 then
				arg_799_1.var_.moveOldPos1248ui_story = var_802_0.localPosition
			end

			local var_802_2 = 0.001

			if var_802_1 <= arg_799_1.time_ and arg_799_1.time_ < var_802_1 + var_802_2 then
				local var_802_3 = (arg_799_1.time_ - var_802_1) / var_802_2
				local var_802_4 = Vector3.New(-0.7, -0.775, -6.18)

				var_802_0.localPosition = Vector3.Lerp(arg_799_1.var_.moveOldPos1248ui_story, var_802_4, var_802_3)

				local var_802_5 = manager.ui.mainCamera.transform.position - var_802_0.position

				var_802_0.forward = Vector3.New(var_802_5.x, var_802_5.y, var_802_5.z)

				local var_802_6 = var_802_0.localEulerAngles

				var_802_6.z = 0
				var_802_6.x = 0
				var_802_0.localEulerAngles = var_802_6
			end

			if arg_799_1.time_ >= var_802_1 + var_802_2 and arg_799_1.time_ < var_802_1 + var_802_2 + arg_802_0 then
				var_802_0.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_802_7 = manager.ui.mainCamera.transform.position - var_802_0.position

				var_802_0.forward = Vector3.New(var_802_7.x, var_802_7.y, var_802_7.z)

				local var_802_8 = var_802_0.localEulerAngles

				var_802_8.z = 0
				var_802_8.x = 0
				var_802_0.localEulerAngles = var_802_8
			end

			local var_802_9 = arg_799_1.actors_["1248ui_story"]
			local var_802_10 = 0

			if var_802_10 < arg_799_1.time_ and arg_799_1.time_ <= var_802_10 + arg_802_0 and not isNil(var_802_9) and arg_799_1.var_.characterEffect1248ui_story == nil then
				arg_799_1.var_.characterEffect1248ui_story = var_802_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_11 = 0.200000002980232

			if var_802_10 <= arg_799_1.time_ and arg_799_1.time_ < var_802_10 + var_802_11 and not isNil(var_802_9) then
				local var_802_12 = (arg_799_1.time_ - var_802_10) / var_802_11

				if arg_799_1.var_.characterEffect1248ui_story and not isNil(var_802_9) then
					arg_799_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_799_1.time_ >= var_802_10 + var_802_11 and arg_799_1.time_ < var_802_10 + var_802_11 + arg_802_0 and not isNil(var_802_9) and arg_799_1.var_.characterEffect1248ui_story then
				arg_799_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_802_13 = arg_799_1.actors_["1028ui_story"]
			local var_802_14 = 0

			if var_802_14 < arg_799_1.time_ and arg_799_1.time_ <= var_802_14 + arg_802_0 and not isNil(var_802_13) and arg_799_1.var_.characterEffect1028ui_story == nil then
				arg_799_1.var_.characterEffect1028ui_story = var_802_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_15 = 0.200000002980232

			if var_802_14 <= arg_799_1.time_ and arg_799_1.time_ < var_802_14 + var_802_15 and not isNil(var_802_13) then
				local var_802_16 = (arg_799_1.time_ - var_802_14) / var_802_15

				if arg_799_1.var_.characterEffect1028ui_story and not isNil(var_802_13) then
					local var_802_17 = Mathf.Lerp(0, 0.5, var_802_16)

					arg_799_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_799_1.var_.characterEffect1028ui_story.fillRatio = var_802_17
				end
			end

			if arg_799_1.time_ >= var_802_14 + var_802_15 and arg_799_1.time_ < var_802_14 + var_802_15 + arg_802_0 and not isNil(var_802_13) and arg_799_1.var_.characterEffect1028ui_story then
				local var_802_18 = 0.5

				arg_799_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_799_1.var_.characterEffect1028ui_story.fillRatio = var_802_18
			end

			local var_802_19 = 0

			if var_802_19 < arg_799_1.time_ and arg_799_1.time_ <= var_802_19 + arg_802_0 then
				arg_799_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248actionlink/1248action457")
			end

			local var_802_20 = 0

			if var_802_20 < arg_799_1.time_ and arg_799_1.time_ <= var_802_20 + arg_802_0 then
				arg_799_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_802_21 = 0
			local var_802_22 = 0.25

			if var_802_21 < arg_799_1.time_ and arg_799_1.time_ <= var_802_21 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				local var_802_23 = arg_799_1:FormatText(StoryNameCfg[8].name)

				arg_799_1.leftNameTxt_.text = var_802_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_24 = arg_799_1:GetWordFromCfg(930011200)
				local var_802_25 = arg_799_1:FormatText(var_802_24.content)

				arg_799_1.text_.text = var_802_25

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_26 = 10
				local var_802_27 = utf8.len(var_802_25)
				local var_802_28 = var_802_26 <= 0 and var_802_22 or var_802_22 * (var_802_27 / var_802_26)

				if var_802_28 > 0 and var_802_22 < var_802_28 then
					arg_799_1.talkMaxDuration = var_802_28

					if var_802_28 + var_802_21 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_28 + var_802_21
					end
				end

				arg_799_1.text_.text = var_802_25
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)
				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_29 = math.max(var_802_22, arg_799_1.talkMaxDuration)

			if var_802_21 <= arg_799_1.time_ and arg_799_1.time_ < var_802_21 + var_802_29 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_21) / var_802_29

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_21 + var_802_29 and arg_799_1.time_ < var_802_21 + var_802_29 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_799_1:InitPlayNodeList()
	end,
	Play930011201 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 930011201
		arg_803_1.duration_ = 5

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play930011202(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = arg_803_1.actors_["1028ui_story"].transform
			local var_806_1 = 0

			if var_806_1 < arg_803_1.time_ and arg_803_1.time_ <= var_806_1 + arg_806_0 then
				arg_803_1.var_.moveOldPos1028ui_story = var_806_0.localPosition
			end

			local var_806_2 = 0.001

			if var_806_1 <= arg_803_1.time_ and arg_803_1.time_ < var_806_1 + var_806_2 then
				local var_806_3 = (arg_803_1.time_ - var_806_1) / var_806_2
				local var_806_4 = Vector3.New(0.7, -0.9, -5.9)

				var_806_0.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos1028ui_story, var_806_4, var_806_3)

				local var_806_5 = manager.ui.mainCamera.transform.position - var_806_0.position

				var_806_0.forward = Vector3.New(var_806_5.x, var_806_5.y, var_806_5.z)

				local var_806_6 = var_806_0.localEulerAngles

				var_806_6.z = 0
				var_806_6.x = 0
				var_806_0.localEulerAngles = var_806_6
			end

			if arg_803_1.time_ >= var_806_1 + var_806_2 and arg_803_1.time_ < var_806_1 + var_806_2 + arg_806_0 then
				var_806_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_806_7 = manager.ui.mainCamera.transform.position - var_806_0.position

				var_806_0.forward = Vector3.New(var_806_7.x, var_806_7.y, var_806_7.z)

				local var_806_8 = var_806_0.localEulerAngles

				var_806_8.z = 0
				var_806_8.x = 0
				var_806_0.localEulerAngles = var_806_8
			end

			local var_806_9 = arg_803_1.actors_["1028ui_story"]
			local var_806_10 = 0

			if var_806_10 < arg_803_1.time_ and arg_803_1.time_ <= var_806_10 + arg_806_0 and not isNil(var_806_9) and arg_803_1.var_.characterEffect1028ui_story == nil then
				arg_803_1.var_.characterEffect1028ui_story = var_806_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_11 = 0.200000002980232

			if var_806_10 <= arg_803_1.time_ and arg_803_1.time_ < var_806_10 + var_806_11 and not isNil(var_806_9) then
				local var_806_12 = (arg_803_1.time_ - var_806_10) / var_806_11

				if arg_803_1.var_.characterEffect1028ui_story and not isNil(var_806_9) then
					arg_803_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_803_1.time_ >= var_806_10 + var_806_11 and arg_803_1.time_ < var_806_10 + var_806_11 + arg_806_0 and not isNil(var_806_9) and arg_803_1.var_.characterEffect1028ui_story then
				arg_803_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_806_13 = arg_803_1.actors_["1248ui_story"]
			local var_806_14 = 0

			if var_806_14 < arg_803_1.time_ and arg_803_1.time_ <= var_806_14 + arg_806_0 and not isNil(var_806_13) and arg_803_1.var_.characterEffect1248ui_story == nil then
				arg_803_1.var_.characterEffect1248ui_story = var_806_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_15 = 0.200000002980232

			if var_806_14 <= arg_803_1.time_ and arg_803_1.time_ < var_806_14 + var_806_15 and not isNil(var_806_13) then
				local var_806_16 = (arg_803_1.time_ - var_806_14) / var_806_15

				if arg_803_1.var_.characterEffect1248ui_story and not isNil(var_806_13) then
					local var_806_17 = Mathf.Lerp(0, 0.5, var_806_16)

					arg_803_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_803_1.var_.characterEffect1248ui_story.fillRatio = var_806_17
				end
			end

			if arg_803_1.time_ >= var_806_14 + var_806_15 and arg_803_1.time_ < var_806_14 + var_806_15 + arg_806_0 and not isNil(var_806_13) and arg_803_1.var_.characterEffect1248ui_story then
				local var_806_18 = 0.5

				arg_803_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_803_1.var_.characterEffect1248ui_story.fillRatio = var_806_18
			end

			local var_806_19 = 0

			if var_806_19 < arg_803_1.time_ and arg_803_1.time_ <= var_806_19 + arg_806_0 then
				arg_803_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_806_20 = 0

			if var_806_20 < arg_803_1.time_ and arg_803_1.time_ <= var_806_20 + arg_806_0 then
				arg_803_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_806_21 = 0
			local var_806_22 = 0.25

			if var_806_21 < arg_803_1.time_ and arg_803_1.time_ <= var_806_21 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, true)

				local var_806_23 = arg_803_1:FormatText(StoryNameCfg[327].name)

				arg_803_1.leftNameTxt_.text = var_806_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_803_1.leftNameTxt_.transform)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1.leftNameTxt_.text)
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_24 = arg_803_1:GetWordFromCfg(930011201)
				local var_806_25 = arg_803_1:FormatText(var_806_24.content)

				arg_803_1.text_.text = var_806_25

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_26 = 10
				local var_806_27 = utf8.len(var_806_25)
				local var_806_28 = var_806_26 <= 0 and var_806_22 or var_806_22 * (var_806_27 / var_806_26)

				if var_806_28 > 0 and var_806_22 < var_806_28 then
					arg_803_1.talkMaxDuration = var_806_28

					if var_806_28 + var_806_21 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_28 + var_806_21
					end
				end

				arg_803_1.text_.text = var_806_25
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)
				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_29 = math.max(var_806_22, arg_803_1.talkMaxDuration)

			if var_806_21 <= arg_803_1.time_ and arg_803_1.time_ < var_806_21 + var_806_29 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_21) / var_806_29

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_21 + var_806_29 and arg_803_1.time_ < var_806_21 + var_806_29 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play930011202 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 930011202
		arg_807_1.duration_ = 5

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play930011203(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			local var_810_0 = arg_807_1.actors_["1044ui_story"].transform
			local var_810_1 = 0

			if var_810_1 < arg_807_1.time_ and arg_807_1.time_ <= var_810_1 + arg_810_0 then
				arg_807_1.var_.moveOldPos1044ui_story = var_810_0.localPosition
			end

			local var_810_2 = 0.001

			if var_810_1 <= arg_807_1.time_ and arg_807_1.time_ < var_810_1 + var_810_2 then
				local var_810_3 = (arg_807_1.time_ - var_810_1) / var_810_2
				local var_810_4 = Vector3.New(-0.7, -1, -5.93)

				var_810_0.localPosition = Vector3.Lerp(arg_807_1.var_.moveOldPos1044ui_story, var_810_4, var_810_3)

				local var_810_5 = manager.ui.mainCamera.transform.position - var_810_0.position

				var_810_0.forward = Vector3.New(var_810_5.x, var_810_5.y, var_810_5.z)

				local var_810_6 = var_810_0.localEulerAngles

				var_810_6.z = 0
				var_810_6.x = 0
				var_810_0.localEulerAngles = var_810_6
			end

			if arg_807_1.time_ >= var_810_1 + var_810_2 and arg_807_1.time_ < var_810_1 + var_810_2 + arg_810_0 then
				var_810_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_810_7 = manager.ui.mainCamera.transform.position - var_810_0.position

				var_810_0.forward = Vector3.New(var_810_7.x, var_810_7.y, var_810_7.z)

				local var_810_8 = var_810_0.localEulerAngles

				var_810_8.z = 0
				var_810_8.x = 0
				var_810_0.localEulerAngles = var_810_8
			end

			local var_810_9 = arg_807_1.actors_["1248ui_story"].transform
			local var_810_10 = 0

			if var_810_10 < arg_807_1.time_ and arg_807_1.time_ <= var_810_10 + arg_810_0 then
				arg_807_1.var_.moveOldPos1248ui_story = var_810_9.localPosition
			end

			local var_810_11 = 0.001

			if var_810_10 <= arg_807_1.time_ and arg_807_1.time_ < var_810_10 + var_810_11 then
				local var_810_12 = (arg_807_1.time_ - var_810_10) / var_810_11
				local var_810_13 = Vector3.New(0, 100, 0)

				var_810_9.localPosition = Vector3.Lerp(arg_807_1.var_.moveOldPos1248ui_story, var_810_13, var_810_12)

				local var_810_14 = manager.ui.mainCamera.transform.position - var_810_9.position

				var_810_9.forward = Vector3.New(var_810_14.x, var_810_14.y, var_810_14.z)

				local var_810_15 = var_810_9.localEulerAngles

				var_810_15.z = 0
				var_810_15.x = 0
				var_810_9.localEulerAngles = var_810_15
			end

			if arg_807_1.time_ >= var_810_10 + var_810_11 and arg_807_1.time_ < var_810_10 + var_810_11 + arg_810_0 then
				var_810_9.localPosition = Vector3.New(0, 100, 0)

				local var_810_16 = manager.ui.mainCamera.transform.position - var_810_9.position

				var_810_9.forward = Vector3.New(var_810_16.x, var_810_16.y, var_810_16.z)

				local var_810_17 = var_810_9.localEulerAngles

				var_810_17.z = 0
				var_810_17.x = 0
				var_810_9.localEulerAngles = var_810_17
			end

			local var_810_18 = arg_807_1.actors_["1044ui_story"]
			local var_810_19 = 0

			if var_810_19 < arg_807_1.time_ and arg_807_1.time_ <= var_810_19 + arg_810_0 and not isNil(var_810_18) and arg_807_1.var_.characterEffect1044ui_story == nil then
				arg_807_1.var_.characterEffect1044ui_story = var_810_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_810_20 = 0.200000002980232

			if var_810_19 <= arg_807_1.time_ and arg_807_1.time_ < var_810_19 + var_810_20 and not isNil(var_810_18) then
				local var_810_21 = (arg_807_1.time_ - var_810_19) / var_810_20

				if arg_807_1.var_.characterEffect1044ui_story and not isNil(var_810_18) then
					arg_807_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_807_1.time_ >= var_810_19 + var_810_20 and arg_807_1.time_ < var_810_19 + var_810_20 + arg_810_0 and not isNil(var_810_18) and arg_807_1.var_.characterEffect1044ui_story then
				arg_807_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_810_22 = arg_807_1.actors_["1028ui_story"]
			local var_810_23 = 0

			if var_810_23 < arg_807_1.time_ and arg_807_1.time_ <= var_810_23 + arg_810_0 and not isNil(var_810_22) and arg_807_1.var_.characterEffect1028ui_story == nil then
				arg_807_1.var_.characterEffect1028ui_story = var_810_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_810_24 = 0.200000002980232

			if var_810_23 <= arg_807_1.time_ and arg_807_1.time_ < var_810_23 + var_810_24 and not isNil(var_810_22) then
				local var_810_25 = (arg_807_1.time_ - var_810_23) / var_810_24

				if arg_807_1.var_.characterEffect1028ui_story and not isNil(var_810_22) then
					local var_810_26 = Mathf.Lerp(0, 0.5, var_810_25)

					arg_807_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_807_1.var_.characterEffect1028ui_story.fillRatio = var_810_26
				end
			end

			if arg_807_1.time_ >= var_810_23 + var_810_24 and arg_807_1.time_ < var_810_23 + var_810_24 + arg_810_0 and not isNil(var_810_22) and arg_807_1.var_.characterEffect1028ui_story then
				local var_810_27 = 0.5

				arg_807_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_807_1.var_.characterEffect1028ui_story.fillRatio = var_810_27
			end

			local var_810_28 = 0

			if var_810_28 < arg_807_1.time_ and arg_807_1.time_ <= var_810_28 + arg_810_0 then
				arg_807_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			local var_810_29 = 0

			if var_810_29 < arg_807_1.time_ and arg_807_1.time_ <= var_810_29 + arg_810_0 then
				arg_807_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_810_30 = 0
			local var_810_31 = 0.25

			if var_810_30 < arg_807_1.time_ and arg_807_1.time_ <= var_810_30 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				local var_810_32 = arg_807_1:FormatText(StoryNameCfg[1367].name)

				arg_807_1.leftNameTxt_.text = var_810_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, false)
				arg_807_1.callingController_:SetSelectedState("normal")

				local var_810_33 = arg_807_1:GetWordFromCfg(930011202)
				local var_810_34 = arg_807_1:FormatText(var_810_33.content)

				arg_807_1.text_.text = var_810_34

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_35 = 10
				local var_810_36 = utf8.len(var_810_34)
				local var_810_37 = var_810_35 <= 0 and var_810_31 or var_810_31 * (var_810_36 / var_810_35)

				if var_810_37 > 0 and var_810_31 < var_810_37 then
					arg_807_1.talkMaxDuration = var_810_37

					if var_810_37 + var_810_30 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_37 + var_810_30
					end
				end

				arg_807_1.text_.text = var_810_34
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)
				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_38 = math.max(var_810_31, arg_807_1.talkMaxDuration)

			if var_810_30 <= arg_807_1.time_ and arg_807_1.time_ < var_810_30 + var_810_38 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_30) / var_810_38

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_30 + var_810_38 and arg_807_1.time_ < var_810_30 + var_810_38 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_807_1:InitPlayNodeList()
	end,
	Play930011203 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 930011203
		arg_811_1.duration_ = 5

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play930011204(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			local var_814_0 = arg_811_1.actors_["1044ui_story"].transform
			local var_814_1 = 0

			if var_814_1 < arg_811_1.time_ and arg_811_1.time_ <= var_814_1 + arg_814_0 then
				arg_811_1.var_.moveOldPos1044ui_story = var_814_0.localPosition
			end

			local var_814_2 = 0.001

			if var_814_1 <= arg_811_1.time_ and arg_811_1.time_ < var_814_1 + var_814_2 then
				local var_814_3 = (arg_811_1.time_ - var_814_1) / var_814_2
				local var_814_4 = Vector3.New(0, 100, 0)

				var_814_0.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos1044ui_story, var_814_4, var_814_3)

				local var_814_5 = manager.ui.mainCamera.transform.position - var_814_0.position

				var_814_0.forward = Vector3.New(var_814_5.x, var_814_5.y, var_814_5.z)

				local var_814_6 = var_814_0.localEulerAngles

				var_814_6.z = 0
				var_814_6.x = 0
				var_814_0.localEulerAngles = var_814_6
			end

			if arg_811_1.time_ >= var_814_1 + var_814_2 and arg_811_1.time_ < var_814_1 + var_814_2 + arg_814_0 then
				var_814_0.localPosition = Vector3.New(0, 100, 0)

				local var_814_7 = manager.ui.mainCamera.transform.position - var_814_0.position

				var_814_0.forward = Vector3.New(var_814_7.x, var_814_7.y, var_814_7.z)

				local var_814_8 = var_814_0.localEulerAngles

				var_814_8.z = 0
				var_814_8.x = 0
				var_814_0.localEulerAngles = var_814_8
			end

			local var_814_9 = arg_811_1.actors_["1028ui_story"].transform
			local var_814_10 = 0

			if var_814_10 < arg_811_1.time_ and arg_811_1.time_ <= var_814_10 + arg_814_0 then
				arg_811_1.var_.moveOldPos1028ui_story = var_814_9.localPosition
			end

			local var_814_11 = 0.001

			if var_814_10 <= arg_811_1.time_ and arg_811_1.time_ < var_814_10 + var_814_11 then
				local var_814_12 = (arg_811_1.time_ - var_814_10) / var_814_11
				local var_814_13 = Vector3.New(0, 100, 0)

				var_814_9.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos1028ui_story, var_814_13, var_814_12)

				local var_814_14 = manager.ui.mainCamera.transform.position - var_814_9.position

				var_814_9.forward = Vector3.New(var_814_14.x, var_814_14.y, var_814_14.z)

				local var_814_15 = var_814_9.localEulerAngles

				var_814_15.z = 0
				var_814_15.x = 0
				var_814_9.localEulerAngles = var_814_15
			end

			if arg_811_1.time_ >= var_814_10 + var_814_11 and arg_811_1.time_ < var_814_10 + var_814_11 + arg_814_0 then
				var_814_9.localPosition = Vector3.New(0, 100, 0)

				local var_814_16 = manager.ui.mainCamera.transform.position - var_814_9.position

				var_814_9.forward = Vector3.New(var_814_16.x, var_814_16.y, var_814_16.z)

				local var_814_17 = var_814_9.localEulerAngles

				var_814_17.z = 0
				var_814_17.x = 0
				var_814_9.localEulerAngles = var_814_17
			end

			local var_814_18 = arg_811_1.actors_["1044ui_story"]
			local var_814_19 = 0

			if var_814_19 < arg_811_1.time_ and arg_811_1.time_ <= var_814_19 + arg_814_0 and not isNil(var_814_18) and arg_811_1.var_.characterEffect1044ui_story == nil then
				arg_811_1.var_.characterEffect1044ui_story = var_814_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_814_20 = 0.200000002980232

			if var_814_19 <= arg_811_1.time_ and arg_811_1.time_ < var_814_19 + var_814_20 and not isNil(var_814_18) then
				local var_814_21 = (arg_811_1.time_ - var_814_19) / var_814_20

				if arg_811_1.var_.characterEffect1044ui_story and not isNil(var_814_18) then
					local var_814_22 = Mathf.Lerp(0, 0.5, var_814_21)

					arg_811_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_811_1.var_.characterEffect1044ui_story.fillRatio = var_814_22
				end
			end

			if arg_811_1.time_ >= var_814_19 + var_814_20 and arg_811_1.time_ < var_814_19 + var_814_20 + arg_814_0 and not isNil(var_814_18) and arg_811_1.var_.characterEffect1044ui_story then
				local var_814_23 = 0.5

				arg_811_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_811_1.var_.characterEffect1044ui_story.fillRatio = var_814_23
			end

			local var_814_24 = 0
			local var_814_25 = 0.975

			if var_814_24 < arg_811_1.time_ and arg_811_1.time_ <= var_814_24 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, false)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_26 = arg_811_1:GetWordFromCfg(930011203)
				local var_814_27 = arg_811_1:FormatText(var_814_26.content)

				arg_811_1.text_.text = var_814_27

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_28 = 39
				local var_814_29 = utf8.len(var_814_27)
				local var_814_30 = var_814_28 <= 0 and var_814_25 or var_814_25 * (var_814_29 / var_814_28)

				if var_814_30 > 0 and var_814_25 < var_814_30 then
					arg_811_1.talkMaxDuration = var_814_30

					if var_814_30 + var_814_24 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_30 + var_814_24
					end
				end

				arg_811_1.text_.text = var_814_27
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)
				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_31 = math.max(var_814_25, arg_811_1.talkMaxDuration)

			if var_814_24 <= arg_811_1.time_ and arg_811_1.time_ < var_814_24 + var_814_31 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_24) / var_814_31

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_24 + var_814_31 and arg_811_1.time_ < var_814_24 + var_814_31 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_811_1:InitPlayNodeList()
	end,
	Play930011204 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 930011204
		arg_815_1.duration_ = 5

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
		end

		function arg_815_1.playNext_(arg_817_0)
			if arg_817_0 == 1 then
				arg_815_0:Play930011205(arg_815_1)
			end
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			local var_818_0 = 0
			local var_818_1 = 1.1

			if var_818_0 < arg_815_1.time_ and arg_815_1.time_ <= var_818_0 + arg_818_0 then
				arg_815_1.talkMaxDuration = 0
				arg_815_1.dialogCg_.alpha = 1

				arg_815_1.dialog_:SetActive(true)
				SetActive(arg_815_1.leftNameGo_, true)

				local var_818_2 = arg_815_1:FormatText(StoryNameCfg[7].name)

				arg_815_1.leftNameTxt_.text = var_818_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_815_1.leftNameTxt_.transform)

				arg_815_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_815_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_815_1:RecordName(arg_815_1.leftNameTxt_.text)
				SetActive(arg_815_1.iconTrs_.gameObject, true)
				arg_815_1.iconController_:SetSelectedState("hero")

				arg_815_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_815_1.callingController_:SetSelectedState("normal")

				arg_815_1.keyicon_.color = Color.New(1, 1, 1)
				arg_815_1.icon_.color = Color.New(1, 1, 1)

				local var_818_3 = arg_815_1:GetWordFromCfg(930011204)
				local var_818_4 = arg_815_1:FormatText(var_818_3.content)

				arg_815_1.text_.text = var_818_4

				LuaForUtil.ClearLinePrefixSymbol(arg_815_1.text_)

				local var_818_5 = 44
				local var_818_6 = utf8.len(var_818_4)
				local var_818_7 = var_818_5 <= 0 and var_818_1 or var_818_1 * (var_818_6 / var_818_5)

				if var_818_7 > 0 and var_818_1 < var_818_7 then
					arg_815_1.talkMaxDuration = var_818_7

					if var_818_7 + var_818_0 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_7 + var_818_0
					end
				end

				arg_815_1.text_.text = var_818_4
				arg_815_1.typewritter.percent = 0

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(false)
				arg_815_1:RecordContent(arg_815_1.text_.text)
			end

			local var_818_8 = math.max(var_818_1, arg_815_1.talkMaxDuration)

			if var_818_0 <= arg_815_1.time_ and arg_815_1.time_ < var_818_0 + var_818_8 then
				arg_815_1.typewritter.percent = (arg_815_1.time_ - var_818_0) / var_818_8

				arg_815_1.typewritter:SetDirty()
			end

			if arg_815_1.time_ >= var_818_0 + var_818_8 and arg_815_1.time_ < var_818_0 + var_818_8 + arg_818_0 then
				arg_815_1.typewritter.percent = 1

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(true)
			end
		end

		arg_815_1.nodeConfigList_ = {}

		arg_815_1:InitPlayNodeList()
	end,
	Play930011205 = function(arg_819_0, arg_819_1)
		arg_819_1.time_ = 0
		arg_819_1.frameCnt_ = 0
		arg_819_1.state_ = "playing"
		arg_819_1.curTalkId_ = 930011205
		arg_819_1.duration_ = 5

		SetActive(arg_819_1.tipsGo_, false)

		function arg_819_1.onSingleLineFinish_()
			arg_819_1.onSingleLineUpdate_ = nil
			arg_819_1.onSingleLineFinish_ = nil
			arg_819_1.state_ = "waiting"
		end

		function arg_819_1.playNext_(arg_821_0)
			if arg_821_0 == 1 then
				arg_819_0:Play930011206(arg_819_1)
			end
		end

		function arg_819_1.onSingleLineUpdate_(arg_822_0)
			local var_822_0 = arg_819_1.actors_["1044ui_story"].transform
			local var_822_1 = 0

			if var_822_1 < arg_819_1.time_ and arg_819_1.time_ <= var_822_1 + arg_822_0 then
				arg_819_1.var_.moveOldPos1044ui_story = var_822_0.localPosition
			end

			local var_822_2 = 0.001

			if var_822_1 <= arg_819_1.time_ and arg_819_1.time_ < var_822_1 + var_822_2 then
				local var_822_3 = (arg_819_1.time_ - var_822_1) / var_822_2
				local var_822_4 = Vector3.New(0, -1, -5.93)

				var_822_0.localPosition = Vector3.Lerp(arg_819_1.var_.moveOldPos1044ui_story, var_822_4, var_822_3)

				local var_822_5 = manager.ui.mainCamera.transform.position - var_822_0.position

				var_822_0.forward = Vector3.New(var_822_5.x, var_822_5.y, var_822_5.z)

				local var_822_6 = var_822_0.localEulerAngles

				var_822_6.z = 0
				var_822_6.x = 0
				var_822_0.localEulerAngles = var_822_6
			end

			if arg_819_1.time_ >= var_822_1 + var_822_2 and arg_819_1.time_ < var_822_1 + var_822_2 + arg_822_0 then
				var_822_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_822_7 = manager.ui.mainCamera.transform.position - var_822_0.position

				var_822_0.forward = Vector3.New(var_822_7.x, var_822_7.y, var_822_7.z)

				local var_822_8 = var_822_0.localEulerAngles

				var_822_8.z = 0
				var_822_8.x = 0
				var_822_0.localEulerAngles = var_822_8
			end

			local var_822_9 = arg_819_1.actors_["1044ui_story"]
			local var_822_10 = 0

			if var_822_10 < arg_819_1.time_ and arg_819_1.time_ <= var_822_10 + arg_822_0 and not isNil(var_822_9) and arg_819_1.var_.characterEffect1044ui_story == nil then
				arg_819_1.var_.characterEffect1044ui_story = var_822_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_822_11 = 0.200000002980232

			if var_822_10 <= arg_819_1.time_ and arg_819_1.time_ < var_822_10 + var_822_11 and not isNil(var_822_9) then
				local var_822_12 = (arg_819_1.time_ - var_822_10) / var_822_11

				if arg_819_1.var_.characterEffect1044ui_story and not isNil(var_822_9) then
					arg_819_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_819_1.time_ >= var_822_10 + var_822_11 and arg_819_1.time_ < var_822_10 + var_822_11 + arg_822_0 and not isNil(var_822_9) and arg_819_1.var_.characterEffect1044ui_story then
				arg_819_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_822_13 = 0

			if var_822_13 < arg_819_1.time_ and arg_819_1.time_ <= var_822_13 + arg_822_0 then
				arg_819_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_822_14 = 0

			if var_822_14 < arg_819_1.time_ and arg_819_1.time_ <= var_822_14 + arg_822_0 then
				arg_819_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_822_15 = 0
			local var_822_16 = 0.45

			if var_822_15 < arg_819_1.time_ and arg_819_1.time_ <= var_822_15 + arg_822_0 then
				arg_819_1.talkMaxDuration = 0
				arg_819_1.dialogCg_.alpha = 1

				arg_819_1.dialog_:SetActive(true)
				SetActive(arg_819_1.leftNameGo_, true)

				local var_822_17 = arg_819_1:FormatText(StoryNameCfg[1367].name)

				arg_819_1.leftNameTxt_.text = var_822_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_819_1.leftNameTxt_.transform)

				arg_819_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_819_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_819_1:RecordName(arg_819_1.leftNameTxt_.text)
				SetActive(arg_819_1.iconTrs_.gameObject, false)
				arg_819_1.callingController_:SetSelectedState("normal")

				local var_822_18 = arg_819_1:GetWordFromCfg(930011205)
				local var_822_19 = arg_819_1:FormatText(var_822_18.content)

				arg_819_1.text_.text = var_822_19

				LuaForUtil.ClearLinePrefixSymbol(arg_819_1.text_)

				local var_822_20 = 18
				local var_822_21 = utf8.len(var_822_19)
				local var_822_22 = var_822_20 <= 0 and var_822_16 or var_822_16 * (var_822_21 / var_822_20)

				if var_822_22 > 0 and var_822_16 < var_822_22 then
					arg_819_1.talkMaxDuration = var_822_22

					if var_822_22 + var_822_15 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_22 + var_822_15
					end
				end

				arg_819_1.text_.text = var_822_19
				arg_819_1.typewritter.percent = 0

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(false)
				arg_819_1:RecordContent(arg_819_1.text_.text)
			end

			local var_822_23 = math.max(var_822_16, arg_819_1.talkMaxDuration)

			if var_822_15 <= arg_819_1.time_ and arg_819_1.time_ < var_822_15 + var_822_23 then
				arg_819_1.typewritter.percent = (arg_819_1.time_ - var_822_15) / var_822_23

				arg_819_1.typewritter:SetDirty()
			end

			if arg_819_1.time_ >= var_822_15 + var_822_23 and arg_819_1.time_ < var_822_15 + var_822_23 + arg_822_0 then
				arg_819_1.typewritter.percent = 1

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(true)
			end
		end

		arg_819_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_819_1:InitPlayNodeList()
	end,
	Play930011206 = function(arg_823_0, arg_823_1)
		arg_823_1.time_ = 0
		arg_823_1.frameCnt_ = 0
		arg_823_1.state_ = "playing"
		arg_823_1.curTalkId_ = 930011206
		arg_823_1.duration_ = 5

		SetActive(arg_823_1.tipsGo_, false)

		function arg_823_1.onSingleLineFinish_()
			arg_823_1.onSingleLineUpdate_ = nil
			arg_823_1.onSingleLineFinish_ = nil
			arg_823_1.state_ = "waiting"
		end

		function arg_823_1.playNext_(arg_825_0)
			if arg_825_0 == 1 then
				arg_823_0:Play930011207(arg_823_1)
			end
		end

		function arg_823_1.onSingleLineUpdate_(arg_826_0)
			local var_826_0 = arg_823_1.actors_["1044ui_story"].transform
			local var_826_1 = 0

			if var_826_1 < arg_823_1.time_ and arg_823_1.time_ <= var_826_1 + arg_826_0 then
				arg_823_1.var_.moveOldPos1044ui_story = var_826_0.localPosition
			end

			local var_826_2 = 0.001

			if var_826_1 <= arg_823_1.time_ and arg_823_1.time_ < var_826_1 + var_826_2 then
				local var_826_3 = (arg_823_1.time_ - var_826_1) / var_826_2
				local var_826_4 = Vector3.New(0, 100, 0)

				var_826_0.localPosition = Vector3.Lerp(arg_823_1.var_.moveOldPos1044ui_story, var_826_4, var_826_3)

				local var_826_5 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_5.x, var_826_5.y, var_826_5.z)

				local var_826_6 = var_826_0.localEulerAngles

				var_826_6.z = 0
				var_826_6.x = 0
				var_826_0.localEulerAngles = var_826_6
			end

			if arg_823_1.time_ >= var_826_1 + var_826_2 and arg_823_1.time_ < var_826_1 + var_826_2 + arg_826_0 then
				var_826_0.localPosition = Vector3.New(0, 100, 0)

				local var_826_7 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_7.x, var_826_7.y, var_826_7.z)

				local var_826_8 = var_826_0.localEulerAngles

				var_826_8.z = 0
				var_826_8.x = 0
				var_826_0.localEulerAngles = var_826_8
			end

			local var_826_9 = arg_823_1.actors_["1044ui_story"]
			local var_826_10 = 0

			if var_826_10 < arg_823_1.time_ and arg_823_1.time_ <= var_826_10 + arg_826_0 and not isNil(var_826_9) and arg_823_1.var_.characterEffect1044ui_story == nil then
				arg_823_1.var_.characterEffect1044ui_story = var_826_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_826_11 = 0.200000002980232

			if var_826_10 <= arg_823_1.time_ and arg_823_1.time_ < var_826_10 + var_826_11 and not isNil(var_826_9) then
				local var_826_12 = (arg_823_1.time_ - var_826_10) / var_826_11

				if arg_823_1.var_.characterEffect1044ui_story and not isNil(var_826_9) then
					local var_826_13 = Mathf.Lerp(0, 0.5, var_826_12)

					arg_823_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_823_1.var_.characterEffect1044ui_story.fillRatio = var_826_13
				end
			end

			if arg_823_1.time_ >= var_826_10 + var_826_11 and arg_823_1.time_ < var_826_10 + var_826_11 + arg_826_0 and not isNil(var_826_9) and arg_823_1.var_.characterEffect1044ui_story then
				local var_826_14 = 0.5

				arg_823_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_823_1.var_.characterEffect1044ui_story.fillRatio = var_826_14
			end

			local var_826_15 = 0
			local var_826_16 = 1.175

			if var_826_15 < arg_823_1.time_ and arg_823_1.time_ <= var_826_15 + arg_826_0 then
				arg_823_1.talkMaxDuration = 0
				arg_823_1.dialogCg_.alpha = 1

				arg_823_1.dialog_:SetActive(true)
				SetActive(arg_823_1.leftNameGo_, false)

				arg_823_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_823_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_823_1:RecordName(arg_823_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_823_1.iconTrs_.gameObject, false)
				arg_823_1.callingController_:SetSelectedState("normal")

				local var_826_17 = arg_823_1:GetWordFromCfg(930011206)
				local var_826_18 = arg_823_1:FormatText(var_826_17.content)

				arg_823_1.text_.text = var_826_18

				LuaForUtil.ClearLinePrefixSymbol(arg_823_1.text_)

				local var_826_19 = 47
				local var_826_20 = utf8.len(var_826_18)
				local var_826_21 = var_826_19 <= 0 and var_826_16 or var_826_16 * (var_826_20 / var_826_19)

				if var_826_21 > 0 and var_826_16 < var_826_21 then
					arg_823_1.talkMaxDuration = var_826_21

					if var_826_21 + var_826_15 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_21 + var_826_15
					end
				end

				arg_823_1.text_.text = var_826_18
				arg_823_1.typewritter.percent = 0

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(false)
				arg_823_1:RecordContent(arg_823_1.text_.text)
			end

			local var_826_22 = math.max(var_826_16, arg_823_1.talkMaxDuration)

			if var_826_15 <= arg_823_1.time_ and arg_823_1.time_ < var_826_15 + var_826_22 then
				arg_823_1.typewritter.percent = (arg_823_1.time_ - var_826_15) / var_826_22

				arg_823_1.typewritter:SetDirty()
			end

			if arg_823_1.time_ >= var_826_15 + var_826_22 and arg_823_1.time_ < var_826_15 + var_826_22 + arg_826_0 then
				arg_823_1.typewritter.percent = 1

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(true)
			end
		end

		arg_823_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_823_1:InitPlayNodeList()
	end,
	Play930011207 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 930011207
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play930011208(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = arg_827_1.actors_["1044ui_story"].transform
			local var_830_1 = 0

			if var_830_1 < arg_827_1.time_ and arg_827_1.time_ <= var_830_1 + arg_830_0 then
				arg_827_1.var_.moveOldPos1044ui_story = var_830_0.localPosition
			end

			local var_830_2 = 0.001

			if var_830_1 <= arg_827_1.time_ and arg_827_1.time_ < var_830_1 + var_830_2 then
				local var_830_3 = (arg_827_1.time_ - var_830_1) / var_830_2
				local var_830_4 = Vector3.New(-0.7, -1, -5.93)

				var_830_0.localPosition = Vector3.Lerp(arg_827_1.var_.moveOldPos1044ui_story, var_830_4, var_830_3)

				local var_830_5 = manager.ui.mainCamera.transform.position - var_830_0.position

				var_830_0.forward = Vector3.New(var_830_5.x, var_830_5.y, var_830_5.z)

				local var_830_6 = var_830_0.localEulerAngles

				var_830_6.z = 0
				var_830_6.x = 0
				var_830_0.localEulerAngles = var_830_6
			end

			if arg_827_1.time_ >= var_830_1 + var_830_2 and arg_827_1.time_ < var_830_1 + var_830_2 + arg_830_0 then
				var_830_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_830_7 = manager.ui.mainCamera.transform.position - var_830_0.position

				var_830_0.forward = Vector3.New(var_830_7.x, var_830_7.y, var_830_7.z)

				local var_830_8 = var_830_0.localEulerAngles

				var_830_8.z = 0
				var_830_8.x = 0
				var_830_0.localEulerAngles = var_830_8
			end

			local var_830_9 = arg_827_1.actors_["1044ui_story"]
			local var_830_10 = 0

			if var_830_10 < arg_827_1.time_ and arg_827_1.time_ <= var_830_10 + arg_830_0 and not isNil(var_830_9) and arg_827_1.var_.characterEffect1044ui_story == nil then
				arg_827_1.var_.characterEffect1044ui_story = var_830_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_830_11 = 0.200000002980232

			if var_830_10 <= arg_827_1.time_ and arg_827_1.time_ < var_830_10 + var_830_11 and not isNil(var_830_9) then
				local var_830_12 = (arg_827_1.time_ - var_830_10) / var_830_11

				if arg_827_1.var_.characterEffect1044ui_story and not isNil(var_830_9) then
					arg_827_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_827_1.time_ >= var_830_10 + var_830_11 and arg_827_1.time_ < var_830_10 + var_830_11 + arg_830_0 and not isNil(var_830_9) and arg_827_1.var_.characterEffect1044ui_story then
				arg_827_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_830_13 = 0

			if var_830_13 < arg_827_1.time_ and arg_827_1.time_ <= var_830_13 + arg_830_0 then
				arg_827_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_830_14 = 0

			if var_830_14 < arg_827_1.time_ and arg_827_1.time_ <= var_830_14 + arg_830_0 then
				arg_827_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_830_15 = 0
			local var_830_16 = 0.525

			if var_830_15 < arg_827_1.time_ and arg_827_1.time_ <= var_830_15 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				local var_830_17 = arg_827_1:FormatText(StoryNameCfg[1367].name)

				arg_827_1.leftNameTxt_.text = var_830_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, false)
				arg_827_1.callingController_:SetSelectedState("normal")

				local var_830_18 = arg_827_1:GetWordFromCfg(930011207)
				local var_830_19 = arg_827_1:FormatText(var_830_18.content)

				arg_827_1.text_.text = var_830_19

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_20 = 21
				local var_830_21 = utf8.len(var_830_19)
				local var_830_22 = var_830_20 <= 0 and var_830_16 or var_830_16 * (var_830_21 / var_830_20)

				if var_830_22 > 0 and var_830_16 < var_830_22 then
					arg_827_1.talkMaxDuration = var_830_22

					if var_830_22 + var_830_15 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_22 + var_830_15
					end
				end

				arg_827_1.text_.text = var_830_19
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_23 = math.max(var_830_16, arg_827_1.talkMaxDuration)

			if var_830_15 <= arg_827_1.time_ and arg_827_1.time_ < var_830_15 + var_830_23 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - var_830_15) / var_830_23

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= var_830_15 + var_830_23 and arg_827_1.time_ < var_830_15 + var_830_23 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_827_1:InitPlayNodeList()
	end,
	Play930011208 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 930011208
		arg_831_1.duration_ = 5

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play930011209(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			local var_834_0 = arg_831_1.actors_["1028ui_story"].transform
			local var_834_1 = 0

			if var_834_1 < arg_831_1.time_ and arg_831_1.time_ <= var_834_1 + arg_834_0 then
				arg_831_1.var_.moveOldPos1028ui_story = var_834_0.localPosition
			end

			local var_834_2 = 0.001

			if var_834_1 <= arg_831_1.time_ and arg_831_1.time_ < var_834_1 + var_834_2 then
				local var_834_3 = (arg_831_1.time_ - var_834_1) / var_834_2
				local var_834_4 = Vector3.New(0.7, -0.9, -5.9)

				var_834_0.localPosition = Vector3.Lerp(arg_831_1.var_.moveOldPos1028ui_story, var_834_4, var_834_3)

				local var_834_5 = manager.ui.mainCamera.transform.position - var_834_0.position

				var_834_0.forward = Vector3.New(var_834_5.x, var_834_5.y, var_834_5.z)

				local var_834_6 = var_834_0.localEulerAngles

				var_834_6.z = 0
				var_834_6.x = 0
				var_834_0.localEulerAngles = var_834_6
			end

			if arg_831_1.time_ >= var_834_1 + var_834_2 and arg_831_1.time_ < var_834_1 + var_834_2 + arg_834_0 then
				var_834_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_834_7 = manager.ui.mainCamera.transform.position - var_834_0.position

				var_834_0.forward = Vector3.New(var_834_7.x, var_834_7.y, var_834_7.z)

				local var_834_8 = var_834_0.localEulerAngles

				var_834_8.z = 0
				var_834_8.x = 0
				var_834_0.localEulerAngles = var_834_8
			end

			local var_834_9 = arg_831_1.actors_["1028ui_story"]
			local var_834_10 = 0

			if var_834_10 < arg_831_1.time_ and arg_831_1.time_ <= var_834_10 + arg_834_0 and not isNil(var_834_9) and arg_831_1.var_.characterEffect1028ui_story == nil then
				arg_831_1.var_.characterEffect1028ui_story = var_834_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_834_11 = 0.200000002980232

			if var_834_10 <= arg_831_1.time_ and arg_831_1.time_ < var_834_10 + var_834_11 and not isNil(var_834_9) then
				local var_834_12 = (arg_831_1.time_ - var_834_10) / var_834_11

				if arg_831_1.var_.characterEffect1028ui_story and not isNil(var_834_9) then
					arg_831_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_831_1.time_ >= var_834_10 + var_834_11 and arg_831_1.time_ < var_834_10 + var_834_11 + arg_834_0 and not isNil(var_834_9) and arg_831_1.var_.characterEffect1028ui_story then
				arg_831_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_834_13 = arg_831_1.actors_["1044ui_story"]
			local var_834_14 = 0

			if var_834_14 < arg_831_1.time_ and arg_831_1.time_ <= var_834_14 + arg_834_0 and not isNil(var_834_13) and arg_831_1.var_.characterEffect1044ui_story == nil then
				arg_831_1.var_.characterEffect1044ui_story = var_834_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_834_15 = 0.200000002980232

			if var_834_14 <= arg_831_1.time_ and arg_831_1.time_ < var_834_14 + var_834_15 and not isNil(var_834_13) then
				local var_834_16 = (arg_831_1.time_ - var_834_14) / var_834_15

				if arg_831_1.var_.characterEffect1044ui_story and not isNil(var_834_13) then
					local var_834_17 = Mathf.Lerp(0, 0.5, var_834_16)

					arg_831_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_831_1.var_.characterEffect1044ui_story.fillRatio = var_834_17
				end
			end

			if arg_831_1.time_ >= var_834_14 + var_834_15 and arg_831_1.time_ < var_834_14 + var_834_15 + arg_834_0 and not isNil(var_834_13) and arg_831_1.var_.characterEffect1044ui_story then
				local var_834_18 = 0.5

				arg_831_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_831_1.var_.characterEffect1044ui_story.fillRatio = var_834_18
			end

			local var_834_19 = 0

			if var_834_19 < arg_831_1.time_ and arg_831_1.time_ <= var_834_19 + arg_834_0 then
				arg_831_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_834_20 = 0

			if var_834_20 < arg_831_1.time_ and arg_831_1.time_ <= var_834_20 + arg_834_0 then
				arg_831_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_834_21 = 0
			local var_834_22 = 0.375

			if var_834_21 < arg_831_1.time_ and arg_831_1.time_ <= var_834_21 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, true)

				local var_834_23 = arg_831_1:FormatText(StoryNameCfg[327].name)

				arg_831_1.leftNameTxt_.text = var_834_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_831_1.leftNameTxt_.transform)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1.leftNameTxt_.text)
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_24 = arg_831_1:GetWordFromCfg(930011208)
				local var_834_25 = arg_831_1:FormatText(var_834_24.content)

				arg_831_1.text_.text = var_834_25

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_26 = 15
				local var_834_27 = utf8.len(var_834_25)
				local var_834_28 = var_834_26 <= 0 and var_834_22 or var_834_22 * (var_834_27 / var_834_26)

				if var_834_28 > 0 and var_834_22 < var_834_28 then
					arg_831_1.talkMaxDuration = var_834_28

					if var_834_28 + var_834_21 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_28 + var_834_21
					end
				end

				arg_831_1.text_.text = var_834_25
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)
				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_29 = math.max(var_834_22, arg_831_1.talkMaxDuration)

			if var_834_21 <= arg_831_1.time_ and arg_831_1.time_ < var_834_21 + var_834_29 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_21) / var_834_29

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_21 + var_834_29 and arg_831_1.time_ < var_834_21 + var_834_29 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_831_1:InitPlayNodeList()
	end,
	Play930011209 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 930011209
		arg_835_1.duration_ = 5

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play930011210(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = arg_835_1.actors_["1028ui_story"].transform
			local var_838_1 = 0

			if var_838_1 < arg_835_1.time_ and arg_835_1.time_ <= var_838_1 + arg_838_0 then
				arg_835_1.var_.moveOldPos1028ui_story = var_838_0.localPosition
			end

			local var_838_2 = 0.001

			if var_838_1 <= arg_835_1.time_ and arg_835_1.time_ < var_838_1 + var_838_2 then
				local var_838_3 = (arg_835_1.time_ - var_838_1) / var_838_2
				local var_838_4 = Vector3.New(0, 100, 0)

				var_838_0.localPosition = Vector3.Lerp(arg_835_1.var_.moveOldPos1028ui_story, var_838_4, var_838_3)

				local var_838_5 = manager.ui.mainCamera.transform.position - var_838_0.position

				var_838_0.forward = Vector3.New(var_838_5.x, var_838_5.y, var_838_5.z)

				local var_838_6 = var_838_0.localEulerAngles

				var_838_6.z = 0
				var_838_6.x = 0
				var_838_0.localEulerAngles = var_838_6
			end

			if arg_835_1.time_ >= var_838_1 + var_838_2 and arg_835_1.time_ < var_838_1 + var_838_2 + arg_838_0 then
				var_838_0.localPosition = Vector3.New(0, 100, 0)

				local var_838_7 = manager.ui.mainCamera.transform.position - var_838_0.position

				var_838_0.forward = Vector3.New(var_838_7.x, var_838_7.y, var_838_7.z)

				local var_838_8 = var_838_0.localEulerAngles

				var_838_8.z = 0
				var_838_8.x = 0
				var_838_0.localEulerAngles = var_838_8
			end

			local var_838_9 = arg_835_1.actors_["1044ui_story"].transform
			local var_838_10 = 0

			if var_838_10 < arg_835_1.time_ and arg_835_1.time_ <= var_838_10 + arg_838_0 then
				arg_835_1.var_.moveOldPos1044ui_story = var_838_9.localPosition
			end

			local var_838_11 = 0.001

			if var_838_10 <= arg_835_1.time_ and arg_835_1.time_ < var_838_10 + var_838_11 then
				local var_838_12 = (arg_835_1.time_ - var_838_10) / var_838_11
				local var_838_13 = Vector3.New(0, 100, 0)

				var_838_9.localPosition = Vector3.Lerp(arg_835_1.var_.moveOldPos1044ui_story, var_838_13, var_838_12)

				local var_838_14 = manager.ui.mainCamera.transform.position - var_838_9.position

				var_838_9.forward = Vector3.New(var_838_14.x, var_838_14.y, var_838_14.z)

				local var_838_15 = var_838_9.localEulerAngles

				var_838_15.z = 0
				var_838_15.x = 0
				var_838_9.localEulerAngles = var_838_15
			end

			if arg_835_1.time_ >= var_838_10 + var_838_11 and arg_835_1.time_ < var_838_10 + var_838_11 + arg_838_0 then
				var_838_9.localPosition = Vector3.New(0, 100, 0)

				local var_838_16 = manager.ui.mainCamera.transform.position - var_838_9.position

				var_838_9.forward = Vector3.New(var_838_16.x, var_838_16.y, var_838_16.z)

				local var_838_17 = var_838_9.localEulerAngles

				var_838_17.z = 0
				var_838_17.x = 0
				var_838_9.localEulerAngles = var_838_17
			end

			local var_838_18 = arg_835_1.actors_["1028ui_story"]
			local var_838_19 = 0

			if var_838_19 < arg_835_1.time_ and arg_835_1.time_ <= var_838_19 + arg_838_0 and not isNil(var_838_18) and arg_835_1.var_.characterEffect1028ui_story == nil then
				arg_835_1.var_.characterEffect1028ui_story = var_838_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_838_20 = 0.200000002980232

			if var_838_19 <= arg_835_1.time_ and arg_835_1.time_ < var_838_19 + var_838_20 and not isNil(var_838_18) then
				local var_838_21 = (arg_835_1.time_ - var_838_19) / var_838_20

				if arg_835_1.var_.characterEffect1028ui_story and not isNil(var_838_18) then
					local var_838_22 = Mathf.Lerp(0, 0.5, var_838_21)

					arg_835_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_835_1.var_.characterEffect1028ui_story.fillRatio = var_838_22
				end
			end

			if arg_835_1.time_ >= var_838_19 + var_838_20 and arg_835_1.time_ < var_838_19 + var_838_20 + arg_838_0 and not isNil(var_838_18) and arg_835_1.var_.characterEffect1028ui_story then
				local var_838_23 = 0.5

				arg_835_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_835_1.var_.characterEffect1028ui_story.fillRatio = var_838_23
			end

			local var_838_24 = 0
			local var_838_25 = 1.025

			if var_838_24 < arg_835_1.time_ and arg_835_1.time_ <= var_838_24 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, false)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_835_1.iconTrs_.gameObject, false)
				arg_835_1.callingController_:SetSelectedState("normal")

				local var_838_26 = arg_835_1:GetWordFromCfg(930011209)
				local var_838_27 = arg_835_1:FormatText(var_838_26.content)

				arg_835_1.text_.text = var_838_27

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_28 = 41
				local var_838_29 = utf8.len(var_838_27)
				local var_838_30 = var_838_28 <= 0 and var_838_25 or var_838_25 * (var_838_29 / var_838_28)

				if var_838_30 > 0 and var_838_25 < var_838_30 then
					arg_835_1.talkMaxDuration = var_838_30

					if var_838_30 + var_838_24 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_30 + var_838_24
					end
				end

				arg_835_1.text_.text = var_838_27
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)
				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_31 = math.max(var_838_25, arg_835_1.talkMaxDuration)

			if var_838_24 <= arg_835_1.time_ and arg_835_1.time_ < var_838_24 + var_838_31 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - var_838_24) / var_838_31

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= var_838_24 + var_838_31 and arg_835_1.time_ < var_838_24 + var_838_31 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_835_1:InitPlayNodeList()
	end,
	Play930011210 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 930011210
		arg_839_1.duration_ = 5

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
			arg_839_1.auto_ = false
		end

		function arg_839_1.playNext_(arg_841_0)
			arg_839_1.onStoryFinished_()
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			local var_842_0 = arg_839_1.actors_["1028ui_story"].transform
			local var_842_1 = 0

			if var_842_1 < arg_839_1.time_ and arg_839_1.time_ <= var_842_1 + arg_842_0 then
				arg_839_1.var_.moveOldPos1028ui_story = var_842_0.localPosition
			end

			local var_842_2 = 0.001

			if var_842_1 <= arg_839_1.time_ and arg_839_1.time_ < var_842_1 + var_842_2 then
				local var_842_3 = (arg_839_1.time_ - var_842_1) / var_842_2
				local var_842_4 = Vector3.New(0.7, -0.9, -5.9)

				var_842_0.localPosition = Vector3.Lerp(arg_839_1.var_.moveOldPos1028ui_story, var_842_4, var_842_3)

				local var_842_5 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_5.x, var_842_5.y, var_842_5.z)

				local var_842_6 = var_842_0.localEulerAngles

				var_842_6.z = 0
				var_842_6.x = 0
				var_842_0.localEulerAngles = var_842_6
			end

			if arg_839_1.time_ >= var_842_1 + var_842_2 and arg_839_1.time_ < var_842_1 + var_842_2 + arg_842_0 then
				var_842_0.localPosition = Vector3.New(0.7, -0.9, -5.9)

				local var_842_7 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_7.x, var_842_7.y, var_842_7.z)

				local var_842_8 = var_842_0.localEulerAngles

				var_842_8.z = 0
				var_842_8.x = 0
				var_842_0.localEulerAngles = var_842_8
			end

			local var_842_9 = 0

			if var_842_9 < arg_839_1.time_ and arg_839_1.time_ <= var_842_9 + arg_842_0 then
				arg_839_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_842_10 = 0

			if var_842_10 < arg_839_1.time_ and arg_839_1.time_ <= var_842_10 + arg_842_0 then
				arg_839_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_842_11 = arg_839_1.actors_["1044ui_story"].transform
			local var_842_12 = 0

			if var_842_12 < arg_839_1.time_ and arg_839_1.time_ <= var_842_12 + arg_842_0 then
				arg_839_1.var_.moveOldPos1044ui_story = var_842_11.localPosition
			end

			local var_842_13 = 0.001

			if var_842_12 <= arg_839_1.time_ and arg_839_1.time_ < var_842_12 + var_842_13 then
				local var_842_14 = (arg_839_1.time_ - var_842_12) / var_842_13
				local var_842_15 = Vector3.New(-0.7, -1, -5.93)

				var_842_11.localPosition = Vector3.Lerp(arg_839_1.var_.moveOldPos1044ui_story, var_842_15, var_842_14)

				local var_842_16 = manager.ui.mainCamera.transform.position - var_842_11.position

				var_842_11.forward = Vector3.New(var_842_16.x, var_842_16.y, var_842_16.z)

				local var_842_17 = var_842_11.localEulerAngles

				var_842_17.z = 0
				var_842_17.x = 0
				var_842_11.localEulerAngles = var_842_17
			end

			if arg_839_1.time_ >= var_842_12 + var_842_13 and arg_839_1.time_ < var_842_12 + var_842_13 + arg_842_0 then
				var_842_11.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_842_18 = manager.ui.mainCamera.transform.position - var_842_11.position

				var_842_11.forward = Vector3.New(var_842_18.x, var_842_18.y, var_842_18.z)

				local var_842_19 = var_842_11.localEulerAngles

				var_842_19.z = 0
				var_842_19.x = 0
				var_842_11.localEulerAngles = var_842_19
			end

			local var_842_20 = arg_839_1.actors_["1044ui_story"]
			local var_842_21 = 0

			if var_842_21 < arg_839_1.time_ and arg_839_1.time_ <= var_842_21 + arg_842_0 and not isNil(var_842_20) and arg_839_1.var_.characterEffect1044ui_story == nil then
				arg_839_1.var_.characterEffect1044ui_story = var_842_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_22 = 0.200000002980232

			if var_842_21 <= arg_839_1.time_ and arg_839_1.time_ < var_842_21 + var_842_22 and not isNil(var_842_20) then
				local var_842_23 = (arg_839_1.time_ - var_842_21) / var_842_22

				if arg_839_1.var_.characterEffect1044ui_story and not isNil(var_842_20) then
					arg_839_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_839_1.time_ >= var_842_21 + var_842_22 and arg_839_1.time_ < var_842_21 + var_842_22 + arg_842_0 and not isNil(var_842_20) and arg_839_1.var_.characterEffect1044ui_story then
				arg_839_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_842_24 = 0

			if var_842_24 < arg_839_1.time_ and arg_839_1.time_ <= var_842_24 + arg_842_0 then
				arg_839_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_842_25 = 0

			if var_842_25 < arg_839_1.time_ and arg_839_1.time_ <= var_842_25 + arg_842_0 then
				arg_839_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_842_26 = 0
			local var_842_27 = 0.125

			if var_842_26 < arg_839_1.time_ and arg_839_1.time_ <= var_842_26 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				local var_842_28 = arg_839_1:FormatText(StoryNameCfg[1413].name)

				arg_839_1.leftNameTxt_.text = var_842_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_29 = arg_839_1:GetWordFromCfg(930011210)
				local var_842_30 = arg_839_1:FormatText(var_842_29.content)

				arg_839_1.text_.text = var_842_30

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_31 = 5
				local var_842_32 = utf8.len(var_842_30)
				local var_842_33 = var_842_31 <= 0 and var_842_27 or var_842_27 * (var_842_32 / var_842_31)

				if var_842_33 > 0 and var_842_27 < var_842_33 then
					arg_839_1.talkMaxDuration = var_842_33

					if var_842_33 + var_842_26 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_33 + var_842_26
					end
				end

				arg_839_1.text_.text = var_842_30
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)
				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_34 = math.max(var_842_27, arg_839_1.talkMaxDuration)

			if var_842_26 <= arg_839_1.time_ and arg_839_1.time_ < var_842_26 + var_842_34 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_26) / var_842_34

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_26 + var_842_34 and arg_839_1.time_ < var_842_26 + var_842_34 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_839_1:InitPlayNodeList()
	end,
	Play930011106 = function(arg_843_0, arg_843_1)
		arg_843_1.time_ = 0
		arg_843_1.frameCnt_ = 0
		arg_843_1.state_ = "playing"
		arg_843_1.curTalkId_ = 930011106
		arg_843_1.duration_ = 5

		SetActive(arg_843_1.tipsGo_, false)

		function arg_843_1.onSingleLineFinish_()
			arg_843_1.onSingleLineUpdate_ = nil
			arg_843_1.onSingleLineFinish_ = nil
			arg_843_1.state_ = "waiting"
		end

		function arg_843_1.playNext_(arg_845_0)
			if arg_845_0 == 1 then
				arg_843_0:Play930011107(arg_843_1)
			end
		end

		function arg_843_1.onSingleLineUpdate_(arg_846_0)
			local var_846_0 = 0
			local var_846_1 = 0.375

			if var_846_0 < arg_843_1.time_ and arg_843_1.time_ <= var_846_0 + arg_846_0 then
				arg_843_1.talkMaxDuration = 0
				arg_843_1.dialogCg_.alpha = 1

				arg_843_1.dialog_:SetActive(true)
				SetActive(arg_843_1.leftNameGo_, true)

				local var_846_2 = arg_843_1:FormatText(StoryNameCfg[1412].name)

				arg_843_1.leftNameTxt_.text = var_846_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_843_1.leftNameTxt_.transform)

				arg_843_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_843_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_843_1:RecordName(arg_843_1.leftNameTxt_.text)
				SetActive(arg_843_1.iconTrs_.gameObject, true)
				arg_843_1.iconController_:SetSelectedState("hero")

				arg_843_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10161")

				arg_843_1.callingController_:SetSelectedState("normal")

				arg_843_1.keyicon_.color = Color.New(1, 1, 1)
				arg_843_1.icon_.color = Color.New(1, 1, 1)

				local var_846_3 = arg_843_1:GetWordFromCfg(930011106)
				local var_846_4 = arg_843_1:FormatText(var_846_3.content)

				arg_843_1.text_.text = var_846_4

				LuaForUtil.ClearLinePrefixSymbol(arg_843_1.text_)

				local var_846_5 = 15
				local var_846_6 = utf8.len(var_846_4)
				local var_846_7 = var_846_5 <= 0 and var_846_1 or var_846_1 * (var_846_6 / var_846_5)

				if var_846_7 > 0 and var_846_1 < var_846_7 then
					arg_843_1.talkMaxDuration = var_846_7

					if var_846_7 + var_846_0 > arg_843_1.duration_ then
						arg_843_1.duration_ = var_846_7 + var_846_0
					end
				end

				arg_843_1.text_.text = var_846_4
				arg_843_1.typewritter.percent = 0

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(false)
				arg_843_1:RecordContent(arg_843_1.text_.text)
			end

			local var_846_8 = math.max(var_846_1, arg_843_1.talkMaxDuration)

			if var_846_0 <= arg_843_1.time_ and arg_843_1.time_ < var_846_0 + var_846_8 then
				arg_843_1.typewritter.percent = (arg_843_1.time_ - var_846_0) / var_846_8

				arg_843_1.typewritter:SetDirty()
			end

			if arg_843_1.time_ >= var_846_0 + var_846_8 and arg_843_1.time_ < var_846_0 + var_846_8 + arg_846_0 then
				arg_843_1.typewritter.percent = 1

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(true)
			end
		end

		arg_843_1.nodeConfigList_ = {}

		arg_843_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST05"
	},
	voices = {}
}
