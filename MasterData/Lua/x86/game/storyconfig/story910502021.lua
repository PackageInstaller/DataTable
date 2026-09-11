return {
	Play910502008 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910502008
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910502009(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K04f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K04f")
				var_4_0.name = "K04f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K04f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K04f

				arg_1_1.bgs_.K04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K04f" then
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

			local var_4_9 = "10048ui_story"

			if arg_1_1.actors_["10048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10048ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10048ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10048ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10048ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.155, -6.13)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10048ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10048ui_story == nil then
				arg_1_1.var_.characterEffect10048ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10048ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10048ui_story then
				arg_1_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action7_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2.00000000298023
			local var_4_19 = 0.3

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910502008).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 12 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 12)

				if (12 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 12)) > 0 and var_4_19 < var_4_23 then
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
				actorName = "10048ui_story",
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
	Play910502009 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910502009
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910502010(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos10048ui_story = arg_7_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_10_0 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				arg_7_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).z)
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles = arg_7_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				arg_7_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["10048ui_story"].transform.position).z)
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["10048ui_story"].transform.localEulerAngles = arg_7_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_10_1 = arg_7_1.actors_["10048ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect10048ui_story == nil then
				arg_7_1.var_.characterEffect10048ui_story = var_10_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_2 and not isNil(var_10_1) then
				if arg_7_1.var_.characterEffect10048ui_story and not isNil(var_10_1) then
					arg_7_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_7_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_2)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_2 and arg_7_1.time_ < 0 + var_10_2 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect10048ui_story then
				arg_7_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_7_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_10_3 = 0
			local var_10_4 = 0.375

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_3 + arg_10_0 then
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

				local var_10_5 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910502009).content)

				arg_7_1.text_.text = var_10_5

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_7 = 15 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 15)

				if (15 <= 0 and var_10_4 or var_10_4 * (utf8.len(var_10_5) / 15)) > 0 and var_10_4 < var_10_7 then
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
				actorName = "10048ui_story",
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
	Play910502010 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910502010
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910502011(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "1055ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1055ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["1055ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["1055ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["1055ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1055ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["1055ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1055ui_story == nil then
				arg_11_1.var_.characterEffect1055ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect1055ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1055ui_story then
				arg_11_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_14_8 = 0
			local var_14_9 = 0.2

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910502010).content)

				arg_11_1.text_.text = var_14_10

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_12 = 8 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 8)

				if (8 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_10) / 8)) > 0 and var_14_9 < var_14_12 then
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
				actorName = "1055ui_story",
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
	Play910502011 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910502011
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
			arg_15_1.auto_ = false
		end

		function arg_15_1.playNext_(arg_17_0)
			arg_15_1.onStoryFinished_()
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos10048ui_story = arg_15_1.actors_["10048ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["10048ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10048ui_story, Vector3.New(0.7, -1.155, -6.13), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).z)
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles = arg_15_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["10048ui_story"].transform.localPosition = Vector3.New(0.7, -1.155, -6.13)
				arg_15_1.actors_["10048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["10048ui_story"].transform.position).z)
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["10048ui_story"].transform.localEulerAngles = arg_15_1.actors_["10048ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["10048ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect10048ui_story == nil then
				arg_15_1.var_.characterEffect10048ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect10048ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect10048ui_story then
				arg_15_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action1_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_18_4 = arg_15_1.actors_["1055ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1055ui_story == nil then
				arg_15_1.var_.characterEffect1055ui_story = var_18_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_5 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 and not isNil(var_18_4) then
				if arg_15_1.var_.characterEffect1055ui_story and not isNil(var_18_4) then
					arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_5)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1055ui_story then
				arg_15_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_18_6 = 0
			local var_18_7 = 0.375

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[476].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_8 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910502011).content)

				arg_15_1.text_.text = var_18_8

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_10 = 15 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 15)

				if (15 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_8) / 15)) > 0 and var_18_7 < var_18_10 then
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
				actorName = "10048ui_story",
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
	assets = {
		"TextureConfig/Background/K04f"
	},
	voices = {}
}
