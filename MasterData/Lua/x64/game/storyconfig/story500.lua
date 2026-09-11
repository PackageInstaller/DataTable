return {
	Play100011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 100011001
		arg_1_1.duration_ = 10.9

		local var_1_0 = {
			ja = 10.9,
			ko = 7.133,
			zh = 6.9,
			en = 7.833
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play100011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST28 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28")
				var_4_0.name = "ST28"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST28 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST28

				arg_1_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST28" then
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

			local var_4_8 = "6148ui_story"

			if arg_1_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["6148ui_story"].transform

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.13333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos6148ui_story = var_4_12.localPosition

				local var_4_13 = GameObjectTools.GetOrAddComponent(var_4_12.gameObject, typeof(DynamicBoneHelper))

				if var_4_13 then
					var_4_13:EnableDynamicBone(false)
				end
			end

			local var_4_14 = 0.001

			if 1.13333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.13333333333333 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_1_1.time_ - 1.13333333333333) / var_4_14)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.13333333333333 + var_4_14 and arg_1_1.time_ < 1.13333333333333 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles

				local var_4_15 = GameObjectTools.GetOrAddComponent(var_4_12.gameObject, typeof(DynamicBoneHelper))

				if var_4_15 then
					var_4_15:EnableDynamicBone(true)
				end
			end

			local var_4_16 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_17 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

				var_4_17.name = var_4_16
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_16] = var_4_17

				local var_4_18 = var_4_17:GetComponentInChildren(typeof(CharacterEffect))

				var_4_18.enabled = true

				local var_4_19 = GameObjectTools.GetOrAddComponent(var_4_17, typeof(DynamicBoneHelper))

				if var_4_19 then
					var_4_19:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_18.transform, false)

				arg_1_1.var_[var_4_16 .. "Animator"] = var_4_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_20 = arg_1_1.actors_["1070ui_story"]

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.13333333333333 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_21 = 0.2

			if 1.13333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.13333333333333 + var_4_21 and not isNil(var_4_20) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_20) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.13333333333333 + var_4_21 and arg_1_1.time_ < 1.13333333333333 + var_4_21 + arg_4_0 and not isNil(var_4_20) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_4_23 = "1054ui_story"

			if arg_1_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_1_1.stage_.transform)

				var_4_24.name = var_4_23
				var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_23] = var_4_24

				local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

				var_4_25.enabled = true

				local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

				if var_4_26 then
					var_4_26:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_25.transform, false)

				arg_1_1.var_[var_4_23 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_23 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_23 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.13333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= 4.2 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 1.16733333518108 < arg_1_1.time_ and arg_1_1.time_ <= 1.16733333518108 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_4_27 = arg_1_1.actors_["1054ui_story"].transform

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.13333333333333 + arg_4_0 then
				arg_1_1.var_.moveOldPos1054ui_story = var_4_27.localPosition

				local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_28 then
					var_4_28:EnableDynamicBone(false)
				end
			end

			local var_4_29 = 0.001

			if 1.13333333333333 <= arg_1_1.time_ and arg_1_1.time_ < 1.13333333333333 + var_4_29 then
				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_1_1.time_ - 1.13333333333333) / var_4_29)
				var_4_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_27.position).x, (manager.ui.mainCamera.transform.position - var_4_27.position).y, (manager.ui.mainCamera.transform.position - var_4_27.position).z)
				var_4_27.localEulerAngles.z = 0
				var_4_27.localEulerAngles.x = 0
				var_4_27.localEulerAngles = var_4_27.localEulerAngles
			end

			if arg_1_1.time_ >= 1.13333333333333 + var_4_29 and arg_1_1.time_ < 1.13333333333333 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0.7, -0.985, -6)
				var_4_27.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_27.position).x, (manager.ui.mainCamera.transform.position - var_4_27.position).y, (manager.ui.mainCamera.transform.position - var_4_27.position).z)
				var_4_27.localEulerAngles.z = 0
				var_4_27.localEulerAngles.x = 0
				var_4_27.localEulerAngles = var_4_27.localEulerAngles

				local var_4_30 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_30 then
					var_4_30:EnableDynamicBone(true)
				end
			end

			if 1.13333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.13333333333333 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= 4.2 + arg_4_0 then
				arg_1_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_31 = 1.6
			local var_4_32 = 0.7

			if 1.6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_34 = arg_1_1:GetWordFromCfg(100011001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 28 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 28)

				if (28 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 28)) > 0 and var_4_32 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_31 = var_4_31 + 0.3

					if var_4_37 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") ~= 0 then
					local var_4_38 = manager.audio:GetVoiceLength("story_v_out_100011", "100011001", "story_v_out_100011.awb") / 1000

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_100011", "100011001", "story_v_out_100011.awb")

						arg_1_1:RecordAudio("100011001", var_4_39)
						arg_1_1:RecordAudio("100011001", var_4_39)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_100011", "100011001", "story_v_out_100011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_100011", "100011001", "story_v_out_100011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_31 + 0.3
			local var_4_41 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_31 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play100011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 100011002
		arg_7_1.duration_ = 23.83

		local var_7_0 = {
			ja = 23.8326666666667,
			ko = 17.4326666666667,
			zh = 18.8326666666667,
			en = 20.0666666666667
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play100011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 2 < arg_7_1.time_ and arg_7_1.time_ <= 2 + arg_10_0 then
				arg_7_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_1")
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_0 = 4.16666666666667
			local var_10_1 = 1.5

			if 4.16666666666667 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_2 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_2:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:GetWordFromCfg(100011002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_6 = 60 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_4) / 60)

				if (60 <= 0 and var_10_1 or var_10_1 * (utf8.len(var_10_4) / 60)) > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6
					var_10_0 = var_10_0 + 0.3

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") ~= 0 then
					local var_10_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011002", "story_v_out_100011.awb") / 1000

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end

					if var_10_3.prefab_name ~= "" and arg_7_1.actors_[var_10_3.prefab_name] ~= nil then
						local var_10_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_3.prefab_name].transform, "story_v_out_100011", "100011002", "story_v_out_100011.awb")

						arg_7_1:RecordAudio("100011002", var_10_8)
						arg_7_1:RecordAudio("100011002", var_10_8)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_100011", "100011002", "story_v_out_100011.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_100011", "100011002", "story_v_out_100011.awb")
				end

				arg_7_1:RecordContent((string.gsub(var_10_4, "「盖亚」", "「盖亚」(Geyser宇宙)")))
			end

			local var_10_9 = var_10_0 + 0.3
			local var_10_10 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_9 + var_10_10 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_9) / var_10_10

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_9 + var_10_10 and arg_7_1.time_ < var_10_9 + var_10_10 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play100011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 100011003
		arg_13_1.duration_ = 24.83

		local var_13_0 = {
			ja = 24.833,
			ko = 18.2,
			zh = 16.566,
			en = 21.266
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play100011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_2")
			end

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= 2 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_0 = 4
			local var_16_1 = 1.6

			if 4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_2 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_2:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(100011003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 64 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_4) / 64)

				if (64 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_4) / 64)) > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6
					var_16_0 = var_16_0 + 0.3

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011003", "story_v_out_100011.awb") / 1000

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_100011", "100011003", "story_v_out_100011.awb")

						arg_13_1:RecordAudio("100011003", var_16_8)
						arg_13_1:RecordAudio("100011003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_100011", "100011003", "story_v_out_100011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_100011", "100011003", "story_v_out_100011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = var_16_0 + 0.3
			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_9 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_9) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_9 + var_16_10 and arg_13_1.time_ < var_16_9 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play100011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 100011004
		arg_19_1.duration_ = 22.6

		local var_19_0 = {
			ja = 22.6,
			ko = 16.433,
			zh = 17.866,
			en = 19.733
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play100011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			if 2 < arg_19_1.time_ and arg_19_1.time_ <= 2 + arg_22_0 then
				arg_19_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_0 = 4
			local var_22_1 = 1.525

			if 4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_2 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_2:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(100011004)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 61 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_4) / 61)

				if (61 <= 0 and var_22_1 or var_22_1 * (utf8.len(var_22_4) / 61)) > 0 and var_22_1 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6
					var_22_0 = var_22_0 + 0.3

					if var_22_6 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") ~= 0 then
					local var_22_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011004", "story_v_out_100011.awb") / 1000

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_100011", "100011004", "story_v_out_100011.awb")

						arg_19_1:RecordAudio("100011004", var_22_8)
						arg_19_1:RecordAudio("100011004", var_22_8)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_100011", "100011004", "story_v_out_100011.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_100011", "100011004", "story_v_out_100011.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_9 = var_22_0 + 0.3
			local var_22_10 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_9 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_9) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_9 + var_22_10 and arg_19_1.time_ < var_22_9 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play100011005 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 100011005
		arg_25_1.duration_ = 10.17

		local var_25_0 = {
			ja = 10.1663333333333,
			ko = 7.96633333333333,
			zh = 8.39933333333333,
			en = 7.49933333333333
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play100011006(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_0 = 3.73333333333333
			local var_28_1 = 0.475

			if 3.73333333333333 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_2 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_2:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(100011005)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 19 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_4) / 19)

				if (19 <= 0 and var_28_1 or var_28_1 * (utf8.len(var_28_4) / 19)) > 0 and var_28_1 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6
					var_28_0 = var_28_0 + 0.3

					if var_28_6 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011005", "story_v_out_100011.awb") / 1000

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_100011", "100011005", "story_v_out_100011.awb")

						arg_25_1:RecordAudio("100011005", var_28_8)
						arg_25_1:RecordAudio("100011005", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_100011", "100011005", "story_v_out_100011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_100011", "100011005", "story_v_out_100011.awb")
				end

				arg_25_1:RecordContent((string.gsub(var_28_4, "「视骸」", "「视骸」(BUG)")))
			end

			local var_28_9 = var_28_0 + 0.3
			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_10 and arg_25_1.time_ < var_28_9 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play100011006 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 100011006
		arg_31_1.duration_ = 17.77

		local var_31_0 = {
			ja = 17.766,
			ko = 15.066,
			zh = 12.133,
			en = 15.833
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play100011007(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			if 2 < arg_31_1.time_ and arg_31_1.time_ <= 2 + arg_34_0 then
				arg_31_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_0 = 3.8
			local var_34_1 = 1.075

			if 3.8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_2 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_2:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:GetWordFromCfg(100011006)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_6 = 43 <= 0 and var_34_1 or var_34_1 * (utf8.len(var_34_4) / 43)

				if (43 <= 0 and var_34_1 or var_34_1 * (utf8.len(var_34_4) / 43)) > 0 and var_34_1 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6
					var_34_0 = var_34_0 + 0.3

					if var_34_6 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") ~= 0 then
					local var_34_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011006", "story_v_out_100011.awb") / 1000

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end

					if var_34_3.prefab_name ~= "" and arg_31_1.actors_[var_34_3.prefab_name] ~= nil then
						local var_34_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_3.prefab_name].transform, "story_v_out_100011", "100011006", "story_v_out_100011.awb")

						arg_31_1:RecordAudio("100011006", var_34_8)
						arg_31_1:RecordAudio("100011006", var_34_8)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_100011", "100011006", "story_v_out_100011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_100011", "100011006", "story_v_out_100011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_9 = var_34_0 + 0.3
			local var_34_10 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_9 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_9) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_9 + var_34_10 and arg_31_1.time_ < var_34_9 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play100011007 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 100011007
		arg_37_1.duration_ = 11.93

		local var_37_0 = {
			ja = 11.933,
			ko = 10.2,
			zh = 8.7,
			en = 10.733
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play100011008(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			local var_40_0 = 0
			local var_40_1 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_2 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_2:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(100011007)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 39 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_4) / 39)

				if (39 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_4) / 39)) > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6
					var_40_0 = var_40_0 + 0.3

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_100011", "100011007", "story_v_out_100011.awb") / 1000

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_100011", "100011007", "story_v_out_100011.awb")

						arg_37_1:RecordAudio("100011007", var_40_8)
						arg_37_1:RecordAudio("100011007", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_100011", "100011007", "story_v_out_100011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_100011", "100011007", "story_v_out_100011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = var_40_0 + 0.3
			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_9) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play100011008 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 100011008
		arg_43_1.duration_ = 12.3

		local var_43_0 = {
			ja = 12.3,
			ko = 8.466,
			zh = 8.266,
			en = 9.4
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play100011009(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_2")
			end

			local var_46_0 = 0
			local var_46_1 = 1.025

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(100011008)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 41 <= 0 and var_46_1 or var_46_1 * (utf8.len(var_46_3) / 41)

				if (41 <= 0 and var_46_1 or var_46_1 * (utf8.len(var_46_3) / 41)) > 0 and var_46_1 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") ~= 0 then
					local var_46_6 = manager.audio:GetVoiceLength("story_v_out_100011", "100011008", "story_v_out_100011.awb") / 1000

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end

					if var_46_2.prefab_name ~= "" and arg_43_1.actors_[var_46_2.prefab_name] ~= nil then
						local var_46_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_2.prefab_name].transform, "story_v_out_100011", "100011008", "story_v_out_100011.awb")

						arg_43_1:RecordAudio("100011008", var_46_7)
						arg_43_1:RecordAudio("100011008", var_46_7)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_100011", "100011008", "story_v_out_100011.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_100011", "100011008", "story_v_out_100011.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play100011009 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 100011009
		arg_47_1.duration_ = 6.73

		local var_47_0 = {
			ja = 5.8,
			ko = 4.933,
			zh = 5.033,
			en = 6.733
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play100011010(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(100011009)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 21)

				if (21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 21)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_100011", "100011009", "story_v_out_100011.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_100011", "100011009", "story_v_out_100011.awb")

						arg_47_1:RecordAudio("100011009", var_50_6)
						arg_47_1:RecordAudio("100011009", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_100011", "100011009", "story_v_out_100011.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_100011", "100011009", "story_v_out_100011.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play100011010 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 100011010
		arg_51_1.duration_ = 11.43

		local var_51_0 = {
			ja = 11.4,
			ko = 9.4,
			zh = 7.933,
			en = 11.433
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play100011011(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.025

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(100011010)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 41 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 41)

				if (41 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 41)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_100011", "100011010", "story_v_out_100011.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_100011", "100011010", "story_v_out_100011.awb")

						arg_51_1:RecordAudio("100011010", var_54_6)
						arg_51_1:RecordAudio("100011010", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_100011", "100011010", "story_v_out_100011.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_100011", "100011010", "story_v_out_100011.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play100011011 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 100011011
		arg_55_1.duration_ = 10.43

		local var_55_0 = {
			ja = 10.433,
			ko = 7.233,
			zh = 6.833,
			en = 9.266
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play100011012(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.8

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(100011011)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 32 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 32)

				if (32 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 32)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_100011", "100011011", "story_v_out_100011.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_100011", "100011011", "story_v_out_100011.awb")

						arg_55_1:RecordAudio("100011011", var_58_6)
						arg_55_1:RecordAudio("100011011", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_100011", "100011011", "story_v_out_100011.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_100011", "100011011", "story_v_out_100011.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play100011012 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 100011012
		arg_59_1.duration_ = 15.07

		local var_59_0 = {
			ja = 15.066,
			ko = 9.6,
			zh = 8.766,
			en = 13.5
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
			arg_59_1.auto_ = false
		end

		function arg_59_1.playNext_(arg_61_0)
			arg_59_1.onStoryFinished_()
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.075

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(100011012)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 43)

				if (43 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 43)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_100011", "100011012", "story_v_out_100011.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_100011", "100011012", "story_v_out_100011.awb")

						arg_59_1:RecordAudio("100011012", var_62_6)
						arg_59_1:RecordAudio("100011012", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_100011", "100011012", "story_v_out_100011.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_100011", "100011012", "story_v_out_100011.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST28"
	},
	voices = {
		"story_v_out_100011.awb"
	}
}
