return {
	Play414371001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414371001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414371002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H07h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_4_0.name = "H07h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H07h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H07h

				arg_1_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H07h" then
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

			local var_4_9 = "1039ui_story"

			if arg_1_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1039ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1039ui_story = var_4_13.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.01, -5.9)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1039ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1039ui_story == nil then
				arg_1_1.var_.characterEffect1039ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1039ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1039ui_story then
				arg_1_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.25

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414371001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 10 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 10)

				if (10 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 10)) > 0 and var_4_19 < var_4_23 then
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
				actorName = "1039ui_story",
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
	Play414371002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 414371002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play414371003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1039ui_story"]) and arg_7_1.var_.characterEffect1039ui_story == nil then
				arg_7_1.var_.characterEffect1039ui_story = arg_7_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1039ui_story"]) then
				if arg_7_1.var_.characterEffect1039ui_story and not isNil(arg_7_1.actors_["1039ui_story"]) then
					arg_7_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1039ui_story"]) and arg_7_1.var_.characterEffect1039ui_story then
				arg_7_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 0.925

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

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(414371002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 37 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 37)

				if (37 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 37)) > 0 and var_10_2 < var_10_5 then
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
	Play414371003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 414371003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play414371004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1039ui_story = arg_11_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).z)
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles = arg_11_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_11_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1039ui_story"].transform.position).z)
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1039ui_story"].transform.localEulerAngles = arg_11_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1039ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1039ui_story == nil then
				arg_11_1.var_.characterEffect1039ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect1039ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1039ui_story then
				arg_11_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_14_4 = 0
			local var_14_5 = 0.45

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_6 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(414371003).content)

				arg_11_1.text_.text = var_14_6

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_8 = 18 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 18)

				if (18 <= 0 and var_14_5 or var_14_5 * (utf8.len(var_14_6) / 18)) > 0 and var_14_5 < var_14_8 then
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
				actorName = "1039ui_story",
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
	Play414371004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 414371004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play414371005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1039ui_story = arg_15_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).z)
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles = arg_15_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1039ui_story"].transform.position).z)
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1039ui_story"].transform.localEulerAngles = arg_15_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["1039ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1039ui_story == nil then
				arg_15_1.var_.characterEffect1039ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect1039ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_2)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1039ui_story then
				arg_15_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_18_3 = "104902ui_story"

			if arg_15_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_18_4 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_15_1.stage_.transform)

				var_18_4.name = var_18_3
				var_18_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_[var_18_3] = var_18_4

				local var_18_5 = var_18_4:GetComponentInChildren(typeof(CharacterEffect))

				var_18_5.enabled = true

				local var_18_6 = GameObjectTools.GetOrAddComponent(var_18_4, typeof(DynamicBoneHelper))

				if var_18_6 then
					var_18_6:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_5.transform, false)

				arg_15_1.var_[var_18_3 .. "Animator"] = var_18_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_[var_18_3 .. "Animator"].applyRootMotion = true
				arg_15_1.var_[var_18_3 .. "LipSync"] = var_18_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_7 = arg_15_1.actors_["104902ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos104902ui_story = var_18_7.localPosition
			end

			local var_18_8 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_8 then
				var_18_7.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_15_1.time_ - 0) / var_18_8)
				var_18_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_7.position).x, (manager.ui.mainCamera.transform.position - var_18_7.position).y, (manager.ui.mainCamera.transform.position - var_18_7.position).z)
				var_18_7.localEulerAngles.z = 0
				var_18_7.localEulerAngles.x = 0
				var_18_7.localEulerAngles = var_18_7.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_8 and arg_15_1.time_ < 0 + var_18_8 + arg_18_0 then
				var_18_7.localPosition = Vector3.New(0, -1.2, -6)
				var_18_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_7.position).x, (manager.ui.mainCamera.transform.position - var_18_7.position).y, (manager.ui.mainCamera.transform.position - var_18_7.position).z)
				var_18_7.localEulerAngles.z = 0
				var_18_7.localEulerAngles.x = 0
				var_18_7.localEulerAngles = var_18_7.localEulerAngles
			end

			local var_18_9 = arg_15_1.actors_["104902ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect104902ui_story == nil then
				arg_15_1.var_.characterEffect104902ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_10 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_10 and not isNil(var_18_9) then
				if arg_15_1.var_.characterEffect104902ui_story and not isNil(var_18_9) then
					arg_15_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_10 and arg_15_1.time_ < 0 + var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect104902ui_story then
				arg_15_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action2_1")
			end

			local var_18_12 = 0
			local var_18_13 = 0.325

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
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

				local var_18_14 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(414371004).content)

				arg_15_1.text_.text = var_18_14

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_16 = 13 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_14) / 13)

				if (13 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_14) / 13)) > 0 and var_18_13 < var_18_16 then
					arg_15_1.talkMaxDuration = var_18_16

					if var_18_16 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_12
					end
				end

				arg_15_1.text_.text = var_18_14
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_17 = math.max(var_18_13, arg_15_1.talkMaxDuration)

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_17 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_17

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_17 and arg_15_1.time_ < var_18_12 + var_18_17 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play414371005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 414371005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play414371006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1039ui_story = arg_19_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).z)
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles = arg_19_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_19_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1039ui_story"].transform.position).z)
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1039ui_story"].transform.localEulerAngles = arg_19_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1039ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1039ui_story == nil then
				arg_19_1.var_.characterEffect1039ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect1039ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect1039ui_story then
				arg_19_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_2")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_22_4 = arg_19_1.actors_["104902ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos104902ui_story = var_22_4.localPosition
			end

			local var_22_5 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 then
				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_5)
				var_22_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_4.position).x, (manager.ui.mainCamera.transform.position - var_22_4.position).y, (manager.ui.mainCamera.transform.position - var_22_4.position).z)
				var_22_4.localEulerAngles.z = 0
				var_22_4.localEulerAngles.x = 0
				var_22_4.localEulerAngles = var_22_4.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_5 and arg_19_1.time_ < 0 + var_22_5 + arg_22_0 then
				var_22_4.localPosition = Vector3.New(0, 100, 0)
				var_22_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_4.position).x, (manager.ui.mainCamera.transform.position - var_22_4.position).y, (manager.ui.mainCamera.transform.position - var_22_4.position).z)
				var_22_4.localEulerAngles.z = 0
				var_22_4.localEulerAngles.x = 0
				var_22_4.localEulerAngles = var_22_4.localEulerAngles
			end

			local var_22_6 = arg_19_1.actors_["104902ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect104902ui_story == nil then
				arg_19_1.var_.characterEffect104902ui_story = var_22_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_7 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 and not isNil(var_22_6) then
				if arg_19_1.var_.characterEffect104902ui_story and not isNil(var_22_6) then
					arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_19_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_7)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect104902ui_story then
				arg_19_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_19_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_22_8 = 0
			local var_22_9 = 0.525

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(414371005).content)

				arg_19_1.text_.text = var_22_10

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_12 = 21 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_10) / 21)

				if (21 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_10) / 21)) > 0 and var_22_9 < var_22_12 then
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play414371006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414371006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414371007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1039ui_story"]) and arg_23_1.var_.characterEffect1039ui_story == nil then
				arg_23_1.var_.characterEffect1039ui_story = arg_23_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1039ui_story"]) then
				if arg_23_1.var_.characterEffect1039ui_story and not isNil(arg_23_1.actors_["1039ui_story"]) then
					arg_23_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1039ui_story"]) and arg_23_1.var_.characterEffect1039ui_story then
				arg_23_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_26_1 = 0
			local var_26_2 = 0.45

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
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

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(414371006).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 18 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 18)

				if (18 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 18)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play414371007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414371007
		arg_27_1.duration_ = 5.47

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414371008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1039ui_story = arg_27_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).z)
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles = arg_27_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_27_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1039ui_story"].transform.position).z)
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1039ui_story"].transform.localEulerAngles = arg_27_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1039ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1039ui_story == nil then
				arg_27_1.var_.characterEffect1039ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1039ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1039ui_story then
				arg_27_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_4 = 0.466666666666667
			local var_30_5 = 0.15

			if 0.466666666666667 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_6 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_6:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(414371007).content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 6 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 6)

				if (6 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 6)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9
					var_30_4 = var_30_4 + 0.3

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = var_30_4 + 0.3
			local var_30_11 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play414371008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414371008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414371009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) and arg_33_1.var_.characterEffect1039ui_story == nil then
				arg_33_1.var_.characterEffect1039ui_story = arg_33_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) then
				if arg_33_1.var_.characterEffect1039ui_story and not isNil(arg_33_1.actors_["1039ui_story"]) then
					arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) and arg_33_1.var_.characterEffect1039ui_story then
				arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.5

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[90].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(414371008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 20 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 20)

				if (20 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 20)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play414371009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 414371009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play414371010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1039ui_story = arg_37_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).z)
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles = arg_37_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1039ui_story"].transform.position).z)
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1039ui_story"].transform.localEulerAngles = arg_37_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_40_1 = 0
			local var_40_2 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(414371009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 24)

				if (24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 24)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play414371010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 414371010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play414371011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1039ui_story = arg_41_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).z)
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles = arg_41_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_41_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1039ui_story"].transform.position).z)
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1039ui_story"].transform.localEulerAngles = arg_41_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1039ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1039ui_story == nil then
				arg_41_1.var_.characterEffect1039ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1039ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1039ui_story then
				arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action7_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.2

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(414371010).content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 8 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 8)

				if (8 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_6) / 8)) > 0 and var_44_5 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_9 and arg_41_1.time_ < var_44_4 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play414371011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 414371011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
			arg_45_1.auto_ = false
		end

		function arg_45_1.playNext_(arg_47_0)
			arg_45_1.onStoryFinished_()
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(414371011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)

				if (30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H07h"
	},
	voices = {}
}
