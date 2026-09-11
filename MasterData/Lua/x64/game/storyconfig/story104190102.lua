return {
	Play419012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 419012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play419012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I18g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I18g")
				var_4_0.name = "I18g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I18g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I18g

				arg_1_1.bgs_.I18g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I18g" then
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
			local var_4_10 = 1.2

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_12 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419012001).content)

				arg_1_1.text_.text = var_4_12

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_14 = 48 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 48)

				if (48 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 48)) > 0 and var_4_10 < var_4_14 then
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
	Play419012002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 419012002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play419012003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.125

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(419012002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 45 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 45)

				if (45 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 45)) > 0 and var_10_0 < var_10_3 then
					arg_7_1.talkMaxDuration = var_10_3

					if var_10_3 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_3 + 0
					end
				end

				arg_7_1.text_.text = var_10_1
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_4 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_4

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play419012003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 419012003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play419012004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1045ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "1045ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "1045ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1045ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["1045ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["1045ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["1045ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["1045ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1045ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1045ui_story, Vector3.New(0, -1, -6.05), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0, -1, -6.05)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["1045ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1045ui_story == nil then
				arg_11_1.var_.characterEffect1045ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect1045ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1045ui_story then
				arg_11_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action1_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_14_8 = 0
			local var_14_9 = 0.85

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(419012003).content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_12 = 34 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 34)

				if (34 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 34)) > 0 and var_14_9 < var_14_12 then
					arg_11_1.talkMaxDuration = var_14_12

					if var_14_12 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_12 + var_14_8
					end
				end

				arg_11_1.text_.text = var_14_10
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_13 = math.max(var_14_9, arg_11_1.talkMaxDuration)

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_13 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_8) / var_14_13

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_8 + var_14_13 and arg_11_1.time_ < var_14_8 + var_14_13 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 419012004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play419012005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1045ui_story = arg_15_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1045ui_story, Vector3.New(0, -1, -6.05), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).z)
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles = arg_15_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_15_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1045ui_story"].transform.position).z)
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1045ui_story"].transform.localEulerAngles = arg_15_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action2_1")
			end

			local var_18_1 = 0
			local var_18_2 = 0.85

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(419012004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 24 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 24)

				if (24 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 24)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 419012005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play419012006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1045ui_story = arg_19_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1045ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).z)
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles = arg_19_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1045ui_story"].transform.position).z)
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1045ui_story"].transform.localEulerAngles = arg_19_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1045ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1045ui_story == nil then
				arg_19_1.var_.characterEffect1045ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1045ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_2)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1045ui_story then
				arg_19_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			local var_22_3 = 0
			local var_22_4 = 1.35

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

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(419012005).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 54 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 54)

				if (54 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 54)) > 0 and var_22_4 < var_22_7 then
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
				actorName = "1045ui_story",
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
	Play419012006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 419012006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play419012007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1095ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1095ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1095ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1095ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1095ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1095ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1095ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1095ui_story == nil then
				arg_23_1.var_.characterEffect1095ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1095ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1095ui_story then
				arg_23_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.675

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(419012006).content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_12 = 27 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_10) / 27)

				if (27 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_10) / 27)) > 0 and var_26_9 < var_26_12 then
					arg_23_1.talkMaxDuration = var_26_12

					if var_26_12 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_12 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_13 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_13 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_13

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_13 and arg_23_1.time_ < var_26_8 + var_26_13 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 419012007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play419012008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1045ui_story = arg_27_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).z)
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles = arg_27_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_27_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1045ui_story"].transform.position).z)
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1045ui_story"].transform.localEulerAngles = arg_27_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1045ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1045ui_story == nil then
				arg_27_1.var_.characterEffect1045ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1045ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1045ui_story then
				arg_27_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_30_4 = arg_27_1.actors_["1095ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1095ui_story == nil then
				arg_27_1.var_.characterEffect1095ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect1095ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1095ui_story then
				arg_27_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action2_2")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_30_6 = 0
			local var_30_7 = 0.6

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(419012007).content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 19 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 19)

				if (19 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 19)) > 0 and var_30_7 < var_30_10 then
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
				actorName = "1045ui_story",
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
	Play419012008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 419012008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play419012009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1095ui_story"]) and arg_31_1.var_.characterEffect1095ui_story == nil then
				arg_31_1.var_.characterEffect1095ui_story = arg_31_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1095ui_story"]) then
				if arg_31_1.var_.characterEffect1095ui_story and not isNil(arg_31_1.actors_["1095ui_story"]) then
					arg_31_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1095ui_story"]) and arg_31_1.var_.characterEffect1095ui_story then
				arg_31_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_34_2 = arg_31_1.actors_["1045ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1045ui_story == nil then
				arg_31_1.var_.characterEffect1045ui_story = var_34_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_3 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_3 and not isNil(var_34_2) then
				if arg_31_1.var_.characterEffect1045ui_story and not isNil(var_34_2) then
					arg_31_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_3)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_3 and arg_31_1.time_ < 0 + var_34_3 + arg_34_0 and not isNil(var_34_2) and arg_31_1.var_.characterEffect1045ui_story then
				arg_31_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_34_4 = 0
			local var_34_5 = 0.425

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(419012008).content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 17 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 17)

				if (17 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 17)) > 0 and var_34_5 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_9 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_9 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_9

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_9 and arg_31_1.time_ < var_34_4 + var_34_9 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play419012009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 419012009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play419012010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.725

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(419012009).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 29 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 29)

				if (29 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 29)) > 0 and var_38_0 < var_38_3 then
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
	Play419012010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 419012010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play419012011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1095ui_story"]) and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = arg_39_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1095ui_story"]) then
				if arg_39_1.var_.characterEffect1095ui_story and not isNil(arg_39_1.actors_["1095ui_story"]) then
					arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1095ui_story"]) and arg_39_1.var_.characterEffect1095ui_story then
				arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action4_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_42_1 = 0
			local var_42_2 = 0.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(419012010).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 8 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 8)

				if (8 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 8)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play419012011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 419012011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play419012012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) and arg_43_1.var_.characterEffect1095ui_story == nil then
				arg_43_1.var_.characterEffect1095ui_story = arg_43_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) then
				if arg_43_1.var_.characterEffect1095ui_story and not isNil(arg_43_1.actors_["1095ui_story"]) then
					arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1095ui_story"]) and arg_43_1.var_.characterEffect1095ui_story then
				arg_43_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_46_2 = 0
			local var_46_3 = 0.55

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(419012011).content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 22 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 22)

				if (22 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 22)) > 0 and var_46_3 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_7 and arg_43_1.time_ < var_46_2 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play419012012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 419012012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play419012013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1045ui_story"]) and arg_47_1.var_.characterEffect1045ui_story == nil then
				arg_47_1.var_.characterEffect1045ui_story = arg_47_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1045ui_story"]) then
				if arg_47_1.var_.characterEffect1045ui_story and not isNil(arg_47_1.actors_["1045ui_story"]) then
					arg_47_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1045ui_story"]) and arg_47_1.var_.characterEffect1045ui_story then
				arg_47_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["1095ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1095ui_story == nil then
				arg_47_1.var_.characterEffect1095ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect1095ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1095ui_story then
				arg_47_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_50_4 = 0
			local var_50_5 = 0.125

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(419012012).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 5 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 5)

				if (5 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 5)) > 0 and var_50_5 < var_50_8 then
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

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play419012013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 419012013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play419012014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1095ui_story"]) and arg_51_1.var_.characterEffect1095ui_story == nil then
				arg_51_1.var_.characterEffect1095ui_story = arg_51_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1095ui_story"]) then
				if arg_51_1.var_.characterEffect1095ui_story and not isNil(arg_51_1.actors_["1095ui_story"]) then
					arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1095ui_story"]) and arg_51_1.var_.characterEffect1095ui_story then
				arg_51_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["1045ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1045ui_story == nil then
				arg_51_1.var_.characterEffect1045ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect1045ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect1045ui_story then
				arg_51_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_54_4 = 0
			local var_54_5 = 0.575

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(419012013).content)

				arg_51_1.text_.text = var_54_6

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_8 = 23 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 23)

				if (23 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_6) / 23)) > 0 and var_54_5 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_6
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_9 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_9 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_9

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_9 and arg_51_1.time_ < var_54_4 + var_54_9 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play419012014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 419012014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play419012015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1045ui_story"]) and arg_55_1.var_.characterEffect1045ui_story == nil then
				arg_55_1.var_.characterEffect1045ui_story = arg_55_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1045ui_story"]) then
				if arg_55_1.var_.characterEffect1045ui_story and not isNil(arg_55_1.actors_["1045ui_story"]) then
					arg_55_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1045ui_story"]) and arg_55_1.var_.characterEffect1045ui_story then
				arg_55_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["1095ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1095ui_story == nil then
				arg_55_1.var_.characterEffect1095ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect1095ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect1095ui_story then
				arg_55_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action4_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_58_4 = 0
			local var_58_5 = 0.575

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(419012014).content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 23 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 23)

				if (23 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 23)) > 0 and var_58_5 < var_58_8 then
					arg_55_1.talkMaxDuration = var_58_8

					if var_58_8 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_6
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_9 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_9 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_9

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_9 and arg_55_1.time_ < var_58_4 + var_58_9 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play419012015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 419012015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play419012016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1045ui_story"]) and arg_59_1.var_.characterEffect1045ui_story == nil then
				arg_59_1.var_.characterEffect1045ui_story = arg_59_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1045ui_story"]) then
				if arg_59_1.var_.characterEffect1045ui_story and not isNil(arg_59_1.actors_["1045ui_story"]) then
					arg_59_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1045ui_story"]) and arg_59_1.var_.characterEffect1045ui_story then
				arg_59_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 1.1

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(419012015).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 44 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 44)

				if (44 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 44)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play419012016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 419012016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play419012017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) and arg_63_1.var_.characterEffect1095ui_story == nil then
				arg_63_1.var_.characterEffect1095ui_story = arg_63_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) then
				if arg_63_1.var_.characterEffect1095ui_story and not isNil(arg_63_1.actors_["1095ui_story"]) then
					arg_63_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1095ui_story"]) and arg_63_1.var_.characterEffect1095ui_story then
				arg_63_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_66_2 = 0
			local var_66_3 = 0.6

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(419012016).content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 24 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 24)

				if (24 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_4) / 24)) > 0 and var_66_3 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_7 and arg_63_1.time_ < var_66_2 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play419012017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 419012017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play419012018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(419012017).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 24)

				if (24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 24)) > 0 and var_70_0 < var_70_3 then
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
	Play419012018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 419012018
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play419012019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 then
				arg_71_1.var_.moveOldPos1095ui_story = arg_71_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_0 then
				arg_71_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 1.96599999815226) / var_74_0)
				arg_71_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).z)
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles = arg_71_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_0 and arg_71_1.time_ < 1.96599999815226 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1095ui_story"].transform.position).z)
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1095ui_story"].transform.localEulerAngles = arg_71_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1045ui_story"].transform

			if 1.96599999815226 < arg_71_1.time_ and arg_71_1.time_ <= 1.96599999815226 + arg_74_0 then
				arg_71_1.var_.moveOldPos1045ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 1.96599999815226 <= arg_71_1.time_ and arg_71_1.time_ < 1.96599999815226 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1045ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 1.96599999815226) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 1.96599999815226 + var_74_2 and arg_71_1.time_ < 1.96599999815226 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0, 100, 0)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			local var_74_3 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_4 = 2

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_4 then
				local var_74_5 = Color.New(0, 0, 0)

				var_74_5.a = Mathf.Lerp(0, 1, (arg_71_1.time_ - var_74_3) / var_74_4)
				arg_71_1.mask_.color = var_74_5
			end

			if arg_71_1.time_ >= var_74_3 + var_74_4 and arg_71_1.time_ < var_74_3 + var_74_4 + arg_74_0 then
				local var_74_6 = Color.New(0, 0, 0)

				var_74_6.a = 1
				arg_71_1.mask_.color = var_74_6
			end

			local var_74_7 = 2

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_8 = 2

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 then
				local var_74_9 = Color.New(0, 0, 0)

				var_74_9.a = Mathf.Lerp(1, 0, (arg_71_1.time_ - var_74_7) / var_74_8)
				arg_71_1.mask_.color = var_74_9
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 then
				local var_74_10 = Color.New(0, 0, 0)

				arg_71_1.mask_.enabled = false
				var_74_10.a = 0
				arg_71_1.mask_.color = var_74_10
			end

			local var_74_11 = "I18f"

			if arg_71_1.bgs_.I18f == nil then
				local var_74_12 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_74_11)
				var_74_12.name = var_74_11
				var_74_12.transform.parent = arg_71_1.stage_.transform
				var_74_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_[var_74_11] = var_74_12
			end

			if 2 < arg_71_1.time_ and arg_71_1.time_ <= 2 + arg_74_0 then
				local var_74_13 = arg_71_1.bgs_.I18f

				arg_71_1.bgs_.I18f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_14 = var_74_13:GetComponent("SpriteRenderer")

				if var_74_14 and var_74_14.sprite then
					local var_74_15 = 2 * (var_74_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_13.transform.localScale = Vector3.New(var_74_15 / var_74_14.sprite.bounds.size.y < var_74_15 * manager.ui.mainCameraCom_.aspect / var_74_14.sprite.bounds.size.x and var_74_15 * manager.ui.mainCameraCom_.aspect / var_74_14.sprite.bounds.size.x or var_74_15 / var_74_14.sprite.bounds.size.y, var_74_15 / var_74_14.sprite.bounds.size.y < var_74_15 * manager.ui.mainCameraCom_.aspect / var_74_14.sprite.bounds.size.x and var_74_15 * manager.ui.mainCameraCom_.aspect / var_74_14.sprite.bounds.size.x or var_74_15 / var_74_14.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "I18f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_16 = 4
			local var_74_17 = 0.4

			if 4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_18 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_18:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_19 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(419012018).content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_21 = 16 <= 0 and var_74_17 or var_74_17 * (utf8.len(var_74_19) / 16)

				if (16 <= 0 and var_74_17 or var_74_17 * (utf8.len(var_74_19) / 16)) > 0 and var_74_17 < var_74_21 then
					arg_71_1.talkMaxDuration = var_74_21
					var_74_16 = var_74_16 + 0.3

					if var_74_21 + var_74_16 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_16
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = var_74_16 + 0.3
			local var_74_23 = math.max(var_74_17, arg_71_1.talkMaxDuration)

			if var_74_16 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_22 + var_74_23 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_22) / var_74_23

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_22 + var_74_23 and arg_71_1.time_ < var_74_22 + var_74_23 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play419012019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 419012019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play419012020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1095ui_story = arg_77_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).z)
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles = arg_77_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1095ui_story"].transform.position).z)
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1095ui_story"].transform.localEulerAngles = arg_77_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1095ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1095ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_80_3 = 0
			local var_80_4 = 1.15

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(419012019).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 46 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 46)

				if (46 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 46)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play419012020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 419012020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play419012021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1095ui_story = arg_81_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).z)
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles = arg_81_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1095ui_story"].transform.position).z)
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1095ui_story"].transform.localEulerAngles = arg_81_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_84_1 = 0
			local var_84_2 = 1.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(419012020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 60 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 60)

				if (60 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 60)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 419012021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play419012022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1095ui_story = arg_85_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).z)
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles = arg_85_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_85_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1095ui_story"].transform.position).z)
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1095ui_story"].transform.localEulerAngles = arg_85_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1095ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_88_4 = 0
			local var_88_5 = 1.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(419012021).content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 59 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_6) / 59)

				if (59 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_6) / 59)) > 0 and var_88_5 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_9 and arg_85_1.time_ < var_88_4 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play419012022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 419012022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play419012023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1045ui_story = arg_89_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).z)
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles = arg_89_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_89_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1045ui_story"].transform.position).z)
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1045ui_story"].transform.localEulerAngles = arg_89_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1045ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1045ui_story == nil then
				arg_89_1.var_.characterEffect1045ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1045ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1045ui_story then
				arg_89_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["1095ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_92_6 = 0
			local var_92_7 = 0.75

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(419012022).content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 30 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_8) / 30)

				if (30 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_8) / 30)) > 0 and var_92_7 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_11 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_11 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_11

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_11 and arg_89_1.time_ < var_92_6 + var_92_11 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play419012023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 419012023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play419012024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.575

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(419012023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 23 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 23)

				if (23 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 23)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play419012024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 419012024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play419012025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = arg_97_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_97_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1095ui_story"].transform.position).z)
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1095ui_story"].transform.localEulerAngles = arg_97_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1095ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story == nil then
				arg_97_1.var_.characterEffect1095ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1095ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1095ui_story then
				arg_97_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["1045ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1045ui_story == nil then
				arg_97_1.var_.characterEffect1045ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect1045ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1045ui_story then
				arg_97_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_6 = 0
			local var_100_7 = 0.325

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(419012024).content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 13 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 13)

				if (13 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 13)) > 0 and var_100_7 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_11 and arg_97_1.time_ < var_100_6 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 419012025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play419012026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1045ui_story = arg_101_1.actors_["1045ui_story"].transform.localPosition

				arg_101_1:ShowWeapon(arg_101_1.var_["1045ui_story" .. "Animator"].transform, false)
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).z)
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles = arg_101_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_101_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1045ui_story"].transform.position).z)
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1045ui_story"].transform.localEulerAngles = arg_101_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1045ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1045ui_story == nil then
				arg_101_1.var_.characterEffect1045ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1045ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1045ui_story then
				arg_101_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["1095ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action3_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.9

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(419012025).content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 30 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_8) / 30)

				if (30 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_8) / 30)) > 0 and var_104_7 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_11 and arg_101_1.time_ < var_104_6 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 419012026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play419012027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1045ui_story"]) and arg_105_1.var_.characterEffect1045ui_story == nil then
				arg_105_1.var_.characterEffect1045ui_story = arg_105_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1045ui_story"]) then
				if arg_105_1.var_.characterEffect1045ui_story and not isNil(arg_105_1.actors_["1045ui_story"]) then
					arg_105_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1045ui_story"]) and arg_105_1.var_.characterEffect1045ui_story then
				arg_105_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.875

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(419012026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 35 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 35)

				if (35 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 35)) > 0 and var_108_2 < var_108_5 then
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
	Play419012027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 419012027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play419012028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1095ui_story = arg_109_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_109_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1095ui_story"].transform.position).z)
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1095ui_story"].transform.localEulerAngles = arg_109_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_112_4 = 0
			local var_112_5 = 1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(419012027).content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 40 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 40)

				if (40 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 40)) > 0 and var_112_5 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_9 and arg_109_1.time_ < var_112_4 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 419012028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play419012029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.45

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(419012028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 18)

				if (18 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 18)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play419012029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 419012029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play419012030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1045ui_story = arg_117_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).z)
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles = arg_117_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_117_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1045ui_story"].transform.position).z)
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1045ui_story"].transform.localEulerAngles = arg_117_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1045ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1045ui_story == nil then
				arg_117_1.var_.characterEffect1045ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1045ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1045ui_story then
				arg_117_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["1095ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1095ui_story == nil then
				arg_117_1.var_.characterEffect1095ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect1095ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1095ui_story then
				arg_117_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045actionlink/1045action439")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.175

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(419012029).content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 7 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 7)

				if (7 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_8) / 7)) > 0 and var_120_7 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_11 and arg_117_1.time_ < var_120_6 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 419012030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play419012031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = arg_121_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_121_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1095ui_story"].transform.position).z)
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1095ui_story"].transform.localEulerAngles = arg_121_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1095ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1045ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1045ui_story == nil then
				arg_121_1.var_.characterEffect1045ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect1045ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1045ui_story then
				arg_121_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_124_6 = 0
			local var_124_7 = 0.375

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(419012030).content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 15 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_8) / 15)

				if (15 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_8) / 15)) > 0 and var_124_7 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_11 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_11 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_11

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_11 and arg_121_1.time_ < var_124_6 + var_124_11 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play419012031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 419012031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play419012032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1045ui_story = arg_125_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).z)
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles = arg_125_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_125_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1045ui_story"].transform.position).z)
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1045ui_story"].transform.localEulerAngles = arg_125_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1045ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1045ui_story == nil then
				arg_125_1.var_.characterEffect1045ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1045ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1045ui_story then
				arg_125_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1095ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1095ui_story == nil then
				arg_125_1.var_.characterEffect1095ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect1095ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1095ui_story then
				arg_125_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_128_6 = 0
			local var_128_7 = 0.25

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(419012031).content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 41 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 41)

				if (41 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 41)) > 0 and var_128_7 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_11 and arg_125_1.time_ < var_128_6 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 419012032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play419012033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1045ui_story"]) and arg_129_1.var_.characterEffect1045ui_story == nil then
				arg_129_1.var_.characterEffect1045ui_story = arg_129_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1045ui_story"]) then
				if arg_129_1.var_.characterEffect1045ui_story and not isNil(arg_129_1.actors_["1045ui_story"]) then
					arg_129_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1045ui_story"]) and arg_129_1.var_.characterEffect1045ui_story then
				arg_129_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.925

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(419012032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 37 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 37)

				if (37 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 37)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play419012033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 419012033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play419012034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1045ui_story = arg_133_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).z)
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles = arg_133_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_133_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1045ui_story"].transform.position).z)
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1045ui_story"].transform.localEulerAngles = arg_133_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1045ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1045ui_story == nil then
				arg_133_1.var_.characterEffect1045ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1045ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1045ui_story then
				arg_133_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action9_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_136_4 = 0
			local var_136_5 = 1.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(419012033).content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_8 = 43 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_6) / 43)

				if (43 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_6) / 43)) > 0 and var_136_5 < var_136_8 then
					arg_133_1.talkMaxDuration = var_136_8

					if var_136_8 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_6
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_9 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_9

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_9 and arg_133_1.time_ < var_136_4 + var_136_9 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 419012034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play419012035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.325

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(419012034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 53 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 53)

				if (53 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 53)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play419012035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 419012035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play419012036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(419012035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 45 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 45)

				if (45 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 45)) > 0 and var_144_0 < var_144_3 then
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
	Play419012036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 419012036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play419012037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1095ui_story = arg_145_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_145_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1095ui_story"].transform.position).z)
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1095ui_story"].transform.localEulerAngles = arg_145_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1095ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["1045ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1045ui_story == nil then
				arg_145_1.var_.characterEffect1045ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect1045ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1045ui_story then
				arg_145_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_6 = 0
			local var_148_7 = 0.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(419012036).content)

				arg_145_1.text_.text = var_148_8

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_10 = 4 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_8) / 4)

				if (4 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_8) / 4)) > 0 and var_148_7 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_8
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_11 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_11 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_11

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_11 and arg_145_1.time_ < var_148_6 + var_148_11 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 419012037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play419012038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1045ui_story = arg_149_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).z)
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles = arg_149_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_149_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1045ui_story"].transform.position).z)
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1045ui_story"].transform.localEulerAngles = arg_149_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1045ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1045ui_story == nil then
				arg_149_1.var_.characterEffect1045ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1045ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1045ui_story then
				arg_149_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1095ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect1095ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1095ui_story then
				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action2_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.6

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(419012037).content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 24 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 24)

				if (24 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 24)) > 0 and var_152_7 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_11 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_11 and arg_149_1.time_ < var_152_6 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 419012038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play419012039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_156_0 = 0
			local var_156_1 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(419012038).content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 24 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_2) / 24)

				if (24 <= 0 and var_156_1 or var_156_1 * (utf8.len(var_156_2) / 24)) > 0 and var_156_1 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_5 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_5 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_5

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_5 and arg_153_1.time_ < var_156_0 + var_156_5 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play419012039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 419012039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play419012040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1095ui_story"]) and arg_157_1.var_.characterEffect1095ui_story == nil then
				arg_157_1.var_.characterEffect1095ui_story = arg_157_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1095ui_story"]) then
				if arg_157_1.var_.characterEffect1095ui_story and not isNil(arg_157_1.actors_["1095ui_story"]) then
					arg_157_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1095ui_story"]) and arg_157_1.var_.characterEffect1095ui_story then
				arg_157_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_160_2 = arg_157_1.actors_["1045ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1045ui_story == nil then
				arg_157_1.var_.characterEffect1045ui_story = var_160_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_3 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.characterEffect1045ui_story and not isNil(var_160_2) then
					arg_157_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_3)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.characterEffect1045ui_story then
				arg_157_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_160_4 = 0
			local var_160_5 = 0.75

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(419012039).content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 30 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 30)

				if (30 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 30)) > 0 and var_160_5 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_9 and arg_157_1.time_ < var_160_4 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play419012040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 419012040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play419012041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1045ui_story = arg_161_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).z)
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles = arg_161_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_161_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1045ui_story"].transform.position).z)
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1045ui_story"].transform.localEulerAngles = arg_161_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1045ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1045ui_story == nil then
				arg_161_1.var_.characterEffect1045ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1045ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1045ui_story then
				arg_161_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["1095ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1095ui_story == nil then
				arg_161_1.var_.characterEffect1095ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_5 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 and not isNil(var_164_4) then
				if arg_161_1.var_.characterEffect1095ui_story and not isNil(var_164_4) then
					arg_161_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_5)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1095ui_story then
				arg_161_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action2_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 0.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(419012040).content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 4 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_8) / 4)

				if (4 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_8) / 4)) > 0 and var_164_7 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_11 and arg_161_1.time_ < var_164_6 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 419012041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play419012042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1095ui_story = arg_165_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1095ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1045ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1045ui_story == nil then
				arg_165_1.var_.characterEffect1045ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect1045ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1045ui_story then
				arg_165_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_168_6 = 0
			local var_168_7 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(419012041).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 36)

				if (36 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 36)) > 0 and var_168_7 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_11 and arg_165_1.time_ < var_168_6 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 419012042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play419012043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(419012042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)

				if (39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play419012043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 419012043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play419012044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_176_0 = 0
			local var_176_1 = 1.075

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(419012043).content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 43 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_2) / 43)

				if (43 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_2) / 43)) > 0 and var_176_1 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_5 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_5 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_5

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_5 and arg_173_1.time_ < var_176_0 + var_176_5 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play419012044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 419012044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play419012045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1045ui_story = arg_177_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).z)
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles = arg_177_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_177_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1045ui_story"].transform.position).z)
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1045ui_story"].transform.localEulerAngles = arg_177_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1045ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1045ui_story == nil then
				arg_177_1.var_.characterEffect1045ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1045ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1045ui_story then
				arg_177_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1095ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045action/1045action3_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_180_6 = 0
			local var_180_7 = 0.625

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(419012044).content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 26 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_8) / 26)

				if (26 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_8) / 26)) > 0 and var_180_7 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_11 and arg_177_1.time_ < var_180_6 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1045ui_story",
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
	Play419012045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 419012045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play419012046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.95

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(419012045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 38)

				if (38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 38)) > 0 and var_184_0 < var_184_3 then
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
	Play419012046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 419012046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play419012047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story == nil then
				arg_185_1.var_.characterEffect1095ui_story = arg_185_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) then
				if arg_185_1.var_.characterEffect1095ui_story and not isNil(arg_185_1.actors_["1095ui_story"]) then
					arg_185_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1095ui_story"]) and arg_185_1.var_.characterEffect1095ui_story then
				arg_185_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_188_2 = arg_185_1.actors_["1045ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1045ui_story == nil then
				arg_185_1.var_.characterEffect1045ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect1045ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_3)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1045ui_story then
				arg_185_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			local var_188_4 = 0
			local var_188_5 = 0.375

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(419012046).content)

				arg_185_1.text_.text = var_188_6

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 15 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_6) / 15)

				if (15 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_6) / 15)) > 0 and var_188_5 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8

					if var_188_8 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_6
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_9 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_9

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_9 and arg_185_1.time_ < var_188_4 + var_188_9 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play419012047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 419012047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play419012048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = arg_189_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) then
				if arg_189_1.var_.characterEffect1095ui_story and not isNil(arg_189_1.actors_["1095ui_story"]) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1095ui_story"]) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 1.375

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(419012047).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 55 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 55)

				if (55 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 55)) > 0 and var_192_2 < var_192_5 then
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

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play419012048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 419012048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play419012049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1095ui_story = arg_193_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).z)
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles = arg_193_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_193_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1095ui_story"].transform.position).z)
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1095ui_story"].transform.localEulerAngles = arg_193_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1095ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1095ui_story == nil then
				arg_193_1.var_.characterEffect1095ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1095ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1095ui_story then
				arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_196_4 = 0
			local var_196_5 = 0.9

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(419012048).content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 36 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 36)

				if (36 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 36)) > 0 and var_196_5 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_6
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_9 and arg_193_1.time_ < var_196_4 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play419012049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 419012049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play419012050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1045ui_story = arg_197_1.actors_["1045ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1045ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1045ui_story, Vector3.New(0.7, -1, -6.05), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).z)
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles = arg_197_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1045ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.05)
				arg_197_1.actors_["1045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1045ui_story"].transform.position).z)
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1045ui_story"].transform.localEulerAngles = arg_197_1.actors_["1045ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1045ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1045ui_story == nil then
				arg_197_1.var_.characterEffect1045ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1045ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1045ui_story then
				arg_197_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1095ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_5 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 and not isNil(var_200_4) then
				if arg_197_1.var_.characterEffect1095ui_story and not isNil(var_200_4) then
					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_5)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1095ui_story then
				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/story1045/story1045actionlink/1045action434")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1045ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 0.65

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(419012049).content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 26 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 26)

				if (26 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 26)) > 0 and var_200_7 < var_200_10 then
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
				actorName = "1045ui_story",
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
	Play419012050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 419012050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play419012051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1095ui_story = arg_201_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).z)
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles = arg_201_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_201_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1095ui_story"].transform.position).z)
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1095ui_story"].transform.localEulerAngles = arg_201_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1095ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1095ui_story == nil then
				arg_201_1.var_.characterEffect1095ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1095ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1095ui_story then
				arg_201_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1045ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1045ui_story == nil then
				arg_201_1.var_.characterEffect1045ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_5 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 and not isNil(var_204_4) then
				if arg_201_1.var_.characterEffect1045ui_story and not isNil(var_204_4) then
					arg_201_1.var_.characterEffect1045ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_5)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1045ui_story then
				arg_201_1.var_.characterEffect1045ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1045ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_204_6 = 0
			local var_204_7 = 0.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(419012050).content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 5 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_8) / 5)

				if (5 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_8) / 5)) > 0 and var_204_7 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_11 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_11 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_11

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_11 and arg_201_1.time_ < var_204_6 + var_204_11 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play419012051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 419012051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1045ui_story"]) and arg_205_1.var_.characterEffect1045ui_story == nil then
				arg_205_1.var_.characterEffect1045ui_story = arg_205_1.actors_["1045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1045ui_story"]) then
				if arg_205_1.var_.characterEffect1045ui_story and not isNil(arg_205_1.actors_["1045ui_story"]) then
					arg_205_1.var_.characterEffect1045ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1045ui_story"]) and arg_205_1.var_.characterEffect1045ui_story then
				arg_205_1.var_.characterEffect1045ui_story.fillFlat = false
			end

			local var_208_2 = arg_205_1.actors_["1095ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect1095ui_story == nil then
				arg_205_1.var_.characterEffect1095ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.characterEffect1095ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect1095ui_story then
				arg_205_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_208_4 = 0
			local var_208_5 = 0.475

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(419012051).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 19 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 19)

				if (19 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 19)) > 0 and var_208_5 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_9 and arg_205_1.time_ < var_208_4 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I18g",
		"TextureConfig/Background/I18f"
	},
	voices = {}
}
