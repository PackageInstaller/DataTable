return {
	Play414391001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414391001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414391002(arg_1_1)
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

			local var_4_9 = "104902ui_story"

			if arg_1_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["104902ui_story"].transform

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPos104902ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_1_1.time_ - 1.86666666666667) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_14 and arg_1_1.time_ < 1.86666666666667 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.2, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["104902ui_story"]

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect104902ui_story == nil then
				arg_1_1.var_.characterEffect104902ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.86666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 1.86666666666667 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect104902ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.86666666666667 + var_4_16 and arg_1_1.time_ < 1.86666666666667 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect104902ui_story then
				arg_1_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.86666666666667 + arg_4_0 then
				arg_1_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.05

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414391001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 2 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 2)

				if (2 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 2)) > 0 and var_4_19 < var_4_23 then
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
				actorName = "104902ui_story",
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
	Play414391002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 414391002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play414391003(arg_7_1)
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
			local var_10_2 = 0.65

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

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(414391002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 26 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 26)

				if (26 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 26)) > 0 and var_10_2 < var_10_5 then
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
	Play414391003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 414391003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play414391004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos104902ui_story = arg_11_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).z)
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles = arg_11_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["104902ui_story"].transform.position).z)
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["104902ui_story"].transform.localEulerAngles = arg_11_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_14_1 = 0
			local var_14_2 = 1.025

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

				local var_14_3 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(414391003).content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 41 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 41)

				if (41 <= 0 and var_14_2 or var_14_2 * (utf8.len(var_14_3) / 41)) > 0 and var_14_2 < var_14_5 then
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
	Play414391004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414391004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414391005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos104902ui_story = arg_15_1.actors_["104902ui_story"].transform.localPosition
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
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_18_4 = 0
			local var_18_5 = 0.3

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

				local var_18_6 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(414391004).content)

				arg_15_1.text_.text = var_18_6

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_8 = 12 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 12)

				if (12 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_6) / 12)) > 0 and var_18_5 < var_18_8 then
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
	Play414391005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 414391005
		arg_19_1.duration_ = 1

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"

			SetActive(arg_19_1.choicesGo_, true)

			for iter_20_0, iter_20_1 in ipairs(arg_19_1.choices_) do
				SetActive(iter_20_1.go, iter_20_0 <= 2)
			end

			arg_19_1.choices_[1].txt.text = arg_19_1:FormatText(StoryChoiceCfg[918].name)
			arg_19_1.choices_[2].txt.text = arg_19_1:FormatText(StoryChoiceCfg[919].name)
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play414391006(arg_19_1)
			end

			if arg_21_0 == 2 then
				arg_19_0:Play414391007(arg_19_1)
			end

			arg_19_1:RecordChoiceLog(414391005, 918, 919)
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) and arg_19_1.var_.characterEffect104902ui_story == nil then
				arg_19_1.var_.characterEffect104902ui_story = arg_19_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) then
				if arg_19_1.var_.characterEffect104902ui_story and not isNil(arg_19_1.actors_["104902ui_story"]) then
					arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_19_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["104902ui_story"]) and arg_19_1.var_.characterEffect104902ui_story then
				arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_19_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play414391006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414391006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414391008(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.4

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

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(414391006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 16 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 16)

				if (16 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 16)) > 0 and var_26_0 < var_26_3 then
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
	Play414391008 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414391008
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414391009(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.325

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

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(414391008).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 13)

				if (13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 13)) > 0 and var_30_0 < var_30_3 then
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
	Play414391009 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414391009
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play414391010(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos104902ui_story = arg_31_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).z)
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles = arg_31_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).z)
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles = arg_31_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_34_1 = 0
			local var_34_2 = 1.35

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(414391009).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 54 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 54)

				if (54 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 54)) > 0 and var_34_2 < var_34_5 then
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

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play414391010 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414391010
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414391011(arg_35_1)
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

			local var_38_4 = 0
			local var_38_5 = 0.15

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
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

				local var_38_6 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414391010).content)

				arg_35_1.text_.text = var_38_6

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_8 = 6 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 6)

				if (6 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_6) / 6)) > 0 and var_38_5 < var_38_8 then
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
	Play414391011 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414391011
		arg_39_1.duration_ = 8.73

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414391012(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if arg_39_1.bgs_.H07h == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_42_0.name = "H07h"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.H07h = var_42_0
			end

			if 1.86666666666667 < arg_39_1.time_ and arg_39_1.time_ <= 1.86666666666667 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.H07h

				arg_39_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "H07h" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 1.86666666666667

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 1.86666666666667

			if 1.86666666666667 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 1.86666666666667

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["104902ui_story"].transform

			if 3.53333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 3.53333333333333 + arg_42_0 then
				arg_39_1.var_.moveOldPos104902ui_story = var_42_13.localPosition
			end

			local var_42_14 = 0.001

			if 3.53333333333333 <= arg_39_1.time_ and arg_39_1.time_ < 3.53333333333333 + var_42_14 then
				var_42_13.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_39_1.time_ - 3.53333333333333) / var_42_14)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			if arg_39_1.time_ >= 3.53333333333333 + var_42_14 and arg_39_1.time_ < 3.53333333333333 + var_42_14 + arg_42_0 then
				var_42_13.localPosition = Vector3.New(0, -1.2, -6)
				var_42_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_13.position).x, (manager.ui.mainCamera.transform.position - var_42_13.position).y, (manager.ui.mainCamera.transform.position - var_42_13.position).z)
				var_42_13.localEulerAngles.z = 0
				var_42_13.localEulerAngles.x = 0
				var_42_13.localEulerAngles = var_42_13.localEulerAngles
			end

			local var_42_15 = arg_39_1.actors_["104902ui_story"]

			if 3.53333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 3.53333333333333 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect104902ui_story == nil then
				arg_39_1.var_.characterEffect104902ui_story = var_42_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_16 = 0.200000002980232

			if 3.53333333333333 <= arg_39_1.time_ and arg_39_1.time_ < 3.53333333333333 + var_42_16 and not isNil(var_42_15) then
				if arg_39_1.var_.characterEffect104902ui_story and not isNil(var_42_15) then
					arg_39_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 3.53333333333333 + var_42_16 and arg_39_1.time_ < 3.53333333333333 + var_42_16 + arg_42_0 and not isNil(var_42_15) and arg_39_1.var_.characterEffect104902ui_story then
				arg_39_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 3.53333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 3.53333333333333 + arg_42_0 then
				arg_39_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_18 = arg_39_1.actors_["104902ui_story"].transform

			if 1.86666666666667 < arg_39_1.time_ and arg_39_1.time_ <= 1.86666666666667 + arg_42_0 then
				arg_39_1.var_.moveOldPos104902ui_story = var_42_18.localPosition
			end

			local var_42_19 = 0.001

			if 1.86666666666667 <= arg_39_1.time_ and arg_39_1.time_ < 1.86666666666667 + var_42_19 then
				var_42_18.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 1.86666666666667) / var_42_19)
				var_42_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_18.position).x, (manager.ui.mainCamera.transform.position - var_42_18.position).y, (manager.ui.mainCamera.transform.position - var_42_18.position).z)
				var_42_18.localEulerAngles.z = 0
				var_42_18.localEulerAngles.x = 0
				var_42_18.localEulerAngles = var_42_18.localEulerAngles
			end

			if arg_39_1.time_ >= 1.86666666666667 + var_42_19 and arg_39_1.time_ < 1.86666666666667 + var_42_19 + arg_42_0 then
				var_42_18.localPosition = Vector3.New(0, 100, 0)
				var_42_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_18.position).x, (manager.ui.mainCamera.transform.position - var_42_18.position).y, (manager.ui.mainCamera.transform.position - var_42_18.position).z)
				var_42_18.localEulerAngles.z = 0
				var_42_18.localEulerAngles.x = 0
				var_42_18.localEulerAngles = var_42_18.localEulerAngles
			end

			if 3.56733333518108 < arg_39_1.time_ and arg_39_1.time_ <= 3.56733333518108 + arg_42_0 then
				arg_39_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_1")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_20 = 3.73333333333333
			local var_42_21 = 0.525

			if 3.73333333333333 < arg_39_1.time_ and arg_39_1.time_ <= var_42_20 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_22 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_22:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_23 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414391011).content)

				arg_39_1.text_.text = var_42_23

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_25 = 21 <= 0 and var_42_21 or var_42_21 * (utf8.len(var_42_23) / 21)

				if (21 <= 0 and var_42_21 or var_42_21 * (utf8.len(var_42_23) / 21)) > 0 and var_42_21 < var_42_25 then
					arg_39_1.talkMaxDuration = var_42_25
					var_42_20 = var_42_20 + 0.3

					if var_42_25 + var_42_20 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_25 + var_42_20
					end
				end

				arg_39_1.text_.text = var_42_23
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_26 = var_42_20 + 0.3
			local var_42_27 = math.max(var_42_21, arg_39_1.talkMaxDuration)

			if var_42_20 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_26 + var_42_27 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_26) / var_42_27

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_26 + var_42_27 and arg_39_1.time_ < var_42_26 + var_42_27 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play414391012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 414391012
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play414391013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["104902ui_story"]) and arg_45_1.var_.characterEffect104902ui_story == nil then
				arg_45_1.var_.characterEffect104902ui_story = arg_45_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["104902ui_story"]) then
				if arg_45_1.var_.characterEffect104902ui_story and not isNil(arg_45_1.actors_["104902ui_story"]) then
					arg_45_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_45_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["104902ui_story"]) and arg_45_1.var_.characterEffect104902ui_story then
				arg_45_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_45_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(414391012).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 21 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 21)

				if (21 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 21)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play414391013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 414391013
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play414391014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["104902ui_story"]) and arg_49_1.var_.characterEffect104902ui_story == nil then
				arg_49_1.var_.characterEffect104902ui_story = arg_49_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["104902ui_story"]) then
				if arg_49_1.var_.characterEffect104902ui_story and not isNil(arg_49_1.actors_["104902ui_story"]) then
					arg_49_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["104902ui_story"]) and arg_49_1.var_.characterEffect104902ui_story then
				arg_49_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_2")
			end

			local var_52_2 = 0
			local var_52_3 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(414391013).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 19 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 19)

				if (19 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 19)) > 0 and var_52_3 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_7 and arg_49_1.time_ < var_52_2 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play414391014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 414391014
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play414391015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["104902ui_story"]) and arg_53_1.var_.characterEffect104902ui_story == nil then
				arg_53_1.var_.characterEffect104902ui_story = arg_53_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["104902ui_story"]) then
				if arg_53_1.var_.characterEffect104902ui_story and not isNil(arg_53_1.actors_["104902ui_story"]) then
					arg_53_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_53_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["104902ui_story"]) and arg_53_1.var_.characterEffect104902ui_story then
				arg_53_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_53_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(414391014).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 18 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 18)

				if (18 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 18)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play414391015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 414391015
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
			arg_57_1.auto_ = false
		end

		function arg_57_1.playNext_(arg_59_0)
			arg_57_1.onStoryFinished_()
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos104902ui_story = arg_57_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).z)
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles = arg_57_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["104902ui_story"].transform.position).z)
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["104902ui_story"].transform.localEulerAngles = arg_57_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_60_1 = 0
			local var_60_2 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(414391015).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 17 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 17)

				if (17 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 17)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play414391007 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 414391007
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play414391008(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.475

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(414391007).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 19 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 19)

				if (19 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 19)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07f",
		"TextureConfig/Background/H07h"
	},
	voices = {}
}
