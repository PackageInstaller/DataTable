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
			if arg_1_1.bgs_.H07j == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07j")
				var_4_0.name = "H07j"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07j = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07j

				arg_1_1.bgs_.H07j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07j" then
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

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "10089ui_story"

			if arg_1_1.actors_["10089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10089ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10089ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["10089ui_story"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos10089ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10089ui_story, Vector3.New(0, -1.12, -5.99), (arg_1_1.time_ - 1.86666666666667) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_13 and arg_1_1.time_ < 1.86666666666667 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.12, -5.99)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10089ui_story"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10089ui_story == nil then
				arg_1_1.var_.characterEffect10089ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10089ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_15 and arg_1_1.time_ < 1.86666666666667 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10089ui_story then
				arg_1_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 2
			local var_4_18 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[988].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414231001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 14 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 14)

				if (14 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 14)) > 0 and var_4_18 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_17 = var_4_17 + 0.3

					if var_4_22 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_17 + 0.3
			local var_4_24 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
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
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["10089ui_story"]) and arg_7_1.var_.characterEffect10089ui_story == nil then
				arg_7_1.var_.characterEffect10089ui_story = arg_7_1.actors_["10089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["10089ui_story"]) then
				if arg_7_1.var_.characterEffect10089ui_story and not isNil(arg_7_1.actors_["10089ui_story"]) then
					arg_7_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_7_1.var_.characterEffect10089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["10089ui_story"]) and arg_7_1.var_.characterEffect10089ui_story then
				arg_7_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_7_1.var_.characterEffect10089ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 0.25

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[980].name)

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

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(414231002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 10 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 10)

				if (10 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 10)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
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
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos10089ui_story = arg_11_1.actors_["10089ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["10089ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos10089ui_story, Vector3.New(0, -1.12, -5.99), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["10089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).z)
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles = arg_11_1.actors_["10089ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["10089ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_11_1.actors_["10089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["10089ui_story"].transform.position).z)
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["10089ui_story"].transform.localEulerAngles = arg_11_1.actors_["10089ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["10089ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect10089ui_story == nil then
				arg_11_1.var_.characterEffect10089ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect10089ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect10089ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect10089ui_story then
				arg_11_1.var_.characterEffect10089ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10089ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_14_4 = 0
			local var_14_5 = 0.2

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[988].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(414231003).content)

				arg_11_1.text_.text = var_14_6

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_8 = 8 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 8)

				if (8 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 8)) > 0 and var_14_5 < var_14_8 then
					arg_11_1.talkMaxDuration = var_14_8

					if var_14_8 + var_14_4 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_8 + var_14_4
					end
				end

				arg_11_1.text_.text = var_14_6
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_9 = math.max(var_14_5, arg_11_1.talkMaxDuration)

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_9 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_4) / var_14_9

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_4 + var_14_9 and arg_11_1.time_ < var_14_4 + var_14_9 + arg_14_0 then
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
			if 1 < arg_15_1.time_ and arg_15_1.time_ <= 1 + arg_18_0 then
				arg_15_1.var_.moveOldPos10089ui_story = arg_15_1.actors_["10089ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 1 <= arg_15_1.time_ and arg_15_1.time_ < 1 + var_18_0 then
				arg_15_1.actors_["10089ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10089ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 1) / var_18_0)
				arg_15_1.actors_["10089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).z)
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles = arg_15_1.actors_["10089ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 1 + var_18_0 and arg_15_1.time_ < 1 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["10089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["10089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10089ui_story"].transform.position).z)
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["10089ui_story"].transform.localEulerAngles = arg_15_1.actors_["10089ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["10089ui_story"]

			if 1 < arg_15_1.time_ and arg_15_1.time_ <= 1 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect10089ui_story == nil then
				arg_15_1.var_.characterEffect10089ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 1 <= arg_15_1.time_ and arg_15_1.time_ < 1 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect10089ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect10089ui_story.fillFlat = true
					arg_15_1.var_.characterEffect10089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 1) / var_18_2)
				end
			end

			if arg_15_1.time_ >= 1 + var_18_2 and arg_15_1.time_ < 1 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect10089ui_story then
				arg_15_1.var_.characterEffect10089ui_story.fillFlat = true
				arg_15_1.var_.characterEffect10089ui_story.fillRatio = 0.5
			end

			if 1 < arg_15_1.time_ and arg_15_1.time_ <= 1 + arg_18_0 then
				local var_18_3 = arg_15_1.bgs_.H07j

				arg_15_1.bgs_.H07j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_18_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_18_4 = var_18_3:GetComponent("SpriteRenderer")

				if var_18_4 and var_18_4.sprite then
					local var_18_5 = 2 * (var_18_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_18_3.transform.localScale = Vector3.New(var_18_5 / var_18_4.sprite.bounds.size.y < var_18_5 * manager.ui.mainCameraCom_.aspect / var_18_4.sprite.bounds.size.x and var_18_5 * manager.ui.mainCameraCom_.aspect / var_18_4.sprite.bounds.size.x or var_18_5 / var_18_4.sprite.bounds.size.y, var_18_5 / var_18_4.sprite.bounds.size.y < var_18_5 * manager.ui.mainCameraCom_.aspect / var_18_4.sprite.bounds.size.x and var_18_5 * manager.ui.mainCameraCom_.aspect / var_18_4.sprite.bounds.size.x or var_18_5 / var_18_4.sprite.bounds.size.y, 0)
				end

				for iter_18_0, iter_18_1 in pairs(arg_15_1.bgs_) do
					if iter_18_0 ~= "H07j" then
						iter_18_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_18_6 = 0

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_7 = 1

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = Color.New(0, 0, 0)

				var_18_8.a = Mathf.Lerp(0, 1, (arg_15_1.time_ - var_18_6) / var_18_7)
				arg_15_1.mask_.color = var_18_8
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				local var_18_9 = Color.New(0, 0, 0)

				var_18_9.a = 1
				arg_15_1.mask_.color = var_18_9
			end

			local var_18_10 = 1

			if 1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_11 = 2

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 then
				local var_18_12 = Color.New(0, 0, 0)

				var_18_12.a = Mathf.Lerp(1, 0, (arg_15_1.time_ - var_18_10) / var_18_11)
				arg_15_1.mask_.color = var_18_12
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 then
				local var_18_13 = Color.New(0, 0, 0)

				arg_15_1.mask_.enabled = false
				var_18_13.a = 0
				arg_15_1.mask_.color = var_18_13
			end

			if arg_15_1.frameCnt_ <= 1 then
				arg_15_1.dialog_:SetActive(false)
			end

			local var_18_14 = 2.775
			local var_18_15 = 0.225

			if 2.775 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_16 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_16:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

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

				local var_18_17 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(414231004).content)

				arg_15_1.text_.text = var_18_17

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_19 = 9 <= 0 and var_18_15 or var_18_15 * (utf8.len(var_18_17) / 9)

				if (9 <= 0 and var_18_15 or var_18_15 * (utf8.len(var_18_17) / 9)) > 0 and var_18_15 < var_18_19 then
					arg_15_1.talkMaxDuration = var_18_19
					var_18_14 = var_18_14 + 0.3

					if var_18_19 + var_18_14 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_19 + var_18_14
					end
				end

				arg_15_1.text_.text = var_18_17
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_20 = var_18_14 + 0.3
			local var_18_21 = math.max(var_18_15, arg_15_1.talkMaxDuration)

			if var_18_14 + 0.3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_20 + var_18_21 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_20) / var_18_21

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_20 + var_18_21 and arg_15_1.time_ < var_18_20 + var_18_21 + arg_18_0 then
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
			if arg_21_1.actors_["102201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102201ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "102201ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "102201ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["102201ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["102201ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["102201ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["102201ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["102201ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos102201ui_story = var_24_3.localPosition

				arg_21_1:ShowWeapon(arg_21_1.var_["102201ui_story" .. "Animator"].transform, false)
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.08, -6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["102201ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect102201ui_story == nil then
				arg_21_1.var_.characterEffect102201ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect102201ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect102201ui_story then
				arg_21_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_1")
			end

			local var_24_8 = 0
			local var_24_9 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414231005).content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 17 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_10) / 17)

				if (17 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_10) / 17)) > 0 and var_24_9 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_13 and arg_21_1.time_ < var_24_8 + var_24_13 + arg_24_0 then
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
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["102201ui_story"]) and arg_25_1.var_.characterEffect102201ui_story == nil then
				arg_25_1.var_.characterEffect102201ui_story = arg_25_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["102201ui_story"]) then
				if arg_25_1.var_.characterEffect102201ui_story and not isNil(arg_25_1.actors_["102201ui_story"]) then
					arg_25_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_25_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["102201ui_story"]) and arg_25_1.var_.characterEffect102201ui_story then
				arg_25_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_25_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

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

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414231006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 17 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 17)

				if (17 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 17)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
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
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["102201ui_story"]) and arg_29_1.var_.characterEffect102201ui_story == nil then
				arg_29_1.var_.characterEffect102201ui_story = arg_29_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["102201ui_story"]) then
				if arg_29_1.var_.characterEffect102201ui_story and not isNil(arg_29_1.actors_["102201ui_story"]) then
					arg_29_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["102201ui_story"]) and arg_29_1.var_.characterEffect102201ui_story then
				arg_29_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			local var_32_2 = 0
			local var_32_3 = 0.125

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(414231007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 5 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 5)

				if (5 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 5)) > 0 and var_32_3 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_7 and arg_29_1.time_ < var_32_2 + var_32_7 + arg_32_0 then
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
			if arg_33_1.bgs_.H07h == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_36_0.name = "H07h"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.H07h = var_36_0
			end

			if 1.26666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 1.26666666666667 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.H07h

				arg_33_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "H07h" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 1.26666666666667

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 1.26666666666667

			if 1.26666666666667 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 1.6

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			local var_36_12 = arg_33_1.actors_["102201ui_story"].transform

			if 1.26666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 1.26666666666667 + arg_36_0 then
				arg_33_1.var_.moveOldPos102201ui_story = var_36_12.localPosition
			end

			local var_36_13 = 0.001

			if 1.26666666666667 <= arg_33_1.time_ and arg_33_1.time_ < 1.26666666666667 + var_36_13 then
				var_36_12.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 1.26666666666667) / var_36_13)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			if arg_33_1.time_ >= 1.26666666666667 + var_36_13 and arg_33_1.time_ < 1.26666666666667 + var_36_13 + arg_36_0 then
				var_36_12.localPosition = Vector3.New(0, 100, 0)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_14 = 2.76666666666667
			local var_36_15 = 0.225

			if 2.76666666666667 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_16 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_16:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[146].name)

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

				local var_36_17 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(414231008).content)

				arg_33_1.text_.text = var_36_17

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 9 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 9)

				if (9 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 9)) > 0 and var_36_15 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19
					var_36_14 = var_36_14 + 0.3

					if var_36_19 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_17
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = var_36_14 + 0.3
			local var_36_21 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_20 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_20) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_20 + var_36_21 and arg_33_1.time_ < var_36_20 + var_36_21 + arg_36_0 then
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
			local var_42_0 = 0.825

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[146].name)

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

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414231009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 33 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 33)

				if (33 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 33)) > 0 and var_42_0 < var_42_3 then
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
			local var_46_0 = 0.725

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414231010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 29 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 29)

				if (29 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 29)) > 0 and var_46_0 < var_46_3 then
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
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos102201ui_story = arg_47_1.actors_["102201ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["102201ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos102201ui_story, Vector3.New(0, -1.08, -6), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).z)
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles = arg_47_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["102201ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6)
				arg_47_1.actors_["102201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["102201ui_story"].transform.position).z)
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["102201ui_story"].transform.localEulerAngles = arg_47_1.actors_["102201ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["102201ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect102201ui_story == nil then
				arg_47_1.var_.characterEffect102201ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect102201ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect102201ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect102201ui_story then
				arg_47_1.var_.characterEffect102201ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("102201ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action4_2")
			end

			local var_50_4 = 0
			local var_50_5 = 0.3

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414231011).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 12 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 12)

				if (12 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_6) / 12)) > 0 and var_50_5 < var_50_8 then
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
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["102201ui_story"]) and arg_51_1.var_.characterEffect102201ui_story == nil then
				arg_51_1.var_.characterEffect102201ui_story = arg_51_1.actors_["102201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["102201ui_story"]) then
				if arg_51_1.var_.characterEffect102201ui_story and not isNil(arg_51_1.actors_["102201ui_story"]) then
					arg_51_1.var_.characterEffect102201ui_story.fillFlat = true
					arg_51_1.var_.characterEffect102201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["102201ui_story"]) and arg_51_1.var_.characterEffect102201ui_story then
				arg_51_1.var_.characterEffect102201ui_story.fillFlat = true
				arg_51_1.var_.characterEffect102201ui_story.fillRatio = 0.5
			end

			local var_54_1 = arg_51_1.actors_["102201ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos102201ui_story = var_54_1.localPosition
			end

			local var_54_2 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 then
				var_54_1.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos102201ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_2)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 then
				var_54_1.localPosition = Vector3.New(0, 100, 0)
				var_54_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_1.position).x, (manager.ui.mainCamera.transform.position - var_54_1.position).y, (manager.ui.mainCamera.transform.position - var_54_1.position).z)
				var_54_1.localEulerAngles.z = 0
				var_54_1.localEulerAngles.x = 0
				var_54_1.localEulerAngles = var_54_1.localEulerAngles
			end

			local var_54_3 = 0
			local var_54_4 = 0.8

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414231012).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 32 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 32)

				if (32 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 32)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
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
