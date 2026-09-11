return {
	Play910116001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910116001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910116002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST47 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_4_0.name = "ST47"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST47 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST47

				arg_1_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST47" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_8 = 2
			local var_4_9 = 1.05

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_10 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_10:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910116001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 42 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 42)

				if (42 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 42)) > 0 and var_4_9 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13
					var_4_8 = var_4_8 + 0.3

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end

				arg_1_1.text_.text = var_4_11
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_14 = var_4_8 + 0.3
			local var_4_15 = math.max(var_4_9, arg_1_1.talkMaxDuration)

			if var_4_8 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_14) / var_4_15

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play910116002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910116002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910116003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.775

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

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910116002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 31 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 31)

				if (31 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 31)) > 0 and var_10_0 < var_10_3 then
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
	Play910116003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910116003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910116004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1060ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1060ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "1060ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "1060ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1060ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["1060ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["1060ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["1060ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["1060ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1060ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["1060ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1060ui_story == nil then
				arg_11_1.var_.characterEffect1060ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect1060ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1060ui_story then
				arg_11_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action2_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_14_8 = "1070ui_story"

			if arg_11_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_14_9 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_11_1.stage_.transform)

				var_14_9.name = var_14_8
				var_14_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_8] = var_14_9

				local var_14_10 = var_14_9:GetComponentInChildren(typeof(CharacterEffect))

				var_14_10.enabled = true

				local var_14_11 = GameObjectTools.GetOrAddComponent(var_14_9, typeof(DynamicBoneHelper))

				if var_14_11 then
					var_14_11:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_10.transform, false)

				arg_11_1.var_[var_14_8 .. "Animator"] = var_14_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_8 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_8 .. "LipSync"] = var_14_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_12 = arg_11_1.actors_["1070ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1070ui_story = var_14_12.localPosition
			end

			local var_14_13 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_13 then
				var_14_12.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_11_1.time_ - 0) / var_14_13)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_13 and arg_11_1.time_ < 0 + var_14_13 + arg_14_0 then
				var_14_12.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			local var_14_14 = arg_11_1.actors_["1070ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1070ui_story == nil then
				arg_11_1.var_.characterEffect1070ui_story = var_14_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_15 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_15 and not isNil(var_14_14) then
				if arg_11_1.var_.characterEffect1070ui_story and not isNil(var_14_14) then
					arg_11_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_15)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_15 and arg_11_1.time_ < 0 + var_14_15 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1070ui_story then
				arg_11_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_14_16 = 0
			local var_14_17 = 0.65

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_16 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_18 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910116003).content)

				arg_11_1.text_.text = var_14_18

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_20 = 26 <= 0 and var_14_17 or var_14_17 * (utf8.len(var_14_18) / 26)

				if (26 <= 0 and var_14_17 or var_14_17 * (utf8.len(var_14_18) / 26)) > 0 and var_14_17 < var_14_20 then
					arg_11_1.talkMaxDuration = var_14_20

					if var_14_20 + var_14_16 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_16
					end
				end

				arg_11_1.text_.text = var_14_18
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_17, arg_11_1.talkMaxDuration)

			if var_14_16 <= arg_11_1.time_ and arg_11_1.time_ < var_14_16 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_16) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_16 + var_14_21 and arg_11_1.time_ < var_14_16 + var_14_21 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910116004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910116005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1070ui_story = arg_15_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).z)
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles = arg_15_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_15_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).z)
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles = arg_15_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["1070ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1070ui_story == nil then
				arg_15_1.var_.characterEffect1070ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect1070ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1070ui_story then
				arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_18_4 = arg_15_1.actors_["1060ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1060ui_story == nil then
				arg_15_1.var_.characterEffect1060ui_story = var_18_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_5 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 and not isNil(var_18_4) then
				if arg_15_1.var_.characterEffect1060ui_story and not isNil(var_18_4) then
					arg_15_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_5)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1060ui_story then
				arg_15_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_18_6 = 0
			local var_18_7 = 0.5

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_8 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910116004).content)

				arg_15_1.text_.text = var_18_8

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 20 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 20)

				if (20 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 20)) > 0 and var_18_7 < var_18_10 then
					arg_15_1.talkMaxDuration = var_18_10

					if var_18_10 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_8
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_11 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_11 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_11

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_11 and arg_15_1.time_ < var_18_6 + var_18_11 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910116005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910116006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1074ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1074ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1074ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1074ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1074ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1074ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1074ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1074ui_story == nil then
				arg_19_1.var_.characterEffect1074ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1074ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1074ui_story then
				arg_19_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_8 = arg_19_1.actors_["1060ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1060ui_story = var_22_8.localPosition
			end

			local var_22_9 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 then
				var_22_8.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_9)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 then
				var_22_8.localPosition = Vector3.New(0, 100, 0)
				var_22_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_8.position).x, (manager.ui.mainCamera.transform.position - var_22_8.position).y, (manager.ui.mainCamera.transform.position - var_22_8.position).z)
				var_22_8.localEulerAngles.z = 0
				var_22_8.localEulerAngles.x = 0
				var_22_8.localEulerAngles = var_22_8.localEulerAngles
			end

			local var_22_10 = arg_19_1.actors_["1060ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.characterEffect1060ui_story == nil then
				arg_19_1.var_.characterEffect1060ui_story = var_22_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_11 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_11 and not isNil(var_22_10) then
				if arg_19_1.var_.characterEffect1060ui_story and not isNil(var_22_10) then
					arg_19_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_11)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_11 and arg_19_1.time_ < 0 + var_22_11 + arg_22_0 and not isNil(var_22_10) and arg_19_1.var_.characterEffect1060ui_story then
				arg_19_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_22_12 = arg_19_1.actors_["1070ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1070ui_story = var_22_12.localPosition
			end

			local var_22_13 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_13 then
				var_22_12.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_13)
				var_22_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_12.position).x, (manager.ui.mainCamera.transform.position - var_22_12.position).y, (manager.ui.mainCamera.transform.position - var_22_12.position).z)
				var_22_12.localEulerAngles.z = 0
				var_22_12.localEulerAngles.x = 0
				var_22_12.localEulerAngles = var_22_12.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_13 and arg_19_1.time_ < 0 + var_22_13 + arg_22_0 then
				var_22_12.localPosition = Vector3.New(0, 100, 0)
				var_22_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_12.position).x, (manager.ui.mainCamera.transform.position - var_22_12.position).y, (manager.ui.mainCamera.transform.position - var_22_12.position).z)
				var_22_12.localEulerAngles.z = 0
				var_22_12.localEulerAngles.x = 0
				var_22_12.localEulerAngles = var_22_12.localEulerAngles
			end

			local var_22_14 = arg_19_1.actors_["1070ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1070ui_story == nil then
				arg_19_1.var_.characterEffect1070ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_15 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_15 and not isNil(var_22_14) then
				if arg_19_1.var_.characterEffect1070ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_15)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_15 and arg_19_1.time_ < 0 + var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1070ui_story then
				arg_19_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_22_16 = 0
			local var_22_17 = 0.275

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_16 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_18 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910116005).content)

				arg_19_1.text_.text = var_22_18

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_20 = 11 <= 0 and var_22_17 or var_22_17 * (utf8.len(var_22_18) / 11)

				if (11 <= 0 and var_22_17 or var_22_17 * (utf8.len(var_22_18) / 11)) > 0 and var_22_17 < var_22_20 then
					arg_19_1.talkMaxDuration = var_22_20

					if var_22_20 + var_22_16 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_16
					end
				end

				arg_19_1.text_.text = var_22_18
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_21 = math.max(var_22_17, arg_19_1.talkMaxDuration)

			if var_22_16 <= arg_19_1.time_ and arg_19_1.time_ < var_22_16 + var_22_21 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_16) / var_22_21

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_16 + var_22_21 and arg_19_1.time_ < var_22_16 + var_22_21 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910116006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910116007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1060ui_story = arg_23_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).z)
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles = arg_23_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				arg_23_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1060ui_story"].transform.position).z)
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1060ui_story"].transform.localEulerAngles = arg_23_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1060ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1060ui_story == nil then
				arg_23_1.var_.characterEffect1060ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1060ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1060ui_story then
				arg_23_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_26_3 = arg_23_1.actors_["1070ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1070ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_8 = arg_23_1.actors_["1074ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1074ui_story = var_26_8.localPosition
			end

			local var_26_9 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_9 then
				var_26_8.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_9)
				var_26_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_8.position).x, (manager.ui.mainCamera.transform.position - var_26_8.position).y, (manager.ui.mainCamera.transform.position - var_26_8.position).z)
				var_26_8.localEulerAngles.z = 0
				var_26_8.localEulerAngles.x = 0
				var_26_8.localEulerAngles = var_26_8.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_9 and arg_23_1.time_ < 0 + var_26_9 + arg_26_0 then
				var_26_8.localPosition = Vector3.New(0, 100, 0)
				var_26_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_8.position).x, (manager.ui.mainCamera.transform.position - var_26_8.position).y, (manager.ui.mainCamera.transform.position - var_26_8.position).z)
				var_26_8.localEulerAngles.z = 0
				var_26_8.localEulerAngles.x = 0
				var_26_8.localEulerAngles = var_26_8.localEulerAngles
			end

			local var_26_10 = arg_23_1.actors_["1074ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_10) and arg_23_1.var_.characterEffect1074ui_story == nil then
				arg_23_1.var_.characterEffect1074ui_story = var_26_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_11 and not isNil(var_26_10) then
				if arg_23_1.var_.characterEffect1074ui_story and not isNil(var_26_10) then
					arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_11)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_11 and arg_23_1.time_ < 0 + var_26_11 + arg_26_0 and not isNil(var_26_10) and arg_23_1.var_.characterEffect1074ui_story then
				arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_26_12 = 0
			local var_26_13 = 0.275

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_14 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910116006).content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 11 <= 0 and var_26_13 or var_26_13 * (utf8.len(var_26_14) / 11)

				if (11 <= 0 and var_26_13 or var_26_13 * (utf8.len(var_26_14) / 11)) > 0 and var_26_13 < var_26_16 then
					arg_23_1.talkMaxDuration = var_26_16

					if var_26_16 + var_26_12 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_12
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_17 = math.max(var_26_13, arg_23_1.talkMaxDuration)

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_17 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_12) / var_26_17

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_12 + var_26_17 and arg_23_1.time_ < var_26_12 + var_26_17 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play910116007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910116007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910116008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1060ui_story = arg_27_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).z)
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles = arg_27_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				arg_27_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1060ui_story"].transform.position).z)
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1060ui_story"].transform.localEulerAngles = arg_27_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1060ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1060ui_story == nil then
				arg_27_1.var_.characterEffect1060ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1060ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1060ui_story then
				arg_27_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action2_2")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_4 = arg_27_1.actors_["1070ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1070ui_story == nil then
				arg_27_1.var_.characterEffect1070ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect1070ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1070ui_story then
				arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_30_6 = 0
			local var_30_7 = 0.725

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910116007).content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 29 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 29)

				if (29 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 29)) > 0 and var_30_7 < var_30_10 then
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
				actorName = "1060ui_story",
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
	Play910116008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910116008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910116009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1070ui_story = arg_31_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).z)
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles = arg_31_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_31_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).z)
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles = arg_31_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1070ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1070ui_story == nil then
				arg_31_1.var_.characterEffect1070ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1070ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1070ui_story then
				arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_34_4 = arg_31_1.actors_["1060ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1060ui_story == nil then
				arg_31_1.var_.characterEffect1060ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_5 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_4) then
				if arg_31_1.var_.characterEffect1060ui_story and not isNil(var_34_4) then
					arg_31_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_5)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1060ui_story then
				arg_31_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_34_6 = 0
			local var_34_7 = 0.175

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910116008).content)

				arg_31_1.text_.text = var_34_8

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 7 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 7)

				if (7 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 7)) > 0 and var_34_7 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_8
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_11 and arg_31_1.time_ < var_34_6 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910116009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910116010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1060ui_story = arg_35_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).z)
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles = arg_35_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				arg_35_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1060ui_story"].transform.position).z)
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1060ui_story"].transform.localEulerAngles = arg_35_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1060ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1060ui_story == nil then
				arg_35_1.var_.characterEffect1060ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1060ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1060ui_story then
				arg_35_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = arg_35_1.actors_["1070ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1070ui_story == nil then
				arg_35_1.var_.characterEffect1070ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_5 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 and not isNil(var_38_4) then
				if arg_35_1.var_.characterEffect1070ui_story and not isNil(var_38_4) then
					arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_5)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1070ui_story then
				arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_38_6 = 0
			local var_38_7 = 1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910116009).content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 40 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_8) / 40)

				if (40 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_8) / 40)) > 0 and var_38_7 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_11 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_11 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_11

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_11 and arg_35_1.time_ < var_38_6 + var_38_11 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910116010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910116011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1074ui_story = arg_39_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).z)
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles = arg_39_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_39_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1074ui_story"].transform.position).z)
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1074ui_story"].transform.localEulerAngles = arg_39_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1074ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1074ui_story == nil then
				arg_39_1.var_.characterEffect1074ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1074ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1074ui_story then
				arg_39_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_4 = arg_39_1.actors_["1060ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1060ui_story = var_42_4.localPosition
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_39_1.time_ - 0) / var_42_5)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(0.7, -1.14, -6.33)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			local var_42_6 = arg_39_1.actors_["1060ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1060ui_story == nil then
				arg_39_1.var_.characterEffect1060ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 and not isNil(var_42_6) then
				if arg_39_1.var_.characterEffect1060ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_7)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1060ui_story then
				arg_39_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_42_8 = arg_39_1.actors_["1070ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1070ui_story = var_42_8.localPosition
			end

			local var_42_9 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 then
				var_42_8.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_9)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 then
				var_42_8.localPosition = Vector3.New(0, 100, 0)
				var_42_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_8.position).x, (manager.ui.mainCamera.transform.position - var_42_8.position).y, (manager.ui.mainCamera.transform.position - var_42_8.position).z)
				var_42_8.localEulerAngles.z = 0
				var_42_8.localEulerAngles.x = 0
				var_42_8.localEulerAngles = var_42_8.localEulerAngles
			end

			local var_42_10 = arg_39_1.actors_["1070ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1070ui_story == nil then
				arg_39_1.var_.characterEffect1070ui_story = var_42_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_11 and not isNil(var_42_10) then
				if arg_39_1.var_.characterEffect1070ui_story and not isNil(var_42_10) then
					arg_39_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_11)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_11 and arg_39_1.time_ < 0 + var_42_11 + arg_42_0 and not isNil(var_42_10) and arg_39_1.var_.characterEffect1070ui_story then
				arg_39_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_42_12 = 0
			local var_42_13 = 0.85

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_14 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910116010).content)

				arg_39_1.text_.text = var_42_14

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_16 = 34 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_14) / 34)

				if (34 <= 0 and var_42_13 or var_42_13 * (utf8.len(var_42_14) / 34)) > 0 and var_42_13 < var_42_16 then
					arg_39_1.talkMaxDuration = var_42_16

					if var_42_16 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_12
					end
				end

				arg_39_1.text_.text = var_42_14
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_17 = math.max(var_42_13, arg_39_1.talkMaxDuration)

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_17 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_12) / var_42_17

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_12 + var_42_17 and arg_39_1.time_ < var_42_12 + var_42_17 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910116011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910116012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1060ui_story = arg_43_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).z)
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles = arg_43_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_43_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1060ui_story"].transform.position).z)
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1060ui_story"].transform.localEulerAngles = arg_43_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1060ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1060ui_story == nil then
				arg_43_1.var_.characterEffect1060ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1060ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1060ui_story then
				arg_43_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_46_4 = arg_43_1.actors_["1074ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_5 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 and not isNil(var_46_4) then
				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_4) then
					arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_5)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1074ui_story then
				arg_43_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_46_6 = 0
			local var_46_7 = 0.7

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910116011).content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 29 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 29)

				if (29 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 29)) > 0 and var_46_7 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_11 and arg_43_1.time_ < var_46_6 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910116012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910116013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1074ui_story = arg_47_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).z)
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles = arg_47_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_47_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1074ui_story"].transform.position).z)
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1074ui_story"].transform.localEulerAngles = arg_47_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1074ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1074ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1074ui_story then
				arg_47_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = arg_47_1.actors_["1060ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1060ui_story == nil then
				arg_47_1.var_.characterEffect1060ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_5 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.characterEffect1060ui_story and not isNil(var_50_4) then
					arg_47_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_5)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1060ui_story then
				arg_47_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_50_6 = 0
			local var_50_7 = 0.475

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_8 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910116012).content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 19 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 19)

				if (19 <= 0 and var_50_7 or var_50_7 * (utf8.len(var_50_8) / 19)) > 0 and var_50_7 < var_50_10 then
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
				actorName = "1074ui_story",
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
	Play910116013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910116013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910116014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1060ui_story = arg_51_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).z)
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles = arg_51_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_51_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1060ui_story"].transform.position).z)
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1060ui_story"].transform.localEulerAngles = arg_51_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1060ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1060ui_story == nil then
				arg_51_1.var_.characterEffect1060ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1060ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1060ui_story then
				arg_51_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_4 = arg_51_1.actors_["1074ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1074ui_story == nil then
				arg_51_1.var_.characterEffect1074ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_5 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 and not isNil(var_54_4) then
				if arg_51_1.var_.characterEffect1074ui_story and not isNil(var_54_4) then
					arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_5)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1074ui_story then
				arg_51_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_54_6 = 0
			local var_54_7 = 0.375

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(910116013).content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 15 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 15)

				if (15 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 15)) > 0 and var_54_7 < var_54_10 then
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
				actorName = "1060ui_story",
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
	Play910116014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910116014
		arg_55_1.duration_ = 9

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910116015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.ST37 == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_58_0.name = "ST37"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.ST37 = var_58_0
			end

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= 2 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.ST37

				arg_55_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST37" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_5 = 2

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_5 then
				local var_58_6 = Color.New(0, 0, 0)

				var_58_6.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_4) / var_58_5)
				arg_55_1.mask_.color = var_58_6
			end

			if arg_55_1.time_ >= var_58_4 + var_58_5 and arg_55_1.time_ < var_58_4 + var_58_5 + arg_58_0 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = 1
				arg_55_1.mask_.color = var_58_7
			end

			local var_58_8 = 2

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_9 = 2

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_9 then
				local var_58_10 = Color.New(0, 0, 0)

				var_58_10.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_8) / var_58_9)
				arg_55_1.mask_.color = var_58_10
			end

			if arg_55_1.time_ >= var_58_8 + var_58_9 and arg_55_1.time_ < var_58_8 + var_58_9 + arg_58_0 then
				local var_58_11 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_11.a = 0
				arg_55_1.mask_.color = var_58_11
			end

			local var_58_12 = arg_55_1.actors_["1074ui_story"].transform

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= 2 + arg_58_0 then
				arg_55_1.var_.moveOldPos1074ui_story = var_58_12.localPosition
			end

			local var_58_13 = 0.001

			if 2 <= arg_55_1.time_ and arg_55_1.time_ < 2 + var_58_13 then
				var_58_12.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 2) / var_58_13)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			if arg_55_1.time_ >= 2 + var_58_13 and arg_55_1.time_ < 2 + var_58_13 + arg_58_0 then
				var_58_12.localPosition = Vector3.New(0, 100, 0)
				var_58_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_12.position).x, (manager.ui.mainCamera.transform.position - var_58_12.position).y, (manager.ui.mainCamera.transform.position - var_58_12.position).z)
				var_58_12.localEulerAngles.z = 0
				var_58_12.localEulerAngles.x = 0
				var_58_12.localEulerAngles = var_58_12.localEulerAngles
			end

			local var_58_14 = arg_55_1.actors_["1060ui_story"].transform

			if 2 < arg_55_1.time_ and arg_55_1.time_ <= 2 + arg_58_0 then
				arg_55_1.var_.moveOldPos1060ui_story = var_58_14.localPosition
			end

			local var_58_15 = 0.001

			if 2 <= arg_55_1.time_ and arg_55_1.time_ < 2 + var_58_15 then
				var_58_14.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 2) / var_58_15)
				var_58_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_14.position).x, (manager.ui.mainCamera.transform.position - var_58_14.position).y, (manager.ui.mainCamera.transform.position - var_58_14.position).z)
				var_58_14.localEulerAngles.z = 0
				var_58_14.localEulerAngles.x = 0
				var_58_14.localEulerAngles = var_58_14.localEulerAngles
			end

			if arg_55_1.time_ >= 2 + var_58_15 and arg_55_1.time_ < 2 + var_58_15 + arg_58_0 then
				var_58_14.localPosition = Vector3.New(0, 100, 0)
				var_58_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_14.position).x, (manager.ui.mainCamera.transform.position - var_58_14.position).y, (manager.ui.mainCamera.transform.position - var_58_14.position).z)
				var_58_14.localEulerAngles.z = 0
				var_58_14.localEulerAngles.x = 0
				var_58_14.localEulerAngles = var_58_14.localEulerAngles
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_16 = 4
			local var_58_17 = 0.425

			if 4 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_18 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_18:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_19 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(910116014).content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 17 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 17)

				if (17 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 17)) > 0 and var_58_17 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21
					var_58_16 = var_58_16 + 0.3

					if var_58_21 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_22 = var_58_16 + 0.3
			local var_58_23 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_22 + var_58_23 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_22) / var_58_23

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_22 + var_58_23 and arg_55_1.time_ < var_58_22 + var_58_23 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play910116015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 910116015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play910116016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1060ui_story = arg_61_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).z)
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles = arg_61_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_61_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1060ui_story"].transform.position).z)
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1060ui_story"].transform.localEulerAngles = arg_61_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1060ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1060ui_story == nil then
				arg_61_1.var_.characterEffect1060ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1060ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1060ui_story then
				arg_61_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(910116015).content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 24 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 24)

				if (24 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 24)) > 0 and var_64_5 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_9 and arg_61_1.time_ < var_64_4 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play910116016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 910116016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play910116017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.725

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(910116016).content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 29 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_2) / 29)

				if (29 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_2) / 29)) > 0 and var_68_1 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_5 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_5 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_5

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_5 and arg_65_1.time_ < var_68_0 + var_68_5 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play910116017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 910116017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play910116018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1060ui_story"]) and arg_69_1.var_.characterEffect1060ui_story == nil then
				arg_69_1.var_.characterEffect1060ui_story = arg_69_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1060ui_story"]) then
				if arg_69_1.var_.characterEffect1060ui_story and not isNil(arg_69_1.actors_["1060ui_story"]) then
					arg_69_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1060ui_story"]) and arg_69_1.var_.characterEffect1060ui_story then
				arg_69_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.85

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(910116017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 34 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 34)

				if (34 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 34)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play910116018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 910116018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play910116019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(910116018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 25)

				if (25 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 25)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play910116019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 910116019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play910116020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1060ui_story"]) and arg_77_1.var_.characterEffect1060ui_story == nil then
				arg_77_1.var_.characterEffect1060ui_story = arg_77_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1060ui_story"]) then
				if arg_77_1.var_.characterEffect1060ui_story and not isNil(arg_77_1.actors_["1060ui_story"]) then
					arg_77_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1060ui_story"]) and arg_77_1.var_.characterEffect1060ui_story then
				arg_77_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(910116019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 21 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 21)

				if (21 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 21)) > 0 and var_80_3 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_7 and arg_77_1.time_ < var_80_2 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play910116020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 910116020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play910116021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1060ui_story = arg_81_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).z)
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles = arg_81_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1060ui_story"].transform.position).z)
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1060ui_story"].transform.localEulerAngles = arg_81_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1060ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1060ui_story == nil then
				arg_81_1.var_.characterEffect1060ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1060ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1060ui_story then
				arg_81_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 0.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(910116020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 17 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 17)

				if (17 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 17)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 910116021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play910116022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(910116021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 26)

				if (26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 26)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play910116022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910116022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910116023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(910116022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 46 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 46)

				if (46 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 46)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play910116023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910116023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910116024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.975

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(910116023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 39 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 39)

				if (39 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 39)) > 0 and var_96_0 < var_96_3 then
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
	Play910116024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910116024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910116025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.575

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(910116024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 23 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 23)

				if (23 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 23)) > 0 and var_100_0 < var_100_3 then
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
	Play910116025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910116025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910116026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(910116025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 19 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 19)

				if (19 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 19)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play910116026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910116026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910116027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(910116026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 18 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 18)

				if (18 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 18)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play910116027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910116027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910116028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(910116027).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 46 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 46)

				if (46 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 46)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play910116028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910116028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910116029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.65

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(910116028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 26 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 26)

				if (26 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 26)) > 0 and var_116_0 < var_116_3 then
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
	Play910116029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910116029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910116030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1074ui_story = arg_117_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).z)
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles = arg_117_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_117_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1074ui_story"].transform.position).z)
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1074ui_story"].transform.localEulerAngles = arg_117_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1074ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1074ui_story then
				arg_117_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_4 = arg_117_1.actors_["1070ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1070ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_117_1.time_ - 0) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = arg_117_1.actors_["1070ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 and not isNil(var_120_6) then
				if arg_117_1.var_.characterEffect1070ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_7)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1070ui_story then
				arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_120_8 = 0
			local var_120_9 = 0.3

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(910116029).content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 12 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_10) / 12)

				if (12 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_10) / 12)) > 0 and var_120_9 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_13 and arg_117_1.time_ < var_120_8 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910116030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910116031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = arg_121_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) then
				if arg_121_1.var_.characterEffect1074ui_story and not isNil(arg_121_1.actors_["1074ui_story"]) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1074ui_story"]) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.75

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(910116030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 30 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 30)

				if (30 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 30)) > 0 and var_124_2 < var_124_5 then
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
	Play910116031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910116031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910116032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1070ui_story = arg_125_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).z)
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles = arg_125_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_125_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1070ui_story"].transform.position).z)
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1070ui_story"].transform.localEulerAngles = arg_125_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1070ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1070ui_story == nil then
				arg_125_1.var_.characterEffect1070ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1070ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1070ui_story then
				arg_125_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.2

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(910116031).content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 8 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 8)

				if (8 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_6) / 8)) > 0 and var_128_5 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_9 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_9 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_9

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_9 and arg_125_1.time_ < var_128_4 + var_128_9 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910116032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910116032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910116033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) and arg_129_1.var_.characterEffect1070ui_story == nil then
				arg_129_1.var_.characterEffect1070ui_story = arg_129_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) then
				if arg_129_1.var_.characterEffect1070ui_story and not isNil(arg_129_1.actors_["1070ui_story"]) then
					arg_129_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1070ui_story"]) and arg_129_1.var_.characterEffect1070ui_story then
				arg_129_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.725

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(910116032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 29 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 29)

				if (29 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 29)) > 0 and var_132_2 < var_132_5 then
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
	Play910116033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910116033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910116034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1070ui_story = arg_133_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).z)
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles = arg_133_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_133_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1070ui_story"].transform.position).z)
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1070ui_story"].transform.localEulerAngles = arg_133_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1070ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1070ui_story == nil then
				arg_133_1.var_.characterEffect1070ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1070ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1070ui_story then
				arg_133_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.6

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(910116033).content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_8 = 24 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_6) / 24)

				if (24 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_6) / 24)) > 0 and var_136_5 < var_136_8 then
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
				actorName = "1070ui_story",
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
	Play910116034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910116034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910116035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1070ui_story"]) and arg_137_1.var_.characterEffect1070ui_story == nil then
				arg_137_1.var_.characterEffect1070ui_story = arg_137_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1070ui_story"]) then
				if arg_137_1.var_.characterEffect1070ui_story and not isNil(arg_137_1.actors_["1070ui_story"]) then
					arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1070ui_story"]) and arg_137_1.var_.characterEffect1070ui_story then
				arg_137_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 1.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(910116034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 43 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 43)

				if (43 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 43)) > 0 and var_140_2 < var_140_5 then
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
	Play910116035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910116035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910116036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(910116035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)

				if (34 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 34)) > 0 and var_144_0 < var_144_3 then
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
	Play910116036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910116036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910116037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1070ui_story = arg_145_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).z)
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles = arg_145_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_145_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1070ui_story"].transform.position).z)
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1070ui_story"].transform.localEulerAngles = arg_145_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1070ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1070ui_story == nil then
				arg_145_1.var_.characterEffect1070ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1070ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1070ui_story then
				arg_145_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.375

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(910116036).content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_8 = 15 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 15)

				if (15 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 15)) > 0 and var_148_5 < var_148_8 then
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
				actorName = "1070ui_story",
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
	Play910116037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910116037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910116038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1074ui_story = arg_149_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).z)
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles = arg_149_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_149_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1074ui_story"].transform.position).z)
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1074ui_story"].transform.localEulerAngles = arg_149_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1074ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1074ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1074ui_story then
				arg_149_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_4 = arg_149_1.actors_["1070ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1070ui_story == nil then
				arg_149_1.var_.characterEffect1070ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect1070ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1070ui_story then
				arg_149_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_152_6 = 0
			local var_152_7 = 0.075

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(910116037).content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 3 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 3)

				if (3 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 3)) > 0 and var_152_7 < var_152_10 then
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
				actorName = "1074ui_story",
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
	Play910116038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 910116038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play910116039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1070ui_story = arg_153_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).z)
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles = arg_153_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_153_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).z)
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles = arg_153_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1070ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1070ui_story == nil then
				arg_153_1.var_.characterEffect1070ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1070ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1070ui_story then
				arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action476")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_156_4 = arg_153_1.actors_["1074ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1074ui_story == nil then
				arg_153_1.var_.characterEffect1074ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect1074ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1074ui_story then
				arg_153_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_156_6 = 0
			local var_156_7 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(910116038).content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 26 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 26)

				if (26 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 26)) > 0 and var_156_7 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_11 and arg_153_1.time_ < var_156_6 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play910116039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 910116039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play910116040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1074ui_story = arg_157_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).z)
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles = arg_157_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_157_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1074ui_story"].transform.position).z)
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1074ui_story"].transform.localEulerAngles = arg_157_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1074ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1074ui_story == nil then
				arg_157_1.var_.characterEffect1074ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1074ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1074ui_story then
				arg_157_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_4 = arg_157_1.actors_["1070ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1070ui_story == nil then
				arg_157_1.var_.characterEffect1070ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1070ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1070ui_story then
				arg_157_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_160_6 = 0
			local var_160_7 = 0.825

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(910116039).content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 33 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 33)

				if (33 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 33)) > 0 and var_160_7 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_11 and arg_157_1.time_ < var_160_6 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play910116040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910116040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910116041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070ui_story = arg_161_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).z)
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles = arg_161_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_161_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).z)
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles = arg_161_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1070ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1070ui_story == nil then
				arg_161_1.var_.characterEffect1070ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1070ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1070ui_story then
				arg_161_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_4 = arg_161_1.actors_["1074ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_5 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_5 and not isNil(var_164_4) then
				if arg_161_1.var_.characterEffect1074ui_story and not isNil(var_164_4) then
					arg_161_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_5)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_5 and arg_161_1.time_ < 0 + var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect1074ui_story then
				arg_161_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_164_6 = 0
			local var_164_7 = 0.475

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(910116040).content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 19 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_8) / 19)

				if (19 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_8) / 19)) > 0 and var_164_7 < var_164_10 then
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
				actorName = "1070ui_story",
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
	Play910116041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910116041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910116042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.875

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(910116041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 35 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 35)

				if (35 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 35)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play910116042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910116042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910116043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1074ui_story = arg_169_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).z)
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles = arg_169_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1074ui_story"].transform.position).z)
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1074ui_story"].transform.localEulerAngles = arg_169_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1074ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1074ui_story == nil then
				arg_169_1.var_.characterEffect1074ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1074ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_2)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1074ui_story then
				arg_169_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_172_3 = arg_169_1.actors_["1070ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1070ui_story = var_172_3.localPosition
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_4)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(0, 100, 0)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			local var_172_5 = arg_169_1.actors_["1070ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1070ui_story == nil then
				arg_169_1.var_.characterEffect1070ui_story = var_172_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.characterEffect1070ui_story and not isNil(var_172_5) then
					arg_169_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_6)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1070ui_story then
				arg_169_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_172_7 = arg_169_1.actors_["1060ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1060ui_story = var_172_7.localPosition
			end

			local var_172_8 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_8 then
				var_172_7.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_169_1.time_ - 0) / var_172_8)
				var_172_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_7.position).x, (manager.ui.mainCamera.transform.position - var_172_7.position).y, (manager.ui.mainCamera.transform.position - var_172_7.position).z)
				var_172_7.localEulerAngles.z = 0
				var_172_7.localEulerAngles.x = 0
				var_172_7.localEulerAngles = var_172_7.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_8 and arg_169_1.time_ < 0 + var_172_8 + arg_172_0 then
				var_172_7.localPosition = Vector3.New(0, -1.14, -6.33)
				var_172_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_7.position).x, (manager.ui.mainCamera.transform.position - var_172_7.position).y, (manager.ui.mainCamera.transform.position - var_172_7.position).z)
				var_172_7.localEulerAngles.z = 0
				var_172_7.localEulerAngles.x = 0
				var_172_7.localEulerAngles = var_172_7.localEulerAngles
			end

			local var_172_9 = arg_169_1.actors_["1060ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1060ui_story == nil then
				arg_169_1.var_.characterEffect1060ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_10 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_10 and not isNil(var_172_9) then
				if arg_169_1.var_.characterEffect1060ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_10 and arg_169_1.time_ < 0 + var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1060ui_story then
				arg_169_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_172_12 = 0
			local var_172_13 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_14 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(910116042).content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 15 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_14) / 15)

				if (15 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_14) / 15)) > 0 and var_172_13 < var_172_16 then
					arg_169_1.talkMaxDuration = var_172_16

					if var_172_16 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_17 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_17 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_12) / var_172_17

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_12 + var_172_17 and arg_169_1.time_ < var_172_12 + var_172_17 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910116043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910116044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1060ui_story"]) and arg_173_1.var_.characterEffect1060ui_story == nil then
				arg_173_1.var_.characterEffect1060ui_story = arg_173_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1060ui_story"]) then
				if arg_173_1.var_.characterEffect1060ui_story and not isNil(arg_173_1.actors_["1060ui_story"]) then
					arg_173_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1060ui_story"]) and arg_173_1.var_.characterEffect1060ui_story then
				arg_173_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(910116043).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 6 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 6)

				if (6 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 6)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910116044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910116044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910116045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1060ui_story = arg_177_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).z)
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles = arg_177_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1060ui_story"].transform.position).z)
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1060ui_story"].transform.localEulerAngles = arg_177_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_180_1 = 0
			local var_180_2 = 0.85

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(910116044).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 34 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 34)

				if (34 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 34)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910116045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910116046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.775

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(910116045).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 31 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 31)

				if (31 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 31)) > 0 and var_184_0 < var_184_3 then
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
	Play910116046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910116046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910116047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.05

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(910116046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 42 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 42)

				if (42 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 42)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play910116047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910116047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910116048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.5

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(910116047).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 20 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 20)

				if (20 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 20)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play910116048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910116048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910116049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1070ui_story = arg_193_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).z)
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles = arg_193_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_193_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1070ui_story"].transform.position).z)
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1070ui_story"].transform.localEulerAngles = arg_193_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1070ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1070ui_story == nil then
				arg_193_1.var_.characterEffect1070ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1070ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1070ui_story then
				arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.425

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(910116048).content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 17 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 17)

				if (17 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 17)) > 0 and var_196_5 < var_196_8 then
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
				actorName = "1070ui_story",
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
	Play910116049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910116049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910116050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1070ui_story = arg_197_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).z)
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles = arg_197_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1070ui_story"].transform.position).z)
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1070ui_story"].transform.localEulerAngles = arg_197_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1070ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1070ui_story == nil then
				arg_197_1.var_.characterEffect1070ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1070ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_2)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1070ui_story then
				arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_200_3 = arg_197_1.actors_["1060ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060ui_story = var_200_3.localPosition
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_3.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_197_1.time_ - 0) / var_200_4)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = Vector3.New(0, -1.14, -6.33)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			local var_200_5 = arg_197_1.actors_["1060ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1060ui_story == nil then
				arg_197_1.var_.characterEffect1060ui_story = var_200_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_6 and not isNil(var_200_5) then
				if arg_197_1.var_.characterEffect1060ui_story and not isNil(var_200_5) then
					arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_6 and arg_197_1.time_ < 0 + var_200_6 + arg_200_0 and not isNil(var_200_5) and arg_197_1.var_.characterEffect1060ui_story then
				arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_8 = 0
			local var_200_9 = 0.2

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(910116049).content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_12 = 8 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_10) / 8)

				if (8 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_10) / 8)) > 0 and var_200_9 < var_200_12 then
					arg_197_1.talkMaxDuration = var_200_12

					if var_200_12 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_13 and arg_197_1.time_ < var_200_8 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910116050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910116051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1060ui_story"]) and arg_201_1.var_.characterEffect1060ui_story == nil then
				arg_201_1.var_.characterEffect1060ui_story = arg_201_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1060ui_story"]) then
				if arg_201_1.var_.characterEffect1060ui_story and not isNil(arg_201_1.actors_["1060ui_story"]) then
					arg_201_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1060ui_story"]) and arg_201_1.var_.characterEffect1060ui_story then
				arg_201_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(910116050).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 7 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 7)

				if (7 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 7)) > 0 and var_204_2 < var_204_5 then
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
	Play910116051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910116051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910116052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1060ui_story = arg_205_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).z)
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles = arg_205_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_205_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1060ui_story"].transform.position).z)
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1060ui_story"].transform.localEulerAngles = arg_205_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1060ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1060ui_story == nil then
				arg_205_1.var_.characterEffect1060ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1060ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1060ui_story then
				arg_205_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_208_4 = 0
			local var_208_5 = 0.25

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(910116051).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 10 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 10)

				if (10 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 10)) > 0 and var_208_5 < var_208_8 then
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

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910116052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910116052
		arg_209_1.duration_ = 7.42

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910116053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.bgs_.STblack == nil then
				local var_212_0 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_212_0.name = "STblack"
				var_212_0.transform.parent = arg_209_1.stage_.transform
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_.STblack = var_212_0
			end

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				local var_212_1 = arg_209_1.bgs_.STblack

				arg_209_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_2 = var_212_1:GetComponent("SpriteRenderer")

				if var_212_2 and var_212_2.sprite then
					local var_212_3 = 2 * (var_212_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_1.transform.localScale = Vector3.New(var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "STblack" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_5 = 2

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_5 then
				local var_212_6 = Color.New(0, 0, 0)

				var_212_6.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_4) / var_212_5)
				arg_209_1.mask_.color = var_212_6
			end

			if arg_209_1.time_ >= var_212_4 + var_212_5 and arg_209_1.time_ < var_212_4 + var_212_5 + arg_212_0 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = 1
				arg_209_1.mask_.color = var_212_7
			end

			local var_212_8 = 2

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_9 = 0.425

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_9 then
				local var_212_10 = Color.New(0, 0, 0)

				var_212_10.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_8) / var_212_9)
				arg_209_1.mask_.color = var_212_10
			end

			if arg_209_1.time_ >= var_212_8 + var_212_9 and arg_209_1.time_ < var_212_8 + var_212_9 + arg_212_0 then
				local var_212_11 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_11.a = 0
				arg_209_1.mask_.color = var_212_11
			end

			local var_212_12 = arg_209_1.actors_["1060ui_story"].transform

			if 2 < arg_209_1.time_ and arg_209_1.time_ <= 2 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060ui_story = var_212_12.localPosition
			end

			local var_212_13 = 0.001

			if 2 <= arg_209_1.time_ and arg_209_1.time_ < 2 + var_212_13 then
				var_212_12.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 2) / var_212_13)
				var_212_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_12.position).x, (manager.ui.mainCamera.transform.position - var_212_12.position).y, (manager.ui.mainCamera.transform.position - var_212_12.position).z)
				var_212_12.localEulerAngles.z = 0
				var_212_12.localEulerAngles.x = 0
				var_212_12.localEulerAngles = var_212_12.localEulerAngles
			end

			if arg_209_1.time_ >= 2 + var_212_13 and arg_209_1.time_ < 2 + var_212_13 + arg_212_0 then
				var_212_12.localPosition = Vector3.New(0, 100, 0)
				var_212_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_12.position).x, (manager.ui.mainCamera.transform.position - var_212_12.position).y, (manager.ui.mainCamera.transform.position - var_212_12.position).z)
				var_212_12.localEulerAngles.z = 0
				var_212_12.localEulerAngles.x = 0
				var_212_12.localEulerAngles = var_212_12.localEulerAngles
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_14 = 2.425
			local var_212_15 = 0.425

			if 2.425 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_16 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_16:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_17 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(910116052).content)

				arg_209_1.text_.text = var_212_17

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_19 = 17 <= 0 and var_212_15 or var_212_15 * (utf8.len(var_212_17) / 17)

				if (17 <= 0 and var_212_15 or var_212_15 * (utf8.len(var_212_17) / 17)) > 0 and var_212_15 < var_212_19 then
					arg_209_1.talkMaxDuration = var_212_19
					var_212_14 = var_212_14 + 0.3

					if var_212_19 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_17
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_20 = var_212_14 + 0.3
			local var_212_21 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_20 + var_212_21 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_20) / var_212_21

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_20 + var_212_21 and arg_209_1.time_ < var_212_20 + var_212_21 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play910116053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 910116053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play910116054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.375

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(910116053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 15 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 15)

				if (15 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 15)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play910116054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 910116054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play910116055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.975

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(910116054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 39 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 39)

				if (39 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 39)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play910116055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 910116055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play910116056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.35

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(910116055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 14 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 14)

				if (14 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 14)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play910116056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 910116056
		arg_227_1.duration_ = 7

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play910116057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.ST40 == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST40")
				var_230_0.name = "ST40"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.ST40 = var_230_0
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.ST40

				arg_227_1.bgs_.ST40.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "ST40" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_5 = 2

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_5 then
				local var_230_6 = Color.New(0, 0, 0)

				var_230_6.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_4) / var_230_5)
				arg_227_1.mask_.color = var_230_6
			end

			if arg_227_1.time_ >= var_230_4 + var_230_5 and arg_227_1.time_ < var_230_4 + var_230_5 + arg_230_0 then
				local var_230_7 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_7.a = 0
				arg_227_1.mask_.color = var_230_7
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_8 = 2
			local var_230_9 = 1.275

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_10 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_10:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_11 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(910116056).content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 51 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 51)

				if (51 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 51)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13
					var_230_8 = var_230_8 + 0.3

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = var_230_8 + 0.3
			local var_230_15 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_14 + var_230_15 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_14) / var_230_15

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_14 + var_230_15 and arg_227_1.time_ < var_230_14 + var_230_15 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play910116057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910116057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910116058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1074ui_story = arg_233_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).z)
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles = arg_233_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_233_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1074ui_story"].transform.position).z)
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1074ui_story"].transform.localEulerAngles = arg_233_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1074ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1074ui_story == nil then
				arg_233_1.var_.characterEffect1074ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1074ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1074ui_story then
				arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = "1072ui_story"

			if arg_233_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_236_5 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_233_1.stage_.transform)

				var_236_5.name = var_236_4
				var_236_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_[var_236_4] = var_236_5

				local var_236_6 = var_236_5:GetComponentInChildren(typeof(CharacterEffect))

				var_236_6.enabled = true

				local var_236_7 = GameObjectTools.GetOrAddComponent(var_236_5, typeof(DynamicBoneHelper))

				if var_236_7 then
					var_236_7:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_6.transform, false)

				arg_233_1.var_[var_236_4 .. "Animator"] = var_236_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_[var_236_4 .. "Animator"].applyRootMotion = true
				arg_233_1.var_[var_236_4 .. "LipSync"] = var_236_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_8 = arg_233_1.actors_["1072ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1072ui_story = var_236_8.localPosition
			end

			local var_236_9 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_9 then
				var_236_8.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_233_1.time_ - 0) / var_236_9)
				var_236_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_8.position).x, (manager.ui.mainCamera.transform.position - var_236_8.position).y, (manager.ui.mainCamera.transform.position - var_236_8.position).z)
				var_236_8.localEulerAngles.z = 0
				var_236_8.localEulerAngles.x = 0
				var_236_8.localEulerAngles = var_236_8.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_9 and arg_233_1.time_ < 0 + var_236_9 + arg_236_0 then
				var_236_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_236_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_8.position).x, (manager.ui.mainCamera.transform.position - var_236_8.position).y, (manager.ui.mainCamera.transform.position - var_236_8.position).z)
				var_236_8.localEulerAngles.z = 0
				var_236_8.localEulerAngles.x = 0
				var_236_8.localEulerAngles = var_236_8.localEulerAngles
			end

			local var_236_10 = arg_233_1.actors_["1072ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_10) and arg_233_1.var_.characterEffect1072ui_story == nil then
				arg_233_1.var_.characterEffect1072ui_story = var_236_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_11 and not isNil(var_236_10) then
				if arg_233_1.var_.characterEffect1072ui_story and not isNil(var_236_10) then
					arg_233_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_11)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_11 and arg_233_1.time_ < 0 + var_236_11 + arg_236_0 and not isNil(var_236_10) and arg_233_1.var_.characterEffect1072ui_story then
				arg_233_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_236_12 = 0
			local var_236_13 = 0.8

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_14 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(910116057).content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_16 = 32 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_14) / 32)

				if (32 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_14) / 32)) > 0 and var_236_13 < var_236_16 then
					arg_233_1.talkMaxDuration = var_236_16

					if var_236_16 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_12
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = math.max(var_236_13, arg_233_1.talkMaxDuration)

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_17 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_12) / var_236_17

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_12 + var_236_17 and arg_233_1.time_ < var_236_12 + var_236_17 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play910116058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910116058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910116059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1072ui_story = arg_237_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).z)
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles = arg_237_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_237_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1072ui_story"].transform.position).z)
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1072ui_story"].transform.localEulerAngles = arg_237_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1072ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1072ui_story == nil then
				arg_237_1.var_.characterEffect1072ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1072ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1072ui_story then
				arg_237_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_240_4 = arg_237_1.actors_["1074ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1074ui_story == nil then
				arg_237_1.var_.characterEffect1074ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_5 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 and not isNil(var_240_4) then
				if arg_237_1.var_.characterEffect1074ui_story and not isNil(var_240_4) then
					arg_237_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_5)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1074ui_story then
				arg_237_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_240_6 = 0
			local var_240_7 = 0.625

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(910116058).content)

				arg_237_1.text_.text = var_240_8

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_10 = 25 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_8) / 25)

				if (25 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_8) / 25)) > 0 and var_240_7 < var_240_10 then
					arg_237_1.talkMaxDuration = var_240_10

					if var_240_10 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_8
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_11 and arg_237_1.time_ < var_240_6 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play910116059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910116059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910116060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1074ui_story = arg_241_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).z)
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles = arg_241_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_241_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1074ui_story"].transform.position).z)
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1074ui_story"].transform.localEulerAngles = arg_241_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1074ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1074ui_story == nil then
				arg_241_1.var_.characterEffect1074ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1074ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1074ui_story then
				arg_241_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = arg_241_1.actors_["1072ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1072ui_story == nil then
				arg_241_1.var_.characterEffect1072ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_5 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_5 and not isNil(var_244_4) then
				if arg_241_1.var_.characterEffect1072ui_story and not isNil(var_244_4) then
					arg_241_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_5)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_5 and arg_241_1.time_ < 0 + var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1072ui_story then
				arg_241_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_244_6 = 0
			local var_244_7 = 0.525

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(910116059).content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 21 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_8) / 21)

				if (21 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_8) / 21)) > 0 and var_244_7 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_11 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_11 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_11

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_11 and arg_241_1.time_ < var_244_6 + var_244_11 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play910116060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 910116060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play910116061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1072ui_story = arg_245_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).z)
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles = arg_245_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_245_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1072ui_story"].transform.position).z)
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1072ui_story"].transform.localEulerAngles = arg_245_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1072ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1072ui_story == nil then
				arg_245_1.var_.characterEffect1072ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1072ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1072ui_story then
				arg_245_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_2")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_4 = arg_245_1.actors_["1074ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1074ui_story == nil then
				arg_245_1.var_.characterEffect1074ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_5 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 and not isNil(var_248_4) then
				if arg_245_1.var_.characterEffect1074ui_story and not isNil(var_248_4) then
					arg_245_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_5)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect1074ui_story then
				arg_245_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_248_6 = 0
			local var_248_7 = 0.975

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(910116060).content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 39 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_8) / 39)

				if (39 <= 0 and var_248_7 or var_248_7 * (utf8.len(var_248_8) / 39)) > 0 and var_248_7 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10

					if var_248_10 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_11 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_11 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_11

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_11 and arg_245_1.time_ < var_248_6 + var_248_11 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play910116061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 910116061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play910116062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1074ui_story = arg_249_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).z)
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles = arg_249_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_249_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1074ui_story"].transform.position).z)
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1074ui_story"].transform.localEulerAngles = arg_249_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1074ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1074ui_story == nil then
				arg_249_1.var_.characterEffect1074ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1074ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1074ui_story then
				arg_249_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["1072ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1072ui_story == nil then
				arg_249_1.var_.characterEffect1072ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_5 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 and not isNil(var_252_4) then
				if arg_249_1.var_.characterEffect1072ui_story and not isNil(var_252_4) then
					arg_249_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_5)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1072ui_story then
				arg_249_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_252_6 = 0
			local var_252_7 = 0.425

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(910116061).content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 17 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_8) / 17)

				if (17 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_8) / 17)) > 0 and var_252_7 < var_252_10 then
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
				actorName = "1074ui_story",
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
	Play910116062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 910116062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play910116063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1072ui_story = arg_253_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).z)
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles = arg_253_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_253_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1072ui_story"].transform.position).z)
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1072ui_story"].transform.localEulerAngles = arg_253_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1072ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1072ui_story == nil then
				arg_253_1.var_.characterEffect1072ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1072ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1072ui_story then
				arg_253_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_256_4 = arg_253_1.actors_["1074ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1074ui_story == nil then
				arg_253_1.var_.characterEffect1074ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_5 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 and not isNil(var_256_4) then
				if arg_253_1.var_.characterEffect1074ui_story and not isNil(var_256_4) then
					arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_5)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1074ui_story then
				arg_253_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_256_6 = 0
			local var_256_7 = 0.825

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(910116062).content)

				arg_253_1.text_.text = var_256_8

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_10 = 33 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_8) / 33)

				if (33 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_8) / 33)) > 0 and var_256_7 < var_256_10 then
					arg_253_1.talkMaxDuration = var_256_10

					if var_256_10 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_8
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_11 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_11 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_11

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_11 and arg_253_1.time_ < var_256_6 + var_256_11 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play910116063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 910116063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play910116064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1074ui_story = arg_257_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).z)
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles = arg_257_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_257_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1074ui_story"].transform.position).z)
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1074ui_story"].transform.localEulerAngles = arg_257_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1074ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1074ui_story == nil then
				arg_257_1.var_.characterEffect1074ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1074ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1074ui_story then
				arg_257_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["1072ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1072ui_story == nil then
				arg_257_1.var_.characterEffect1072ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_5 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_5 and not isNil(var_260_4) then
				if arg_257_1.var_.characterEffect1072ui_story and not isNil(var_260_4) then
					arg_257_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_5)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_5 and arg_257_1.time_ < 0 + var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1072ui_story then
				arg_257_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_260_6 = 0
			local var_260_7 = 1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(910116063).content)

				arg_257_1.text_.text = var_260_8

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_10 = 18 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_8) / 18)

				if (18 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_8) / 18)) > 0 and var_260_7 < var_260_10 then
					arg_257_1.talkMaxDuration = var_260_10

					if var_260_10 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_8
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_11 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_11 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_11

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_11 and arg_257_1.time_ < var_260_6 + var_260_11 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play910116064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 910116064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play910116065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1072ui_story = arg_261_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).z)
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles = arg_261_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_261_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1072ui_story"].transform.position).z)
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1072ui_story"].transform.localEulerAngles = arg_261_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1072ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1072ui_story == nil then
				arg_261_1.var_.characterEffect1072ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1072ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1072ui_story then
				arg_261_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_264_4 = arg_261_1.actors_["1074ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1074ui_story == nil then
				arg_261_1.var_.characterEffect1074ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_5 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_5 and not isNil(var_264_4) then
				if arg_261_1.var_.characterEffect1074ui_story and not isNil(var_264_4) then
					arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_5)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_5 and arg_261_1.time_ < 0 + var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1074ui_story then
				arg_261_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_264_6 = 0
			local var_264_7 = 1.225

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(910116064).content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 63 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_8) / 63)

				if (63 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_8) / 63)) > 0 and var_264_7 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_11 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_11 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_11

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_11 and arg_261_1.time_ < var_264_6 + var_264_11 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play910116065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 910116065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play910116066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.425

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(910116065).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 65 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 65)

				if (65 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 65)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play910116066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 910116066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play910116067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1074ui_story = arg_269_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).z)
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles = arg_269_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_269_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1074ui_story"].transform.position).z)
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1074ui_story"].transform.localEulerAngles = arg_269_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1074ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1074ui_story == nil then
				arg_269_1.var_.characterEffect1074ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1074ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1074ui_story then
				arg_269_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_272_4 = arg_269_1.actors_["1072ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect1072ui_story == nil then
				arg_269_1.var_.characterEffect1072ui_story = var_272_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_5 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 and not isNil(var_272_4) then
				if arg_269_1.var_.characterEffect1072ui_story and not isNil(var_272_4) then
					arg_269_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_5)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect1072ui_story then
				arg_269_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_272_6 = 0
			local var_272_7 = 0.65

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(910116066).content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 31 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_8) / 31)

				if (31 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_8) / 31)) > 0 and var_272_7 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_11 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_11 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_11

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_11 and arg_269_1.time_ < var_272_6 + var_272_11 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play910116067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 910116067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play910116068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1072ui_story = arg_273_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).z)
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles = arg_273_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_273_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1072ui_story"].transform.position).z)
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1072ui_story"].transform.localEulerAngles = arg_273_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1072ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1072ui_story == nil then
				arg_273_1.var_.characterEffect1072ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1072ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1072ui_story then
				arg_273_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_4 = arg_273_1.actors_["1074ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1074ui_story == nil then
				arg_273_1.var_.characterEffect1074ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_5 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 and not isNil(var_276_4) then
				if arg_273_1.var_.characterEffect1074ui_story and not isNil(var_276_4) then
					arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_5)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1074ui_story then
				arg_273_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_276_6 = 0
			local var_276_7 = 0.925

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(910116067).content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 40 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_8) / 40)

				if (40 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_8) / 40)) > 0 and var_276_7 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_11 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_11 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_11

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_11 and arg_273_1.time_ < var_276_6 + var_276_11 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play910116068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 910116068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play910116069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.425

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(910116068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 17 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 17)

				if (17 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 17)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play910116069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 910116069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play910116070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.375

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(910116069).content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 15 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_2) / 15)

				if (15 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_2) / 15)) > 0 and var_284_1 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_5 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_5 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_5

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_5 and arg_281_1.time_ < var_284_0 + var_284_5 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play910116070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 910116070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play910116071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) and arg_285_1.var_.characterEffect1072ui_story == nil then
				arg_285_1.var_.characterEffect1072ui_story = arg_285_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) then
				if arg_285_1.var_.characterEffect1072ui_story and not isNil(arg_285_1.actors_["1072ui_story"]) then
					arg_285_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1072ui_story"]) and arg_285_1.var_.characterEffect1072ui_story then
				arg_285_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_288_1 = arg_285_1.actors_["1074ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1074ui_story == nil then
				arg_285_1.var_.characterEffect1074ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1074ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1074ui_story then
				arg_285_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_288_4 = 0
			local var_288_5 = 0.25

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(910116070).content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 10 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 10)

				if (10 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 10)) > 0 and var_288_5 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_9 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_9 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_9

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_9 and arg_285_1.time_ < var_288_4 + var_288_9 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play910116071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 910116071
		arg_289_1.duration_ = 9

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play910116072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.bgs_.NI0201 == nil then
				local var_292_0 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "NI0201")
				var_292_0.name = "NI0201"
				var_292_0.transform.parent = arg_289_1.stage_.transform
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_.NI0201 = var_292_0
			end

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= 2 + arg_292_0 then
				local var_292_1 = arg_289_1.bgs_.NI0201

				arg_289_1.bgs_.NI0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_2 = var_292_1:GetComponent("SpriteRenderer")

				if var_292_2 and var_292_2.sprite then
					local var_292_3 = 2 * (var_292_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_1.transform.localScale = Vector3.New(var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "NI0201" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_4 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_5 = 2

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_5 then
				local var_292_6 = Color.New(0, 0, 0)

				var_292_6.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_4) / var_292_5)
				arg_289_1.mask_.color = var_292_6
			end

			if arg_289_1.time_ >= var_292_4 + var_292_5 and arg_289_1.time_ < var_292_4 + var_292_5 + arg_292_0 then
				local var_292_7 = Color.New(0, 0, 0)

				var_292_7.a = 1
				arg_289_1.mask_.color = var_292_7
			end

			local var_292_8 = 2

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_9 = 2

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 then
				local var_292_10 = Color.New(0, 0, 0)

				var_292_10.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_8) / var_292_9)
				arg_289_1.mask_.color = var_292_10
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 then
				local var_292_11 = Color.New(0, 0, 0)

				arg_289_1.mask_.enabled = false
				var_292_11.a = 0
				arg_289_1.mask_.color = var_292_11
			end

			local var_292_12 = arg_289_1.actors_["1074ui_story"].transform

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= 2 + arg_292_0 then
				arg_289_1.var_.moveOldPos1074ui_story = var_292_12.localPosition
			end

			local var_292_13 = 0.001

			if 2 <= arg_289_1.time_ and arg_289_1.time_ < 2 + var_292_13 then
				var_292_12.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 2) / var_292_13)
				var_292_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_12.position).x, (manager.ui.mainCamera.transform.position - var_292_12.position).y, (manager.ui.mainCamera.transform.position - var_292_12.position).z)
				var_292_12.localEulerAngles.z = 0
				var_292_12.localEulerAngles.x = 0
				var_292_12.localEulerAngles = var_292_12.localEulerAngles
			end

			if arg_289_1.time_ >= 2 + var_292_13 and arg_289_1.time_ < 2 + var_292_13 + arg_292_0 then
				var_292_12.localPosition = Vector3.New(0, 100, 0)
				var_292_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_12.position).x, (manager.ui.mainCamera.transform.position - var_292_12.position).y, (manager.ui.mainCamera.transform.position - var_292_12.position).z)
				var_292_12.localEulerAngles.z = 0
				var_292_12.localEulerAngles.x = 0
				var_292_12.localEulerAngles = var_292_12.localEulerAngles
			end

			local var_292_14 = arg_289_1.actors_["1072ui_story"].transform

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= 2 + arg_292_0 then
				arg_289_1.var_.moveOldPos1072ui_story = var_292_14.localPosition
			end

			local var_292_15 = 0.001

			if 2 <= arg_289_1.time_ and arg_289_1.time_ < 2 + var_292_15 then
				var_292_14.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 2) / var_292_15)
				var_292_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_14.position).x, (manager.ui.mainCamera.transform.position - var_292_14.position).y, (manager.ui.mainCamera.transform.position - var_292_14.position).z)
				var_292_14.localEulerAngles.z = 0
				var_292_14.localEulerAngles.x = 0
				var_292_14.localEulerAngles = var_292_14.localEulerAngles
			end

			if arg_289_1.time_ >= 2 + var_292_15 and arg_289_1.time_ < 2 + var_292_15 + arg_292_0 then
				var_292_14.localPosition = Vector3.New(0, 100, 0)
				var_292_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_14.position).x, (manager.ui.mainCamera.transform.position - var_292_14.position).y, (manager.ui.mainCamera.transform.position - var_292_14.position).z)
				var_292_14.localEulerAngles.z = 0
				var_292_14.localEulerAngles.x = 0
				var_292_14.localEulerAngles = var_292_14.localEulerAngles
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_16 = 4
			local var_292_17 = 0.475

			if 4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_18 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_18:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_19 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(910116071).content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_21 = 19 <= 0 and var_292_17 or var_292_17 * (utf8.len(var_292_19) / 19)

				if (19 <= 0 and var_292_17 or var_292_17 * (utf8.len(var_292_19) / 19)) > 0 and var_292_17 < var_292_21 then
					arg_289_1.talkMaxDuration = var_292_21
					var_292_16 = var_292_16 + 0.3

					if var_292_21 + var_292_16 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_21 + var_292_16
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_22 = var_292_16 + 0.3
			local var_292_23 = math.max(var_292_17, arg_289_1.talkMaxDuration)

			if var_292_16 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_22 + var_292_23 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_22) / var_292_23

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_22 + var_292_23 and arg_289_1.time_ < var_292_22 + var_292_23 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play910116072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 910116072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play910116073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.725

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(910116072).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 29 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 29)

				if (29 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 29)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play910116073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 910116073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play910116074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.8

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(910116073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 32 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 32)

				if (32 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 32)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play910116074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 910116074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play910116075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.275

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(910116074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 11 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 11)

				if (11 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 11)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play910116075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 910116075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play910116076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.525

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(910116075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 21 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 21)

				if (21 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 21)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play910116076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 910116076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
			arg_311_1.auto_ = false
		end

		function arg_311_1.playNext_(arg_313_0)
			arg_311_1.onStoryFinished_()
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.475

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(910116076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 19 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 19)

				if (19 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 19)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST40",
		"TextureConfig/Background/NI0201"
	},
	voices = {}
}
