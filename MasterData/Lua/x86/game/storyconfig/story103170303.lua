return {
	Play317033001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317033001
		arg_1_1.duration_ = 8.53

		local var_1_0 = {
			zh = 8.533,
			ja = 7
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
				arg_1_0:Play317033002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K10f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K10f")
				var_4_0.name = "K10f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K10f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K10f

				arg_1_1.bgs_.K10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K10f" then
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

			local var_4_8 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 0.3 and arg_1_1.time_ < var_4_8 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_9 = "2079ui_story"

			if arg_1_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["2079ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos2079ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_1_1.time_ - 2) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.28, -5.6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["2079ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2079ui_story == nil then
				arg_1_1.var_.characterEffect2079ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect2079ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect2079ui_story then
				arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 2
			local var_4_19 = 0.0329999998211861

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:GetWordFromCfg(317033001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 35 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 35)

				if (35 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 35)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033001", "story_v_out_317033.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_317033", "317033001", "story_v_out_317033.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_317033", "317033001", "story_v_out_317033.awb")

						arg_1_1:RecordAudio("317033001", var_4_26)
						arg_1_1:RecordAudio("317033001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317033", "317033001", "story_v_out_317033.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317033", "317033001", "story_v_out_317033.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play317033002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 317033002
		arg_7_1.duration_ = 2.87

		local var_7_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_7_0:Play317033003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos2079ui_story = arg_7_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_10_0 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 then
				arg_7_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_0)
				arg_7_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).z)
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles = arg_7_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 then
				arg_7_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_7_1.actors_["2079ui_story"].transform.position).z)
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_7_1.actors_["2079ui_story"].transform.localEulerAngles = arg_7_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_10_1 = arg_7_1.actors_["2079ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect2079ui_story == nil then
				arg_7_1.var_.characterEffect2079ui_story = var_10_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_2 and not isNil(var_10_1) then
				if arg_7_1.var_.characterEffect2079ui_story and not isNil(var_10_1) then
					arg_7_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_7_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_2)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_2 and arg_7_1.time_ < 0 + var_10_2 + arg_10_0 and not isNil(var_10_1) and arg_7_1.var_.characterEffect2079ui_story then
				arg_7_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_7_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_10_3 = "1015ui_story"

			if arg_7_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_10_4 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_7_1.stage_.transform)

				var_10_4.name = var_10_3
				var_10_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_3] = var_10_4

				local var_10_5 = var_10_4:GetComponentInChildren(typeof(CharacterEffect))

				var_10_5.enabled = true

				local var_10_6 = GameObjectTools.GetOrAddComponent(var_10_4, typeof(DynamicBoneHelper))

				if var_10_6 then
					var_10_6:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_5.transform, false)

				arg_7_1.var_[var_10_3 .. "Animator"] = var_10_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_3 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_3 .. "LipSync"] = var_10_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_7 = arg_7_1.actors_["1015ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1015ui_story = var_10_7.localPosition
			end

			local var_10_8 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_8 then
				var_10_7.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_7_1.time_ - 0) / var_10_8)
				var_10_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_7.position).x, (manager.ui.mainCamera.transform.position - var_10_7.position).y, (manager.ui.mainCamera.transform.position - var_10_7.position).z)
				var_10_7.localEulerAngles.z = 0
				var_10_7.localEulerAngles.x = 0
				var_10_7.localEulerAngles = var_10_7.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_8 and arg_7_1.time_ < 0 + var_10_8 + arg_10_0 then
				var_10_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_10_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_7.position).x, (manager.ui.mainCamera.transform.position - var_10_7.position).y, (manager.ui.mainCamera.transform.position - var_10_7.position).z)
				var_10_7.localEulerAngles.z = 0
				var_10_7.localEulerAngles.x = 0
				var_10_7.localEulerAngles = var_10_7.localEulerAngles
			end

			local var_10_9 = arg_7_1.actors_["1015ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_9) and arg_7_1.var_.characterEffect1015ui_story == nil then
				arg_7_1.var_.characterEffect1015ui_story = var_10_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_10 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_10 and not isNil(var_10_9) then
				if arg_7_1.var_.characterEffect1015ui_story and not isNil(var_10_9) then
					arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_10 and arg_7_1.time_ < 0 + var_10_10 + arg_10_0 and not isNil(var_10_9) and arg_7_1.var_.characterEffect1015ui_story then
				arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_12 = 0
			local var_10_13 = 0.0329999998211861

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_12 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_14 = arg_7_1:GetWordFromCfg(317033002)
				local var_10_15 = arg_7_1:FormatText(var_10_14.content)

				arg_7_1.text_.text = var_10_15

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_17 = 3 <= 0 and var_10_13 or var_10_13 * (utf8.len(var_10_15) / 3)

				if (3 <= 0 and var_10_13 or var_10_13 * (utf8.len(var_10_15) / 3)) > 0 and var_10_13 < var_10_17 then
					arg_7_1.talkMaxDuration = var_10_17

					if var_10_17 + var_10_12 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_12
					end
				end

				arg_7_1.text_.text = var_10_15
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033002", "story_v_out_317033.awb") ~= 0 then
					local var_10_18 = manager.audio:GetVoiceLength("story_v_out_317033", "317033002", "story_v_out_317033.awb") / 1000

					if var_10_18 + var_10_12 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_18 + var_10_12
					end

					if var_10_14.prefab_name ~= "" and arg_7_1.actors_[var_10_14.prefab_name] ~= nil then
						local var_10_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_14.prefab_name].transform, "story_v_out_317033", "317033002", "story_v_out_317033.awb")

						arg_7_1:RecordAudio("317033002", var_10_19)
						arg_7_1:RecordAudio("317033002", var_10_19)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_317033", "317033002", "story_v_out_317033.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_317033", "317033002", "story_v_out_317033.awb")
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317033003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 317033003
		arg_11_1.duration_ = 5.63

		local var_11_0 = {
			zh = 3.333,
			ja = 5.633
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
				arg_11_0:Play317033004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1015ui_story = arg_11_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).z)
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles = arg_11_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).z)
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles = arg_11_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1015ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1015ui_story == nil then
				arg_11_1.var_.characterEffect1015ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_2 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 and not isNil(var_14_1) then
				if arg_11_1.var_.characterEffect1015ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_2)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1015ui_story then
				arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_14_3 = arg_11_1.actors_["2079ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos2079ui_story = var_14_3.localPosition
			end

			local var_14_4 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				var_14_3.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_11_1.time_ - 0) / var_14_4)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				var_14_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_14_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_3.position).x, (manager.ui.mainCamera.transform.position - var_14_3.position).y, (manager.ui.mainCamera.transform.position - var_14_3.position).z)
				var_14_3.localEulerAngles.z = 0
				var_14_3.localEulerAngles.x = 0
				var_14_3.localEulerAngles = var_14_3.localEulerAngles
			end

			local var_14_5 = arg_11_1.actors_["2079ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect2079ui_story == nil then
				arg_11_1.var_.characterEffect2079ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect2079ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect2079ui_story then
				arg_11_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_14_8 = 0
			local var_14_9 = 0.0329999998211861

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:GetWordFromCfg(317033003)
				local var_14_11 = arg_11_1:FormatText(var_14_10.content)

				arg_11_1.text_.text = var_14_11

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_13 = 17 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 17)

				if (17 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 17)) > 0 and var_14_9 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_8
					end
				end

				arg_11_1.text_.text = var_14_11
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033003", "story_v_out_317033.awb") ~= 0 then
					local var_14_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033003", "story_v_out_317033.awb") / 1000

					if var_14_14 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_14 + var_14_8
					end

					if var_14_10.prefab_name ~= "" and arg_11_1.actors_[var_14_10.prefab_name] ~= nil then
						local var_14_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_10.prefab_name].transform, "story_v_out_317033", "317033003", "story_v_out_317033.awb")

						arg_11_1:RecordAudio("317033003", var_14_15)
						arg_11_1:RecordAudio("317033003", var_14_15)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_317033", "317033003", "story_v_out_317033.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_317033", "317033003", "story_v_out_317033.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_16 = math.max(var_14_9, arg_11_1.talkMaxDuration)

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_16 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_8) / var_14_16

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_8 + var_14_16 and arg_11_1.time_ < var_14_8 + var_14_16 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 317033004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play317033005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) and arg_15_1.var_.characterEffect2079ui_story == nil then
				arg_15_1.var_.characterEffect2079ui_story = arg_15_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) then
				if arg_15_1.var_.characterEffect2079ui_story and not isNil(arg_15_1.actors_["2079ui_story"]) then
					arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_15_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["2079ui_story"]) and arg_15_1.var_.characterEffect2079ui_story then
				arg_15_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_15_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 0.0329999998211861

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(317033004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 19 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 19)

				if (19 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 19)) > 0 and var_18_2 < var_18_5 then
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
	Play317033005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 317033005
		arg_19_1.duration_ = 2.03

		local var_19_0 = {
			zh = 1.233,
			ja = 2.033
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
				arg_19_0:Play317033006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos2079ui_story = arg_19_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).z)
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles = arg_19_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["2079ui_story"].transform.position).z)
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["2079ui_story"].transform.localEulerAngles = arg_19_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["2079ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect2079ui_story == nil then
				arg_19_1.var_.characterEffect2079ui_story = var_22_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 and not isNil(var_22_1) then
				if arg_19_1.var_.characterEffect2079ui_story and not isNil(var_22_1) then
					arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_19_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_2)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 and not isNil(var_22_1) and arg_19_1.var_.characterEffect2079ui_story then
				arg_19_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_19_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_22_3 = arg_19_1.actors_["1015ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1015ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1015ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1015ui_story == nil then
				arg_19_1.var_.characterEffect1015ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1015ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1015ui_story then
				arg_19_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_22_8 = 0
			local var_22_9 = 0.0329999998211861

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(317033005)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 5 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 5)

				if (5 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 5)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033005", "story_v_out_317033.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033005", "story_v_out_317033.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_out_317033", "317033005", "story_v_out_317033.awb")

						arg_19_1:RecordAudio("317033005", var_22_15)
						arg_19_1:RecordAudio("317033005", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_317033", "317033005", "story_v_out_317033.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_317033", "317033005", "story_v_out_317033.awb")
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
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317033006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 317033006
		arg_23_1.duration_ = 2.73

		local var_23_0 = {
			zh = 2.1,
			ja = 2.733
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
				arg_23_0:Play317033007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1015ui_story = arg_23_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).z)
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles = arg_23_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).z)
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles = arg_23_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1015ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1015ui_story == nil then
				arg_23_1.var_.characterEffect1015ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1015ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1015ui_story then
				arg_23_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_26_3 = arg_23_1.actors_["2079ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos2079ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["2079ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect2079ui_story == nil then
				arg_23_1.var_.characterEffect2079ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect2079ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect2079ui_story then
				arg_23_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_26_8 = 0
			local var_26_9 = 0.0329999998211861

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(317033006)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 9 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 9)

				if (9 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 9)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033006", "story_v_out_317033.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033006", "story_v_out_317033.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_317033", "317033006", "story_v_out_317033.awb")

						arg_23_1:RecordAudio("317033006", var_26_15)
						arg_23_1:RecordAudio("317033006", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317033", "317033006", "story_v_out_317033.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317033", "317033006", "story_v_out_317033.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 317033007
		arg_27_1.duration_ = 1.6

		local var_27_0 = {
			zh = 1.1,
			ja = 1.6
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
				arg_27_0:Play317033008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1015ui_story = arg_27_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).z)
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles = arg_27_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_27_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1015ui_story"].transform.position).z)
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1015ui_story"].transform.localEulerAngles = arg_27_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1015ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1015ui_story == nil then
				arg_27_1.var_.characterEffect1015ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1015ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1015ui_story then
				arg_27_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_4 = arg_27_1.actors_["2079ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos2079ui_story = var_30_4.localPosition
			end

			local var_30_5 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				var_30_4.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_5)
				var_30_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_4.position).x, (manager.ui.mainCamera.transform.position - var_30_4.position).y, (manager.ui.mainCamera.transform.position - var_30_4.position).z)
				var_30_4.localEulerAngles.z = 0
				var_30_4.localEulerAngles.x = 0
				var_30_4.localEulerAngles = var_30_4.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				var_30_4.localPosition = Vector3.New(0, 100, 0)
				var_30_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_4.position).x, (manager.ui.mainCamera.transform.position - var_30_4.position).y, (manager.ui.mainCamera.transform.position - var_30_4.position).z)
				var_30_4.localEulerAngles.z = 0
				var_30_4.localEulerAngles.x = 0
				var_30_4.localEulerAngles = var_30_4.localEulerAngles
			end

			local var_30_6 = arg_27_1.actors_["2079ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect2079ui_story == nil then
				arg_27_1.var_.characterEffect2079ui_story = var_30_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_7 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 and not isNil(var_30_6) then
				if arg_27_1.var_.characterEffect2079ui_story and not isNil(var_30_6) then
					arg_27_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_27_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_7)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 and not isNil(var_30_6) and arg_27_1.var_.characterEffect2079ui_story then
				arg_27_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_27_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_30_8 = 0
			local var_30_9 = 0.0329999998211861

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:GetWordFromCfg(317033007)
				local var_30_11 = arg_27_1:FormatText(var_30_10.content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 5 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 5)

				if (5 <= 0 and var_30_9 or var_30_9 * (utf8.len(var_30_11) / 5)) > 0 and var_30_9 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033007", "story_v_out_317033.awb") ~= 0 then
					local var_30_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033007", "story_v_out_317033.awb") / 1000

					if var_30_14 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_14 + var_30_8
					end

					if var_30_10.prefab_name ~= "" and arg_27_1.actors_[var_30_10.prefab_name] ~= nil then
						local var_30_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_10.prefab_name].transform, "story_v_out_317033", "317033007", "story_v_out_317033.awb")

						arg_27_1:RecordAudio("317033007", var_30_15)
						arg_27_1:RecordAudio("317033007", var_30_15)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_317033", "317033007", "story_v_out_317033.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_317033", "317033007", "story_v_out_317033.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317033008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play317033009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1015ui_story = arg_31_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_34_1 = 0
			local var_34_2 = 0.0329999998211861

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

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(317033008).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 35 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 35)

				if (35 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 35)) > 0 and var_34_2 < var_34_5 then
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
				actorName = "1015ui_story",
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
	Play317033009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 317033009
		arg_35_1.duration_ = 7.4

		local var_35_0 = {
			zh = 7.4,
			ja = 7.3
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play317033010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1015ui_story = arg_35_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).z)
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles = arg_35_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_35_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).z)
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles = arg_35_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1015ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1015ui_story == nil then
				arg_35_1.var_.characterEffect1015ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1015ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1015ui_story then
				arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.0329999998211861

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(317033009)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 33 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 33)

				if (33 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 33)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033009", "story_v_out_317033.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_317033", "317033009", "story_v_out_317033.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_317033", "317033009", "story_v_out_317033.awb")

						arg_35_1:RecordAudio("317033009", var_38_11)
						arg_35_1:RecordAudio("317033009", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_317033", "317033009", "story_v_out_317033.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_317033", "317033009", "story_v_out_317033.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317033010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 317033010
		arg_39_1.duration_ = 2.2

		local var_39_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play317033011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1015ui_story = arg_39_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).z)
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles = arg_39_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1015ui_story"].transform.position).z)
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1015ui_story"].transform.localEulerAngles = arg_39_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1015ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1015ui_story == nil then
				arg_39_1.var_.characterEffect1015ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1015ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_2)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1015ui_story then
				arg_39_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_42_3 = arg_39_1.actors_["2079ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos2079ui_story = var_42_3.localPosition
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_3.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_39_1.time_ - 0) / var_42_4)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			local var_42_5 = arg_39_1.actors_["2079ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect2079ui_story == nil then
				arg_39_1.var_.characterEffect2079ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.characterEffect2079ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect2079ui_story then
				arg_39_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_42_8 = 0
			local var_42_9 = 0.0329999998211861

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(317033010)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 3 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 3)

				if (3 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 3)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033010", "story_v_out_317033.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033010", "story_v_out_317033.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_317033", "317033010", "story_v_out_317033.awb")

						arg_39_1:RecordAudio("317033010", var_42_15)
						arg_39_1:RecordAudio("317033010", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_317033", "317033010", "story_v_out_317033.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_317033", "317033010", "story_v_out_317033.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 317033011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play317033012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) and arg_43_1.var_.characterEffect2079ui_story == nil then
				arg_43_1.var_.characterEffect2079ui_story = arg_43_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) then
				if arg_43_1.var_.characterEffect2079ui_story and not isNil(arg_43_1.actors_["2079ui_story"]) then
					arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_43_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["2079ui_story"]) and arg_43_1.var_.characterEffect2079ui_story then
				arg_43_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_43_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.0329999998211861

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(317033011).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 13 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 13)

				if (13 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 13)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play317033012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 317033012
		arg_47_1.duration_ = 2.1

		local var_47_0 = {
			zh = 1.2,
			ja = 2.1
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
				arg_47_0:Play317033013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1015ui_story = arg_47_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).z)
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles = arg_47_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_47_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1015ui_story"].transform.position).z)
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1015ui_story"].transform.localEulerAngles = arg_47_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1015ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1015ui_story == nil then
				arg_47_1.var_.characterEffect1015ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1015ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1015ui_story then
				arg_47_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = arg_47_1.actors_["2079ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos2079ui_story = var_50_4.localPosition
			end

			local var_50_5 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				var_50_4.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_5)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				var_50_4.localPosition = Vector3.New(0, 100, 0)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			local var_50_6 = arg_47_1.actors_["2079ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect2079ui_story == nil then
				arg_47_1.var_.characterEffect2079ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_7 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 and not isNil(var_50_6) then
				if arg_47_1.var_.characterEffect2079ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_47_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_7)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect2079ui_story then
				arg_47_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_47_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_50_8 = 0
			local var_50_9 = 0.0329999998211861

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(317033012)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 5 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 5)

				if (5 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 5)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033012", "story_v_out_317033.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033012", "story_v_out_317033.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_317033", "317033012", "story_v_out_317033.awb")

						arg_47_1:RecordAudio("317033012", var_50_15)
						arg_47_1:RecordAudio("317033012", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317033", "317033012", "story_v_out_317033.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317033", "317033012", "story_v_out_317033.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 317033013
		arg_51_1.duration_ = 7.4

		local var_51_0 = {
			zh = 7.3,
			ja = 7.4
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
				arg_51_0:Play317033014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1015ui_story = arg_51_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1015ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story == nil then
				arg_51_1.var_.characterEffect1015ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1015ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story then
				arg_51_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_54_3 = arg_51_1.actors_["2079ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos2079ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["2079ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect2079ui_story == nil then
				arg_51_1.var_.characterEffect2079ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect2079ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect2079ui_story then
				arg_51_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_54_8 = 0
			local var_54_9 = 0.0329999998211861

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(317033013)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 36 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 36)

				if (36 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 36)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033013", "story_v_out_317033.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033013", "story_v_out_317033.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_317033", "317033013", "story_v_out_317033.awb")

						arg_51_1:RecordAudio("317033013", var_54_15)
						arg_51_1:RecordAudio("317033013", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_317033", "317033013", "story_v_out_317033.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_317033", "317033013", "story_v_out_317033.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317033014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 317033014
		arg_55_1.duration_ = 5.3

		local var_55_0 = {
			zh = 5.2,
			ja = 5.3
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
				arg_55_0:Play317033015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos2079ui_story = arg_55_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).z)
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles = arg_55_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).z)
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles = arg_55_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["2079ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2079ui_story == nil then
				arg_55_1.var_.characterEffect2079ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect2079ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_55_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_2)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2079ui_story then
				arg_55_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_55_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_58_3 = "1093ui_story"

			if arg_55_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_58_4 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_55_1.stage_.transform)

				var_58_4.name = var_58_3
				var_58_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_[var_58_3] = var_58_4

				local var_58_5 = var_58_4:GetComponentInChildren(typeof(CharacterEffect))

				var_58_5.enabled = true

				local var_58_6 = GameObjectTools.GetOrAddComponent(var_58_4, typeof(DynamicBoneHelper))

				if var_58_6 then
					var_58_6:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_5.transform, false)

				arg_55_1.var_[var_58_3 .. "Animator"] = var_58_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_[var_58_3 .. "Animator"].applyRootMotion = true
				arg_55_1.var_[var_58_3 .. "LipSync"] = var_58_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_58_7 = arg_55_1.actors_["1093ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1093ui_story = var_58_7.localPosition
			end

			local var_58_8 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_8 then
				var_58_7.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_55_1.time_ - 0) / var_58_8)
				var_58_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_7.position).x, (manager.ui.mainCamera.transform.position - var_58_7.position).y, (manager.ui.mainCamera.transform.position - var_58_7.position).z)
				var_58_7.localEulerAngles.z = 0
				var_58_7.localEulerAngles.x = 0
				var_58_7.localEulerAngles = var_58_7.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_8 and arg_55_1.time_ < 0 + var_58_8 + arg_58_0 then
				var_58_7.localPosition = Vector3.New(0, -1.11, -5.88)
				var_58_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_7.position).x, (manager.ui.mainCamera.transform.position - var_58_7.position).y, (manager.ui.mainCamera.transform.position - var_58_7.position).z)
				var_58_7.localEulerAngles.z = 0
				var_58_7.localEulerAngles.x = 0
				var_58_7.localEulerAngles = var_58_7.localEulerAngles
			end

			local var_58_9 = arg_55_1.actors_["1093ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1093ui_story == nil then
				arg_55_1.var_.characterEffect1093ui_story = var_58_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_10 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_10 and not isNil(var_58_9) then
				if arg_55_1.var_.characterEffect1093ui_story and not isNil(var_58_9) then
					arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_10 and arg_55_1.time_ < 0 + var_58_10 + arg_58_0 and not isNil(var_58_9) and arg_55_1.var_.characterEffect1093ui_story then
				arg_55_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_12 = 0
			local var_58_13 = 0.0329999998211861

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_14 = arg_55_1:GetWordFromCfg(317033014)
				local var_58_15 = arg_55_1:FormatText(var_58_14.content)

				arg_55_1.text_.text = var_58_15

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_17 = 21 <= 0 and var_58_13 or var_58_13 * (utf8.len(var_58_15) / 21)

				if (21 <= 0 and var_58_13 or var_58_13 * (utf8.len(var_58_15) / 21)) > 0 and var_58_13 < var_58_17 then
					arg_55_1.talkMaxDuration = var_58_17

					if var_58_17 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_12
					end
				end

				arg_55_1.text_.text = var_58_15
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033014", "story_v_out_317033.awb") ~= 0 then
					local var_58_18 = manager.audio:GetVoiceLength("story_v_out_317033", "317033014", "story_v_out_317033.awb") / 1000

					if var_58_18 + var_58_12 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_18 + var_58_12
					end

					if var_58_14.prefab_name ~= "" and arg_55_1.actors_[var_58_14.prefab_name] ~= nil then
						local var_58_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_14.prefab_name].transform, "story_v_out_317033", "317033014", "story_v_out_317033.awb")

						arg_55_1:RecordAudio("317033014", var_58_19)
						arg_55_1:RecordAudio("317033014", var_58_19)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_317033", "317033014", "story_v_out_317033.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_317033", "317033014", "story_v_out_317033.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_20 = math.max(var_58_13, arg_55_1.talkMaxDuration)

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_20 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_12) / var_58_20

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_12 + var_58_20 and arg_55_1.time_ < var_58_12 + var_58_20 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317033015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317033015
		arg_59_1.duration_ = 8.07

		local var_59_0 = {
			zh = 8.066,
			ja = 5.866
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
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play317033016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos2079ui_story = arg_59_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).z)
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles = arg_59_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_59_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["2079ui_story"].transform.position).z)
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["2079ui_story"].transform.localEulerAngles = arg_59_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["2079ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect2079ui_story == nil then
				arg_59_1.var_.characterEffect2079ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect2079ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect2079ui_story then
				arg_59_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = arg_59_1.actors_["1093ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1093ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0, 100, 0)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["1093ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1093ui_story == nil then
				arg_59_1.var_.characterEffect1093ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect1093ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1093ui_story then
				arg_59_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_62_8 = 0
			local var_62_9 = 0.0329999998211861

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(317033015)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 39 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 39)

				if (39 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 39)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033015", "story_v_out_317033.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033015", "story_v_out_317033.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_317033", "317033015", "story_v_out_317033.awb")

						arg_59_1:RecordAudio("317033015", var_62_15)
						arg_59_1:RecordAudio("317033015", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317033", "317033015", "story_v_out_317033.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317033", "317033015", "story_v_out_317033.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317033016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 317033016
		arg_63_1.duration_ = 2.6

		local var_63_0 = {
			zh = 2.166,
			ja = 2.6
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play317033017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos2079ui_story = arg_63_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).z)
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles = arg_63_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["2079ui_story"].transform.position).z)
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["2079ui_story"].transform.localEulerAngles = arg_63_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["2079ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect2079ui_story == nil then
				arg_63_1.var_.characterEffect2079ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect2079ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_63_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_2)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect2079ui_story then
				arg_63_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_63_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_66_3 = arg_63_1.actors_["1015ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1015ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_63_1.time_ - 0) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			local var_66_5 = arg_63_1.actors_["1015ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 and not isNil(var_66_5) then
				if arg_63_1.var_.characterEffect1015ui_story and not isNil(var_66_5) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_8 = 0
			local var_66_9 = 0.0329999998211861

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(317033016)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 10 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 10)

				if (10 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 10)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033016", "story_v_out_317033.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_317033", "317033016", "story_v_out_317033.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_317033", "317033016", "story_v_out_317033.awb")

						arg_63_1:RecordAudio("317033016", var_66_15)
						arg_63_1:RecordAudio("317033016", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317033", "317033016", "story_v_out_317033.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317033", "317033016", "story_v_out_317033.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play317033017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 317033017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play317033018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) and arg_67_1.var_.characterEffect1015ui_story == nil then
				arg_67_1.var_.characterEffect1015ui_story = arg_67_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) then
				if arg_67_1.var_.characterEffect1015ui_story and not isNil(arg_67_1.actors_["1015ui_story"]) then
					arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) and arg_67_1.var_.characterEffect1015ui_story then
				arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.0329999998211861

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(317033017).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 19 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 19)

				if (19 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 19)) > 0 and var_70_2 < var_70_5 then
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
	Play317033018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 317033018
		arg_71_1.duration_ = 4.1

		local var_71_0 = {
			zh = 4,
			ja = 4.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play317033019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1015ui_story = arg_71_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).z)
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles = arg_71_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_71_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1015ui_story"].transform.position).z)
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1015ui_story"].transform.localEulerAngles = arg_71_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1015ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1015ui_story == nil then
				arg_71_1.var_.characterEffect1015ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1015ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1015ui_story then
				arg_71_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.0329999998211861

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(317033018)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)

				if (19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033018", "story_v_out_317033.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_317033", "317033018", "story_v_out_317033.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_317033", "317033018", "story_v_out_317033.awb")

						arg_71_1:RecordAudio("317033018", var_74_11)
						arg_71_1:RecordAudio("317033018", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_317033", "317033018", "story_v_out_317033.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_317033", "317033018", "story_v_out_317033.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317033019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 317033019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play317033020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1015ui_story"]) and arg_75_1.var_.characterEffect1015ui_story == nil then
				arg_75_1.var_.characterEffect1015ui_story = arg_75_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1015ui_story"]) then
				if arg_75_1.var_.characterEffect1015ui_story and not isNil(arg_75_1.actors_["1015ui_story"]) then
					arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1015ui_story"]) and arg_75_1.var_.characterEffect1015ui_story then
				arg_75_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.0329999998211861

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(317033019).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 5 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 5)

				if (5 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 5)) > 0 and var_78_2 < var_78_5 then
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

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play317033020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317033020
		arg_79_1.duration_ = 3.6

		local var_79_0 = {
			zh = 3.566,
			ja = 3.6
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

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
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1015ui_story = arg_79_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).z)
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles = arg_79_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_79_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1015ui_story"].transform.position).z)
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1015ui_story"].transform.localEulerAngles = arg_79_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1015ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1015ui_story == nil then
				arg_79_1.var_.characterEffect1015ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1015ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1015ui_story then
				arg_79_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.0329999998211861

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(317033020)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)

				if (14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317033", "317033020", "story_v_out_317033.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_317033", "317033020", "story_v_out_317033.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_317033", "317033020", "story_v_out_317033.awb")

						arg_79_1:RecordAudio("317033020", var_82_11)
						arg_79_1:RecordAudio("317033020", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_317033", "317033020", "story_v_out_317033.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_317033", "317033020", "story_v_out_317033.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K10f"
	},
	voices = {
		"story_v_out_317033.awb"
	}
}
