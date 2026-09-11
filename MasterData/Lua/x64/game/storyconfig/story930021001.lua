return {
	Play930021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 930021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play930021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_4_0.name = "ST10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST10

				arg_1_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1066ui_story"

			if arg_1_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1066ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.77, -6.1)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1066ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2.00000000298023
			local var_4_19 = 0.475

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(930021001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 19 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 19)

				if (19 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 19)) > 0 and var_4_19 < var_4_23 then
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
				actorName = "1066ui_story",
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
	Play930021002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 930021002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play930021003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1066ui_story = arg_7_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_10_0 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				arg_7_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["1066ui_story"].transform.position).z)
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["1066ui_story"].transform.localEulerAngles = arg_7_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				arg_7_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_7_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_2)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_2 and arg_7_1.time_ < 0 + var_10_2 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect1066ui_story then
				arg_7_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_10_3 = 0
			local var_10_4 = 1.5

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_3 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_5 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(930021002).content)

				arg_7_1.text_.text = var_10_5

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_7 = 60 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 60)

				if (60 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 60)) > 0 and var_10_4 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_3 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_3
					end
				end

				arg_7_1.text_.text = var_10_5
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_4, arg_7_1.talkMaxDuration)

			if var_10_3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_3 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_3) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_3 + var_10_8 and arg_7_1.time_ < var_10_3 + var_10_8 + arg_10_0 then
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
	Play930021003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 930021003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play930021004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.225

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

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(930021003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 9 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 9)

				if (9 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 9)) > 0 and var_14_0 < var_14_3 then
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
	Play930021004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 930021004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play930021005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1066ui_story = arg_15_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).z)
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles = arg_15_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_15_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1066ui_story"].transform.position).z)
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1066ui_story"].transform.localEulerAngles = arg_15_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["1066ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1066ui_story == nil then
				arg_15_1.var_.characterEffect1066ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect1066ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1066ui_story then
				arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_18_4 = 0
			local var_18_5 = 0.15

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
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

				local var_18_6 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(930021004).content)

				arg_15_1.text_.text = var_18_6

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_8 = 6 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 6)

				if (6 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 6)) > 0 and var_18_5 < var_18_8 then
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
				actorName = "1066ui_story",
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
	Play930021005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 930021005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play930021006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1066ui_story = arg_19_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1066ui_story"].transform.position).z)
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1066ui_story"].transform.localEulerAngles = arg_19_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_19_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_2)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1066ui_story then
				arg_19_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_22_3 = 0
			local var_22_4 = 1.1

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

				local var_22_5 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(930021005).content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 44 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 44)

				if (44 <= 0 and var_22_4 or var_22_4 * (utf8.len(var_22_5) / 44)) > 0 and var_22_4 < var_22_7 then
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
				actorName = "1066ui_story",
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
	Play930021006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 930021006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play930021007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1066ui_story = arg_23_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1066ui_story"].transform.position).z)
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1066ui_story"].transform.localEulerAngles = arg_23_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
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
					arg_23_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1066ui_story then
				arg_23_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_2")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_26_4 = 0
			local var_26_5 = 0.275

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
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

				local var_26_6 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(930021006).content)

				arg_23_1.text_.text = var_26_6

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_8 = 11 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_6) / 11)

				if (11 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_6) / 11)) > 0 and var_26_5 < var_26_8 then
					arg_23_1.talkMaxDuration = var_26_8

					if var_26_8 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_8 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_6
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_9 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_9 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_9

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_9 and arg_23_1.time_ < var_26_4 + var_26_9 + arg_26_0 then
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
	Play930021007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 930021007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play930021008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1066ui_story = arg_27_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).z)
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles = arg_27_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_27_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1066ui_story"].transform.position).z)
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1066ui_story"].transform.localEulerAngles = arg_27_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_30_1 = 0
			local var_30_2 = 0.775

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(930021007).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 31 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 31)

				if (31 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 31)) > 0 and var_30_2 < var_30_5 then
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
				actorName = "1066ui_story",
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
	Play930021008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 930021008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play930021009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1066ui_story"]) and arg_31_1.var_.characterEffect1066ui_story == nil then
				arg_31_1.var_.characterEffect1066ui_story = arg_31_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1066ui_story"]) then
				if arg_31_1.var_.characterEffect1066ui_story and not isNil(arg_31_1.actors_["1066ui_story"]) then
					arg_31_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1066ui_story"]) and arg_31_1.var_.characterEffect1066ui_story then
				arg_31_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
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

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(930021008).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 18 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 18)

				if (18 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 18)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play930021009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 930021009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play930021010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1066ui_story = arg_35_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).z)
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles = arg_35_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_35_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1066ui_story"].transform.position).z)
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1066ui_story"].transform.localEulerAngles = arg_35_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1066ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1066ui_story == nil then
				arg_35_1.var_.characterEffect1066ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1066ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1066ui_story then
				arg_35_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action438")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_38_4 = 0
			local var_38_5 = 0.125

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(930021009).content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_8 = 5 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 5)

				if (5 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 5)) > 0 and var_38_5 < var_38_8 then
					arg_35_1.talkMaxDuration = var_38_8

					if var_38_8 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_6
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_9 and arg_35_1.time_ < var_38_4 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play930021010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 930021010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play930021011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1066ui_story = arg_39_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).z)
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles = arg_39_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1066ui_story"].transform.position).z)
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1066ui_story"].transform.localEulerAngles = arg_39_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1066ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1066ui_story == nil then
				arg_39_1.var_.characterEffect1066ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1066ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_2)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1066ui_story then
				arg_39_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_42_3 = 0
			local var_42_4 = 0.625

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(930021010).content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 25 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 25)

				if (25 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 25)) > 0 and var_42_4 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_8 and arg_39_1.time_ < var_42_3 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play930021011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 930021011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play930021012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["1044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1044ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "1044ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1044ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["1044ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["1044ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["1044ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["1044ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1044ui_story = var_46_3.localPosition
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1044ui_story, Vector3.New(0, -1, -5.93), (arg_43_1.time_ - 0) / var_46_4)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(0, -1, -5.93)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			local var_46_5 = arg_43_1.actors_["1044ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1044ui_story == nil then
				arg_43_1.var_.characterEffect1044ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.characterEffect1044ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1044ui_story then
				arg_43_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_46_8 = 0
			local var_46_9 = 0.175

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(930021011).content)

				arg_43_1.text_.text = var_46_10

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_12 = 7 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_10) / 7)

				if (7 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_10) / 7)) > 0 and var_46_9 < var_46_12 then
					arg_43_1.talkMaxDuration = var_46_12

					if var_46_12 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_10
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_13 and arg_43_1.time_ < var_46_8 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play930021012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 930021012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play930021013(arg_47_1)
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

			local var_50_1 = arg_47_1.actors_["1066ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1066ui_story = var_50_1.localPosition
			end

			local var_50_2 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 then
				var_50_1.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (arg_47_1.time_ - 0) / var_50_2)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 then
				var_50_1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			local var_50_3 = arg_47_1.actors_["1066ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1066ui_story == nil then
				arg_47_1.var_.characterEffect1066ui_story = var_50_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_4 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 and not isNil(var_50_3) then
				if arg_47_1.var_.characterEffect1066ui_story and not isNil(var_50_3) then
					arg_47_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1066ui_story then
				arg_47_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_50_6 = arg_47_1.actors_["1044ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1044ui_story == nil then
				arg_47_1.var_.characterEffect1044ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_7 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 and not isNil(var_50_6) then
				if arg_47_1.var_.characterEffect1044ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_7)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1044ui_story then
				arg_47_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_50_8 = 0
			local var_50_9 = 0.65

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
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

				local var_50_10 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(930021012).content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 28 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 28)

				if (28 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_10) / 28)) > 0 and var_50_9 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12

					if var_50_12 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_13 and arg_47_1.time_ < var_50_8 + var_50_13 + arg_50_0 then
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

		arg_47_1:InitPlayNodeList()
	end,
	Play930021013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 930021013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play930021014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1044ui_story = arg_51_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).z)
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles = arg_51_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_51_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1044ui_story"].transform.position).z)
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1044ui_story"].transform.localEulerAngles = arg_51_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1044ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1044ui_story == nil then
				arg_51_1.var_.characterEffect1044ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1044ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1044ui_story then
				arg_51_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_54_4 = arg_51_1.actors_["1066ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1066ui_story == nil then
				arg_51_1.var_.characterEffect1066ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_5 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 and not isNil(var_54_4) then
				if arg_51_1.var_.characterEffect1066ui_story and not isNil(var_54_4) then
					arg_51_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_5)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1066ui_story then
				arg_51_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_54_6 = 0
			local var_54_7 = 0.525

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(930021013).content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 21 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 21)

				if (21 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 21)) > 0 and var_54_7 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_11 and arg_51_1.time_ < var_54_6 + var_54_11 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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

		arg_51_1:InitPlayNodeList()
	end,
	Play930021014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 930021014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play930021015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1044ui_story"]) and arg_55_1.var_.characterEffect1044ui_story == nil then
				arg_55_1.var_.characterEffect1044ui_story = arg_55_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1044ui_story"]) then
				if arg_55_1.var_.characterEffect1044ui_story and not isNil(arg_55_1.actors_["1044ui_story"]) then
					arg_55_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1044ui_story"]) and arg_55_1.var_.characterEffect1044ui_story then
				arg_55_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.725

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
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

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(930021014).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 29 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 29)

				if (29 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 29)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play930021015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 930021015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play930021016(arg_59_1)
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
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_62_4 = 0
			local var_62_5 = 1.05

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

				local var_62_6 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(930021015).content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 42 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 42)

				if (42 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_6) / 42)) > 0 and var_62_5 < var_62_8 then
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
	Play930021016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 930021016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play930021017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.9

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
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

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(930021016).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 36 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 36)

				if (36 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 36)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play930021017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 930021017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play930021018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) and arg_67_1.var_.characterEffect1066ui_story == nil then
				arg_67_1.var_.characterEffect1066ui_story = arg_67_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) then
				if arg_67_1.var_.characterEffect1066ui_story and not isNil(arg_67_1.actors_["1066ui_story"]) then
					arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) and arg_67_1.var_.characterEffect1066ui_story then
				arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.425

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
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

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(930021017).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 17 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 17)

				if (17 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 17)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play930021018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 930021018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play930021019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1066ui_story"]) and arg_71_1.var_.characterEffect1066ui_story == nil then
				arg_71_1.var_.characterEffect1066ui_story = arg_71_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1066ui_story"]) then
				if arg_71_1.var_.characterEffect1066ui_story and not isNil(arg_71_1.actors_["1066ui_story"]) then
					arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1066ui_story"]) and arg_71_1.var_.characterEffect1066ui_story then
				arg_71_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action434")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_2 = 0
			local var_74_3 = 0.15

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
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

				local var_74_4 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(930021018).content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 6 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 6)

				if (6 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_4) / 6)) > 0 and var_74_3 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_7 and arg_71_1.time_ < var_74_2 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play930021019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 930021019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play930021020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1044ui_story = arg_75_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1044ui_story, Vector3.New(-0.7, -1, -5.93), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).z)
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles = arg_75_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.93)
				arg_75_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1044ui_story"].transform.position).z)
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1044ui_story"].transform.localEulerAngles = arg_75_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1044ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1044ui_story == nil then
				arg_75_1.var_.characterEffect1044ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1044ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1044ui_story then
				arg_75_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["1066ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1066ui_story == nil then
				arg_75_1.var_.characterEffect1066ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect1066ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1066ui_story then
				arg_75_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action5_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_78_6 = 0
			local var_78_7 = 0.575

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(930021019).content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 23 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 23)

				if (23 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 23)) > 0 and var_78_7 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_11 and arg_75_1.time_ < var_78_6 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play930021020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 930021020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play930021021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1066ui_story"]) and arg_79_1.var_.characterEffect1066ui_story == nil then
				arg_79_1.var_.characterEffect1066ui_story = arg_79_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1066ui_story"]) then
				if arg_79_1.var_.characterEffect1066ui_story and not isNil(arg_79_1.actors_["1066ui_story"]) then
					arg_79_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1066ui_story"]) and arg_79_1.var_.characterEffect1066ui_story then
				arg_79_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["1044ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1044ui_story == nil then
				arg_79_1.var_.characterEffect1044ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect1044ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1044ui_story then
				arg_79_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1044ui_story.fillRatio = 0.5
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 0.425

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(930021020).content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_8 = 17 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_6) / 17)

				if (17 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_6) / 17)) > 0 and var_82_5 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_9 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_9 and arg_79_1.time_ < var_82_4 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play930021021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 930021021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play930021022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1066ui_story = arg_83_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).z)
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles = arg_83_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1066ui_story"].transform.position).z)
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1066ui_story"].transform.localEulerAngles = arg_83_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1044ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1044ui_story = var_86_1.localPosition
			end

			local var_86_2 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1044ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_2)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(0, 100, 0)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			local var_86_3 = arg_83_1.actors_["1066ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1066ui_story == nil then
				arg_83_1.var_.characterEffect1066ui_story = var_86_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.characterEffect1066ui_story and not isNil(var_86_3) then
					arg_83_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_4)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1066ui_story then
				arg_83_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_86_5 = 0
			local var_86_6 = 0.95

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(930021021).content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 38 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 38)

				if (38 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_7) / 38)) > 0 and var_86_6 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_10 and arg_83_1.time_ < var_86_5 + var_86_10 + arg_86_0 then
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
				actorName = "1044ui_story",
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
	Play930021022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 930021022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play930021023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1066ui_story = arg_87_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).z)
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles = arg_87_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_87_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).z)
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles = arg_87_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1066ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1066ui_story == nil then
				arg_87_1.var_.characterEffect1066ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1066ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1066ui_story then
				arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_90_4 = 0
			local var_90_5 = 0.675

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
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

				local var_90_6 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(930021022).content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 27 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_6) / 27)

				if (27 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_6) / 27)) > 0 and var_90_5 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_9 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_9 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_9

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_9 and arg_87_1.time_ < var_90_4 + var_90_9 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play930021023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 930021023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play930021024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1044ui_story = arg_91_1.actors_["1044ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1044ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1044ui_story, Vector3.New(0.7, -1, -5.93), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).z)
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles = arg_91_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1044ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.93)
				arg_91_1.actors_["1044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1044ui_story"].transform.position).z)
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1044ui_story"].transform.localEulerAngles = arg_91_1.actors_["1044ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1044ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1044ui_story == nil then
				arg_91_1.var_.characterEffect1044ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1044ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1044ui_story then
				arg_91_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["1066ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1066ui_story == nil then
				arg_91_1.var_.characterEffect1066ui_story = var_94_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_5 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 and not isNil(var_94_4) then
				if arg_91_1.var_.characterEffect1066ui_story and not isNil(var_94_4) then
					arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_5)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 and not isNil(var_94_4) and arg_91_1.var_.characterEffect1066ui_story then
				arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_94_6 = 0
			local var_94_7 = 0.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1367].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(930021023).content)

				arg_91_1.text_.text = var_94_8

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 12 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_8) / 12)

				if (12 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_8) / 12)) > 0 and var_94_7 < var_94_10 then
					arg_91_1.talkMaxDuration = var_94_10

					if var_94_10 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_8
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_11 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_11 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_11

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_11 and arg_91_1.time_ < var_94_6 + var_94_11 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play930021024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 930021024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
			arg_95_1.auto_ = false
		end

		function arg_95_1.playNext_(arg_97_0)
			arg_95_1.onStoryFinished_()
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1044ui_story"]) and arg_95_1.var_.characterEffect1044ui_story == nil then
				arg_95_1.var_.characterEffect1044ui_story = arg_95_1.actors_["1044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1044ui_story"]) then
				if arg_95_1.var_.characterEffect1044ui_story and not isNil(arg_95_1.actors_["1044ui_story"]) then
					arg_95_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1044ui_story"]) and arg_95_1.var_.characterEffect1044ui_story then
				arg_95_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_98_2 = arg_95_1.actors_["1066ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1066ui_story == nil then
				arg_95_1.var_.characterEffect1066ui_story = var_98_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_3 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.characterEffect1066ui_story and not isNil(var_98_2) then
					arg_95_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.characterEffect1066ui_story then
				arg_95_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action493")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_98_5 = 0
			local var_98_6 = 0.125

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1415].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(930021024).content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 5 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 5)

				if (5 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 5)) > 0 and var_98_6 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_10 and arg_95_1.time_ < var_98_5 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST10"
	},
	voices = {}
}
