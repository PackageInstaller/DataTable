return {
	Play910501012 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910501012
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910501013(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K05f"

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
				local var_4_5 = arg_1_1.bgs_.K05f

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
					if iter_4_0 ~= "K05f" then
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

			local var_4_22 = 1.999999999999

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_23 = 0.3

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_24 = "1055ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1055ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1055ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1055ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(-0.7, -0.965, -6.2)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1055ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -0.965, -6.2)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1055ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1055ui_story == nil then
				arg_1_1.var_.characterEffect1055ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1055ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1055ui_story then
				arg_1_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 1.999999999999
			local var_4_45 = 0.5

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_47 = arg_1_1:FormatText(StoryNameCfg[481].name)

				arg_1_1.leftNameTxt_.text = var_4_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_48 = arg_1_1:GetWordFromCfg(910501012)
				local var_4_49 = arg_1_1:FormatText(var_4_48.content)

				arg_1_1.text_.text = var_4_49

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_50 = 20
				local var_4_51 = utf8.len(var_4_49)
				local var_4_52 = var_4_50 <= 0 and var_4_45 or var_4_45 * (var_4_51 / var_4_50)

				if var_4_52 > 0 and var_4_45 < var_4_52 then
					arg_1_1.talkMaxDuration = var_4_52
					var_4_44 = var_4_44 + 0.3

					if var_4_52 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_52 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_49
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_53 = var_4_44 + 0.3
			local var_4_54 = math.max(var_4_45, arg_1_1.talkMaxDuration)

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_53) / var_4_54

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play910501013 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910501013
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910501014(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1093ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_10_1) then
					local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_7_1.stage_.transform)

					var_10_2.name = var_10_0
					var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_0] = var_10_2

					local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

					var_10_3.enabled = true

					local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

					if var_10_4 then
						var_10_4:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_3.transform, false)

					arg_7_1.var_[var_10_0 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_5 = arg_7_1.actors_["1093ui_story"].transform
			local var_10_6 = 0

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.var_.moveOldPos1093ui_story = var_10_5.localPosition
			end

			local var_10_7 = 0.001

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_7 then
				local var_10_8 = (arg_7_1.time_ - var_10_6) / var_10_7
				local var_10_9 = Vector3.New(0.7, -1.11, -5.88)

				var_10_5.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1093ui_story, var_10_9, var_10_8)

				local var_10_10 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_10.x, var_10_10.y, var_10_10.z)

				local var_10_11 = var_10_5.localEulerAngles

				var_10_11.z = 0
				var_10_11.x = 0
				var_10_5.localEulerAngles = var_10_11
			end

			if arg_7_1.time_ >= var_10_6 + var_10_7 and arg_7_1.time_ < var_10_6 + var_10_7 + arg_10_0 then
				var_10_5.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_10_12 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_12.x, var_10_12.y, var_10_12.z)

				local var_10_13 = var_10_5.localEulerAngles

				var_10_13.z = 0
				var_10_13.x = 0
				var_10_5.localEulerAngles = var_10_13
			end

			local var_10_14 = arg_7_1.actors_["1093ui_story"]
			local var_10_15 = 0

			if var_10_15 < arg_7_1.time_ and arg_7_1.time_ <= var_10_15 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1093ui_story == nil then
				arg_7_1.var_.characterEffect1093ui_story = var_10_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_16 = 0.200000002980232

			if var_10_15 <= arg_7_1.time_ and arg_7_1.time_ < var_10_15 + var_10_16 and not isNil(var_10_14) then
				local var_10_17 = (arg_7_1.time_ - var_10_15) / var_10_16

				if arg_7_1.var_.characterEffect1093ui_story and not isNil(var_10_14) then
					arg_7_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_15 + var_10_16 and arg_7_1.time_ < var_10_15 + var_10_16 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1093ui_story then
				arg_7_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_10_18 = arg_7_1.actors_["1055ui_story"]
			local var_10_19 = 0

			if var_10_19 < arg_7_1.time_ and arg_7_1.time_ <= var_10_19 + arg_10_0 and not isNil(var_10_18) and arg_7_1.var_.characterEffect1055ui_story == nil then
				arg_7_1.var_.characterEffect1055ui_story = var_10_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_20 = 0.200000002980232

			if var_10_19 <= arg_7_1.time_ and arg_7_1.time_ < var_10_19 + var_10_20 and not isNil(var_10_18) then
				local var_10_21 = (arg_7_1.time_ - var_10_19) / var_10_20

				if arg_7_1.var_.characterEffect1055ui_story and not isNil(var_10_18) then
					local var_10_22 = Mathf.Lerp(0, 0.5, var_10_21)

					arg_7_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1055ui_story.fillRatio = var_10_22
				end
			end

			if arg_7_1.time_ >= var_10_19 + var_10_20 and arg_7_1.time_ < var_10_19 + var_10_20 + arg_10_0 and not isNil(var_10_18) and arg_7_1.var_.characterEffect1055ui_story then
				local var_10_23 = 0.5

				arg_7_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1055ui_story.fillRatio = var_10_23
			end

			local var_10_24 = 0

			if var_10_24 < arg_7_1.time_ and arg_7_1.time_ <= var_10_24 + arg_10_0 then
				arg_7_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_10_25 = 0
			local var_10_26 = 0.85

			if var_10_25 < arg_7_1.time_ and arg_7_1.time_ <= var_10_25 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_27 = arg_7_1:FormatText(StoryNameCfg[73].name)

				arg_7_1.leftNameTxt_.text = var_10_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_28 = arg_7_1:GetWordFromCfg(910501013)
				local var_10_29 = arg_7_1:FormatText(var_10_28.content)

				arg_7_1.text_.text = var_10_29

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_30 = 34
				local var_10_31 = utf8.len(var_10_29)
				local var_10_32 = var_10_30 <= 0 and var_10_26 or var_10_26 * (var_10_31 / var_10_30)

				if var_10_32 > 0 and var_10_26 < var_10_32 then
					arg_7_1.talkMaxDuration = var_10_32

					if var_10_32 + var_10_25 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_32 + var_10_25
					end
				end

				arg_7_1.text_.text = var_10_29
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_33 = math.max(var_10_26, arg_7_1.talkMaxDuration)

			if var_10_25 <= arg_7_1.time_ and arg_7_1.time_ < var_10_25 + var_10_33 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_25) / var_10_33

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_25 + var_10_33 and arg_7_1.time_ < var_10_25 + var_10_33 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play910501014 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910501014
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910501015(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = arg_11_1.actors_["1093ui_story"]
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1093ui_story == nil then
				arg_11_1.var_.characterEffect1093ui_story = var_14_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 and not isNil(var_14_0) then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2

				if arg_11_1.var_.characterEffect1093ui_story and not isNil(var_14_0) then
					local var_14_4 = Mathf.Lerp(0, 0.5, var_14_3)

					arg_11_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1093ui_story.fillRatio = var_14_4
				end
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1093ui_story then
				local var_14_5 = 0.5

				arg_11_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1093ui_story.fillRatio = var_14_5
			end

			local var_14_6 = arg_11_1.actors_["1055ui_story"]
			local var_14_7 = 0

			if var_14_7 < arg_11_1.time_ and arg_11_1.time_ <= var_14_7 + arg_14_0 and not isNil(var_14_6) and arg_11_1.var_.characterEffect1055ui_story == nil then
				arg_11_1.var_.characterEffect1055ui_story = var_14_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_8 = 0.200000002980232

			if var_14_7 <= arg_11_1.time_ and arg_11_1.time_ < var_14_7 + var_14_8 and not isNil(var_14_6) then
				local var_14_9 = (arg_11_1.time_ - var_14_7) / var_14_8

				if arg_11_1.var_.characterEffect1055ui_story and not isNil(var_14_6) then
					arg_11_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_7 + var_14_8 and arg_11_1.time_ < var_14_7 + var_14_8 + arg_14_0 and not isNil(var_14_6) and arg_11_1.var_.characterEffect1055ui_story then
				arg_11_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_14_10 = 0
			local var_14_11 = 0.975

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_12 = arg_11_1:FormatText(StoryNameCfg[481].name)

				arg_11_1.leftNameTxt_.text = var_14_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_13 = arg_11_1:GetWordFromCfg(910501014)
				local var_14_14 = arg_11_1:FormatText(var_14_13.content)

				arg_11_1.text_.text = var_14_14

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_15 = 39
				local var_14_16 = utf8.len(var_14_14)
				local var_14_17 = var_14_15 <= 0 and var_14_11 or var_14_11 * (var_14_16 / var_14_15)

				if var_14_17 > 0 and var_14_11 < var_14_17 then
					arg_11_1.talkMaxDuration = var_14_17

					if var_14_17 + var_14_10 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_17 + var_14_10
					end
				end

				arg_11_1.text_.text = var_14_14
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_18 = math.max(var_14_11, arg_11_1.talkMaxDuration)

			if var_14_10 <= arg_11_1.time_ and arg_11_1.time_ < var_14_10 + var_14_18 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_10) / var_14_18

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_10 + var_14_18 and arg_11_1.time_ < var_14_10 + var_14_18 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play910501015 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910501015
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910501016(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1093ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1093ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0, 100, 0)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1093ui_story, var_18_4, var_18_3)

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

			local var_18_9 = arg_15_1.actors_["1055ui_story"]
			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1055ui_story == nil then
				arg_15_1.var_.characterEffect1055ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.200000002980232

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 and not isNil(var_18_9) then
				local var_18_12 = (arg_15_1.time_ - var_18_10) / var_18_11

				if arg_15_1.var_.characterEffect1055ui_story and not isNil(var_18_9) then
					local var_18_13 = Mathf.Lerp(0, 0.5, var_18_12)

					arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1055ui_story.fillRatio = var_18_13
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1055ui_story then
				local var_18_14 = 0.5

				arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1055ui_story.fillRatio = var_18_14
			end

			local var_18_15 = "1050ui_story"

			if arg_15_1.actors_[var_18_15] == nil then
				local var_18_16 = Asset.Load("Char/" .. "1050ui_story")

				if not isNil(var_18_16) then
					local var_18_17 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_15_1.stage_.transform)

					var_18_17.name = var_18_15
					var_18_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_15] = var_18_17

					local var_18_18 = var_18_17:GetComponentInChildren(typeof(CharacterEffect))

					var_18_18.enabled = true

					local var_18_19 = GameObjectTools.GetOrAddComponent(var_18_17, typeof(DynamicBoneHelper))

					if var_18_19 then
						var_18_19:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_18.transform, false)

					arg_15_1.var_[var_18_15 .. "Animator"] = var_18_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_15 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_15 .. "LipSync"] = var_18_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_20 = arg_15_1.actors_["1050ui_story"].transform
			local var_18_21 = 0

			if var_18_21 < arg_15_1.time_ and arg_15_1.time_ <= var_18_21 + arg_18_0 then
				arg_15_1.var_.moveOldPos1050ui_story = var_18_20.localPosition
			end

			local var_18_22 = 0.001

			if var_18_21 <= arg_15_1.time_ and arg_15_1.time_ < var_18_21 + var_18_22 then
				local var_18_23 = (arg_15_1.time_ - var_18_21) / var_18_22
				local var_18_24 = Vector3.New(0.7, -1, -6.1)

				var_18_20.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1050ui_story, var_18_24, var_18_23)

				local var_18_25 = manager.ui.mainCamera.transform.position - var_18_20.position

				var_18_20.forward = Vector3.New(var_18_25.x, var_18_25.y, var_18_25.z)

				local var_18_26 = var_18_20.localEulerAngles

				var_18_26.z = 0
				var_18_26.x = 0
				var_18_20.localEulerAngles = var_18_26
			end

			if arg_15_1.time_ >= var_18_21 + var_18_22 and arg_15_1.time_ < var_18_21 + var_18_22 + arg_18_0 then
				var_18_20.localPosition = Vector3.New(0.7, -1, -6.1)

				local var_18_27 = manager.ui.mainCamera.transform.position - var_18_20.position

				var_18_20.forward = Vector3.New(var_18_27.x, var_18_27.y, var_18_27.z)

				local var_18_28 = var_18_20.localEulerAngles

				var_18_28.z = 0
				var_18_28.x = 0
				var_18_20.localEulerAngles = var_18_28
			end

			local var_18_29 = arg_15_1.actors_["1050ui_story"]
			local var_18_30 = 0

			if var_18_30 < arg_15_1.time_ and arg_15_1.time_ <= var_18_30 + arg_18_0 and not isNil(var_18_29) and arg_15_1.var_.characterEffect1050ui_story == nil then
				arg_15_1.var_.characterEffect1050ui_story = var_18_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_31 = 0.200000002980232

			if var_18_30 <= arg_15_1.time_ and arg_15_1.time_ < var_18_30 + var_18_31 and not isNil(var_18_29) then
				local var_18_32 = (arg_15_1.time_ - var_18_30) / var_18_31

				if arg_15_1.var_.characterEffect1050ui_story and not isNil(var_18_29) then
					arg_15_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_30 + var_18_31 and arg_15_1.time_ < var_18_30 + var_18_31 + arg_18_0 and not isNil(var_18_29) and arg_15_1.var_.characterEffect1050ui_story then
				arg_15_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			local var_18_33 = 0

			if var_18_33 < arg_15_1.time_ and arg_15_1.time_ <= var_18_33 + arg_18_0 then
				arg_15_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_18_34 = 0
			local var_18_35 = 0.725

			if var_18_34 < arg_15_1.time_ and arg_15_1.time_ <= var_18_34 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_36 = arg_15_1:FormatText(StoryNameCfg[74].name)

				arg_15_1.leftNameTxt_.text = var_18_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_37 = arg_15_1:GetWordFromCfg(910501015)
				local var_18_38 = arg_15_1:FormatText(var_18_37.content)

				arg_15_1.text_.text = var_18_38

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_39 = 29
				local var_18_40 = utf8.len(var_18_38)
				local var_18_41 = var_18_39 <= 0 and var_18_35 or var_18_35 * (var_18_40 / var_18_39)

				if var_18_41 > 0 and var_18_35 < var_18_41 then
					arg_15_1.talkMaxDuration = var_18_41

					if var_18_41 + var_18_34 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_41 + var_18_34
					end
				end

				arg_15_1.text_.text = var_18_38
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_42 = math.max(var_18_35, arg_15_1.talkMaxDuration)

			if var_18_34 <= arg_15_1.time_ and arg_15_1.time_ < var_18_34 + var_18_42 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_34) / var_18_42

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_34 + var_18_42 and arg_15_1.time_ < var_18_34 + var_18_42 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play910501016 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910501016
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910501017(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1050ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1050ui_story == nil then
				arg_19_1.var_.characterEffect1050ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1050ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1050ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1050ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1050ui_story.fillRatio = var_22_5
			end

			local var_22_6 = 0
			local var_22_7 = 1.275

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_8 = arg_19_1:FormatText(StoryNameCfg[484].name)

				arg_19_1.leftNameTxt_.text = var_22_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_9 = arg_19_1:GetWordFromCfg(910501016)
				local var_22_10 = arg_19_1:FormatText(var_22_9.content)

				arg_19_1.text_.text = var_22_10

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 51
				local var_22_12 = utf8.len(var_22_10)
				local var_22_13 = var_22_11 <= 0 and var_22_7 or var_22_7 * (var_22_12 / var_22_11)

				if var_22_13 > 0 and var_22_7 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_10
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_14 and arg_19_1.time_ < var_22_6 + var_22_14 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play910501017 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910501017
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910501018(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.5

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[484].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_soldiera")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(910501017)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 20
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
	Play910501018 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910501018
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
			arg_27_1.auto_ = false
		end

		function arg_27_1.playNext_(arg_29_0)
			arg_27_1.onStoryFinished_()
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.25

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(910501018)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 10
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05f"
	},
	voices = {}
}
