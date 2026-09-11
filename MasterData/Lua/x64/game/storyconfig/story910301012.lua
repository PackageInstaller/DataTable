return {
	Play910302001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910302001
		arg_1_1.duration_ = 9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910302002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = 1
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_9 = 2

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_8) / var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_11.a = 0
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_13 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_13.name = var_4_12
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_12] = var_4_13

				local var_4_14 = var_4_13:GetComponentInChildren(typeof(CharacterEffect))

				var_4_14.enabled = true

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_13, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_14.transform, false)

				arg_1_1.var_[var_4_12 .. "Animator"] = var_4_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_16 = arg_1_1.actors_["1084ui_story"].transform

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_16.localPosition
			end

			local var_4_17 = 0.001

			if 4 <= arg_1_1.time_ and arg_1_1.time_ < 4 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_1_1.time_ - 4) / var_4_17)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			if arg_1_1.time_ >= 4 + var_4_17 and arg_1_1.time_ < 4 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_4_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_16.position).x, (manager.ui.mainCamera.transform.position - var_4_16.position).y, (manager.ui.mainCamera.transform.position - var_4_16.position).z)
				var_4_16.localEulerAngles.z = 0
				var_4_16.localEulerAngles.x = 0
				var_4_16.localEulerAngles = var_4_16.localEulerAngles
			end

			local var_4_18 = arg_1_1.actors_["1084ui_story"]

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 and not isNil(var_4_18) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_19 = 0.200000002980232

			if 4 <= arg_1_1.time_ and arg_1_1.time_ < 4 + var_4_19 and not isNil(var_4_18) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_18) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 4 + var_4_19 and arg_1_1.time_ < 4 + var_4_19 + arg_4_0 and not isNil(var_4_18) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_4_21 = "1066ui_story"

			if arg_1_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_4_22 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

				var_4_22.name = var_4_21
				var_4_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_21] = var_4_22

				local var_4_23 = var_4_22:GetComponentInChildren(typeof(CharacterEffect))

				var_4_23.enabled = true

				local var_4_24 = GameObjectTools.GetOrAddComponent(var_4_22, typeof(DynamicBoneHelper))

				if var_4_24 then
					var_4_24:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_23.transform, false)

				arg_1_1.var_[var_4_21 .. "Animator"] = var_4_23.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_21 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_21 .. "LipSync"] = var_4_23.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_25 = arg_1_1.actors_["1066ui_story"].transform

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_25.localPosition
			end

			local var_4_26 = 0.001

			if 4 <= arg_1_1.time_ and arg_1_1.time_ < 4 + var_4_26 then
				var_4_25.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_1_1.time_ - 4) / var_4_26)
				var_4_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_25.position).x, (manager.ui.mainCamera.transform.position - var_4_25.position).y, (manager.ui.mainCamera.transform.position - var_4_25.position).z)
				var_4_25.localEulerAngles.z = 0
				var_4_25.localEulerAngles.x = 0
				var_4_25.localEulerAngles = var_4_25.localEulerAngles
			end

			if arg_1_1.time_ >= 4 + var_4_26 and arg_1_1.time_ < 4 + var_4_26 + arg_4_0 then
				var_4_25.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_4_25.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_25.position).x, (manager.ui.mainCamera.transform.position - var_4_25.position).y, (manager.ui.mainCamera.transform.position - var_4_25.position).z)
				var_4_25.localEulerAngles.z = 0
				var_4_25.localEulerAngles.x = 0
				var_4_25.localEulerAngles = var_4_25.localEulerAngles
			end

			local var_4_27 = arg_1_1.actors_["1066ui_story"]

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 and not isNil(var_4_27) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_28 = 0.200000002980232

			if 4 <= arg_1_1.time_ and arg_1_1.time_ < 4 + var_4_28 and not isNil(var_4_27) then
				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_27) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_1_1.time_ - 4) / var_4_28)
				end
			end

			if arg_1_1.time_ >= 4 + var_4_28 and arg_1_1.time_ < 4 + var_4_28 + arg_4_0 and not isNil(var_4_27) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= 4 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_29 = 4
			local var_4_30 = 0.55

			if 4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_31 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_31:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_32 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910302001).content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 22 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_32) / 22)

				if (22 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_32) / 22)) > 0 and var_4_30 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34
					var_4_29 = var_4_29 + 0.3

					if var_4_34 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_29
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_29 + 0.3
			local var_4_36 = math.max(var_4_30, arg_1_1.talkMaxDuration)

			if var_4_29 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play910302002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910302002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910302003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1066ui_story = arg_7_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_10_0 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				arg_7_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).z)
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles = arg_7_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				arg_7_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_7_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).z)
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles = arg_7_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_10_1 = arg_7_1.actors_["1066ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect1066ui_story == nil then
				arg_7_1.var_.characterEffect1066ui_story = var_10_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_2 and not isNil(var_10_1) then
				if arg_7_1.var_.characterEffect1066ui_story and not isNil(var_10_1) then
					arg_7_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_2 and arg_7_1.time_ < 0 + var_10_2 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect1066ui_story then
				arg_7_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_4 = arg_7_1.actors_["1084ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_4) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_5 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_5 and not isNil(var_10_4) then
				if arg_7_1.var_.characterEffect1084ui_story and not isNil(var_10_4) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_5)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_5 and arg_7_1.time_ < 0 + var_10_5 + arg_10_0 and not isNil(var_10_4) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_10_6 = 0
			local var_10_7 = 0.575

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_8 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910302002).content)

				arg_7_1.text_.text = var_10_8

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 23 <= 0 and var_10_7 or var_10_7 * (utf8.len(var_10_8) / 23)

				if (23 <= 0 and var_10_7 or var_10_7 * (utf8.len(var_10_8) / 23)) > 0 and var_10_7 < var_10_10 then
					arg_7_1.talkMaxDuration = var_10_10

					if var_10_10 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_10 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_8
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_11 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_11 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_11

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_11 and arg_7_1.time_ < var_10_6 + var_10_11 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play910302003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910302003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910302004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1066ui_story"]) and arg_11_1.var_.characterEffect1066ui_story == nil then
				arg_11_1.var_.characterEffect1066ui_story = arg_11_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1066ui_story"]) then
				if arg_11_1.var_.characterEffect1066ui_story and not isNil(arg_11_1.actors_["1066ui_story"]) then
					arg_11_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_0)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1066ui_story"]) and arg_11_1.var_.characterEffect1066ui_story then
				arg_11_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_14_1 = arg_11_1.actors_["1084ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1084ui_story = var_14_1.localPosition
			end

			local var_14_2 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 then
				var_14_1.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_2)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 then
				var_14_1.localPosition = Vector3.New(0, 100, 0)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			local var_14_3 = arg_11_1.actors_["1066ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1066ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0, 100, 0)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = 0
			local var_14_6 = 1.15

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_5 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_7 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910302003).content)

				arg_11_1.text_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_9 = 46 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_7) / 46)

				if (46 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_7) / 46)) > 0 and var_14_6 < var_14_9 then
					arg_11_1.talkMaxDuration = var_14_9

					if var_14_9 + var_14_5 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_9 + var_14_5
					end
				end

				arg_11_1.text_.text = var_14_7
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_10 = math.max(var_14_6, arg_11_1.talkMaxDuration)

			if var_14_5 <= arg_11_1.time_ and arg_11_1.time_ < var_14_5 + var_14_10 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_5) / var_14_10

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_5 + var_14_10 and arg_11_1.time_ < var_14_5 + var_14_10 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play910302004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910302004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910302005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.825

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

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

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910302004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 33 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 33)

				if (33 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 33)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play910302005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910302005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910302006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1066ui_story = arg_19_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).z)
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles = arg_19_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_19_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).z)
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles = arg_19_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1066ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1066ui_story == nil then
				arg_19_1.var_.characterEffect1066ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1066ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1066ui_story then
				arg_19_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_22_4 = arg_19_1.actors_["1084ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1084ui_story = var_22_4.localPosition
			end

			local var_22_5 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 then
				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_19_1.time_ - 0) / var_22_5)
				var_22_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_4.position).x, (manager.ui.mainCamera.transform.position - var_22_4.position).y, (manager.ui.mainCamera.transform.position - var_22_4.position).z)
				var_22_4.localEulerAngles.z = 0
				var_22_4.localEulerAngles.x = 0
				var_22_4.localEulerAngles = var_22_4.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_5 and arg_19_1.time_ < 0 + var_22_5 + arg_22_0 then
				var_22_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_22_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_4.position).x, (manager.ui.mainCamera.transform.position - var_22_4.position).y, (manager.ui.mainCamera.transform.position - var_22_4.position).z)
				var_22_4.localEulerAngles.z = 0
				var_22_4.localEulerAngles.x = 0
				var_22_4.localEulerAngles = var_22_4.localEulerAngles
			end

			local var_22_6 = arg_19_1.actors_["1084ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_7 = 0.034000001847744

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 and not isNil(var_22_6) then
				if arg_19_1.var_.characterEffect1084ui_story and not isNil(var_22_6) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_7)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_22_8 = 0
			local var_22_9 = 0.45

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910302005).content)

				arg_19_1.text_.text = var_22_10

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_12 = 18 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_10) / 18)

				if (18 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_10) / 18)) > 0 and var_22_9 < var_22_12 then
					arg_19_1.talkMaxDuration = var_22_12

					if var_22_12 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_10
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_13 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_13 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_13

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_13 and arg_19_1.time_ < var_22_8 + var_22_13 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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

		arg_19_1:InitPlayNodeList()
	end,
	Play910302006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910302006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910302007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.075

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910302006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 43 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 43)

				if (43 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 43)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play910302007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910302007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910302008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = arg_27_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).z)
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles = arg_27_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_27_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).z)
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles = arg_27_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1084ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_30_4 = arg_27_1.actors_["1066ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1066ui_story == nil then
				arg_27_1.var_.characterEffect1066ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect1066ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1066ui_story then
				arg_27_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_30_6 = 0
			local var_30_7 = 1.025

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910302007).content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 41 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 41)

				if (41 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 41)) > 0 and var_30_7 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_11 and arg_27_1.time_ < var_30_6 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play910302008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910302008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910302009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1.3

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910302008).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 52 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 52)

				if (52 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 52)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play910302009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910302009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910302010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = arg_35_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) then
				if arg_35_1.var_.characterEffect1084ui_story and not isNil(arg_35_1.actors_["1084ui_story"]) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1084ui_story"]) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_38_1 = 0
			local var_38_2 = 0.825

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910302009).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 33 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 33)

				if (33 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 33)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play910302010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910302010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910302011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_42_0 = 0
			local var_42_1 = 0.9

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_2 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910302010).content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 36 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_2) / 36)

				if (36 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_2) / 36)) > 0 and var_42_1 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_5 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_5 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_5

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_5 and arg_39_1.time_ < var_42_0 + var_42_5 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play910302011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910302011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910302012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910302011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 46 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 46)

				if (46 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 46)) > 0 and var_46_0 < var_46_3 then
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
	Play910302012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910302012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910302013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1066ui_story = arg_47_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).z)
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles = arg_47_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_47_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1066ui_story"].transform.position).z)
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1066ui_story"].transform.localEulerAngles = arg_47_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1066ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1066ui_story == nil then
				arg_47_1.var_.characterEffect1066ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1066ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1066ui_story then
				arg_47_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = 0
			local var_50_5 = 0.475

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910302012).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 19 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 19)

				if (19 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 19)) > 0 and var_50_5 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8

					if var_50_8 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_9 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_9

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_9 and arg_47_1.time_ < var_50_4 + var_50_9 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play910302013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910302013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910302014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.075

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(910302013).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 43 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 43)

				if (43 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 43)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play910302014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910302014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910302015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = arg_55_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).z)
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles = arg_55_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).z)
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles = arg_55_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1066ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1066ui_story = var_58_1.localPosition
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_2)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0, 100, 0)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			local var_58_3 = 0
			local var_58_4 = 0.625

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_5 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(910302014).content)

				arg_55_1.text_.text = var_58_5

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_7 = 25 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_5) / 25)

				if (25 <= 0 and var_58_4 or var_58_4 * (utf8.len(var_58_5) / 25)) > 0 and var_58_4 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_3 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_3
					end
				end

				arg_55_1.text_.text = var_58_5
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_4, arg_55_1.talkMaxDuration)

			if var_58_3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_3 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_3) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_3 + var_58_8 and arg_55_1.time_ < var_58_3 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play910302015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910302015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910302016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1084ui_story = arg_59_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).z)
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles = arg_59_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_59_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1084ui_story"].transform.position).z)
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1084ui_story"].transform.localEulerAngles = arg_59_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1084ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1084ui_story == nil then
				arg_59_1.var_.characterEffect1084ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1084ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1084ui_story then
				arg_59_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.725

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(910302015).content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 29 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 29)

				if (29 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 29)) > 0 and var_62_5 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_6
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_9 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_9 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_9

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_9 and arg_59_1.time_ < var_62_4 + var_62_9 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play910302016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910302016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910302017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = arg_63_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) then
				if arg_63_1.var_.characterEffect1084ui_story and not isNil(arg_63_1.actors_["1084ui_story"]) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.95

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(910302016).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 38 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 38)

				if (38 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 38)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play910302017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910302017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910302018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.825

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(910302017).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 33)

				if (33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 33)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play910302018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910302018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play910302019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1066ui_story = arg_71_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).z)
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles = arg_71_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_71_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1066ui_story"].transform.position).z)
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1066ui_story"].transform.localEulerAngles = arg_71_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1066ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1066ui_story == nil then
				arg_71_1.var_.characterEffect1066ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1066ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1066ui_story then
				arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_74_4 = arg_71_1.actors_["1084ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_4.localPosition
			end

			local var_74_5 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 then
				var_74_4.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_5)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 then
				var_74_4.localPosition = Vector3.New(0, 100, 0)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			local var_74_6 = 0
			local var_74_7 = 0.525

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(910302018).content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 21 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 21)

				if (21 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 21)) > 0 and var_74_7 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_11 and arg_71_1.time_ < var_74_6 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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

		arg_71_1:InitPlayNodeList()
	end,
	Play910302019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910302019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play910302020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.5

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(910302019).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 20)

				if (20 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 20)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play910302020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 910302020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play910302021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = arg_79_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).z)
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles = arg_79_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_79_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).z)
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles = arg_79_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1084ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_82_4 = arg_79_1.actors_["1066ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1066ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0, 100, 0)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			local var_82_6 = 0
			local var_82_7 = 0.975

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(910302020).content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 39 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_8) / 39)

				if (39 <= 0 and var_82_7 or var_82_7 * (utf8.len(var_82_8) / 39)) > 0 and var_82_7 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_11 and arg_79_1.time_ < var_82_6 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play910302021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 910302021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play910302022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1066ui_story = arg_83_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).z)
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles = arg_83_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_83_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).z)
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles = arg_83_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1066ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1066ui_story == nil then
				arg_83_1.var_.characterEffect1066ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1066ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1066ui_story then
				arg_83_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_86_4 = arg_83_1.actors_["1084ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_5 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_5 and not isNil(var_86_4) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_4) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_5)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_5 and arg_83_1.time_ < 0 + var_86_5 + arg_86_0 and not isNil(var_86_4) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_86_6 = arg_83_1.actors_["1084ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1084ui_story = var_86_6.localPosition
			end

			local var_86_7 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				var_86_6.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_7)
				var_86_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_6.position).x, (manager.ui.mainCamera.transform.position - var_86_6.position).y, (manager.ui.mainCamera.transform.position - var_86_6.position).z)
				var_86_6.localEulerAngles.z = 0
				var_86_6.localEulerAngles.x = 0
				var_86_6.localEulerAngles = var_86_6.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				var_86_6.localPosition = Vector3.New(0, 100, 0)
				var_86_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_6.position).x, (manager.ui.mainCamera.transform.position - var_86_6.position).y, (manager.ui.mainCamera.transform.position - var_86_6.position).z)
				var_86_6.localEulerAngles.z = 0
				var_86_6.localEulerAngles.x = 0
				var_86_6.localEulerAngles = var_86_6.localEulerAngles
			end

			local var_86_8 = 0
			local var_86_9 = 0.925

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(910302021).content)

				arg_83_1.text_.text = var_86_10

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_12 = 37 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_10) / 37)

				if (37 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_10) / 37)) > 0 and var_86_9 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_10
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_13 and arg_83_1.time_ < var_86_8 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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

		arg_83_1:InitPlayNodeList()
	end,
	Play910302022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 910302022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play910302023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.6

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(910302022).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 24 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 24)

				if (24 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 24)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play910302023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 910302023
		arg_91_1.duration_ = 5

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
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_94_0 = 0
			local var_94_1 = 0.4

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(910302023).content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 16 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_2) / 16)

				if (16 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_2) / 16)) > 0 and var_94_1 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_5 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_5 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_5

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_5 and arg_91_1.time_ < var_94_0 + var_94_5 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13"
	},
	voices = {}
}
