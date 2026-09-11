return {
	Play414351001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414351001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414351002(arg_1_1)
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
			local var_4_10 = 0.825

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

				local var_4_12 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414351001).content)

				arg_1_1.text_.text = var_4_12

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_14 = 33 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 33)

				if (33 <= 0 and var_4_10 or var_4_10 * (utf8.len(var_4_12) / 33)) > 0 and var_4_10 < var_4_14 then
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
	Play414351002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 414351002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play414351003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.2

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

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(414351002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 48 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 48)

				if (48 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 48)) > 0 and var_10_0 < var_10_3 then
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
	Play414351003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 414351003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play414351004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "104902ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["104902ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["104902ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["104902ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["104902ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["104902ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos104902ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0, -1.2, -6)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["104902ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect104902ui_story == nil then
				arg_11_1.var_.characterEffect104902ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect104902ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect104902ui_story then
				arg_11_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action4_1")
			end

			local var_14_8 = 0
			local var_14_9 = 0.4

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(414351003).content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_12 = 16 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 16)

				if (16 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 16)) > 0 and var_14_9 < var_14_12 then
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
				actorName = "104902ui_story",
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
	Play414351004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414351004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414351005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["104902ui_story"]) and arg_15_1.var_.characterEffect104902ui_story == nil then
				arg_15_1.var_.characterEffect104902ui_story = arg_15_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["104902ui_story"]) then
				if arg_15_1.var_.characterEffect104902ui_story and not isNil(arg_15_1.actors_["104902ui_story"]) then
					arg_15_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_15_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["104902ui_story"]) and arg_15_1.var_.characterEffect104902ui_story then
				arg_15_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_15_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 0.8

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
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

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(414351004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 27 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 27)

				if (27 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 27)) > 0 and var_18_2 < var_18_5 then
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

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play414351005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 414351005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play414351006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) and arg_19_1.var_.characterEffect104902ui_story == nil then
				arg_19_1.var_.characterEffect104902ui_story = arg_19_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) then
				if arg_19_1.var_.characterEffect104902ui_story and not isNil(arg_19_1.actors_["104902ui_story"]) then
					arg_19_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) and arg_19_1.var_.characterEffect104902ui_story then
				arg_19_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action4_2")
			end

			local var_22_2 = 0
			local var_22_3 = 1.075

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(414351005).content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 43 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 43)

				if (43 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 43)) > 0 and var_22_3 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_7 and arg_19_1.time_ < var_22_2 + var_22_7 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play414351006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414351006
		arg_23_1.duration_ = 1

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"

			SetActive(arg_23_1.choicesGo_, true)

			for iter_24_0, iter_24_1 in ipairs(arg_23_1.choices_) do
				SetActive(iter_24_1.go, iter_24_0 <= 2)
			end

			arg_23_1.choices_[1].txt.text = arg_23_1:FormatText(StoryChoiceCfg[914].name)
			arg_23_1.choices_[2].txt.text = arg_23_1:FormatText(StoryChoiceCfg[915].name)
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414351007(arg_23_1)
			end

			if arg_25_0 == 2 then
				arg_23_0:Play414351008(arg_23_1)
			end

			arg_23_1:RecordChoiceLog(414351006, 914, 915)
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["104902ui_story"]) and arg_23_1.var_.characterEffect104902ui_story == nil then
				arg_23_1.var_.characterEffect104902ui_story = arg_23_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["104902ui_story"]) then
				if arg_23_1.var_.characterEffect104902ui_story and not isNil(arg_23_1.actors_["104902ui_story"]) then
					arg_23_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_23_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["104902ui_story"]) and arg_23_1.var_.characterEffect104902ui_story then
				arg_23_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_23_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play414351007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414351007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414351009(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.575

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

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

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(414351007).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 23 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 23)

				if (23 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 23)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play414351009 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414351009
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
			arg_31_1.auto_ = false
		end

		function arg_31_1.playNext_(arg_33_0)
			arg_31_1.onStoryFinished_()
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(414351009).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 40 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 40)

				if (40 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 40)) > 0 and var_34_0 < var_34_3 then
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
	Play414351008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414351008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414351009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.65

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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414351008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 26 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 26)

				if (26 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 26)) > 0 and var_38_0 < var_38_3 then
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
	assets = {
		"TextureConfig/Background/H07f"
	},
	voices = {}
}
