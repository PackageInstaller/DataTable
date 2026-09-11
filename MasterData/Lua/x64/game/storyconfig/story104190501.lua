return {
	Play419051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 419051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play419051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18a")
				var_4_0.name = "ST18a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST18a

				arg_1_1.bgs_.ST18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_9 = 2
			local var_4_10 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_11 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_11:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_12 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419051001).content)

				arg_1_1.text_.text = var_4_12

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_14 = 15 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 15)

				if (15 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 15)) > 0 and var_4_10 < var_4_14 then
					arg_1_1.talkMaxDuration = var_4_14
					var_4_9 = var_4_9 + 0.3

					if var_4_14 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_9
					end
				end

				arg_1_1.text_.text = var_4_12
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_15 = var_4_9 + 0.3
			local var_4_16 = math.max(var_4_10, arg_1_1.talkMaxDuration)

			if var_4_9 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_15) / var_4_16

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play419051002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 419051002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play419051003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1066ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1066ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1066ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1066ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1066ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1066ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -0.77, -6.1)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			local var_10_5 = arg_7_1.actors_["1066ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1066ui_story == nil then
				arg_7_1.var_.characterEffect1066ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect1066ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1066ui_story then
				arg_7_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_10_8 = 0
			local var_10_9 = 0.95

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
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

				local var_10_10 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(419051002).content)

				arg_7_1.text_.text = var_10_10

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_12 = 38 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_10) / 38)

				if (38 <= 0 and var_10_9 or var_10_9 * (utf8.len(var_10_10) / 38)) > 0 and var_10_9 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_8 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_8
					end
				end

				arg_7_1.text_.text = var_10_10
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_13 = math.max(var_10_9, arg_7_1.talkMaxDuration)

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_13 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_8) / var_10_13

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_8 + var_10_13 and arg_7_1.time_ < var_10_8 + var_10_13 + arg_10_0 then
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
	Play419051003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 419051003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play419051004(arg_11_1)
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

			local var_14_1 = 0
			local var_14_2 = 0.55

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[7].name)

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

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(419051003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 22 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 22)

				if (22 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 22)) > 0 and var_14_2 < var_14_5 then
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

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play419051004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 419051004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play419051005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1066ui_story"]) and arg_15_1.var_.characterEffect1066ui_story == nil then
				arg_15_1.var_.characterEffect1066ui_story = arg_15_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1066ui_story"]) then
				if arg_15_1.var_.characterEffect1066ui_story and not isNil(arg_15_1.actors_["1066ui_story"]) then
					arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1066ui_story"]) and arg_15_1.var_.characterEffect1066ui_story then
				arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_18_2 = 0
			local var_18_3 = 0.525

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_4 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(419051004).content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 21 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 21)

				if (21 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 21)) > 0 and var_18_3 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_7 and arg_15_1.time_ < var_18_2 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play419051005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 419051005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play419051006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.325

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
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

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(419051005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 13 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 13)

				if (13 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 13)) > 0 and var_22_0 < var_22_3 then
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
	Play419051006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 419051006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play419051007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1066ui_story = arg_23_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).z)
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles = arg_23_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).z)
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles = arg_23_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1066ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1066ui_story == nil then
				arg_23_1.var_.characterEffect1066ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1066ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1066ui_story then
				arg_23_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_26_3 = 0
			local var_26_4 = 0.85

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_5 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(419051006).content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 34 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 34)

				if (34 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 34)) > 0 and var_26_4 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_3 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_3
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_4, arg_23_1.talkMaxDuration)

			if var_26_3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_3 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_3) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_3 + var_26_8 and arg_23_1.time_ < var_26_3 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play419051007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 419051007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play419051008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1046ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1046ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1046ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1046ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1046ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1046ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1046ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1046ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1046ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1046ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0, -1, -6.1)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["1046ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1046ui_story == nil then
				arg_27_1.var_.characterEffect1046ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1046ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1046ui_story then
				arg_27_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_30_8 = 0
			local var_30_9 = 0.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(419051007).content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_12 = 6 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_10) / 6)

				if (6 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_10) / 6)) > 0 and var_30_9 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_13 and arg_27_1.time_ < var_30_8 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 419051008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play419051009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1046ui_story = arg_31_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).z)
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles = arg_31_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1046ui_story"].transform.position).z)
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1046ui_story"].transform.localEulerAngles = arg_31_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1046ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1046ui_story == nil then
				arg_31_1.var_.characterEffect1046ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1046ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1046ui_story then
				arg_31_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_34_3 = 0
			local var_34_4 = 0.4

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(419051008).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 16 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 16)

				if (16 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 16)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 419051009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play419051010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.7

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(419051009).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 28)

				if (28 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 28)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play419051010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 419051010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play419051011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.7

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
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

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(419051010).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 28 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 28)

				if (28 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 28)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play419051011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 419051011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play419051012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1046ui_story = arg_43_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1046ui_story, Vector3.New(-0.7, -1, -6.1), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).z)
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles = arg_43_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_43_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1046ui_story"].transform.position).z)
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1046ui_story"].transform.localEulerAngles = arg_43_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1046ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1046ui_story == nil then
				arg_43_1.var_.characterEffect1046ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1046ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1046ui_story then
				arg_43_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_46_4 = 0
			local var_46_5 = 0.525

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(419051011).content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 29 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 29)

				if (29 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 29)) > 0 and var_46_5 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_6
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_9 and arg_43_1.time_ < var_46_4 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 419051012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play419051013(arg_47_1)
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

			local var_50_4 = arg_47_1.actors_["1046ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1046ui_story == nil then
				arg_47_1.var_.characterEffect1046ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1046ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1046ui_story then
				arg_47_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_50_6 = 0
			local var_50_7 = 0.65

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
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

				local var_50_8 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(419051012).content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 26 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 26)

				if (26 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 26)) > 0 and var_50_7 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_11 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_11 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_11

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_11 and arg_47_1.time_ < var_50_6 + var_50_11 + arg_50_0 then
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
	Play419051013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 419051013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play419051014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1066ui_story"]) and arg_51_1.var_.characterEffect1066ui_story == nil then
				arg_51_1.var_.characterEffect1066ui_story = arg_51_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1066ui_story"]) then
				if arg_51_1.var_.characterEffect1066ui_story and not isNil(arg_51_1.actors_["1066ui_story"]) then
					arg_51_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1066ui_story"]) and arg_51_1.var_.characterEffect1066ui_story then
				arg_51_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.85

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(419051013).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 34 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 34)

				if (34 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 34)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play419051014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 419051014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play419051015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.825

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

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

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(419051014).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 33 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 33)

				if (33 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 33)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play419051015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 419051015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play419051016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1066ui_story = arg_59_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).z)
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles = arg_59_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0.7, -0.77, -6.1)
				arg_59_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1066ui_story"].transform.position).z)
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1066ui_story"].transform.localEulerAngles = arg_59_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1066ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1066ui_story == nil then
				arg_59_1.var_.characterEffect1066ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1066ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1066ui_story then
				arg_59_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action448")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_62_4 = 0
			local var_62_5 = 0.8

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(419051015).content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 32 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 32)

				if (32 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 32)) > 0 and var_62_5 < var_62_8 then
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
				actorName = "1066ui_story",
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
	Play419051016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 419051016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play419051017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action8_2")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_66_0 = 0
			local var_66_1 = 0.65

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(419051016).content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 26 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_2) / 26)

				if (26 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_2) / 26)) > 0 and var_66_1 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_5 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_5 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_5

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_5 and arg_63_1.time_ < var_66_0 + var_66_5 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play419051017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 419051017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play419051018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1066ui_story = arg_67_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).z)
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles = arg_67_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1066ui_story"].transform.position).z)
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1066ui_story"].transform.localEulerAngles = arg_67_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1046ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1046ui_story = var_70_1.localPosition
			end

			local var_70_2 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 then
				var_70_1.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_2)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 then
				var_70_1.localPosition = Vector3.New(0, 100, 0)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			local var_70_3 = arg_67_1.actors_["1066ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1066ui_story == nil then
				arg_67_1.var_.characterEffect1066ui_story = var_70_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 and not isNil(var_70_3) then
				if arg_67_1.var_.characterEffect1066ui_story and not isNil(var_70_3) then
					arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_4)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1066ui_story then
				arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_70_5 = 0
			local var_70_6 = 0.9

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(419051017).content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 36 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_7) / 36)

				if (36 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_7) / 36)) > 0 and var_70_6 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_6, arg_67_1.talkMaxDuration)

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_5) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_5 + var_70_10 and arg_67_1.time_ < var_70_5 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play419051018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 419051018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play419051019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_74_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_71_1.stage_.transform)

				var_74_0.name = "1284ui_story"
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1284ui_story"] = var_74_0

				local var_74_1 = var_74_0:GetComponentInChildren(typeof(CharacterEffect))

				var_74_1.enabled = true

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_1.transform, false)

				arg_71_1.var_["1284ui_story" .. "Animator"] = var_74_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_71_1.var_["1284ui_story" .. "LipSync"] = var_74_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_3 = arg_71_1.actors_["1284ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1284ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_71_1.time_ - 0) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			local var_74_5 = arg_71_1.actors_["1284ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1284ui_story == nil then
				arg_71_1.var_.characterEffect1284ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.characterEffect1284ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1284ui_story then
				arg_71_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_74_8 = 0
			local var_74_9 = 0.35

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(419051018).content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 14 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_10) / 14)

				if (14 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_10) / 14)) > 0 and var_74_9 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_13 and arg_71_1.time_ < var_74_8 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 419051019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play419051020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1284ui_story"]) and arg_75_1.var_.characterEffect1284ui_story == nil then
				arg_75_1.var_.characterEffect1284ui_story = arg_75_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1284ui_story"]) then
				if arg_75_1.var_.characterEffect1284ui_story and not isNil(arg_75_1.actors_["1284ui_story"]) then
					arg_75_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1284ui_story"]) and arg_75_1.var_.characterEffect1284ui_story then
				arg_75_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.725

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(419051019).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 29 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 29)

				if (29 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 29)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play419051020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 419051020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play419051021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(419051020).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 23 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 23)

				if (23 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 23)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play419051021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 419051021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play419051022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1284ui_story = arg_83_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).z)
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles = arg_83_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_83_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1284ui_story"].transform.position).z)
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1284ui_story"].transform.localEulerAngles = arg_83_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1284ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1284ui_story == nil then
				arg_83_1.var_.characterEffect1284ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1284ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1284ui_story then
				arg_83_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_86_4 = 0
			local var_86_5 = 0.45

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(419051021).content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 18 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 18)

				if (18 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 18)) > 0 and var_86_5 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_9 and arg_83_1.time_ < var_86_4 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 419051022
		arg_87_1.duration_ = 9

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play419051023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.ST12 == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_90_0.name = "ST12"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.ST12 = var_90_0
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.ST12

				arg_87_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "ST12" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 4

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_4 + 0.3 and arg_87_1.time_ < var_90_4 + 0.3 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_5 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_6 = 2

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_5) / var_90_6)
				arg_87_1.mask_.color = var_90_7
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = 1
				arg_87_1.mask_.color = var_90_8
			end

			local var_90_9 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_10 = 2

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 then
				local var_90_11 = Color.New(0, 0, 0)

				var_90_11.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_9) / var_90_10)
				arg_87_1.mask_.color = var_90_11
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 then
				local var_90_12 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_12.a = 0
				arg_87_1.mask_.color = var_90_12
			end

			local var_90_13 = arg_87_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_87_1.time_ and arg_87_1.time_ <= 1.96599999815226 + arg_90_0 then
				arg_87_1.var_.moveOldPos1284ui_story = var_90_13.localPosition
			end

			local var_90_14 = 0.001

			if 1.96599999815226 <= arg_87_1.time_ and arg_87_1.time_ < 1.96599999815226 + var_90_14 then
				var_90_13.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 1.96599999815226) / var_90_14)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			if arg_87_1.time_ >= 1.96599999815226 + var_90_14 and arg_87_1.time_ < 1.96599999815226 + var_90_14 + arg_90_0 then
				var_90_13.localPosition = Vector3.New(0, 100, 0)
				var_90_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_13.position).x, (manager.ui.mainCamera.transform.position - var_90_13.position).y, (manager.ui.mainCamera.transform.position - var_90_13.position).z)
				var_90_13.localEulerAngles.z = 0
				var_90_13.localEulerAngles.x = 0
				var_90_13.localEulerAngles = var_90_13.localEulerAngles
			end

			local var_90_15 = arg_87_1.actors_["1284ui_story"]

			if 1.96599999815226 < arg_87_1.time_ and arg_87_1.time_ <= 1.96599999815226 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1284ui_story == nil then
				arg_87_1.var_.characterEffect1284ui_story = var_90_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_16 = 0.034000001847744

			if 1.96599999815226 <= arg_87_1.time_ and arg_87_1.time_ < 1.96599999815226 + var_90_16 and not isNil(var_90_15) then
				if arg_87_1.var_.characterEffect1284ui_story and not isNil(var_90_15) then
					arg_87_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 1.96599999815226) / var_90_16)
				end
			end

			if arg_87_1.time_ >= 1.96599999815226 + var_90_16 and arg_87_1.time_ < 1.96599999815226 + var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1284ui_story then
				arg_87_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_17 = 4
			local var_90_18 = 1.1

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_17 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_19 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_19:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_20 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(419051022).content)

				arg_87_1.text_.text = var_90_20

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_22 = 44 <= 0 and var_90_18 or var_90_18 * (utf8.len(var_90_20) / 44)

				if (44 <= 0 and var_90_18 or var_90_18 * (utf8.len(var_90_20) / 44)) > 0 and var_90_18 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22
					var_90_17 = var_90_17 + 0.3

					if var_90_22 + var_90_17 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_17
					end
				end

				arg_87_1.text_.text = var_90_20
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_23 = var_90_17 + 0.3
			local var_90_24 = math.max(var_90_18, arg_87_1.talkMaxDuration)

			if var_90_17 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_23) / var_90_24

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play419051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 419051023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play419051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0.05 < arg_93_1.time_ and arg_93_1.time_ <= 0.05 + arg_96_0 then
				arg_93_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_96_1 = 0
			local var_96_2 = 1.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(419051023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 52 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 52)

				if (52 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 52)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play419051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 419051024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play419051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(419051024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 15 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 15)

				if (15 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 15)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play419051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 419051025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play419051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1046ui_story = arg_101_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).z)
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles = arg_101_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_101_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1046ui_story"].transform.position).z)
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1046ui_story"].transform.localEulerAngles = arg_101_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1046ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1046ui_story == nil then
				arg_101_1.var_.characterEffect1046ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1046ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1046ui_story then
				arg_101_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_2")
			end

			local var_104_4 = "1045ui_story"

			if arg_101_1.actors_["1045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1045ui_story"))) then
				local var_104_5 = Object.Instantiate(Asset.Load("Char/" .. "1045ui_story"), arg_101_1.stage_.transform)

				var_104_5.name = var_104_4
				var_104_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_[var_104_4] = var_104_5

				local var_104_6 = var_104_5:GetComponentInChildren(typeof(CharacterEffect))

				var_104_6.enabled = true

				local var_104_7 = GameObjectTools.GetOrAddComponent(var_104_5, typeof(DynamicBoneHelper))

				if var_104_7 then
					var_104_7:EnableDynamicBone(false)
				end

				arg_101_1:ShowWeapon(var_104_6.transform, false)

				arg_101_1.var_[var_104_4 .. "Animator"] = var_104_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_101_1.var_[var_104_4 .. "Animator"].applyRootMotion = true
				arg_101_1.var_[var_104_4 .. "LipSync"] = var_104_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_8 = 0
			local var_104_9 = 0.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(419051025).content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 20 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_10) / 20)

				if (20 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_10) / 20)) > 0 and var_104_9 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_13 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_13 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_13

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_13 and arg_101_1.time_ < var_104_8 + var_104_13 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play419051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 419051026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play419051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1046ui_story"]) and arg_105_1.var_.characterEffect1046ui_story == nil then
				arg_105_1.var_.characterEffect1046ui_story = arg_105_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1046ui_story"]) then
				if arg_105_1.var_.characterEffect1046ui_story and not isNil(arg_105_1.actors_["1046ui_story"]) then
					arg_105_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1046ui_story"]) and arg_105_1.var_.characterEffect1046ui_story then
				arg_105_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(419051026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 27 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 27)

				if (27 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 27)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play419051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 419051027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play419051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1284ui_story = arg_109_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).z)
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles = arg_109_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_109_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1284ui_story"].transform.position).z)
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1284ui_story"].transform.localEulerAngles = arg_109_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1046ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1046ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_2)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, 100, 0)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			local var_112_3 = arg_109_1.actors_["1284ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1284ui_story == nil then
				arg_109_1.var_.characterEffect1284ui_story = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect1284ui_story and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1284ui_story then
				arg_109_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_112_6 = 0
			local var_112_7 = 1.35

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(419051027).content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 54 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_8) / 54)

				if (54 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_8) / 54)) > 0 and var_112_7 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_11 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_11 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_11

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_11 and arg_109_1.time_ < var_112_6 + var_112_11 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play419051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 419051028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play419051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1284ui_story"]) and arg_113_1.var_.characterEffect1284ui_story == nil then
				arg_113_1.var_.characterEffect1284ui_story = arg_113_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1284ui_story"]) then
				if arg_113_1.var_.characterEffect1284ui_story and not isNil(arg_113_1.actors_["1284ui_story"]) then
					arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1284ui_story"]) and arg_113_1.var_.characterEffect1284ui_story then
				arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.95

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(419051028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 38 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 38)

				if (38 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 38)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play419051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 419051029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play419051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1284ui_story"]) and arg_117_1.var_.characterEffect1284ui_story == nil then
				arg_117_1.var_.characterEffect1284ui_story = arg_117_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1284ui_story"]) then
				if arg_117_1.var_.characterEffect1284ui_story and not isNil(arg_117_1.actors_["1284ui_story"]) then
					arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1284ui_story"]) and arg_117_1.var_.characterEffect1284ui_story then
				arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 0.425

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(419051029).content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 17 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 17)

				if (17 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_4) / 17)) > 0 and var_120_3 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_7 and arg_117_1.time_ < var_120_2 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play419051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 419051030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play419051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1284ui_story"]) and arg_121_1.var_.characterEffect1284ui_story == nil then
				arg_121_1.var_.characterEffect1284ui_story = arg_121_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1284ui_story"]) then
				if arg_121_1.var_.characterEffect1284ui_story and not isNil(arg_121_1.actors_["1284ui_story"]) then
					arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1284ui_story"]) and arg_121_1.var_.characterEffect1284ui_story then
				arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(419051030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 5 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 5)

				if (5 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 5)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play419051031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 419051031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play419051032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_128_0 = 0
			local var_128_1 = 0.975

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_2 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(419051031).content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 39 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_2) / 39)

				if (39 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_2) / 39)) > 0 and var_128_1 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_5 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_5 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_5

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_5 and arg_125_1.time_ < var_128_0 + var_128_5 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play419051032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 419051032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play419051033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1046ui_story = arg_129_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).z)
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles = arg_129_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_129_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1046ui_story"].transform.position).z)
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1046ui_story"].transform.localEulerAngles = arg_129_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1046ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1046ui_story == nil then
				arg_129_1.var_.characterEffect1046ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1046ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1046ui_story then
				arg_129_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046actionlink/1046action424")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_132_4 = arg_129_1.actors_["1284ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1284ui_story = var_132_4.localPosition
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_5)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0, 100, 0)
				var_132_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_4.position).x, (manager.ui.mainCamera.transform.position - var_132_4.position).y, (manager.ui.mainCamera.transform.position - var_132_4.position).z)
				var_132_4.localEulerAngles.z = 0
				var_132_4.localEulerAngles.x = 0
				var_132_4.localEulerAngles = var_132_4.localEulerAngles
			end

			local var_132_6 = 0
			local var_132_7 = 1.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(419051032).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 56 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 56)

				if (56 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 56)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 419051033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play419051034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_2")
			end

			local var_136_0 = 0
			local var_136_1 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(419051033).content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 14 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_2) / 14)

				if (14 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_2) / 14)) > 0 and var_136_1 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_5 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_5 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_5

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_5 and arg_133_1.time_ < var_136_0 + var_136_5 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play419051034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 419051034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play419051035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1046ui_story"]) and arg_137_1.var_.characterEffect1046ui_story == nil then
				arg_137_1.var_.characterEffect1046ui_story = arg_137_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1046ui_story"]) then
				if arg_137_1.var_.characterEffect1046ui_story and not isNil(arg_137_1.actors_["1046ui_story"]) then
					arg_137_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1046ui_story"]) and arg_137_1.var_.characterEffect1046ui_story then
				arg_137_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(419051034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 36 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 36)

				if (36 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 36)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play419051035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 419051035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play419051036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(419051035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 5 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 5)

				if (5 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 5)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play419051036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 419051036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play419051037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1046ui_story = arg_145_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).z)
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles = arg_145_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_145_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1046ui_story"].transform.position).z)
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1046ui_story"].transform.localEulerAngles = arg_145_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1046ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1046ui_story == nil then
				arg_145_1.var_.characterEffect1046ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1046ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1046ui_story then
				arg_145_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 1.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(419051036).content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_8 = 47 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 47)

				if (47 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 47)) > 0 and var_148_5 < var_148_8 then
					arg_145_1.talkMaxDuration = var_148_8

					if var_148_8 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_9 and arg_145_1.time_ < var_148_4 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 419051037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play419051038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1046ui_story"]) and arg_149_1.var_.characterEffect1046ui_story == nil then
				arg_149_1.var_.characterEffect1046ui_story = arg_149_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1046ui_story"]) then
				if arg_149_1.var_.characterEffect1046ui_story and not isNil(arg_149_1.actors_["1046ui_story"]) then
					arg_149_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1046ui_story"]) and arg_149_1.var_.characterEffect1046ui_story then
				arg_149_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.75

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(419051037).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 30 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 30)

				if (30 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 30)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play419051038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 419051038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play419051039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1046ui_story"]) and arg_153_1.var_.characterEffect1046ui_story == nil then
				arg_153_1.var_.characterEffect1046ui_story = arg_153_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1046ui_story"]) then
				if arg_153_1.var_.characterEffect1046ui_story and not isNil(arg_153_1.actors_["1046ui_story"]) then
					arg_153_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1046ui_story"]) and arg_153_1.var_.characterEffect1046ui_story then
				arg_153_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_156_2 = 0
			local var_156_3 = 1.175

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_4 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(419051038).content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 49 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 49)

				if (49 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_4) / 49)) > 0 and var_156_3 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_7 and arg_153_1.time_ < var_156_2 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play419051039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 419051039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play419051040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.725

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(419051039).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 33 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 33)

				if (33 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 33)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play419051040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 419051040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play419051041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action3_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_164_0 = 0
			local var_164_1 = 0.675

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(419051040).content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 35 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_2) / 35)

				if (35 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_2) / 35)) > 0 and var_164_1 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_5 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_5 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_5

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_5 and arg_161_1.time_ < var_164_0 + var_164_5 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play419051041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 419051041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play419051042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1046ui_story"]) and arg_165_1.var_.characterEffect1046ui_story == nil then
				arg_165_1.var_.characterEffect1046ui_story = arg_165_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1046ui_story"]) then
				if arg_165_1.var_.characterEffect1046ui_story and not isNil(arg_165_1.actors_["1046ui_story"]) then
					arg_165_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1046ui_story"]) and arg_165_1.var_.characterEffect1046ui_story then
				arg_165_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.675

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(419051041).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 27 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 27)

				if (27 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 27)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play419051042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 419051042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play419051043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1046ui_story = arg_169_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).z)
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles = arg_169_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_169_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1046ui_story"].transform.position).z)
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1046ui_story"].transform.localEulerAngles = arg_169_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1046ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1046ui_story == nil then
				arg_169_1.var_.characterEffect1046ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1046ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1046ui_story then
				arg_169_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action3_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_172_4 = 0
			local var_172_5 = 0.2

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(419051042).content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_8 = 15 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_6) / 15)

				if (15 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_6) / 15)) > 0 and var_172_5 < var_172_8 then
					arg_169_1.talkMaxDuration = var_172_8

					if var_172_8 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_9 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_9 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_9

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_9 and arg_169_1.time_ < var_172_4 + var_172_9 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 419051043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play419051044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1046ui_story = arg_173_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).z)
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles = arg_173_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1046ui_story"].transform.position).z)
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1046ui_story"].transform.localEulerAngles = arg_173_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1284ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1284ui_story = var_176_1.localPosition
			end

			local var_176_2 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 then
				var_176_1.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 then
				var_176_1.localPosition = Vector3.New(0, 100, 0)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			local var_176_3 = arg_173_1.actors_["1046ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1046ui_story == nil then
				arg_173_1.var_.characterEffect1046ui_story = var_176_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_3) then
				if arg_173_1.var_.characterEffect1046ui_story and not isNil(var_176_3) then
					arg_173_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_4)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1046ui_story then
				arg_173_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_176_5 = 0
			local var_176_6 = 1.05

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_7 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(419051043).content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 42 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 42)

				if (42 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_7) / 42)) > 0 and var_176_6 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_10 and arg_173_1.time_ < var_176_5 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 419051044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play419051045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1046ui_story = arg_177_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).z)
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles = arg_177_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_177_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1046ui_story"].transform.position).z)
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1046ui_story"].transform.localEulerAngles = arg_177_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1046ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1046ui_story == nil then
				arg_177_1.var_.characterEffect1046ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1046ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1046ui_story then
				arg_177_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_180_4 = 0
			local var_180_5 = 0.9

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(419051044).content)

				arg_177_1.text_.text = var_180_6

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_8 = 36 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_6) / 36)

				if (36 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_6) / 36)) > 0 and var_180_5 < var_180_8 then
					arg_177_1.talkMaxDuration = var_180_8

					if var_180_8 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_6
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_9 and arg_177_1.time_ < var_180_4 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 419051045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play419051046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.2

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(419051045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)

				if (48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play419051046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 419051046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play419051047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1046ui_story = arg_185_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).z)
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles = arg_185_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_185_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1046ui_story"].transform.position).z)
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1046ui_story"].transform.localEulerAngles = arg_185_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_2")
			end

			local var_188_1 = 0
			local var_188_2 = 0.775

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(419051046).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 24 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 24)

				if (24 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 24)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play419051047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 419051047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play419051048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1046ui_story = arg_189_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).z)
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles = arg_189_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_189_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1046ui_story"].transform.position).z)
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1046ui_story"].transform.localEulerAngles = arg_189_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_192_1 = 0
			local var_192_2 = 0.825

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(419051047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 47 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 47)

				if (47 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 47)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play419051048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 419051048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play419051049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1046ui_story"]) and arg_193_1.var_.characterEffect1046ui_story == nil then
				arg_193_1.var_.characterEffect1046ui_story = arg_193_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1046ui_story"]) then
				if arg_193_1.var_.characterEffect1046ui_story and not isNil(arg_193_1.actors_["1046ui_story"]) then
					arg_193_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1046ui_story"]) and arg_193_1.var_.characterEffect1046ui_story then
				arg_193_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 1.05

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(419051048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 42 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 42)

				if (42 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 42)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play419051049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 419051049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play419051050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1284ui_story = arg_197_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).z)
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles = arg_197_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_197_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1284ui_story"].transform.position).z)
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1284ui_story"].transform.localEulerAngles = arg_197_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1046ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1046ui_story = var_200_1.localPosition
			end

			local var_200_2 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 then
				var_200_1.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1046ui_story, Vector3.New(-0.7, -1, -6.1), (arg_197_1.time_ - 0) / var_200_2)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 then
				var_200_1.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			local var_200_3 = arg_197_1.actors_["1284ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1284ui_story == nil then
				arg_197_1.var_.characterEffect1284ui_story = var_200_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_4 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 and not isNil(var_200_3) then
				if arg_197_1.var_.characterEffect1284ui_story and not isNil(var_200_3) then
					arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1284ui_story then
				arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 0.125

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(419051049).content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 5 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 5)

				if (5 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 5)) > 0 and var_200_7 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_11 and arg_197_1.time_ < var_200_6 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 419051050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play419051051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1284ui_story"]) and arg_201_1.var_.characterEffect1284ui_story == nil then
				arg_201_1.var_.characterEffect1284ui_story = arg_201_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1284ui_story"]) then
				if arg_201_1.var_.characterEffect1284ui_story and not isNil(arg_201_1.actors_["1284ui_story"]) then
					arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1284ui_story"]) and arg_201_1.var_.characterEffect1284ui_story then
				arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(419051050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 5 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 5)

				if (5 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 5)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play419051051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 419051051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play419051052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1046ui_story = arg_205_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).z)
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles = arg_205_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1046ui_story"].transform.position).z)
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1046ui_story"].transform.localEulerAngles = arg_205_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1284ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1284ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(0, 100, 0)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			local var_208_3 = 0
			local var_208_4 = 0.775

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_5 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(419051051).content)

				arg_205_1.text_.text = var_208_5

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_7 = 31 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 31)

				if (31 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_5) / 31)) > 0 and var_208_4 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_3
					end
				end

				arg_205_1.text_.text = var_208_5
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_8 = math.max(var_208_4, arg_205_1.talkMaxDuration)

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_8 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_3) / var_208_8

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_3 + var_208_8 and arg_205_1.time_ < var_208_3 + var_208_8 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 419051052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play419051053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1046ui_story = arg_209_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).z)
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles = arg_209_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_209_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1046ui_story"].transform.position).z)
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1046ui_story"].transform.localEulerAngles = arg_209_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1046ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1046ui_story == nil then
				arg_209_1.var_.characterEffect1046ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1046ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1046ui_story then
				arg_209_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action2_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.175

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(419051052).content)

				arg_209_1.text_.text = var_212_6

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 7 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 7)

				if (7 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 7)) > 0 and var_212_5 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_6
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_9 and arg_209_1.time_ < var_212_4 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play419051053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 419051053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play419051054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1046ui_story"]) and arg_213_1.var_.characterEffect1046ui_story == nil then
				arg_213_1.var_.characterEffect1046ui_story = arg_213_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1046ui_story"]) then
				if arg_213_1.var_.characterEffect1046ui_story and not isNil(arg_213_1.actors_["1046ui_story"]) then
					arg_213_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1046ui_story"]) and arg_213_1.var_.characterEffect1046ui_story then
				arg_213_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(419051053).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 34 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 34)

				if (34 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 34)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play419051054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 419051054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play419051055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.2

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(419051054).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 8 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 8)

				if (8 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 8)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play419051055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 419051055
		arg_221_1.duration_ = 9

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play419051056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.bgs_.I05 == nil then
				local var_224_0 = Object.Instantiate(arg_221_1.paintGo_)

				var_224_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05")
				var_224_0.name = "I05"
				var_224_0.transform.parent = arg_221_1.stage_.transform
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.bgs_.I05 = var_224_0
			end

			if 2.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= 2.00000000298023 + arg_224_0 then
				local var_224_1 = arg_221_1.bgs_.I05

				arg_221_1.bgs_.I05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_2 = var_224_1:GetComponent("SpriteRenderer")

				if var_224_2 and var_224_2.sprite then
					local var_224_3 = 2 * (var_224_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_1.transform.localScale = Vector3.New(var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "I05" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_4 = 4.00000000298023

			if 4.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_4 + 0.3 and arg_221_1.time_ < var_224_4 + 0.3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_5 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_6 = 2

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 then
				local var_224_7 = Color.New(0, 0, 0)

				var_224_7.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_5) / var_224_6)
				arg_221_1.mask_.color = var_224_7
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 then
				local var_224_8 = Color.New(0, 0, 0)

				var_224_8.a = 1
				arg_221_1.mask_.color = var_224_8
			end

			local var_224_9 = 2

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_10 = 2

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_10 then
				local var_224_11 = Color.New(0, 0, 0)

				var_224_11.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_9) / var_224_10)
				arg_221_1.mask_.color = var_224_11
			end

			if arg_221_1.time_ >= var_224_9 + var_224_10 and arg_221_1.time_ < var_224_9 + var_224_10 + arg_224_0 then
				local var_224_12 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_12.a = 0
				arg_221_1.mask_.color = var_224_12
			end

			local var_224_13 = arg_221_1.actors_["1046ui_story"].transform

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1.var_.moveOldPos1046ui_story = var_224_13.localPosition
			end

			local var_224_14 = 0.001

			if 1.96599999815226 <= arg_221_1.time_ and arg_221_1.time_ < 1.96599999815226 + var_224_14 then
				var_224_13.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 1.96599999815226) / var_224_14)
				var_224_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_13.position).x, (manager.ui.mainCamera.transform.position - var_224_13.position).y, (manager.ui.mainCamera.transform.position - var_224_13.position).z)
				var_224_13.localEulerAngles.z = 0
				var_224_13.localEulerAngles.x = 0
				var_224_13.localEulerAngles = var_224_13.localEulerAngles
			end

			if arg_221_1.time_ >= 1.96599999815226 + var_224_14 and arg_221_1.time_ < 1.96599999815226 + var_224_14 + arg_224_0 then
				var_224_13.localPosition = Vector3.New(0, 100, 0)
				var_224_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_13.position).x, (manager.ui.mainCamera.transform.position - var_224_13.position).y, (manager.ui.mainCamera.transform.position - var_224_13.position).z)
				var_224_13.localEulerAngles.z = 0
				var_224_13.localEulerAngles.x = 0
				var_224_13.localEulerAngles = var_224_13.localEulerAngles
			end

			local var_224_15 = arg_221_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1.var_.moveOldPos1284ui_story = var_224_15.localPosition
			end

			local var_224_16 = 0.001

			if 1.96599999815226 <= arg_221_1.time_ and arg_221_1.time_ < 1.96599999815226 + var_224_16 then
				var_224_15.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 1.96599999815226) / var_224_16)
				var_224_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_15.position).x, (manager.ui.mainCamera.transform.position - var_224_15.position).y, (manager.ui.mainCamera.transform.position - var_224_15.position).z)
				var_224_15.localEulerAngles.z = 0
				var_224_15.localEulerAngles.x = 0
				var_224_15.localEulerAngles = var_224_15.localEulerAngles
			end

			if arg_221_1.time_ >= 1.96599999815226 + var_224_16 and arg_221_1.time_ < 1.96599999815226 + var_224_16 + arg_224_0 then
				var_224_15.localPosition = Vector3.New(0, 100, 0)
				var_224_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_15.position).x, (manager.ui.mainCamera.transform.position - var_224_15.position).y, (manager.ui.mainCamera.transform.position - var_224_15.position).z)
				var_224_15.localEulerAngles.z = 0
				var_224_15.localEulerAngles.x = 0
				var_224_15.localEulerAngles = var_224_15.localEulerAngles
			end

			local var_224_17 = arg_221_1.actors_["1284ui_story"]

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.characterEffect1284ui_story == nil then
				arg_221_1.var_.characterEffect1284ui_story = var_224_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_18 = 0.200000002980232

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_18 and not isNil(var_224_17) then
				if arg_221_1.var_.characterEffect1284ui_story and not isNil(var_224_17) then
					arg_221_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 3.8 + var_224_18 and arg_221_1.time_ < 3.8 + var_224_18 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.characterEffect1284ui_story then
				arg_221_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_224_20 = arg_221_1.actors_["1284ui_story"].transform

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1.var_.moveOldPos1284ui_story = var_224_20.localPosition
			end

			local var_224_21 = 0.001

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_21 then
				var_224_20.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_221_1.time_ - 3.8) / var_224_21)
				var_224_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_20.position).x, (manager.ui.mainCamera.transform.position - var_224_20.position).y, (manager.ui.mainCamera.transform.position - var_224_20.position).z)
				var_224_20.localEulerAngles.z = 0
				var_224_20.localEulerAngles.x = 0
				var_224_20.localEulerAngles = var_224_20.localEulerAngles
			end

			if arg_221_1.time_ >= 3.8 + var_224_21 and arg_221_1.time_ < 3.8 + var_224_21 + arg_224_0 then
				var_224_20.localPosition = Vector3.New(0, -0.985, -6.22)
				var_224_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_20.position).x, (manager.ui.mainCamera.transform.position - var_224_20.position).y, (manager.ui.mainCamera.transform.position - var_224_20.position).z)
				var_224_20.localEulerAngles.z = 0
				var_224_20.localEulerAngles.x = 0
				var_224_20.localEulerAngles = var_224_20.localEulerAngles
			end

			if 0.05 < arg_221_1.time_ and arg_221_1.time_ <= 0.05 + arg_224_0 then
				arg_221_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.56666666666667 < arg_221_1.time_ and arg_221_1.time_ <= 1.56666666666667 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_224_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_221_1.bgmTxt_.text ~= var_224_26 and arg_221_1.bgmTxt_.text ~= "" then
						if arg_221_1.bgmTxt2_.text ~= "" then
							arg_221_1.bgmTxt_.text = arg_221_1.bgmTxt2_.text
						end

						arg_221_1.bgmTxt2_.text = var_224_26

						arg_221_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_221_1.bgmTxt_.text = var_224_26
						arg_221_1.bgmTxt2_.text = var_224_26
					end

					if arg_221_1.bgmTimer then
						arg_221_1.bgmTimer:Stop()

						arg_221_1.bgmTimer = nil
					end

					if arg_221_1.settingData.show_music_name == 1 then
						arg_221_1.musicController:SetSelectedState("show")
						arg_221_1.musicAnimator_:Play("open", 0, 0)

						if arg_221_1.settingData.music_time ~= 0 then
							arg_221_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_221_1.settingData.music_time), function()
								if arg_221_1 == nil or isNil(arg_221_1.bgmTxt_) then
									return
								end

								arg_221_1.musicController:SetSelectedState("hide")
								arg_221_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 0.333333333333333 + arg_224_0 then
				arg_221_1:AudioAction("play", "music", "bgm_activity_4_2_story_battle", "bgm_activity_4_2_story_battle", "bgm_activity_4_2_story_battle.awb")

				local var_224_29 = manager.audio:GetAudioName("bgm_activity_4_2_story_battle", "bgm_activity_4_2_story_battle")

				if "" ~= "" then
					if arg_221_1.bgmTxt_.text ~= var_224_29 and arg_221_1.bgmTxt_.text ~= "" then
						if arg_221_1.bgmTxt2_.text ~= "" then
							arg_221_1.bgmTxt_.text = arg_221_1.bgmTxt2_.text
						end

						arg_221_1.bgmTxt2_.text = var_224_29

						arg_221_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_221_1.bgmTxt_.text = var_224_29
						arg_221_1.bgmTxt2_.text = var_224_29
					end

					if arg_221_1.bgmTimer then
						arg_221_1.bgmTimer:Stop()

						arg_221_1.bgmTimer = nil
					end

					if arg_221_1.settingData.show_music_name == 1 then
						arg_221_1.musicController:SetSelectedState("show")
						arg_221_1.musicAnimator_:Play("open", 0, 0)

						if arg_221_1.settingData.music_time ~= 0 then
							arg_221_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_221_1.settingData.music_time), function()
								if arg_221_1 == nil or isNil(arg_221_1.bgmTxt_) then
									return
								end

								arg_221_1.musicController:SetSelectedState("hide")
								arg_221_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_30 = 4.00000000298023
			local var_224_31 = 0.35

			if 4.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_32 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_32:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_221_1.dialogCg_.alpha = arg_227_0
				end))
				var_224_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_33 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(419051055).content)

				arg_221_1.text_.text = var_224_33

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_35 = 14 <= 0 and var_224_31 or var_224_31 * (utf8.len(var_224_33) / 14)

				if (14 <= 0 and var_224_31 or var_224_31 * (utf8.len(var_224_33) / 14)) > 0 and var_224_31 < var_224_35 then
					arg_221_1.talkMaxDuration = var_224_35
					var_224_30 = var_224_30 + 0.3

					if var_224_35 + var_224_30 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_35 + var_224_30
					end
				end

				arg_221_1.text_.text = var_224_33
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_36 = var_224_30 + 0.3
			local var_224_37 = math.max(var_224_31, arg_221_1.talkMaxDuration)

			if var_224_30 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_36 + var_224_37 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_36) / var_224_37

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_36 + var_224_37 and arg_221_1.time_ < var_224_36 + var_224_37 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play419051056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 419051056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play419051057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1046ui_story = arg_229_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1046ui_story, Vector3.New(0.7, -1, -6.1), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).z)
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles = arg_229_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_229_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1046ui_story"].transform.position).z)
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1046ui_story"].transform.localEulerAngles = arg_229_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1284ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1284ui_story = var_232_1.localPosition
			end

			local var_232_2 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 then
				var_232_1.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_229_1.time_ - 0) / var_232_2)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 then
				var_232_1.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			local var_232_3 = arg_229_1.actors_["1046ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1046ui_story == nil then
				arg_229_1.var_.characterEffect1046ui_story = var_232_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_4 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 and not isNil(var_232_3) then
				if arg_229_1.var_.characterEffect1046ui_story and not isNil(var_232_3) then
					arg_229_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1046ui_story then
				arg_229_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_232_6 = arg_229_1.actors_["1284ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1284ui_story == nil then
				arg_229_1.var_.characterEffect1284ui_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_7 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 and not isNil(var_232_6) then
				if arg_229_1.var_.characterEffect1284ui_story and not isNil(var_232_6) then
					arg_229_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_7)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1284ui_story then
				arg_229_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_232_8 = 0
			local var_232_9 = 0.575

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_10 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(419051056).content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_12 = 23 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_10) / 23)

				if (23 <= 0 and var_232_9 or var_232_9 * (utf8.len(var_232_10) / 23)) > 0 and var_232_9 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12

					if var_232_12 + var_232_8 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_8
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_9, arg_229_1.talkMaxDuration)

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_8) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_8 + var_232_13 and arg_229_1.time_ < var_232_8 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play419051057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 419051057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play419051058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1284ui_story"]) and arg_233_1.var_.characterEffect1284ui_story == nil then
				arg_233_1.var_.characterEffect1284ui_story = arg_233_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1284ui_story"]) then
				if arg_233_1.var_.characterEffect1284ui_story and not isNil(arg_233_1.actors_["1284ui_story"]) then
					arg_233_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1284ui_story"]) and arg_233_1.var_.characterEffect1284ui_story then
				arg_233_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1046ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1046ui_story == nil then
				arg_233_1.var_.characterEffect1046ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1046ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1046ui_story then
				arg_233_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_236_4 = 0
			local var_236_5 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(419051057).content)

				arg_233_1.text_.text = var_236_6

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 18 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 18)

				if (18 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 18)) > 0 and var_236_5 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_6
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_9 and arg_233_1.time_ < var_236_4 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play419051058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 419051058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play419051059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_2")
			end

			local var_240_0 = 0
			local var_240_1 = 0.775

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(419051058).content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 31 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_2) / 31)

				if (31 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_2) / 31)) > 0 and var_240_1 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_5 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_5 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_5

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_5 and arg_237_1.time_ < var_240_0 + var_240_5 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play419051059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 419051059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play419051060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1284ui_story"]) and arg_241_1.var_.characterEffect1284ui_story == nil then
				arg_241_1.var_.characterEffect1284ui_story = arg_241_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1284ui_story"]) then
				if arg_241_1.var_.characterEffect1284ui_story and not isNil(arg_241_1.actors_["1284ui_story"]) then
					arg_241_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1284ui_story"]) and arg_241_1.var_.characterEffect1284ui_story then
				arg_241_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_244_1 = 0
			local var_244_2 = 0.825

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(419051059).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 33 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 33)

				if (33 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 33)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play419051060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 419051060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play419051061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1046ui_story"]) and arg_245_1.var_.characterEffect1046ui_story == nil then
				arg_245_1.var_.characterEffect1046ui_story = arg_245_1.actors_["1046ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1046ui_story"]) then
				if arg_245_1.var_.characterEffect1046ui_story and not isNil(arg_245_1.actors_["1046ui_story"]) then
					arg_245_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1046ui_story"]) and arg_245_1.var_.characterEffect1046ui_story then
				arg_245_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			local var_248_2 = 0
			local var_248_3 = 0.125

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(419051060).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 5 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 5)

				if (5 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 5)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play419051061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 419051061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play419051062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1046ui_story = arg_249_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).z)
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles = arg_249_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1046ui_story"].transform.position).z)
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1046ui_story"].transform.localEulerAngles = arg_249_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1284ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1284ui_story = var_252_1.localPosition
			end

			local var_252_2 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 then
				var_252_1.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_2)
				var_252_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_1.position).x, (manager.ui.mainCamera.transform.position - var_252_1.position).y, (manager.ui.mainCamera.transform.position - var_252_1.position).z)
				var_252_1.localEulerAngles.z = 0
				var_252_1.localEulerAngles.x = 0
				var_252_1.localEulerAngles = var_252_1.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 then
				var_252_1.localPosition = Vector3.New(0, 100, 0)
				var_252_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_1.position).x, (manager.ui.mainCamera.transform.position - var_252_1.position).y, (manager.ui.mainCamera.transform.position - var_252_1.position).z)
				var_252_1.localEulerAngles.z = 0
				var_252_1.localEulerAngles.x = 0
				var_252_1.localEulerAngles = var_252_1.localEulerAngles
			end

			local var_252_3 = arg_249_1.actors_["1046ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect1046ui_story == nil then
				arg_249_1.var_.characterEffect1046ui_story = var_252_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 and not isNil(var_252_3) then
				if arg_249_1.var_.characterEffect1046ui_story and not isNil(var_252_3) then
					arg_249_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_4)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect1046ui_story then
				arg_249_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_249_1.time_ and arg_249_1.time_ <= 0.05 + arg_252_0 then
				arg_249_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_252_6 = 0
			local var_252_7 = 0.625

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(419051061).content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 25 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_8) / 25)

				if (25 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_8) / 25)) > 0 and var_252_7 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_11 and arg_249_1.time_ < var_252_6 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play419051062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 419051062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play419051063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.925

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(419051062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 37)

				if (37 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 37)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play419051063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 419051063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play419051064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1046ui_story = arg_257_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).z)
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles = arg_257_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_257_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1046ui_story"].transform.position).z)
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1046ui_story"].transform.localEulerAngles = arg_257_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1046ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1046ui_story == nil then
				arg_257_1.var_.characterEffect1046ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1046ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1046ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1046ui_story then
				arg_257_1.var_.characterEffect1046ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_260_4 = 0
			local var_260_5 = 0.45

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(419051063).content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 18 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 18)

				if (18 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 18)) > 0 and var_260_5 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_9 and arg_257_1.time_ < var_260_4 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 419051064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play419051065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1046ui_story = arg_261_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1046ui_story, Vector3.New(0, -1, -6.1), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).z)
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles = arg_261_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_261_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1046ui_story"].transform.position).z)
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1046ui_story"].transform.localEulerAngles = arg_261_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/story1046/story1046action/1046action4_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1046ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_264_1 = 0
			local var_264_2 = 0.675

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(419051064).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 27 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 27)

				if (27 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 27)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
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
	Play419051065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 419051065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play419051066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1046ui_story = arg_265_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).z)
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles = arg_265_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1046ui_story"].transform.position).z)
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1046ui_story"].transform.localEulerAngles = arg_265_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1046ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1046ui_story == nil then
				arg_265_1.var_.characterEffect1046ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1046ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_2)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1046ui_story then
				arg_265_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_265_1.time_ and arg_265_1.time_ <= 0.05 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_268_4 = 0
			local var_268_5 = 0.725

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(419051065).content)

				arg_265_1.text_.text = var_268_6

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_8 = 29 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_6) / 29)

				if (29 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_6) / 29)) > 0 and var_268_5 < var_268_8 then
					arg_265_1.talkMaxDuration = var_268_8

					if var_268_8 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_6
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_9 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_9 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_9

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_9 and arg_265_1.time_ < var_268_4 + var_268_9 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play419051066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 419051066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play419051067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_272_0 = 0.6

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				local var_272_1, var_272_2 = math.modf((arg_269_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_272_2 * 0.13, var_272_2 * 0.13, var_272_2 * 0.13) + arg_269_1.var_.shakeOldPos
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				manager.ui.mainCamera.transform.localPosition = arg_269_1.var_.shakeOldPos
			end

			local var_272_3 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_3 + 0.6 and arg_269_1.time_ < var_272_3 + 0.6 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_4 = 0
			local var_272_5 = 0.25

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_6 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(419051066).content)

				arg_269_1.text_.text = var_272_6

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_8 = 10 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_6) / 10)

				if (10 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_6) / 10)) > 0 and var_272_5 < var_272_8 then
					arg_269_1.talkMaxDuration = var_272_8

					if var_272_8 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_6
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_9 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_9 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_9

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_9 and arg_269_1.time_ < var_272_4 + var_272_9 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play419051067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 419051067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play419051068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.075

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1207].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1046")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(419051067).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 9 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 9)

				if (9 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 9)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play419051068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 419051068
		arg_277_1.duration_ = 6.83

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play419051069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_9001
			local var_280_9000

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1046ui_story = arg_277_1.actors_["1046ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1046ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1046ui_story, Vector3.New(0, 100, 0), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).z)
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles = arg_277_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1046ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_277_1.actors_["1046ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1046ui_story"].transform.position).z)
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1046ui_story"].transform.localEulerAngles = arg_277_1.actors_["1046ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["1046ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1046ui_story == nil then
				arg_277_1.var_.characterEffect1046ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1046ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1046ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1046ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_2)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1046ui_story then
				arg_277_1.var_.characterEffect1046ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1046ui_story.fillRatio = 0.5
			end

			local var_280_3 = manager.ui.mainCamera.transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.shakeOldPos = var_280_3.localPosition
			end

			local var_280_4 = 1

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				local var_280_5, var_280_6 = math.modf((arg_277_1.time_ - 0) / 0.066)

				var_280_3.localPosition = Vector3.New(var_280_6 * 0.13, var_280_6 * 0.13, var_280_6 * 0.13) + arg_277_1.var_.shakeOldPos
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				var_280_3.localPosition = arg_277_1.var_.shakeOldPos
			end

			local var_280_7 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_7 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_7 + 1 and arg_277_1.time_ < var_280_7 + 1 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				local var_280_8 = arg_277_1.var_.effect543

				if not arg_277_1.var_.effect543 then
					var_280_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_280_8.name = "543"
					arg_277_1.var_.effect543 = var_280_8
				else
					var_280_8.transform:SetParent(var_280_9001)
				end

				var_280_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_280_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_280_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_280_0, iter_280_1 in ipairs((var_280_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_280_1.transform.localScale = Vector3.New(iter_280_1.transform.localScale.x / var_280_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_280_1.transform.localScale.y / var_280_10, iter_280_1.transform.localScale.z)
				end
			end

			if 0.633333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 0.633333333333333 + arg_280_0 then
				local var_280_12 = arg_277_1.var_.effect456

				if not arg_277_1.var_.effect456 then
					var_280_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_280_12.name = "456"
					arg_277_1.var_.effect456 = var_280_12
				else
					var_280_12.transform:SetParent(var_280_9000)
				end

				var_280_12.transform.localPosition = Vector3.New(0, -0.29, -0.76)
				var_280_12.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_280_14 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_280_2, iter_280_3 in ipairs((var_280_12.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_280_3.transform.localScale = Vector3.New(iter_280_3.transform.localScale.x / var_280_14 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_280_3.transform.localScale.y / var_280_14, iter_280_3.transform.localScale.z)
				end
			end

			local var_280_16 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_16 + 1.833333333332 and arg_277_1.time_ < var_280_16 + 1.833333333332 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if 0.633333333333333 < arg_277_1.time_ and arg_277_1.time_ <= 0.633333333333333 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_18 = 1.833333333332
			local var_280_19 = 0.825

			if 1.833333333332 < arg_277_1.time_ and arg_277_1.time_ <= var_280_18 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_20 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_20:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_21 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(419051068).content)

				arg_277_1.text_.text = var_280_21

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_23 = 33 <= 0 and var_280_19 or var_280_19 * (utf8.len(var_280_21) / 33)

				if (33 <= 0 and var_280_19 or var_280_19 * (utf8.len(var_280_21) / 33)) > 0 and var_280_19 < var_280_23 then
					arg_277_1.talkMaxDuration = var_280_23
					var_280_18 = var_280_18 + 0.3

					if var_280_23 + var_280_18 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_23 + var_280_18
					end
				end

				arg_277_1.text_.text = var_280_21
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_24 = var_280_18 + 0.3
			local var_280_25 = math.max(var_280_19, arg_277_1.talkMaxDuration)

			if var_280_18 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_24 + var_280_25 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_24) / var_280_25

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_24 + var_280_25 and arg_277_1.time_ < var_280_24 + var_280_25 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1046ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play419051069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 419051069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play419051070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.35

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(419051069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 14 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 14)

				if (14 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 14)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play419051070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 419051070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
			arg_287_1.auto_ = false
		end

		function arg_287_1.playNext_(arg_289_0)
			arg_287_1.onStoryFinished_()
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.95

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(419051070).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 38 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 38)

				if (38 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 38)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/I05"
	},
	voices = {}
}
