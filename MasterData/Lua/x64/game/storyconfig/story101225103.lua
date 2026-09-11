return {
	Play122513001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122513001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			ja = 4.50000000298023,
			ko = 4.133333333332,
			zh = 4.133333333332
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
				arg_1_0:Play122513002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			local var_4_3 = "1076ui_story"

			if arg_1_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1076ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1076ui_story = var_4_7.localPosition
			end

			local var_4_8 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_8 then
				var_4_7.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_1_1.time_ - 1.8) / var_4_8)
				var_4_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_7.position).x, (manager.ui.mainCamera.transform.position - var_4_7.position).y, (manager.ui.mainCamera.transform.position - var_4_7.position).z)
				var_4_7.localEulerAngles.z = 0
				var_4_7.localEulerAngles.x = 0
				var_4_7.localEulerAngles = var_4_7.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_8 and arg_1_1.time_ < 1.8 + var_4_8 + arg_4_0 then
				var_4_7.localPosition = Vector3.New(0, -1.06, -6.2)
				var_4_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_7.position).x, (manager.ui.mainCamera.transform.position - var_4_7.position).y, (manager.ui.mainCamera.transform.position - var_4_7.position).z)
				var_4_7.localEulerAngles.z = 0
				var_4_7.localEulerAngles.x = 0
				var_4_7.localEulerAngles = var_4_7.localEulerAngles
			end

			local var_4_9 = arg_1_1.actors_["1076ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1076ui_story == nil then
				arg_1_1.var_.characterEffect1076ui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffect1076ui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_10 and arg_1_1.time_ < 1.8 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1076ui_story then
				arg_1_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_12 = "J09f"

			if arg_1_1.bgs_.J09f == nil then
				local var_4_13 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_12)
				var_4_13.name = var_4_12
				var_4_13.transform.parent = arg_1_1.stage_.transform
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_12] = var_4_13
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.J09f

				arg_1_1.bgs_.J09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_17 = 2.00000000298023
			local var_4_18 = 0.175

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_20 = arg_1_1:GetWordFromCfg(122513001)
				local var_4_21 = arg_1_1:FormatText(var_4_20.content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 7 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 7)

				if (7 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 7)) > 0 and var_4_18 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_17 = var_4_17 + 0.3

					if var_4_23 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513001", "story_v_out_122513.awb") ~= 0 then
					local var_4_24 = manager.audio:GetVoiceLength("story_v_out_122513", "122513001", "story_v_out_122513.awb") / 1000

					if var_4_24 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_17
					end

					if var_4_20.prefab_name ~= "" and arg_1_1.actors_[var_4_20.prefab_name] ~= nil then
						local var_4_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_20.prefab_name].transform, "story_v_out_122513", "122513001", "story_v_out_122513.awb")

						arg_1_1:RecordAudio("122513001", var_4_25)
						arg_1_1:RecordAudio("122513001", var_4_25)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122513", "122513001", "story_v_out_122513.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122513", "122513001", "story_v_out_122513.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_17 + 0.3
			local var_4_27 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122513002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 122513002
		arg_7_1.duration_ = 10.07

		local var_7_0 = {
			ja = 10.066,
			ko = 4.566,
			zh = 4.566
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
				arg_7_0:Play122513003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "4037ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["4037ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["4037ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["4037ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["4037ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos4037ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_7_1.time_ - 0) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0, -1.12, -6.2)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			local var_10_5 = arg_7_1.actors_["4037ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect4037ui_story == nil then
				arg_7_1.var_.characterEffect4037ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect4037ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect4037ui_story then
				arg_7_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_8 = arg_7_1.actors_["1076ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1076ui_story = var_10_8.localPosition
			end

			local var_10_9 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_9 then
				var_10_8.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_9)
				var_10_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_8.position).x, (manager.ui.mainCamera.transform.position - var_10_8.position).y, (manager.ui.mainCamera.transform.position - var_10_8.position).z)
				var_10_8.localEulerAngles.z = 0
				var_10_8.localEulerAngles.x = 0
				var_10_8.localEulerAngles = var_10_8.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_9 and arg_7_1.time_ < 0 + var_10_9 + arg_10_0 then
				var_10_8.localPosition = Vector3.New(0, 100, 0)
				var_10_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_8.position).x, (manager.ui.mainCamera.transform.position - var_10_8.position).y, (manager.ui.mainCamera.transform.position - var_10_8.position).z)
				var_10_8.localEulerAngles.z = 0
				var_10_8.localEulerAngles.x = 0
				var_10_8.localEulerAngles = var_10_8.localEulerAngles
			end

			local var_10_10 = arg_7_1.actors_["1076ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1076ui_story == nil then
				arg_7_1.var_.characterEffect1076ui_story = var_10_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_11 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_11 and not isNil(var_10_10) then
				if arg_7_1.var_.characterEffect1076ui_story and not isNil(var_10_10) then
					arg_7_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_11)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_11 and arg_7_1.time_ < 0 + var_10_11 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1076ui_story then
				arg_7_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_10_12 = 0
			local var_10_13 = 0.475

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_12 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_14 = arg_7_1:GetWordFromCfg(122513002)
				local var_10_15 = arg_7_1:FormatText(var_10_14.content)

				arg_7_1.text_.text = var_10_15

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_17 = 19 <= 0 and var_10_13 or var_10_13 * (utf8.len(var_10_15) / 19)

				if (19 <= 0 and var_10_13 or var_10_13 * (utf8.len(var_10_15) / 19)) > 0 and var_10_13 < var_10_17 then
					arg_7_1.talkMaxDuration = var_10_17

					if var_10_17 + var_10_12 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_12
					end
				end

				arg_7_1.text_.text = var_10_15
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513002", "story_v_out_122513.awb") ~= 0 then
					local var_10_18 = manager.audio:GetVoiceLength("story_v_out_122513", "122513002", "story_v_out_122513.awb") / 1000

					if var_10_18 + var_10_12 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_18 + var_10_12
					end

					if var_10_14.prefab_name ~= "" and arg_7_1.actors_[var_10_14.prefab_name] ~= nil then
						local var_10_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_14.prefab_name].transform, "story_v_out_122513", "122513002", "story_v_out_122513.awb")

						arg_7_1:RecordAudio("122513002", var_10_19)
						arg_7_1:RecordAudio("122513002", var_10_19)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_122513", "122513002", "story_v_out_122513.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_122513", "122513002", "story_v_out_122513.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_20 = math.max(var_10_13, arg_7_1.talkMaxDuration)

			if var_10_12 <= arg_7_1.time_ and arg_7_1.time_ < var_10_12 + var_10_20 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_12) / var_10_20

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_12 + var_10_20 and arg_7_1.time_ < var_10_12 + var_10_20 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122513003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 122513003
		arg_11_1.duration_ = 9.97

		local var_11_0 = {
			ja = 9.966,
			ko = 5.4,
			zh = 5.4
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play122513004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_14_0 = 0
			local var_14_1 = 0.475

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(122513003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_5 = 19 <= 0 and var_14_1 or var_14_1 * (utf8.len(var_14_3) / 19)

				if (19 <= 0 and var_14_1 or var_14_1 * (utf8.len(var_14_3) / 19)) > 0 and var_14_1 < var_14_5 then
					arg_11_1.talkMaxDuration = var_14_5

					if var_14_5 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513003", "story_v_out_122513.awb") ~= 0 then
					local var_14_6 = manager.audio:GetVoiceLength("story_v_out_122513", "122513003", "story_v_out_122513.awb") / 1000

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end

					if var_14_2.prefab_name ~= "" and arg_11_1.actors_[var_14_2.prefab_name] ~= nil then
						local var_14_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_2.prefab_name].transform, "story_v_out_122513", "122513003", "story_v_out_122513.awb")

						arg_11_1:RecordAudio("122513003", var_14_7)
						arg_11_1:RecordAudio("122513003", var_14_7)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_122513", "122513003", "story_v_out_122513.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_122513", "122513003", "story_v_out_122513.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_8 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_8 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_8

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_8 and arg_11_1.time_ < var_14_0 + var_14_8 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play122513004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 122513004
		arg_15_1.duration_ = 3.17

		local var_15_0 = {
			ja = 3.166,
			ko = 2.133,
			zh = 2.133
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play122513005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1076ui_story = arg_15_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).z)
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles = arg_15_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_15_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1076ui_story"].transform.position).z)
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1076ui_story"].transform.localEulerAngles = arg_15_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["1076ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1076ui_story == nil then
				arg_15_1.var_.characterEffect1076ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect1076ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1076ui_story then
				arg_15_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_18_4 = arg_15_1.actors_["4037ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos4037ui_story = var_18_4.localPosition
			end

			local var_18_5 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_5 then
				var_18_4.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 0) / var_18_5)
				var_18_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_4.position).x, (manager.ui.mainCamera.transform.position - var_18_4.position).y, (manager.ui.mainCamera.transform.position - var_18_4.position).z)
				var_18_4.localEulerAngles.z = 0
				var_18_4.localEulerAngles.x = 0
				var_18_4.localEulerAngles = var_18_4.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_5 and arg_15_1.time_ < 0 + var_18_5 + arg_18_0 then
				var_18_4.localPosition = Vector3.New(0, 100, 0)
				var_18_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_4.position).x, (manager.ui.mainCamera.transform.position - var_18_4.position).y, (manager.ui.mainCamera.transform.position - var_18_4.position).z)
				var_18_4.localEulerAngles.z = 0
				var_18_4.localEulerAngles.x = 0
				var_18_4.localEulerAngles = var_18_4.localEulerAngles
			end

			local var_18_6 = arg_15_1.actors_["4037ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect4037ui_story == nil then
				arg_15_1.var_.characterEffect4037ui_story = var_18_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_7 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 and not isNil(var_18_6) then
				if arg_15_1.var_.characterEffect4037ui_story and not isNil(var_18_6) then
					arg_15_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_15_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_7)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect4037ui_story then
				arg_15_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_15_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_18_8 = 0
			local var_18_9 = 0.3

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(122513004)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 12 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 12)

				if (12 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 12)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513004", "story_v_out_122513.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513004", "story_v_out_122513.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_122513", "122513004", "story_v_out_122513.awb")

						arg_15_1:RecordAudio("122513004", var_18_15)
						arg_15_1:RecordAudio("122513004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_122513", "122513004", "story_v_out_122513.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_122513", "122513004", "story_v_out_122513.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_16 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_16 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_8) / var_18_16

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_16 and arg_15_1.time_ < var_18_8 + var_18_16 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122513005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122513005
		arg_19_1.duration_ = 2.7

		local var_19_0 = {
			ja = 2.266,
			ko = 2.7,
			zh = 2.7
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
				arg_19_0:Play122513006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos4037ui_story = arg_19_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).z)
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles = arg_19_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_19_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["4037ui_story"].transform.position).z)
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["4037ui_story"].transform.localEulerAngles = arg_19_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["4037ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect4037ui_story == nil then
				arg_19_1.var_.characterEffect4037ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect4037ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect4037ui_story then
				arg_19_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_2")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_22_4 = arg_19_1.actors_["1076ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1076ui_story = var_22_4.localPosition
			end

			local var_22_5 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_5 then
				var_22_4.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_5)
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

			local var_22_6 = arg_19_1.actors_["1076ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1076ui_story == nil then
				arg_19_1.var_.characterEffect1076ui_story = var_22_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_7 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 and not isNil(var_22_6) then
				if arg_19_1.var_.characterEffect1076ui_story and not isNil(var_22_6) then
					arg_19_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_7)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1076ui_story then
				arg_19_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_22_8 = 0
			local var_22_9 = 0.275

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(122513005)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 11 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 11)

				if (11 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 11)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513005", "story_v_out_122513.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513005", "story_v_out_122513.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_out_122513", "122513005", "story_v_out_122513.awb")

						arg_19_1:RecordAudio("122513005", var_22_15)
						arg_19_1:RecordAudio("122513005", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_122513", "122513005", "story_v_out_122513.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_122513", "122513005", "story_v_out_122513.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_16 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_16

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_16 and arg_19_1.time_ < var_22_8 + var_22_16 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122513006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122513006
		arg_23_1.duration_ = 10.87

		local var_23_0 = {
			ja = 10.866,
			ko = 7,
			zh = 7
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play122513007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.7

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(122513006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 28 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 28)

				if (28 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 28)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513006", "story_v_out_122513.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513006", "story_v_out_122513.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_122513", "122513006", "story_v_out_122513.awb")

						arg_23_1:RecordAudio("122513006", var_26_6)
						arg_23_1:RecordAudio("122513006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122513", "122513006", "story_v_out_122513.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122513", "122513006", "story_v_out_122513.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play122513007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122513007
		arg_27_1.duration_ = 13.93

		local var_27_0 = {
			ja = 13.933,
			ko = 5.666,
			zh = 5.666
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play122513008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.575

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:GetWordFromCfg(122513007)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 23 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 23)

				if (23 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 23)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513007", "story_v_out_122513.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513007", "story_v_out_122513.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_122513", "122513007", "story_v_out_122513.awb")

						arg_27_1:RecordAudio("122513007", var_30_6)
						arg_27_1:RecordAudio("122513007", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122513", "122513007", "story_v_out_122513.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122513", "122513007", "story_v_out_122513.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play122513008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122513008
		arg_31_1.duration_ = 5.57

		local var_31_0 = {
			ja = 5.333,
			ko = 5.566,
			zh = 5.566
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
				arg_31_0:Play122513009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1076ui_story = arg_31_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).z)
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles = arg_31_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_31_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1076ui_story"].transform.position).z)
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1076ui_story"].transform.localEulerAngles = arg_31_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1076ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1076ui_story == nil then
				arg_31_1.var_.characterEffect1076ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1076ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1076ui_story then
				arg_31_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_34_4 = arg_31_1.actors_["4037ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos4037ui_story = var_34_4.localPosition
			end

			local var_34_5 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 then
				var_34_4.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_5)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 then
				var_34_4.localPosition = Vector3.New(0, 100, 0)
				var_34_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_4.position).x, (manager.ui.mainCamera.transform.position - var_34_4.position).y, (manager.ui.mainCamera.transform.position - var_34_4.position).z)
				var_34_4.localEulerAngles.z = 0
				var_34_4.localEulerAngles.x = 0
				var_34_4.localEulerAngles = var_34_4.localEulerAngles
			end

			local var_34_6 = arg_31_1.actors_["4037ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect4037ui_story == nil then
				arg_31_1.var_.characterEffect4037ui_story = var_34_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_7 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 and not isNil(var_34_6) then
				if arg_31_1.var_.characterEffect4037ui_story and not isNil(var_34_6) then
					arg_31_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_31_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_7)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 and not isNil(var_34_6) and arg_31_1.var_.characterEffect4037ui_story then
				arg_31_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_31_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_34_8 = 0
			local var_34_9 = 0.25

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(122513008)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 10 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 10)

				if (10 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 10)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513008", "story_v_out_122513.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513008", "story_v_out_122513.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_122513", "122513008", "story_v_out_122513.awb")

						arg_31_1:RecordAudio("122513008", var_34_15)
						arg_31_1:RecordAudio("122513008", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_122513", "122513008", "story_v_out_122513.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_122513", "122513008", "story_v_out_122513.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122513009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122513009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play122513010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1076ui_story = arg_35_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).z)
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles = arg_35_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1076ui_story"].transform.position).z)
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1076ui_story"].transform.localEulerAngles = arg_35_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1076ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1076ui_story == nil then
				arg_35_1.var_.characterEffect1076ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1076ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_2)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1076ui_story then
				arg_35_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_38_3 = 0
			local var_38_4 = 1.1

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(122513009).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 44 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 44)

				if (44 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 44)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122513010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122513010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122513011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.2

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(122513010).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 48 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 48)

				if (48 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 48)) > 0 and var_42_0 < var_42_3 then
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
	Play122513011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122513011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play122513012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.675

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(122513011).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 27 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 27)

				if (27 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 27)) > 0 and var_46_0 < var_46_3 then
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
	Play122513012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122513012
		arg_47_1.duration_ = 7

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play122513013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_0 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				local var_50_1 = Color.New(1, 1, 1)

				var_50_1.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.mask_.color = var_50_1
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				local var_50_2 = Color.New(1, 1, 1)

				var_50_2.a = 1
				arg_47_1.mask_.color = var_50_2
			end

			local var_50_3 = 1.999999999999

			if 1.999999999999 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_4 = 1

			if var_50_3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_3 + var_50_4 then
				local var_50_5 = Color.New(1, 1, 1)

				var_50_5.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_3) / var_50_4)
				arg_47_1.mask_.color = var_50_5
			end

			if arg_47_1.time_ >= var_50_3 + var_50_4 and arg_47_1.time_ < var_50_3 + var_50_4 + arg_50_0 then
				local var_50_6 = Color.New(1, 1, 1)

				arg_47_1.mask_.enabled = false
				var_50_6.a = 0
				arg_47_1.mask_.color = var_50_6
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_7 = 1.999999999999
			local var_50_8 = 1.5

			if 1.999999999999 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_9 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_9:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(122513012).content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_12 = 60 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 60)

				if (60 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_10) / 60)) > 0 and var_50_8 < var_50_12 then
					arg_47_1.talkMaxDuration = var_50_12
					var_50_7 = var_50_7 + 0.3

					if var_50_12 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_12 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = var_50_7 + 0.3
			local var_50_14 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_13 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_13) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_13 + var_50_14 and arg_47_1.time_ < var_50_13 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play122513013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122513013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122513014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.675

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(122513013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)

				if (27 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 27)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122513014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122513014
		arg_57_1.duration_ = 12.6

		local var_57_0 = {
			ja = 12.6,
			ko = 4.5,
			zh = 4.5
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122513015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos4037ui_story = arg_57_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).z)
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles = arg_57_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_57_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["4037ui_story"].transform.position).z)
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["4037ui_story"].transform.localEulerAngles = arg_57_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["4037ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect4037ui_story == nil then
				arg_57_1.var_.characterEffect4037ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect4037ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect4037ui_story then
				arg_57_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(122513014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 20 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 20)

				if (20 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 20)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513014", "story_v_out_122513.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_122513", "122513014", "story_v_out_122513.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_122513", "122513014", "story_v_out_122513.awb")

						arg_57_1:RecordAudio("122513014", var_60_11)
						arg_57_1:RecordAudio("122513014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122513", "122513014", "story_v_out_122513.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122513", "122513014", "story_v_out_122513.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122513015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122513015
		arg_61_1.duration_ = 6.77

		local var_61_0 = {
			ja = 6.766,
			ko = 2.333,
			zh = 2.333
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122513016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1076ui_story = arg_61_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).z)
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles = arg_61_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_61_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1076ui_story"].transform.position).z)
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1076ui_story"].transform.localEulerAngles = arg_61_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1076ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1076ui_story == nil then
				arg_61_1.var_.characterEffect1076ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1076ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1076ui_story then
				arg_61_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_2")
			end

			local var_64_4 = arg_61_1.actors_["4037ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos4037ui_story = var_64_4.localPosition
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_4.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_5)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_4.localPosition = Vector3.New(0, 100, 0)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			local var_64_6 = arg_61_1.actors_["4037ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect4037ui_story == nil then
				arg_61_1.var_.characterEffect4037ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect4037ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_61_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect4037ui_story then
				arg_61_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_61_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_64_8 = 0
			local var_64_9 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(122513015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 13 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 13)

				if (13 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 13)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513015", "story_v_out_122513.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513015", "story_v_out_122513.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_122513", "122513015", "story_v_out_122513.awb")

						arg_61_1:RecordAudio("122513015", var_64_15)
						arg_61_1:RecordAudio("122513015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122513", "122513015", "story_v_out_122513.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122513", "122513015", "story_v_out_122513.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play122513016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122513016
		arg_65_1.duration_ = 5.4

		local var_65_0 = {
			ja = 5.4,
			ko = 2.433,
			zh = 2.433
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122513017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos4037ui_story = arg_65_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).z)
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles = arg_65_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_65_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4037ui_story"].transform.position).z)
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4037ui_story"].transform.localEulerAngles = arg_65_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["4037ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4037ui_story == nil then
				arg_65_1.var_.characterEffect4037ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect4037ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4037ui_story then
				arg_65_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037actionlink/4037action432")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = arg_65_1.actors_["1076ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1076ui_story = var_68_4.localPosition
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_5)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(0, 100, 0)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			local var_68_6 = arg_65_1.actors_["1076ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story == nil then
				arg_65_1.var_.characterEffect1076ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect1076ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1076ui_story then
				arg_65_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_68_8 = 0
			local var_68_9 = 0.275

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(122513016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 11 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 11)

				if (11 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 11)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513016", "story_v_out_122513.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513016", "story_v_out_122513.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_122513", "122513016", "story_v_out_122513.awb")

						arg_65_1:RecordAudio("122513016", var_68_15)
						arg_65_1:RecordAudio("122513016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122513", "122513016", "story_v_out_122513.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122513", "122513016", "story_v_out_122513.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play122513017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122513017
		arg_69_1.duration_ = 6.13

		local var_69_0 = {
			ja = 6.133,
			ko = 5.533,
			zh = 5.533
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122513018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1076ui_story = arg_69_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).z)
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles = arg_69_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_69_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1076ui_story"].transform.position).z)
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1076ui_story"].transform.localEulerAngles = arg_69_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1076ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1076ui_story == nil then
				arg_69_1.var_.characterEffect1076ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1076ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1076ui_story then
				arg_69_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["4037ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos4037ui_story = var_72_4.localPosition
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_5)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0, 100, 0)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			local var_72_6 = arg_69_1.actors_["4037ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect4037ui_story == nil then
				arg_69_1.var_.characterEffect4037ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_7 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 and not isNil(var_72_6) then
				if arg_69_1.var_.characterEffect4037ui_story and not isNil(var_72_6) then
					arg_69_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_69_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_7)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect4037ui_story then
				arg_69_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_69_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_72_8 = 0
			local var_72_9 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(122513017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 16 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 16)

				if (16 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 16)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513017", "story_v_out_122513.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_122513", "122513017", "story_v_out_122513.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_122513", "122513017", "story_v_out_122513.awb")

						arg_69_1:RecordAudio("122513017", var_72_15)
						arg_69_1:RecordAudio("122513017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122513", "122513017", "story_v_out_122513.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122513", "122513017", "story_v_out_122513.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play122513018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122513018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play122513019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1076ui_story = arg_73_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).z)
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles = arg_73_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1076ui_story"].transform.position).z)
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1076ui_story"].transform.localEulerAngles = arg_73_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1076ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1076ui_story == nil then
				arg_73_1.var_.characterEffect1076ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1076ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1076ui_story then
				arg_73_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_76_3 = manager.ui.mainCamera.transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.shakeOldPos = var_76_3.localPosition
			end

			local var_76_4 = 0.6

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				local var_76_5, var_76_6 = math.modf((arg_73_1.time_ - 0) / 0.066)

				var_76_3.localPosition = Vector3.New(var_76_6 * 0.13, var_76_6 * 0.13, var_76_6 * 0.13) + arg_73_1.var_.shakeOldPos
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = arg_73_1.var_.shakeOldPos
			end

			local var_76_7 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_7 + 0.6 and arg_73_1.time_ < var_76_7 + 0.6 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_stonecrushing", "")
			end

			local var_76_9 = 0
			local var_76_10 = 1.425

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_11 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(122513018).content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 57 <= 0 and var_76_10 or var_76_10 * (utf8.len(var_76_11) / 57)

				if (57 <= 0 and var_76_10 or var_76_10 * (utf8.len(var_76_11) / 57)) > 0 and var_76_10 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_9 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_9
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_10, arg_73_1.talkMaxDuration)

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_9) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_9 + var_76_14 and arg_73_1.time_ < var_76_9 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play122513019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122513019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play122513020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(122513019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)

				if (41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122513020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122513020
		arg_81_1.duration_ = 3

		local var_81_0 = {
			ja = 3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play122513021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1076ui_story = arg_81_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).z)
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles = arg_81_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_81_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1076ui_story"].transform.position).z)
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1076ui_story"].transform.localEulerAngles = arg_81_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1076ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1076ui_story == nil then
				arg_81_1.var_.characterEffect1076ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1076ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1076ui_story then
				arg_81_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.125

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(122513020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 5 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 5)

				if (5 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 5)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513020", "story_v_out_122513.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_122513", "122513020", "story_v_out_122513.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_122513", "122513020", "story_v_out_122513.awb")

						arg_81_1:RecordAudio("122513020", var_84_11)
						arg_81_1:RecordAudio("122513020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122513", "122513020", "story_v_out_122513.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122513", "122513020", "story_v_out_122513.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
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
	Play122513021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122513021
		arg_85_1.duration_ = 7

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play122513022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.bgs_.XH0604 == nil then
				local var_88_0 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0604")
				var_88_0.name = "XH0604"
				var_88_0.transform.parent = arg_85_1.stage_.transform
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_.XH0604 = var_88_0
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_1 = arg_85_1.bgs_.XH0604

				arg_85_1.bgs_.XH0604.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_2 = var_88_1:GetComponent("SpriteRenderer")

				if var_88_2 and var_88_2.sprite then
					local var_88_3 = 2 * (var_88_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_1.transform.localScale = Vector3.New(var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "XH0604" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_4 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_5 = 0.5

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_5 then
				local var_88_6 = Color.New(1, 1, 1)

				var_88_6.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_4) / var_88_5)
				arg_85_1.mask_.color = var_88_6
			end

			if arg_85_1.time_ >= var_88_4 + var_88_5 and arg_85_1.time_ < var_88_4 + var_88_5 + arg_88_0 then
				local var_88_7 = Color.New(1, 1, 1)

				arg_85_1.mask_.enabled = false
				var_88_7.a = 0
				arg_85_1.mask_.color = var_88_7
			end

			local var_88_8 = arg_85_1.actors_["1076ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1076ui_story = var_88_8.localPosition
			end

			local var_88_9 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_9 then
				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_9)
				var_88_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_8.position).x, (manager.ui.mainCamera.transform.position - var_88_8.position).y, (manager.ui.mainCamera.transform.position - var_88_8.position).z)
				var_88_8.localEulerAngles.z = 0
				var_88_8.localEulerAngles.x = 0
				var_88_8.localEulerAngles = var_88_8.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_9 and arg_85_1.time_ < 0 + var_88_9 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(0, 100, 0)
				var_88_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_8.position).x, (manager.ui.mainCamera.transform.position - var_88_8.position).y, (manager.ui.mainCamera.transform.position - var_88_8.position).z)
				var_88_8.localEulerAngles.z = 0
				var_88_8.localEulerAngles.x = 0
				var_88_8.localEulerAngles = var_88_8.localEulerAngles
			end

			local var_88_10 = arg_85_1.actors_["1076ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_10) and arg_85_1.var_.characterEffect1076ui_story == nil then
				arg_85_1.var_.characterEffect1076ui_story = var_88_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_11 and not isNil(var_88_10) then
				if arg_85_1.var_.characterEffect1076ui_story and not isNil(var_88_10) then
					arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_11)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_11 and arg_85_1.time_ < 0 + var_88_11 + arg_88_0 and not isNil(var_88_10) and arg_85_1.var_.characterEffect1076ui_story then
				arg_85_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_88_12 = manager.ui.mainCamera.transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_12.localPosition
			end

			local var_88_13 = 1

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_13 then
				local var_88_14, var_88_15 = math.modf((arg_85_1.time_ - 0) / 0.066)

				var_88_12.localPosition = Vector3.New(var_88_15 * 0.13, var_88_15 * 0.13, var_88_15 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= 0 + var_88_13 and arg_85_1.time_ < 0 + var_88_13 + arg_88_0 then
				var_88_12.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_16 = arg_85_1.bgs_.XH0604.transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPosXH0604 = var_88_16.localPosition
			end

			local var_88_17 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_17 then
				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPosXH0604, Vector3.New(0, 2, -1), (arg_85_1.time_ - 0) / var_88_17)
			end

			if arg_85_1.time_ >= 0 + var_88_17 and arg_85_1.time_ < 0 + var_88_17 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(0, 2, -1)
			end

			local var_88_18 = arg_85_1.bgs_.XH0604.transform

			if 0.0166666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 0.0166666666666667 + arg_88_0 then
				arg_85_1.var_.moveOldPosXH0604 = var_88_18.localPosition
			end

			local var_88_19 = 1.1

			if 0.0166666666666667 <= arg_85_1.time_ and arg_85_1.time_ < 0.0166666666666667 + var_88_19 then
				var_88_18.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPosXH0604, Vector3.New(0, 0, 7), (arg_85_1.time_ - 0.0166666666666667) / var_88_19)
			end

			if arg_85_1.time_ >= 0.0166666666666667 + var_88_19 and arg_85_1.time_ < 0.0166666666666667 + var_88_19 + arg_88_0 then
				var_88_18.localPosition = Vector3.New(0, 0, 7)
			end

			local var_88_20 = arg_85_1.bgs_.XH0604.transform

			if 0.8 < arg_85_1.time_ and arg_85_1.time_ <= 0.8 + arg_88_0 then
				arg_85_1.var_.moveOldPosXH0604 = var_88_20.localPosition
			end

			local var_88_21 = 4

			if 0.8 <= arg_85_1.time_ and arg_85_1.time_ < 0.8 + var_88_21 then
				var_88_20.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPosXH0604, Vector3.New(0, 1, 7.5), (arg_85_1.time_ - 0.8) / var_88_21)
			end

			if arg_85_1.time_ >= 0.8 + var_88_21 and arg_85_1.time_ < 0.8 + var_88_21 + arg_88_0 then
				var_88_20.localPosition = Vector3.New(0, 1, 7.5)
			end

			local var_88_22 = 0.5

			if 0.5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_22 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_22 + 4.3 and arg_85_1.time_ < var_88_22 + 4.3 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_23 = 1.999999999999
			local var_88_24 = 1.3

			if 1.999999999999 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_25 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_25:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(122513021).content)

				arg_85_1.text_.text = var_88_26

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 52 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 52)

				if (52 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 52)) > 0 and var_88_24 < var_88_28 then
					arg_85_1.talkMaxDuration = var_88_28
					var_88_23 = var_88_23 + 0.3

					if var_88_28 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_26
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_29 = var_88_23 + 0.3
			local var_88_30 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_29 + var_88_30 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_29) / var_88_30

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_29 + var_88_30 and arg_85_1.time_ < var_88_29 + var_88_30 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.1,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play122513022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122513022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122513023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.15

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(122513022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 46 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 46)

				if (46 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 46)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play122513023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122513023
		arg_95_1.duration_ = 3.6

		local var_95_0 = {
			ja = 3.333,
			ko = 3.6,
			zh = 3.6
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122513024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.35

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4037")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(122513023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 14 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 14)

				if (14 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 14)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513023", "story_v_out_122513.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513023", "story_v_out_122513.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_122513", "122513023", "story_v_out_122513.awb")

						arg_95_1:RecordAudio("122513023", var_98_6)
						arg_95_1:RecordAudio("122513023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_122513", "122513023", "story_v_out_122513.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_122513", "122513023", "story_v_out_122513.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122513024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122513024
		arg_99_1.duration_ = 1.57

		local var_99_0 = {
			ja = 1.1,
			ko = 1.566,
			zh = 1.566
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play122513025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.125

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(122513024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 5 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 5)

				if (5 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 5)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513024", "story_v_out_122513.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513024", "story_v_out_122513.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_122513", "122513024", "story_v_out_122513.awb")

						arg_99_1:RecordAudio("122513024", var_102_6)
						arg_99_1:RecordAudio("122513024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_122513", "122513024", "story_v_out_122513.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_122513", "122513024", "story_v_out_122513.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play122513025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122513025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122513026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(122513025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 65 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 65)

				if (65 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 65)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play122513026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122513026
		arg_107_1.duration_ = 1.03

		local var_107_0 = {
			ja = 1.033,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play122513027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_110_0 = 0.6

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				local var_110_1, var_110_2 = math.modf((arg_107_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_110_2 * 0.13, var_110_2 * 0.13, var_110_2 * 0.13) + arg_107_1.var_.shakeOldPos
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				manager.ui.mainCamera.transform.localPosition = arg_107_1.var_.shakeOldPos
			end

			local var_110_3 = 0

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.allBtn_.enabled = false
			end

			if arg_107_1.time_ >= var_110_3 + 0.6 and arg_107_1.time_ < var_110_3 + 0.6 + arg_110_0 then
				arg_107_1.allBtn_.enabled = true
			end

			local var_110_4 = 0
			local var_110_5 = 0.1

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4037")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_6 = arg_107_1:GetWordFromCfg(122513026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)

				if (4 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 4)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513026", "story_v_out_122513.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_122513", "122513026", "story_v_out_122513.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_122513", "122513026", "story_v_out_122513.awb")

						arg_107_1:RecordAudio("122513026", var_110_11)
						arg_107_1:RecordAudio("122513026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_122513", "122513026", "story_v_out_122513.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_122513", "122513026", "story_v_out_122513.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play122513027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122513027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122513028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.25

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(122513027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 50 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 50)

				if (50 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 50)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122513028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122513028
		arg_115_1.duration_ = 10.03

		local var_115_0 = {
			ja = 8.866,
			ko = 10.033,
			zh = 10.033
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play122513029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.675

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4037")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(122513028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 27 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 27)

				if (27 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 27)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513028", "story_v_out_122513.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513028", "story_v_out_122513.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_122513", "122513028", "story_v_out_122513.awb")

						arg_115_1:RecordAudio("122513028", var_118_6)
						arg_115_1:RecordAudio("122513028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122513", "122513028", "story_v_out_122513.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122513", "122513028", "story_v_out_122513.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play122513029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122513029
		arg_119_1.duration_ = 14.3

		local var_119_0 = {
			ja = 14.3,
			ko = 4.966,
			zh = 4.966
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play122513030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4037")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:GetWordFromCfg(122513029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 19 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 19)

				if (19 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 19)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513029", "story_v_out_122513.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513029", "story_v_out_122513.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_122513", "122513029", "story_v_out_122513.awb")

						arg_119_1:RecordAudio("122513029", var_122_6)
						arg_119_1:RecordAudio("122513029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122513", "122513029", "story_v_out_122513.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122513", "122513029", "story_v_out_122513.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play122513030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122513030
		arg_123_1.duration_ = 15.7

		local var_123_0 = {
			ja = 15.7,
			ko = 4.4,
			zh = 4.4
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122513031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.4

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(122513030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 16 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 16)

				if (16 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 16)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513030", "story_v_out_122513.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513030", "story_v_out_122513.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_122513", "122513030", "story_v_out_122513.awb")

						arg_123_1:RecordAudio("122513030", var_126_6)
						arg_123_1:RecordAudio("122513030", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_122513", "122513030", "story_v_out_122513.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_122513", "122513030", "story_v_out_122513.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play122513031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122513031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122513032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPosXH0604 = arg_127_1.bgs_.XH0604.transform.localPosition
			end

			local var_130_0 = 4

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.bgs_.XH0604.transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPosXH0604, Vector3.New(0, 1, 8), (arg_127_1.time_ - 0) / var_130_0)
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.bgs_.XH0604.transform.localPosition = Vector3.New(0, 1, 8)
			end

			local var_130_1 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_1 + 4 and arg_127_1.time_ < var_130_1 + 4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_2 = 0
			local var_130_3 = 0.875

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(122513031).content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 35 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 35)

				if (35 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 35)) > 0 and var_130_3 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_7 and arg_127_1.time_ < var_130_2 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0604",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play122513032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122513032
		arg_131_1.duration_ = 5.33

		local var_131_0 = {
			ja = 5,
			ko = 5.333,
			zh = 5.333
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
			arg_131_1.auto_ = false
		end

		function arg_131_1.playNext_(arg_133_0)
			arg_131_1.onStoryFinished_()
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.425

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(122513032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)

				if (17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122513", "122513032", "story_v_out_122513.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_122513", "122513032", "story_v_out_122513.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_122513", "122513032", "story_v_out_122513.awb")

						arg_131_1:RecordAudio("122513032", var_134_6)
						arg_131_1:RecordAudio("122513032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_122513", "122513032", "story_v_out_122513.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_122513", "122513032", "story_v_out_122513.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J09f",
		"TextureConfig/Background/XH0604"
	},
	voices = {
		"story_v_out_122513.awb"
	}
}
