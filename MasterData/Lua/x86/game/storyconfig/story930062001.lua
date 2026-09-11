return {
	Play930062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 930062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play930062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST42a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST42a")
				var_4_0.name = "ST42a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST42a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST42a

				arg_1_1.bgs_.ST42a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST42a" then
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

			local var_4_9 = "1072ui_story"

			if arg_1_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1072ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.71, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1072ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(930062001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 26 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 26)

				if (26 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 26)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play930062002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 930062002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play930062003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_10_0 = 0
			local var_10_1 = 0.625

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(930062002).content)

				arg_7_1.text_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 25 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_2) / 25)

				if (25 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_2) / 25)) > 0 and var_10_1 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_2
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_5 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_5 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_5

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_5 and arg_7_1.time_ < var_10_0 + var_10_5 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play930062003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 930062003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play930062004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(arg_11_1.actors_["1072ui_story"]) and arg_11_1.var_.characterEffect1072ui_story == nil then
				arg_11_1.var_.characterEffect1072ui_story = arg_11_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_0 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 and not isNil(arg_11_1.actors_["1072ui_story"]) then
				if arg_11_1.var_.characterEffect1072ui_story and not isNil(arg_11_1.actors_["1072ui_story"]) then
					arg_11_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_0)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 and not isNil(arg_11_1.actors_["1072ui_story"]) and arg_11_1.var_.characterEffect1072ui_story then
				arg_11_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_14_1 = 0
			local var_14_2 = 1.65

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(930062003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 66 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 66)

				if (66 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 66)) > 0 and var_14_2 < var_14_5 then
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
	Play930062004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 930062004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play930062005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.175

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

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(930062004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 7)

				if (7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 7)) > 0 and var_18_0 < var_18_3 then
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
	Play930062005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 930062005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play930062006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1044ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1044ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1044ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1044ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1044ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1044ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1044ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1044ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(-0.7, -1, -5.93)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1044ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1044ui_story == nil then
				arg_19_1.var_.characterEffect1044ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1044ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1044ui_story then
				arg_19_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action4_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_22_8 = arg_19_1.actors_["1072ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1072ui_story = var_22_8.localPosition
			end

			local var_22_9 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 then
				var_22_8.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_19_1.time_ - 0) / var_22_9)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 then
				var_22_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			local var_22_10 = 0
			local var_22_11 = 0.6

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_12 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(930062005).content)

				arg_19_1.text_.text = var_22_12

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_14 = 24 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_12) / 24)

				if (24 <= 0 and var_22_11 or var_22_11 * (utf8.len(var_22_12) / 24)) > 0 and var_22_11 < var_22_14 then
					arg_19_1.talkMaxDuration = var_22_14

					if var_22_14 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_10
					end
				end

				arg_19_1.text_.text = var_22_12
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_15 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_15 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_10) / var_22_15

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_10 + var_22_15 and arg_19_1.time_ < var_22_10 + var_22_15 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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
				actorName = "1072ui_story",
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
	Play930062006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 930062006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play930062007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1072ui_story = arg_23_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).z)
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles = arg_23_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_23_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1072ui_story"].transform.position).z)
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1072ui_story"].transform.localEulerAngles = arg_23_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1072ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1072ui_story == nil then
				arg_23_1.var_.characterEffect1072ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1072ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1072ui_story then
				arg_23_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_26_4 = arg_23_1.actors_["1044ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect1044ui_story == nil then
				arg_23_1.var_.characterEffect1044ui_story = var_26_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_5 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_5 and not isNil(var_26_4) then
				if arg_23_1.var_.characterEffect1044ui_story and not isNil(var_26_4) then
					arg_23_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_5)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_5 and arg_23_1.time_ < 0 + var_26_5 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.characterEffect1044ui_story then
				arg_23_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_26_6 = 0
			local var_26_7 = 1.275

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_8 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(930062006).content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 51 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 51)

				if (51 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 51)) > 0 and var_26_7 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_11 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_11 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_11

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_11 and arg_23_1.time_ < var_26_6 + var_26_11 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play930062007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 930062007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play930062008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1072ui_story = arg_27_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).z)
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles = arg_27_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_27_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1072ui_story"].transform.position).z)
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1072ui_story"].transform.localEulerAngles = arg_27_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_30_1 = 0
			local var_30_2 = 1.1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(930062007).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 46 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 46)

				if (46 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 46)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play930062008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 930062008
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

			arg_31_1.choices_[1].txt.text = arg_31_1:FormatText(StoryChoiceCfg[1508].name)
			arg_31_1.choices_[2].txt.text = arg_31_1:FormatText(StoryChoiceCfg[1509].name)
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play930062009(arg_31_1)
			end

			if arg_33_0 == 2 then
				arg_31_0:Play930062009(arg_31_1)
			end

			arg_31_1:RecordChoiceLog(930062008, 1508, 1509)
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1072ui_story"]) and arg_31_1.var_.characterEffect1072ui_story == nil then
				arg_31_1.var_.characterEffect1072ui_story = arg_31_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1072ui_story"]) then
				if arg_31_1.var_.characterEffect1072ui_story and not isNil(arg_31_1.actors_["1072ui_story"]) then
					arg_31_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1072ui_story"]) and arg_31_1.var_.characterEffect1072ui_story then
				arg_31_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play930062009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 930062009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play930062010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1072ui_story = arg_35_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).z)
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles = arg_35_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_35_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1072ui_story"].transform.position).z)
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1072ui_story"].transform.localEulerAngles = arg_35_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1072ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1072ui_story == nil then
				arg_35_1.var_.characterEffect1072ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1072ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1072ui_story then
				arg_35_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_38_4 = "1072ui_story"

			if arg_35_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_38_5 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_35_1.stage_.transform)

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
				arg_35_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			local var_38_8 = "1072ui_story"

			if arg_35_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_38_9 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_35_1.stage_.transform)

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
				arg_35_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_38_12 = 0
			local var_38_13 = 0.55

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(930062009).content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 22 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 22)

				if (22 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 22)) > 0 and var_38_13 < var_38_16 then
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
				actorName = "1072ui_story",
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
	Play930062010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 930062010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play930062011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1044ui_story = arg_39_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).z)
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles = arg_39_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_39_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1044ui_story"].transform.position).z)
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1044ui_story"].transform.localEulerAngles = arg_39_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1044ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1044ui_story == nil then
				arg_39_1.var_.characterEffect1044ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1044ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1044ui_story then
				arg_39_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_42_4 = arg_39_1.actors_["1072ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1072ui_story == nil then
				arg_39_1.var_.characterEffect1072ui_story = var_42_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_5 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 and not isNil(var_42_4) then
				if arg_39_1.var_.characterEffect1072ui_story and not isNil(var_42_4) then
					arg_39_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_5)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1072ui_story then
				arg_39_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action443")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_42_6 = 0
			local var_42_7 = 0.575

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(930062010).content)

				arg_39_1.text_.text = var_42_8

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 23 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_8) / 23)

				if (23 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_8) / 23)) > 0 and var_42_7 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_8
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_11 and arg_39_1.time_ < var_42_6 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play930062011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 930062011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play930062012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1072ui_story"]) and arg_43_1.var_.characterEffect1072ui_story == nil then
				arg_43_1.var_.characterEffect1072ui_story = arg_43_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1072ui_story"]) then
				if arg_43_1.var_.characterEffect1072ui_story and not isNil(arg_43_1.actors_["1072ui_story"]) then
					arg_43_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1072ui_story"]) and arg_43_1.var_.characterEffect1072ui_story then
				arg_43_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["1044ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1044ui_story == nil then
				arg_43_1.var_.characterEffect1044ui_story = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect1044ui_story and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1044ui_story then
				arg_43_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_46_4 = 0
			local var_46_5 = 1.475

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(930062011).content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 59 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 59)

				if (59 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 59)) > 0 and var_46_5 < var_46_8 then
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

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play930062012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 930062012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play930062013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1044ui_story = arg_47_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).z)
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles = arg_47_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_47_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1044ui_story"].transform.position).z)
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1044ui_story"].transform.localEulerAngles = arg_47_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1044ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1044ui_story == nil then
				arg_47_1.var_.characterEffect1044ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1044ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1044ui_story then
				arg_47_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1072ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1072ui_story == nil then
				arg_47_1.var_.characterEffect1072ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1072ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1072ui_story then
				arg_47_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action438")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_50_6 = 0
			local var_50_7 = 0.575

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(930062012).content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 23 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 23)

				if (23 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 23)) > 0 and var_50_7 < var_50_10 then
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
				actorName = "1044ui_story",
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
	Play930062013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 930062013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play930062014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1044ui_story"]) and arg_51_1.var_.characterEffect1044ui_story == nil then
				arg_51_1.var_.characterEffect1044ui_story = arg_51_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1044ui_story"]) then
				if arg_51_1.var_.characterEffect1044ui_story and not isNil(arg_51_1.actors_["1044ui_story"]) then
					arg_51_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1044ui_story"]) and arg_51_1.var_.characterEffect1044ui_story then
				arg_51_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.3

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

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(930062013).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 12 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 12)

				if (12 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 12)) > 0 and var_54_2 < var_54_5 then
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
	Play930062014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 930062014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play930062015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1072ui_story = arg_55_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).z)
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles = arg_55_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_55_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1072ui_story"].transform.position).z)
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1072ui_story"].transform.localEulerAngles = arg_55_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1072ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1072ui_story == nil then
				arg_55_1.var_.characterEffect1072ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1072ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1072ui_story then
				arg_55_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_58_4 = 0
			local var_58_5 = 0.975

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(930062014).content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 39 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 39)

				if (39 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 39)) > 0 and var_58_5 < var_58_8 then
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

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play930062015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 930062015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play930062016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_62_0 = 0
			local var_62_1 = 1.35

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(930062015).content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 54 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_2) / 54)

				if (54 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_2) / 54)) > 0 and var_62_1 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_5 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_5 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_5

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_5 and arg_59_1.time_ < var_62_0 + var_62_5 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play930062016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 930062016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play930062017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1072ui_story"]) and arg_63_1.var_.characterEffect1072ui_story == nil then
				arg_63_1.var_.characterEffect1072ui_story = arg_63_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1072ui_story"]) then
				if arg_63_1.var_.characterEffect1072ui_story and not isNil(arg_63_1.actors_["1072ui_story"]) then
					arg_63_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1072ui_story"]) and arg_63_1.var_.characterEffect1072ui_story then
				arg_63_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.675

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

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(930062016).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 27 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 27)

				if (27 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 27)) > 0 and var_66_2 < var_66_5 then
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
	Play930062017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 930062017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play930062018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.7

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

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(930062017).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 28 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 28)

				if (28 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 28)) > 0 and var_70_0 < var_70_3 then
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
	Play930062018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 930062018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play930062019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1072ui_story = arg_71_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).z)
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles = arg_71_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_71_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1072ui_story"].transform.position).z)
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1072ui_story"].transform.localEulerAngles = arg_71_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1072ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1072ui_story == nil then
				arg_71_1.var_.characterEffect1072ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1072ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1072ui_story then
				arg_71_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_4 = 0
			local var_74_5 = 0.85

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(930062018).content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 34 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_6) / 34)

				if (34 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_6) / 34)) > 0 and var_74_5 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_9 and arg_71_1.time_ < var_74_4 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play930062019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 930062019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play930062020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1072ui_story = arg_75_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).z)
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles = arg_75_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_75_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1072ui_story"].transform.position).z)
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1072ui_story"].transform.localEulerAngles = arg_75_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_78_1 = 0
			local var_78_2 = 0.725

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(930062019).content)

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

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play930062020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 930062020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
			arg_79_1.auto_ = false
		end

		function arg_79_1.playNext_(arg_81_0)
			arg_79_1.onStoryFinished_()
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1072ui_story"]) and arg_79_1.var_.characterEffect1072ui_story == nil then
				arg_79_1.var_.characterEffect1072ui_story = arg_79_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1072ui_story"]) then
				if arg_79_1.var_.characterEffect1072ui_story and not isNil(arg_79_1.actors_["1072ui_story"]) then
					arg_79_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1072ui_story"]) and arg_79_1.var_.characterEffect1072ui_story then
				arg_79_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
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

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(930062020).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 8 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 8)

				if (8 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 8)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST42a"
	},
	voices = {}
}
