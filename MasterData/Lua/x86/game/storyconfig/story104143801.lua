return {
	Play414381001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414381001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414381002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07f")
				var_4_0.name = "H07f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07f

				arg_1_1.bgs_.H07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07f" then
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

			local var_4_8 = "104902ui_story"

			if arg_1_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["104902ui_story"].transform

			if 1.76666666666733 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666733 + arg_4_0 then
				arg_1_1.var_.moveOldPos104902ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.76666666666733 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666733 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_1_1.time_ - 1.76666666666733) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.76666666666733 + var_4_13 and arg_1_1.time_ < 1.76666666666733 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.2, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["104902ui_story"]

			if 1.76666666666733 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666733 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect104902ui_story == nil then
				arg_1_1.var_.characterEffect104902ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.76666666666733 <= arg_1_1.time_ and arg_1_1.time_ < 1.76666666666733 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect104902ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.76666666666733 + var_4_15 and arg_1_1.time_ < 1.76666666666733 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect104902ui_story then
				arg_1_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 1.76666666666733 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666733 + arg_4_0 then
				arg_1_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1.76666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.76666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 2
			local var_4_18 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414381001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 10 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 10)

				if (10 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 10)) > 0 and var_4_18 < var_4_22 then
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
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.76666666666733,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play414381002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 414381002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play414381003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["104902ui_story"]) and arg_7_1.var_.characterEffect104902ui_story == nil then
				arg_7_1.var_.characterEffect104902ui_story = arg_7_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["104902ui_story"]) then
				if arg_7_1.var_.characterEffect104902ui_story and not isNil(arg_7_1.actors_["104902ui_story"]) then
					arg_7_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_7_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["104902ui_story"]) and arg_7_1.var_.characterEffect104902ui_story then
				arg_7_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_7_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 0.45

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(414381002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 18 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 18)

				if (18 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 18)) > 0 and var_10_2 < var_10_5 then
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
	Play414381003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 414381003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play414381004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.625

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
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

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(414381003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 25)

				if (25 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 25)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play414381004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414381004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414381005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos104902ui_story = arg_15_1.actors_["104902ui_story"].transform.localPosition

				arg_15_1:ShowWeapon(arg_15_1.var_["104902ui_story" .. "Animator"].transform, false)
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).z)
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles = arg_15_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_15_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["104902ui_story"].transform.position).z)
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["104902ui_story"].transform.localEulerAngles = arg_15_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["104902ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect104902ui_story == nil then
				arg_15_1.var_.characterEffect104902ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect104902ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect104902ui_story then
				arg_15_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action6_1")
			end

			local var_18_4 = 0
			local var_18_5 = 0.25

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_6 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(414381004).content)

				arg_15_1.text_.text = var_18_6

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_8 = 10 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 10)

				if (10 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 10)) > 0 and var_18_5 < var_18_8 then
					arg_15_1.talkMaxDuration = var_18_8

					if var_18_8 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_8 + var_18_4
					end
				end

				arg_15_1.text_.text = var_18_6
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_9 = math.max(var_18_5, arg_15_1.talkMaxDuration)

			if var_18_4 <= arg_15_1.time_ and arg_15_1.time_ < var_18_4 + var_18_9 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_4) / var_18_9

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_4 + var_18_9 and arg_15_1.time_ < var_18_4 + var_18_9 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414381005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 414381005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play414381006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos104902ui_story = arg_19_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).z)
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles = arg_19_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["104902ui_story"].transform.position).z)
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["104902ui_story"].transform.localEulerAngles = arg_19_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["104902ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect104902ui_story == nil then
				arg_19_1.var_.characterEffect104902ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect104902ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_19_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_2)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect104902ui_story then
				arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_19_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_22_3 = 0
			local var_22_4 = 1

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

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(414381005).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 40 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 40)

				if (40 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 40)) > 0 and var_22_4 < var_22_7 then
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
				actorName = "104902ui_story",
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
	Play414381006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414381006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414381007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.475

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

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

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(414381006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 19 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 19)

				if (19 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 19)) > 0 and var_26_0 < var_26_3 then
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
	Play414381007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414381007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414381008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos104902ui_story = arg_27_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).z)
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles = arg_27_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_27_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["104902ui_story"].transform.position).z)
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["104902ui_story"].transform.localEulerAngles = arg_27_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["104902ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect104902ui_story == nil then
				arg_27_1.var_.characterEffect104902ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect104902ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect104902ui_story then
				arg_27_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action6_2")
			end

			local var_30_4 = 0
			local var_30_5 = 0.7

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(414381007).content)

				arg_27_1.text_.text = var_30_6

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_8 = 28 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_6) / 28)

				if (28 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_6) / 28)) > 0 and var_30_5 < var_30_8 then
					arg_27_1.talkMaxDuration = var_30_8

					if var_30_8 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_6
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_9 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_9 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_9

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_9 and arg_27_1.time_ < var_30_4 + var_30_9 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414381008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414381008
		arg_31_1.duration_ = 1

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"

			SetActive(arg_31_1.choicesGo_, true)

			for iter_32_0, iter_32_1 in ipairs(arg_31_1.choices_) do
				SetActive(iter_32_1.go, iter_32_0 <= 2)
			end

			arg_31_1.choices_[1].txt.text = arg_31_1:FormatText(StoryChoiceCfg[916].name)
			arg_31_1.choices_[2].txt.text = arg_31_1:FormatText(StoryChoiceCfg[917].name)
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play414381009(arg_31_1)
			end

			if arg_33_0 == 2 then
				arg_31_0:Play414381009(arg_31_1)
			end

			arg_31_1:RecordChoiceLog(414381008, 916, 917)
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["104902ui_story"]) and arg_31_1.var_.characterEffect104902ui_story == nil then
				arg_31_1.var_.characterEffect104902ui_story = arg_31_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["104902ui_story"]) then
				if arg_31_1.var_.characterEffect104902ui_story and not isNil(arg_31_1.actors_["104902ui_story"]) then
					arg_31_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_31_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["104902ui_story"]) and arg_31_1.var_.characterEffect104902ui_story then
				arg_31_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_31_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play414381009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414381009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414381010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos104902ui_story = arg_35_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).z)
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles = arg_35_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_35_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["104902ui_story"].transform.position).z)
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["104902ui_story"].transform.localEulerAngles = arg_35_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["104902ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect104902ui_story == nil then
				arg_35_1.var_.characterEffect104902ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect104902ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect104902ui_story then
				arg_35_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			local var_38_4 = "104902ui_story"

			if arg_35_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_38_5 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_35_1.stage_.transform)

				var_38_5.name = var_38_4
				var_38_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_[var_38_4] = var_38_5

				local var_38_6 = var_38_5:GetComponentInChildren(typeof(CharacterEffect))

				var_38_6.enabled = true

				local var_38_7 = GameObjectTools.GetOrAddComponent(var_38_5, typeof(DynamicBoneHelper))

				if var_38_7 then
					var_38_7:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_6.transform, false)

				arg_35_1.var_[var_38_4 .. "Animator"] = var_38_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_[var_38_4 .. "Animator"].applyRootMotion = true
				arg_35_1.var_[var_38_4 .. "LipSync"] = var_38_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_38_8 = "104902ui_story"

			if arg_35_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_38_9 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_35_1.stage_.transform)

				var_38_9.name = var_38_8
				var_38_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_[var_38_8] = var_38_9

				local var_38_10 = var_38_9:GetComponentInChildren(typeof(CharacterEffect))

				var_38_10.enabled = true

				local var_38_11 = GameObjectTools.GetOrAddComponent(var_38_9, typeof(DynamicBoneHelper))

				if var_38_11 then
					var_38_11:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_10.transform, false)

				arg_35_1.var_[var_38_8 .. "Animator"] = var_38_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_[var_38_8 .. "Animator"].applyRootMotion = true
				arg_35_1.var_[var_38_8 .. "LipSync"] = var_38_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_38_12 = 0
			local var_38_13 = 0.225

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414381009).content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 9 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 9)

				if (9 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 9)) > 0 and var_38_13 < var_38_16 then
					arg_35_1.talkMaxDuration = var_38_16

					if var_38_16 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_16 + var_38_12
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_17 = math.max(var_38_13, arg_35_1.talkMaxDuration)

			if var_38_12 <= arg_35_1.time_ and arg_35_1.time_ < var_38_12 + var_38_17 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_12) / var_38_17

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_12 + var_38_17 and arg_35_1.time_ < var_38_12 + var_38_17 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
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
	Play414381010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414381010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414381011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["104902ui_story"]) and arg_39_1.var_.characterEffect104902ui_story == nil then
				arg_39_1.var_.characterEffect104902ui_story = arg_39_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["104902ui_story"]) then
				if arg_39_1.var_.characterEffect104902ui_story and not isNil(arg_39_1.actors_["104902ui_story"]) then
					arg_39_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_39_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["104902ui_story"]) and arg_39_1.var_.characterEffect104902ui_story then
				arg_39_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_39_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.65

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414381010).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 26 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 26)

				if (26 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 26)) > 0 and var_42_2 < var_42_5 then
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
	Play414381011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414381011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414381012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos104902ui_story = arg_43_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).z)
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles = arg_43_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_43_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["104902ui_story"].transform.position).z)
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["104902ui_story"].transform.localEulerAngles = arg_43_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["104902ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect104902ui_story == nil then
				arg_43_1.var_.characterEffect104902ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect104902ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect104902ui_story then
				arg_43_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_46_4 = 0
			local var_46_5 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414381011).content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 13)

				if (13 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 13)) > 0 and var_46_5 < var_46_8 then
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
				actorName = "104902ui_story",
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
	Play414381012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414381012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414381013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["104902ui_story"]) and arg_47_1.var_.characterEffect104902ui_story == nil then
				arg_47_1.var_.characterEffect104902ui_story = arg_47_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["104902ui_story"]) then
				if arg_47_1.var_.characterEffect104902ui_story and not isNil(arg_47_1.actors_["104902ui_story"]) then
					arg_47_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_47_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["104902ui_story"]) and arg_47_1.var_.characterEffect104902ui_story then
				arg_47_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_47_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.475

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

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

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414381012).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 19 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 19)

				if (19 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 19)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play414381013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414381013
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
			local var_54_0 = 0.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
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

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414381013).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 6 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 6)

				if (6 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 6)) > 0 and var_54_0 < var_54_3 then
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
	assets = {
		"TextureConfig/Background/H07f"
	},
	voices = {}
}
