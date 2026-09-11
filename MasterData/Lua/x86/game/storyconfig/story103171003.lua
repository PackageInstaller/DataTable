return {
	Play317103001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317103001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317103002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
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
			local var_4_9 = 0.675

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

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317103001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 27 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 27)

				if (27 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 27)) > 0 and var_4_9 < var_4_13 then
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
	Play317103002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 317103002
		arg_7_1.duration_ = 4.8

		local var_7_0 = {
			zh = 4.8,
			ja = 4.666
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
				arg_7_0:Play317103003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1015ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1015ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1015ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1015ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1015ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_3) and arg_7_1.var_.characterEffect1015ui_story == nil then
				arg_7_1.var_.characterEffect1015ui_story = var_10_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_4 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_4 and not isNil(var_10_3) then
				if arg_7_1.var_.characterEffect1015ui_story and not isNil(var_10_3) then
					arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_4 and arg_7_1.time_ < 0 + var_10_4 + arg_10_0 and not isNil(var_10_3) and arg_7_1.var_.characterEffect1015ui_story then
				arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_10_6 = "1093ui_story"

			if arg_7_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_10_7 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_7_1.stage_.transform)

				var_10_7.name = var_10_6
				var_10_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_6] = var_10_7

				local var_10_8 = var_10_7:GetComponentInChildren(typeof(CharacterEffect))

				var_10_8.enabled = true

				local var_10_9 = GameObjectTools.GetOrAddComponent(var_10_7, typeof(DynamicBoneHelper))

				if var_10_9 then
					var_10_9:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_8.transform, false)

				arg_7_1.var_[var_10_6 .. "Animator"] = var_10_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_6 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_6 .. "LipSync"] = var_10_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_10 = arg_7_1.actors_["1093ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1093ui_story == nil then
				arg_7_1.var_.characterEffect1093ui_story = var_10_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_11 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_11 and not isNil(var_10_10) then
				if arg_7_1.var_.characterEffect1093ui_story and not isNil(var_10_10) then
					arg_7_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_11)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_11 and arg_7_1.time_ < 0 + var_10_11 + arg_10_0 and not isNil(var_10_10) and arg_7_1.var_.characterEffect1093ui_story then
				arg_7_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_10_12 = arg_7_1.actors_["1015ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1015ui_story = var_10_12.localPosition
			end

			local var_10_13 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_13 then
				var_10_12.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_7_1.time_ - 0) / var_10_13)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_13 and arg_7_1.time_ < 0 + var_10_13 + arg_10_0 then
				var_10_12.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_10_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_12.position).x, (manager.ui.mainCamera.transform.position - var_10_12.position).y, (manager.ui.mainCamera.transform.position - var_10_12.position).z)
				var_10_12.localEulerAngles.z = 0
				var_10_12.localEulerAngles.x = 0
				var_10_12.localEulerAngles = var_10_12.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_14 = arg_7_1.actors_["1093ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1093ui_story = var_10_14.localPosition
			end

			local var_10_15 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_15 then
				var_10_14.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_7_1.time_ - 0) / var_10_15)
				var_10_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_14.position).x, (manager.ui.mainCamera.transform.position - var_10_14.position).y, (manager.ui.mainCamera.transform.position - var_10_14.position).z)
				var_10_14.localEulerAngles.z = 0
				var_10_14.localEulerAngles.x = 0
				var_10_14.localEulerAngles = var_10_14.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_15 and arg_7_1.time_ < 0 + var_10_15 + arg_10_0 then
				var_10_14.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_10_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_14.position).x, (manager.ui.mainCamera.transform.position - var_10_14.position).y, (manager.ui.mainCamera.transform.position - var_10_14.position).z)
				var_10_14.localEulerAngles.z = 0
				var_10_14.localEulerAngles.x = 0
				var_10_14.localEulerAngles = var_10_14.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_10_16 = 0
			local var_10_17 = 0.55

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
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

				local var_10_18 = arg_7_1:GetWordFromCfg(317103002)
				local var_10_19 = arg_7_1:FormatText(var_10_18.content)

				arg_7_1.text_.text = var_10_19

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_21 = 22 <= 0 and var_10_17 or var_10_17 * (utf8.len(var_10_19) / 22)

				if (22 <= 0 and var_10_17 or var_10_17 * (utf8.len(var_10_19) / 22)) > 0 and var_10_17 < var_10_21 then
					arg_7_1.talkMaxDuration = var_10_21

					if var_10_21 + var_10_16 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_21 + var_10_16
					end
				end

				arg_7_1.text_.text = var_10_19
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103002", "story_v_out_317103.awb") ~= 0 then
					local var_10_22 = manager.audio:GetVoiceLength("story_v_out_317103", "317103002", "story_v_out_317103.awb") / 1000

					if var_10_22 + var_10_16 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_22 + var_10_16
					end

					if var_10_18.prefab_name ~= "" and arg_7_1.actors_[var_10_18.prefab_name] ~= nil then
						local var_10_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_18.prefab_name].transform, "story_v_out_317103", "317103002", "story_v_out_317103.awb")

						arg_7_1:RecordAudio("317103002", var_10_23)
						arg_7_1:RecordAudio("317103002", var_10_23)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_317103", "317103002", "story_v_out_317103.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_317103", "317103002", "story_v_out_317103.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_24 = math.max(var_10_17, arg_7_1.talkMaxDuration)

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_24 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_16) / var_10_24

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_16 + var_10_24 and arg_7_1.time_ < var_10_16 + var_10_24 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
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
	Play317103003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 317103003
		arg_11_1.duration_ = 7.73

		local var_11_0 = {
			zh = 6.966,
			ja = 7.733
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
				arg_11_0:Play317103004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1015ui_story = arg_11_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).z)
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles = arg_11_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_11_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1015ui_story"].transform.position).z)
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1015ui_story"].transform.localEulerAngles = arg_11_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1093ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1093ui_story = var_14_1.localPosition
			end

			local var_14_2 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 then
				var_14_1.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_11_1.time_ - 0) / var_14_2)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 then
				var_14_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_14_3 = arg_11_1.actors_["1015ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1015ui_story == nil then
				arg_11_1.var_.characterEffect1015ui_story = var_14_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_4 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 and not isNil(var_14_3) then
				if arg_11_1.var_.characterEffect1015ui_story and not isNil(var_14_3) then
					arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_4)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1015ui_story then
				arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_14_5 = arg_11_1.actors_["1093ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1093ui_story == nil then
				arg_11_1.var_.characterEffect1093ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_6 = 0.200000002980232

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_6 and not isNil(var_14_5) then
				if arg_11_1.var_.characterEffect1093ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_6 and arg_11_1.time_ < 0 + var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1093ui_story then
				arg_11_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_14_8 = 0
			local var_14_9 = 0.875

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_10 = arg_11_1:GetWordFromCfg(317103003)
				local var_14_11 = arg_11_1:FormatText(var_14_10.content)

				arg_11_1.text_.text = var_14_11

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_13 = 35 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 35)

				if (35 <= 0 and var_14_9 or var_14_9 * (utf8.len(var_14_11) / 35)) > 0 and var_14_9 < var_14_13 then
					arg_11_1.talkMaxDuration = var_14_13

					if var_14_13 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_13 + var_14_8
					end
				end

				arg_11_1.text_.text = var_14_11
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103003", "story_v_out_317103.awb") ~= 0 then
					local var_14_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103003", "story_v_out_317103.awb") / 1000

					if var_14_14 + var_14_8 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_14 + var_14_8
					end

					if var_14_10.prefab_name ~= "" and arg_11_1.actors_[var_14_10.prefab_name] ~= nil then
						local var_14_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_10.prefab_name].transform, "story_v_out_317103", "317103003", "story_v_out_317103.awb")

						arg_11_1:RecordAudio("317103003", var_14_15)
						arg_11_1:RecordAudio("317103003", var_14_15)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_317103", "317103003", "story_v_out_317103.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_317103", "317103003", "story_v_out_317103.awb")
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
				actorName = "1093ui_story",
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
	Play317103004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 317103004
		arg_15_1.duration_ = 5.5

		local var_15_0 = {
			zh = 5.5,
			ja = 3.766
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
				arg_15_0:Play317103005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1015ui_story = arg_15_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).z)
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles = arg_15_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_15_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1015ui_story"].transform.position).z)
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1015ui_story"].transform.localEulerAngles = arg_15_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_18_1 = arg_15_1.actors_["1093ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1093ui_story = var_18_1.localPosition
			end

			local var_18_2 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 then
				var_18_1.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_15_1.time_ - 0) / var_18_2)
				var_18_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_1.position).x, (manager.ui.mainCamera.transform.position - var_18_1.position).y, (manager.ui.mainCamera.transform.position - var_18_1.position).z)
				var_18_1.localEulerAngles.z = 0
				var_18_1.localEulerAngles.x = 0
				var_18_1.localEulerAngles = var_18_1.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 then
				var_18_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_18_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_1.position).x, (manager.ui.mainCamera.transform.position - var_18_1.position).y, (manager.ui.mainCamera.transform.position - var_18_1.position).z)
				var_18_1.localEulerAngles.z = 0
				var_18_1.localEulerAngles.x = 0
				var_18_1.localEulerAngles = var_18_1.localEulerAngles
			end

			local var_18_3 = arg_15_1.actors_["1015ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1015ui_story == nil then
				arg_15_1.var_.characterEffect1015ui_story = var_18_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 and not isNil(var_18_3) then
				if arg_15_1.var_.characterEffect1015ui_story and not isNil(var_18_3) then
					arg_15_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1015ui_story then
				arg_15_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_18_6 = arg_15_1.actors_["1093ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect1093ui_story == nil then
				arg_15_1.var_.characterEffect1093ui_story = var_18_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_7 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 and not isNil(var_18_6) then
				if arg_15_1.var_.characterEffect1093ui_story and not isNil(var_18_6) then
					arg_15_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_7)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect1093ui_story then
				arg_15_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_18_8 = 0
			local var_18_9 = 0.55

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_10 = arg_15_1:GetWordFromCfg(317103004)
				local var_18_11 = arg_15_1:FormatText(var_18_10.content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 22 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 22)

				if (22 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 22)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103004", "story_v_out_317103.awb") ~= 0 then
					local var_18_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103004", "story_v_out_317103.awb") / 1000

					if var_18_14 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_14 + var_18_8
					end

					if var_18_10.prefab_name ~= "" and arg_15_1.actors_[var_18_10.prefab_name] ~= nil then
						local var_18_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_10.prefab_name].transform, "story_v_out_317103", "317103004", "story_v_out_317103.awb")

						arg_15_1:RecordAudio("317103004", var_18_15)
						arg_15_1:RecordAudio("317103004", var_18_15)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_317103", "317103004", "story_v_out_317103.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_317103", "317103004", "story_v_out_317103.awb")
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
				actorName = "1093ui_story",
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
	Play317103005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 317103005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play317103006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1015ui_story = arg_19_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 then
				arg_19_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_0)
				arg_19_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).z)
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles = arg_19_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1015ui_story"].transform.position).z)
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1015ui_story"].transform.localEulerAngles = arg_19_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1093ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1093ui_story = var_22_1.localPosition
			end

			local var_22_2 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 then
				var_22_1.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_2)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 then
				var_22_1.localPosition = Vector3.New(0, 100, 0)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			local var_22_3 = arg_19_1.actors_["1015ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1015ui_story == nil then
				arg_19_1.var_.characterEffect1015ui_story = var_22_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_4 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 and not isNil(var_22_3) then
				if arg_19_1.var_.characterEffect1015ui_story and not isNil(var_22_3) then
					arg_19_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_4)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1015ui_story then
				arg_19_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_22_5 = 0
			local var_22_6 = 0.75

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_7 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(317103005).content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 30 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 30)

				if (30 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 30)) > 0 and var_22_6 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_5
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_6, arg_19_1.talkMaxDuration)

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_5) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_5 + var_22_10 and arg_19_1.time_ < var_22_5 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
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
	Play317103006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 317103006
		arg_23_1.duration_ = 14.67

		local var_23_0 = {
			zh = 12.233,
			ja = 14.666
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
				arg_23_0:Play317103007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1015ui_story = arg_23_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).z)
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles = arg_23_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_23_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1015ui_story"].transform.position).z)
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1015ui_story"].transform.localEulerAngles = arg_23_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_1 = arg_23_1.actors_["1093ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1093ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = arg_23_1.actors_["1015ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1015ui_story == nil then
				arg_23_1.var_.characterEffect1015ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect1015ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1015ui_story then
				arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_26_6 = arg_23_1.actors_["1093ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1093ui_story == nil then
				arg_23_1.var_.characterEffect1093ui_story = var_26_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_7 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 and not isNil(var_26_6) then
				if arg_23_1.var_.characterEffect1093ui_story and not isNil(var_26_6) then
					arg_23_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_7)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1093ui_story then
				arg_23_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_26_8 = 0
			local var_26_9 = 1.5

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(317103006)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 60 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 60)

				if (60 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 60)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103006", "story_v_out_317103.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103006", "story_v_out_317103.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_317103", "317103006", "story_v_out_317103.awb")

						arg_23_1:RecordAudio("317103006", var_26_15)
						arg_23_1:RecordAudio("317103006", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317103", "317103006", "story_v_out_317103.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317103", "317103006", "story_v_out_317103.awb")
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
				actorName = "1093ui_story",
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
	Play317103007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 317103007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play317103008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1015ui_story"]) and arg_27_1.var_.characterEffect1015ui_story == nil then
				arg_27_1.var_.characterEffect1015ui_story = arg_27_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1015ui_story"]) then
				if arg_27_1.var_.characterEffect1015ui_story and not isNil(arg_27_1.actors_["1015ui_story"]) then
					arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1015ui_story"]) and arg_27_1.var_.characterEffect1015ui_story then
				arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_30_1 = 0
			local var_30_2 = 0.575

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(317103007).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 23 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 23)

				if (23 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 23)) > 0 and var_30_2 < var_30_5 then
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

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play317103008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 317103008
		arg_31_1.duration_ = 6.2

		local var_31_0 = {
			zh = 4.366,
			ja = 6.2
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
				arg_31_0:Play317103009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1015ui_story = arg_31_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_31_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1015ui_story"].transform.position).z)
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1015ui_story"].transform.localEulerAngles = arg_31_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1093ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1093ui_story = var_34_1.localPosition
			end

			local var_34_2 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_31_1.time_ - 0) / var_34_2)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_34_3 = arg_31_1.actors_["1015ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1015ui_story == nil then
				arg_31_1.var_.characterEffect1015ui_story = var_34_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_4 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 and not isNil(var_34_3) then
				if arg_31_1.var_.characterEffect1015ui_story and not isNil(var_34_3) then
					arg_31_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_4)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1015ui_story then
				arg_31_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_34_5 = arg_31_1.actors_["1093ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1093ui_story == nil then
				arg_31_1.var_.characterEffect1093ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect1093ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1093ui_story then
				arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_34_8 = 0
			local var_34_9 = 0.3

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(317103008)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 12 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 12)

				if (12 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 12)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103008", "story_v_out_317103.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103008", "story_v_out_317103.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_317103", "317103008", "story_v_out_317103.awb")

						arg_31_1:RecordAudio("317103008", var_34_15)
						arg_31_1:RecordAudio("317103008", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_317103", "317103008", "story_v_out_317103.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_317103", "317103008", "story_v_out_317103.awb")
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
				actorName = "1093ui_story",
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
	Play317103009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 317103009
		arg_35_1.duration_ = 5.47

		local var_35_0 = {
			zh = 3.133,
			ja = 5.466
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
				arg_35_0:Play317103010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1015ui_story = arg_35_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).z)
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles = arg_35_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_35_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1015ui_story"].transform.position).z)
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1015ui_story"].transform.localEulerAngles = arg_35_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1093ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1093ui_story = var_38_1.localPosition
			end

			local var_38_2 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 then
				var_38_1.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_35_1.time_ - 0) / var_38_2)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 then
				var_38_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_38_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_1.position).x, (manager.ui.mainCamera.transform.position - var_38_1.position).y, (manager.ui.mainCamera.transform.position - var_38_1.position).z)
				var_38_1.localEulerAngles.z = 0
				var_38_1.localEulerAngles.x = 0
				var_38_1.localEulerAngles = var_38_1.localEulerAngles
			end

			local var_38_3 = arg_35_1.actors_["1015ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1015ui_story == nil then
				arg_35_1.var_.characterEffect1015ui_story = var_38_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_4 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 and not isNil(var_38_3) then
				if arg_35_1.var_.characterEffect1015ui_story and not isNil(var_38_3) then
					arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1015ui_story then
				arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_6 = arg_35_1.actors_["1093ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1093ui_story == nil then
				arg_35_1.var_.characterEffect1093ui_story = var_38_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_7 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 and not isNil(var_38_6) then
				if arg_35_1.var_.characterEffect1093ui_story and not isNil(var_38_6) then
					arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_7)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1093ui_story then
				arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_38_8 = 0
			local var_38_9 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
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

				local var_38_10 = arg_35_1:GetWordFromCfg(317103009)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 18 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 18)

				if (18 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 18)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103009", "story_v_out_317103.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103009", "story_v_out_317103.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_317103", "317103009", "story_v_out_317103.awb")

						arg_35_1:RecordAudio("317103009", var_38_15)
						arg_35_1:RecordAudio("317103009", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_317103", "317103009", "story_v_out_317103.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_317103", "317103009", "story_v_out_317103.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
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

		arg_35_1:InitPlayNodeList()
	end,
	Play317103010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 317103010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play317103011(arg_39_1)
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

			local var_42_1 = arg_39_1.actors_["1093ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1093ui_story = var_42_1.localPosition
			end

			local var_42_2 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 then
				var_42_1.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_2)
				var_42_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_1.position).x, (manager.ui.mainCamera.transform.position - var_42_1.position).y, (manager.ui.mainCamera.transform.position - var_42_1.position).z)
				var_42_1.localEulerAngles.z = 0
				var_42_1.localEulerAngles.x = 0
				var_42_1.localEulerAngles = var_42_1.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 then
				var_42_1.localPosition = Vector3.New(0, 100, 0)
				var_42_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_1.position).x, (manager.ui.mainCamera.transform.position - var_42_1.position).y, (manager.ui.mainCamera.transform.position - var_42_1.position).z)
				var_42_1.localEulerAngles.z = 0
				var_42_1.localEulerAngles.x = 0
				var_42_1.localEulerAngles = var_42_1.localEulerAngles
			end

			local var_42_3 = 0
			local var_42_4 = 0.425

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

				local var_42_5 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(317103010).content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 17 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 17)

				if (17 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 17)) > 0 and var_42_4 < var_42_7 then
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
				actorName = "1093ui_story",
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
	Play317103011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 317103011
		arg_43_1.duration_ = 6.47

		local var_43_0 = {
			zh = 6.466,
			ja = 4.966
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
				arg_43_0:Play317103012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) and arg_43_1.var_.characterEffect1015ui_story == nil then
				arg_43_1.var_.characterEffect1015ui_story = arg_43_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) then
				if arg_43_1.var_.characterEffect1015ui_story and not isNil(arg_43_1.actors_["1015ui_story"]) then
					arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) and arg_43_1.var_.characterEffect1015ui_story then
				arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["1093ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1093ui_story == nil then
				arg_43_1.var_.characterEffect1093ui_story = var_46_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_3 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 and not isNil(var_46_2) then
				if arg_43_1.var_.characterEffect1093ui_story and not isNil(var_46_2) then
					arg_43_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_3)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 and not isNil(var_46_2) and arg_43_1.var_.characterEffect1093ui_story then
				arg_43_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_46_4 = arg_43_1.actors_["1015ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1015ui_story = var_46_4.localPosition
			end

			local var_46_5 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				var_46_4.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_43_1.time_ - 0) / var_46_5)
				var_46_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_4.position).x, (manager.ui.mainCamera.transform.position - var_46_4.position).y, (manager.ui.mainCamera.transform.position - var_46_4.position).z)
				var_46_4.localEulerAngles.z = 0
				var_46_4.localEulerAngles.x = 0
				var_46_4.localEulerAngles = var_46_4.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				var_46_4.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_46_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_4.position).x, (manager.ui.mainCamera.transform.position - var_46_4.position).y, (manager.ui.mainCamera.transform.position - var_46_4.position).z)
				var_46_4.localEulerAngles.z = 0
				var_46_4.localEulerAngles.x = 0
				var_46_4.localEulerAngles = var_46_4.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_6 = arg_43_1.actors_["1093ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1093ui_story = var_46_6.localPosition
			end

			local var_46_7 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				var_46_6.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_43_1.time_ - 0) / var_46_7)
				var_46_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_6.position).x, (manager.ui.mainCamera.transform.position - var_46_6.position).y, (manager.ui.mainCamera.transform.position - var_46_6.position).z)
				var_46_6.localEulerAngles.z = 0
				var_46_6.localEulerAngles.x = 0
				var_46_6.localEulerAngles = var_46_6.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				var_46_6.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_46_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_6.position).x, (manager.ui.mainCamera.transform.position - var_46_6.position).y, (manager.ui.mainCamera.transform.position - var_46_6.position).z)
				var_46_6.localEulerAngles.z = 0
				var_46_6.localEulerAngles.x = 0
				var_46_6.localEulerAngles = var_46_6.localEulerAngles
			end

			local var_46_8 = 0
			local var_46_9 = 0.75

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(317103011)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 30 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 30)

				if (30 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 30)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103011", "story_v_out_317103.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103011", "story_v_out_317103.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_317103", "317103011", "story_v_out_317103.awb")

						arg_43_1:RecordAudio("317103011", var_46_15)
						arg_43_1:RecordAudio("317103011", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_317103", "317103011", "story_v_out_317103.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_317103", "317103011", "story_v_out_317103.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
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
	Play317103012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 317103012
		arg_47_1.duration_ = 18.53

		local var_47_0 = {
			zh = 16.4,
			ja = 18.533
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
				arg_47_0:Play317103013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.85

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
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

				local var_50_1 = arg_47_1:GetWordFromCfg(317103012)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 74 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 74)

				if (74 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 74)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103012", "story_v_out_317103.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_317103", "317103012", "story_v_out_317103.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_317103", "317103012", "story_v_out_317103.awb")

						arg_47_1:RecordAudio("317103012", var_50_6)
						arg_47_1:RecordAudio("317103012", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317103", "317103012", "story_v_out_317103.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317103", "317103012", "story_v_out_317103.awb")
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
	Play317103013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 317103013
		arg_51_1.duration_ = 13.47

		local var_51_0 = {
			zh = 13.466,
			ja = 11.566
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
				arg_51_0:Play317103014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.575

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(317103013)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 63 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 63)

				if (63 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 63)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103013", "story_v_out_317103.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_317103", "317103013", "story_v_out_317103.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_317103", "317103013", "story_v_out_317103.awb")

						arg_51_1:RecordAudio("317103013", var_54_6)
						arg_51_1:RecordAudio("317103013", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_317103", "317103013", "story_v_out_317103.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_317103", "317103013", "story_v_out_317103.awb")
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
	Play317103014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 317103014
		arg_55_1.duration_ = 11.77

		local var_55_0 = {
			zh = 6.133,
			ja = 11.766
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
				arg_55_0:Play317103015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.825

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(317103014)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 33 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 33)

				if (33 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 33)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103014", "story_v_out_317103.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_317103", "317103014", "story_v_out_317103.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_317103", "317103014", "story_v_out_317103.awb")

						arg_55_1:RecordAudio("317103014", var_58_6)
						arg_55_1:RecordAudio("317103014", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_317103", "317103014", "story_v_out_317103.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_317103", "317103014", "story_v_out_317103.awb")
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
	Play317103015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317103015
		arg_59_1.duration_ = 10.63

		local var_59_0 = {
			zh = 10.633,
			ja = 10.466
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
				arg_59_0:Play317103016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story == nil then
				arg_59_1.var_.characterEffect1015ui_story = arg_59_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) then
				if arg_59_1.var_.characterEffect1015ui_story and not isNil(arg_59_1.actors_["1015ui_story"]) then
					arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story then
				arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_62_1 = arg_59_1.actors_["1093ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1093ui_story == nil then
				arg_59_1.var_.characterEffect1093ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1093ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1093ui_story then
				arg_59_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["1015ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1015ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["1093ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1093ui_story = var_62_6.localPosition
			end

			local var_62_7 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				var_62_6.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_59_1.time_ - 0) / var_62_7)
				var_62_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_6.position).x, (manager.ui.mainCamera.transform.position - var_62_6.position).y, (manager.ui.mainCamera.transform.position - var_62_6.position).z)
				var_62_6.localEulerAngles.z = 0
				var_62_6.localEulerAngles.x = 0
				var_62_6.localEulerAngles = var_62_6.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				var_62_6.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_62_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_6.position).x, (manager.ui.mainCamera.transform.position - var_62_6.position).y, (manager.ui.mainCamera.transform.position - var_62_6.position).z)
				var_62_6.localEulerAngles.z = 0
				var_62_6.localEulerAngles.x = 0
				var_62_6.localEulerAngles = var_62_6.localEulerAngles
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_8 = 0
			local var_62_9 = 1.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(317103015)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 47 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 47)

				if (47 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 47)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103015", "story_v_out_317103.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103015", "story_v_out_317103.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_317103", "317103015", "story_v_out_317103.awb")

						arg_59_1:RecordAudio("317103015", var_62_15)
						arg_59_1:RecordAudio("317103015", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317103", "317103015", "story_v_out_317103.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317103", "317103015", "story_v_out_317103.awb")
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
	Play317103016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 317103016
		arg_63_1.duration_ = 16.67

		local var_63_0 = {
			zh = 16.666,
			ja = 7.733
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
				arg_63_0:Play317103017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = arg_63_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) then
				if arg_63_1.var_.characterEffect1015ui_story and not isNil(arg_63_1.actors_["1015ui_story"]) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["1093ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1093ui_story == nil then
				arg_63_1.var_.characterEffect1093ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect1093ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1093ui_story then
				arg_63_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_66_4 = 0
			local var_66_5 = 1.925

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
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

				local var_66_6 = arg_63_1:GetWordFromCfg(317103016)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 77 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 77)

				if (77 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 77)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103016", "story_v_out_317103.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_317103", "317103016", "story_v_out_317103.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_317103", "317103016", "story_v_out_317103.awb")

						arg_63_1:RecordAudio("317103016", var_66_11)
						arg_63_1:RecordAudio("317103016", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317103", "317103016", "story_v_out_317103.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317103", "317103016", "story_v_out_317103.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play317103017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 317103017
		arg_67_1.duration_ = 10.3

		local var_67_0 = {
			zh = 6.666,
			ja = 10.3
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play317103018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1015ui_story = arg_67_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).z)
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles = arg_67_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_67_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).z)
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles = arg_67_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_1 = arg_67_1.actors_["1093ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1093ui_story = var_70_1.localPosition
			end

			local var_70_2 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 then
				var_70_1.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_67_1.time_ - 0) / var_70_2)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 then
				var_70_1.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			local var_70_3 = 0
			local var_70_4 = 0.85

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_5 = arg_67_1:GetWordFromCfg(317103017)
				local var_70_6 = arg_67_1:FormatText(var_70_5.content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 34 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 34)

				if (34 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_6) / 34)) > 0 and var_70_4 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_3
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103017", "story_v_out_317103.awb") ~= 0 then
					local var_70_9 = manager.audio:GetVoiceLength("story_v_out_317103", "317103017", "story_v_out_317103.awb") / 1000

					if var_70_9 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_3
					end

					if var_70_5.prefab_name ~= "" and arg_67_1.actors_[var_70_5.prefab_name] ~= nil then
						local var_70_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_5.prefab_name].transform, "story_v_out_317103", "317103017", "story_v_out_317103.awb")

						arg_67_1:RecordAudio("317103017", var_70_10)
						arg_67_1:RecordAudio("317103017", var_70_10)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_317103", "317103017", "story_v_out_317103.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_317103", "317103017", "story_v_out_317103.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_11 = math.max(var_70_4, arg_67_1.talkMaxDuration)

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_11 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_3) / var_70_11

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_3 + var_70_11 and arg_67_1.time_ < var_70_3 + var_70_11 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play317103018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 317103018
		arg_71_1.duration_ = 7.23

		local var_71_0 = {
			zh = 7.233,
			ja = 5.133
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
				arg_71_0:Play317103019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_74_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_71_1.stage_.transform)

				var_74_0.name = "2078ui_story"
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["2078ui_story"] = var_74_0

				local var_74_1 = var_74_0:GetComponentInChildren(typeof(CharacterEffect))

				var_74_1.enabled = true

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_1.transform, false)

				arg_71_1.var_["2078ui_story" .. "Animator"] = var_74_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_71_1.var_["2078ui_story" .. "LipSync"] = var_74_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_3 = arg_71_1.actors_["2078ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect2078ui_story == nil then
				arg_71_1.var_.characterEffect2078ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect2078ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect2078ui_story then
				arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_74_6 = arg_71_1.actors_["1015ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1015ui_story = var_74_6.localPosition
			end

			local var_74_7 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				var_74_6.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_7)
				var_74_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_6.position).x, (manager.ui.mainCamera.transform.position - var_74_6.position).y, (manager.ui.mainCamera.transform.position - var_74_6.position).z)
				var_74_6.localEulerAngles.z = 0
				var_74_6.localEulerAngles.x = 0
				var_74_6.localEulerAngles = var_74_6.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				var_74_6.localPosition = Vector3.New(0, 100, 0)
				var_74_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_6.position).x, (manager.ui.mainCamera.transform.position - var_74_6.position).y, (manager.ui.mainCamera.transform.position - var_74_6.position).z)
				var_74_6.localEulerAngles.z = 0
				var_74_6.localEulerAngles.x = 0
				var_74_6.localEulerAngles = var_74_6.localEulerAngles
			end

			local var_74_8 = arg_71_1.actors_["1093ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1093ui_story = var_74_8.localPosition
			end

			local var_74_9 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_9 then
				var_74_8.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_9)
				var_74_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_8.position).x, (manager.ui.mainCamera.transform.position - var_74_8.position).y, (manager.ui.mainCamera.transform.position - var_74_8.position).z)
				var_74_8.localEulerAngles.z = 0
				var_74_8.localEulerAngles.x = 0
				var_74_8.localEulerAngles = var_74_8.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_9 and arg_71_1.time_ < 0 + var_74_9 + arg_74_0 then
				var_74_8.localPosition = Vector3.New(0, 100, 0)
				var_74_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_8.position).x, (manager.ui.mainCamera.transform.position - var_74_8.position).y, (manager.ui.mainCamera.transform.position - var_74_8.position).z)
				var_74_8.localEulerAngles.z = 0
				var_74_8.localEulerAngles.x = 0
				var_74_8.localEulerAngles = var_74_8.localEulerAngles
			end

			local var_74_10 = arg_71_1.actors_["2078ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos2078ui_story = var_74_10.localPosition
			end

			local var_74_11 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_11 then
				var_74_10.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_71_1.time_ - 0) / var_74_11)
				var_74_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_10.position).x, (manager.ui.mainCamera.transform.position - var_74_10.position).y, (manager.ui.mainCamera.transform.position - var_74_10.position).z)
				var_74_10.localEulerAngles.z = 0
				var_74_10.localEulerAngles.x = 0
				var_74_10.localEulerAngles = var_74_10.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_11 and arg_71_1.time_ < 0 + var_74_11 + arg_74_0 then
				var_74_10.localPosition = Vector3.New(0, -1.28, -5.6)
				var_74_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_10.position).x, (manager.ui.mainCamera.transform.position - var_74_10.position).y, (manager.ui.mainCamera.transform.position - var_74_10.position).z)
				var_74_10.localEulerAngles.z = 0
				var_74_10.localEulerAngles.x = 0
				var_74_10.localEulerAngles = var_74_10.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_74_12 = 0
			local var_74_13 = 0.85

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_14 = arg_71_1:GetWordFromCfg(317103018)
				local var_74_15 = arg_71_1:FormatText(var_74_14.content)

				arg_71_1.text_.text = var_74_15

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 34 <= 0 and var_74_13 or var_74_13 * (utf8.len(var_74_15) / 34)

				if (34 <= 0 and var_74_13 or var_74_13 * (utf8.len(var_74_15) / 34)) > 0 and var_74_13 < var_74_17 then
					arg_71_1.talkMaxDuration = var_74_17

					if var_74_17 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_15
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103018", "story_v_out_317103.awb") ~= 0 then
					local var_74_18 = manager.audio:GetVoiceLength("story_v_out_317103", "317103018", "story_v_out_317103.awb") / 1000

					if var_74_18 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_18 + var_74_12
					end

					if var_74_14.prefab_name ~= "" and arg_71_1.actors_[var_74_14.prefab_name] ~= nil then
						local var_74_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_14.prefab_name].transform, "story_v_out_317103", "317103018", "story_v_out_317103.awb")

						arg_71_1:RecordAudio("317103018", var_74_19)
						arg_71_1:RecordAudio("317103018", var_74_19)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_317103", "317103018", "story_v_out_317103.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_317103", "317103018", "story_v_out_317103.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_20 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_20 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_20

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_20 and arg_71_1.time_ < var_74_12 + var_74_20 + arg_74_0 then
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
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play317103019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 317103019
		arg_75_1.duration_ = 4.53

		local var_75_0 = {
			zh = 4.1,
			ja = 4.533
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play317103020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos2078ui_story = arg_75_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).z)
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles = arg_75_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_75_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["2078ui_story"].transform.position).z)
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["2078ui_story"].transform.localEulerAngles = arg_75_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_78_1 = "2079ui_story"

			if arg_75_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_75_1.stage_.transform)

				var_78_2.name = var_78_1
				var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_[var_78_1] = var_78_2

				local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

				var_78_3.enabled = true

				local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

				if var_78_4 then
					var_78_4:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_3.transform, false)

				arg_75_1.var_[var_78_1 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_[var_78_1 .. "Animator"].applyRootMotion = true
				arg_75_1.var_[var_78_1 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_5 = arg_75_1.actors_["2079ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect2079ui_story == nil then
				arg_75_1.var_.characterEffect2079ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect2079ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect2079ui_story then
				arg_75_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_78_8 = 0
			local var_78_9 = 0.55

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(317103019)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 22 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 22)

				if (22 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 22)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103019", "story_v_out_317103.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103019", "story_v_out_317103.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_317103", "317103019", "story_v_out_317103.awb")

						arg_75_1:RecordAudio("317103019", var_78_15)
						arg_75_1:RecordAudio("317103019", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_317103", "317103019", "story_v_out_317103.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_317103", "317103019", "story_v_out_317103.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play317103020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317103020
		arg_79_1.duration_ = 5.7

		local var_79_0 = {
			zh = 5.2,
			ja = 5.7
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
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play317103021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1015ui_story"]) and arg_79_1.var_.characterEffect1015ui_story == nil then
				arg_79_1.var_.characterEffect1015ui_story = arg_79_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1015ui_story"]) then
				if arg_79_1.var_.characterEffect1015ui_story and not isNil(arg_79_1.actors_["1015ui_story"]) then
					arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1015ui_story"]) and arg_79_1.var_.characterEffect1015ui_story then
				arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_82_1 = arg_79_1.actors_["1093ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1093ui_story == nil then
				arg_79_1.var_.characterEffect1093ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1093ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1093ui_story then
				arg_79_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_82_4 = arg_79_1.actors_["1015ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1015ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			local var_82_6 = arg_79_1.actors_["1093ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1093ui_story = var_82_6.localPosition
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_6.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_79_1.time_ - 0) / var_82_7)
				var_82_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_6.position).x, (manager.ui.mainCamera.transform.position - var_82_6.position).y, (manager.ui.mainCamera.transform.position - var_82_6.position).z)
				var_82_6.localEulerAngles.z = 0
				var_82_6.localEulerAngles.x = 0
				var_82_6.localEulerAngles = var_82_6.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_6.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_82_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_6.position).x, (manager.ui.mainCamera.transform.position - var_82_6.position).y, (manager.ui.mainCamera.transform.position - var_82_6.position).z)
				var_82_6.localEulerAngles.z = 0
				var_82_6.localEulerAngles.x = 0
				var_82_6.localEulerAngles = var_82_6.localEulerAngles
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_8 = arg_79_1.actors_["2078ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos2078ui_story = var_82_8.localPosition
			end

			local var_82_9 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_9 then
				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_9)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_9 and arg_79_1.time_ < 0 + var_82_9 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, 100, 0)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			local var_82_10 = 0
			local var_82_11 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_12 = arg_79_1:GetWordFromCfg(317103020)
				local var_82_13 = arg_79_1:FormatText(var_82_12.content)

				arg_79_1.text_.text = var_82_13

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_15 = 23 <= 0 and var_82_11 or var_82_11 * (utf8.len(var_82_13) / 23)

				if (23 <= 0 and var_82_11 or var_82_11 * (utf8.len(var_82_13) / 23)) > 0 and var_82_11 < var_82_15 then
					arg_79_1.talkMaxDuration = var_82_15

					if var_82_15 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_10
					end
				end

				arg_79_1.text_.text = var_82_13
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103020", "story_v_out_317103.awb") ~= 0 then
					local var_82_16 = manager.audio:GetVoiceLength("story_v_out_317103", "317103020", "story_v_out_317103.awb") / 1000

					if var_82_16 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_10
					end

					if var_82_12.prefab_name ~= "" and arg_79_1.actors_[var_82_12.prefab_name] ~= nil then
						local var_82_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_12.prefab_name].transform, "story_v_out_317103", "317103020", "story_v_out_317103.awb")

						arg_79_1:RecordAudio("317103020", var_82_17)
						arg_79_1:RecordAudio("317103020", var_82_17)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_317103", "317103020", "story_v_out_317103.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_317103", "317103020", "story_v_out_317103.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_18 = math.max(var_82_11, arg_79_1.talkMaxDuration)

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_18 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_10) / var_82_18

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_10 + var_82_18 and arg_79_1.time_ < var_82_10 + var_82_18 + arg_82_0 then
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
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play317103021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 317103021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play317103022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1015ui_story = arg_83_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).z)
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles = arg_83_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1015ui_story"].transform.position).z)
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1015ui_story"].transform.localEulerAngles = arg_83_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1093ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1093ui_story = var_86_1.localPosition
			end

			local var_86_2 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_2)
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

			local var_86_3 = 0
			local var_86_4 = 0.7

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(317103021).content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 28 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 28)

				if (28 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 28)) > 0 and var_86_4 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_8 and arg_83_1.time_ < var_86_3 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
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
	Play317103022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317103022
		arg_87_1.duration_ = 6.9

		local var_87_0 = {
			zh = 6.9,
			ja = 6.566
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play317103023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) and arg_87_1.var_.characterEffect1015ui_story == nil then
				arg_87_1.var_.characterEffect1015ui_story = arg_87_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) then
				if arg_87_1.var_.characterEffect1015ui_story and not isNil(arg_87_1.actors_["1015ui_story"]) then
					arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1015ui_story"]) and arg_87_1.var_.characterEffect1015ui_story then
				arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_90_2 = arg_87_1.actors_["1015ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1015ui_story = var_90_2.localPosition
			end

			local var_90_3 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_87_1.time_ - 0) / var_90_3)
				var_90_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_2.position).x, (manager.ui.mainCamera.transform.position - var_90_2.position).y, (manager.ui.mainCamera.transform.position - var_90_2.position).z)
				var_90_2.localEulerAngles.z = 0
				var_90_2.localEulerAngles.x = 0
				var_90_2.localEulerAngles = var_90_2.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(0, -1.15, -6.2)
				var_90_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_2.position).x, (manager.ui.mainCamera.transform.position - var_90_2.position).y, (manager.ui.mainCamera.transform.position - var_90_2.position).z)
				var_90_2.localEulerAngles.z = 0
				var_90_2.localEulerAngles.x = 0
				var_90_2.localEulerAngles = var_90_2.localEulerAngles
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.8

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(317103022)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 32 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 32)

				if (32 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 32)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103022", "story_v_out_317103.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_317103", "317103022", "story_v_out_317103.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_317103", "317103022", "story_v_out_317103.awb")

						arg_87_1:RecordAudio("317103022", var_90_11)
						arg_87_1:RecordAudio("317103022", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_317103", "317103022", "story_v_out_317103.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_317103", "317103022", "story_v_out_317103.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play317103023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317103023
		arg_91_1.duration_ = 9.17

		local var_91_0 = {
			zh = 9.166,
			ja = 5.1
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play317103024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) and arg_91_1.var_.characterEffect2078ui_story == nil then
				arg_91_1.var_.characterEffect2078ui_story = arg_91_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) then
				if arg_91_1.var_.characterEffect2078ui_story and not isNil(arg_91_1.actors_["2078ui_story"]) then
					arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["2078ui_story"]) and arg_91_1.var_.characterEffect2078ui_story then
				arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_94_2 = arg_91_1.actors_["2078ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos2078ui_story = var_94_2.localPosition
			end

			local var_94_3 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_91_1.time_ - 0) / var_94_3)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -1.28, -5.6)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_94_4 = arg_91_1.actors_["1015ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1015ui_story = var_94_4.localPosition
			end

			local var_94_5 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 then
				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_5)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, 100, 0)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			local var_94_6 = 0
			local var_94_7 = 1

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(317103023)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 40 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 40)

				if (40 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 40)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103023", "story_v_out_317103.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103023", "story_v_out_317103.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_317103", "317103023", "story_v_out_317103.awb")

						arg_91_1:RecordAudio("317103023", var_94_13)
						arg_91_1:RecordAudio("317103023", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317103", "317103023", "story_v_out_317103.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317103", "317103023", "story_v_out_317103.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_91_1:InitPlayNodeList()
	end,
	Play317103024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317103024
		arg_95_1.duration_ = 9.3

		local var_95_0 = {
			zh = 5.366,
			ja = 9.3
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
				arg_95_0:Play317103025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1093ui_story"]) and arg_95_1.var_.characterEffect1093ui_story == nil then
				arg_95_1.var_.characterEffect1093ui_story = arg_95_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1093ui_story"]) then
				if arg_95_1.var_.characterEffect1093ui_story and not isNil(arg_95_1.actors_["1093ui_story"]) then
					arg_95_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1093ui_story"]) and arg_95_1.var_.characterEffect1093ui_story then
				arg_95_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_98_2 = arg_95_1.actors_["1093ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1093ui_story = var_98_2.localPosition
			end

			local var_98_3 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_95_1.time_ - 0) / var_98_3)
				var_98_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_2.position).x, (manager.ui.mainCamera.transform.position - var_98_2.position).y, (manager.ui.mainCamera.transform.position - var_98_2.position).z)
				var_98_2.localEulerAngles.z = 0
				var_98_2.localEulerAngles.x = 0
				var_98_2.localEulerAngles = var_98_2.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_98_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_2.position).x, (manager.ui.mainCamera.transform.position - var_98_2.position).y, (manager.ui.mainCamera.transform.position - var_98_2.position).z)
				var_98_2.localEulerAngles.z = 0
				var_98_2.localEulerAngles.x = 0
				var_98_2.localEulerAngles = var_98_2.localEulerAngles
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_98_4 = arg_95_1.actors_["2078ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos2078ui_story = var_98_4.localPosition
			end

			local var_98_5 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_5 then
				var_98_4.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_5)
				var_98_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_4.position).x, (manager.ui.mainCamera.transform.position - var_98_4.position).y, (manager.ui.mainCamera.transform.position - var_98_4.position).z)
				var_98_4.localEulerAngles.z = 0
				var_98_4.localEulerAngles.x = 0
				var_98_4.localEulerAngles = var_98_4.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_5 and arg_95_1.time_ < 0 + var_98_5 + arg_98_0 then
				var_98_4.localPosition = Vector3.New(0, 100, 0)
				var_98_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_4.position).x, (manager.ui.mainCamera.transform.position - var_98_4.position).y, (manager.ui.mainCamera.transform.position - var_98_4.position).z)
				var_98_4.localEulerAngles.z = 0
				var_98_4.localEulerAngles.x = 0
				var_98_4.localEulerAngles = var_98_4.localEulerAngles
			end

			local var_98_6 = 0
			local var_98_7 = 0.65

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_8 = arg_95_1:GetWordFromCfg(317103024)
				local var_98_9 = arg_95_1:FormatText(var_98_8.content)

				arg_95_1.text_.text = var_98_9

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 26 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 26)

				if (26 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_9) / 26)) > 0 and var_98_7 < var_98_11 then
					arg_95_1.talkMaxDuration = var_98_11

					if var_98_11 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_9
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103024", "story_v_out_317103.awb") ~= 0 then
					local var_98_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103024", "story_v_out_317103.awb") / 1000

					if var_98_12 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_6
					end

					if var_98_8.prefab_name ~= "" and arg_95_1.actors_[var_98_8.prefab_name] ~= nil then
						local var_98_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_8.prefab_name].transform, "story_v_out_317103", "317103024", "story_v_out_317103.awb")

						arg_95_1:RecordAudio("317103024", var_98_13)
						arg_95_1:RecordAudio("317103024", var_98_13)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317103", "317103024", "story_v_out_317103.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317103", "317103024", "story_v_out_317103.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play317103025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317103025
		arg_99_1.duration_ = 10.73

		local var_99_0 = {
			zh = 10.733,
			ja = 9.933
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
				arg_99_0:Play317103026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["2078ui_story"]) and arg_99_1.var_.characterEffect2078ui_story == nil then
				arg_99_1.var_.characterEffect2078ui_story = arg_99_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["2078ui_story"]) then
				if arg_99_1.var_.characterEffect2078ui_story and not isNil(arg_99_1.actors_["2078ui_story"]) then
					arg_99_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["2078ui_story"]) and arg_99_1.var_.characterEffect2078ui_story then
				arg_99_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_102_2 = arg_99_1.actors_["2078ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos2078ui_story = var_102_2.localPosition
			end

			local var_102_3 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_99_1.time_ - 0) / var_102_3)
				var_102_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_2.position).x, (manager.ui.mainCamera.transform.position - var_102_2.position).y, (manager.ui.mainCamera.transform.position - var_102_2.position).z)
				var_102_2.localEulerAngles.z = 0
				var_102_2.localEulerAngles.x = 0
				var_102_2.localEulerAngles = var_102_2.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(0, -1.28, -5.6)
				var_102_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_2.position).x, (manager.ui.mainCamera.transform.position - var_102_2.position).y, (manager.ui.mainCamera.transform.position - var_102_2.position).z)
				var_102_2.localEulerAngles.z = 0
				var_102_2.localEulerAngles.x = 0
				var_102_2.localEulerAngles = var_102_2.localEulerAngles
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_102_4 = arg_99_1.actors_["1093ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1093ui_story = var_102_4.localPosition
			end

			local var_102_5 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				var_102_4.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_5)
				var_102_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_4.position).x, (manager.ui.mainCamera.transform.position - var_102_4.position).y, (manager.ui.mainCamera.transform.position - var_102_4.position).z)
				var_102_4.localEulerAngles.z = 0
				var_102_4.localEulerAngles.x = 0
				var_102_4.localEulerAngles = var_102_4.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				var_102_4.localPosition = Vector3.New(0, 100, 0)
				var_102_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_4.position).x, (manager.ui.mainCamera.transform.position - var_102_4.position).y, (manager.ui.mainCamera.transform.position - var_102_4.position).z)
				var_102_4.localEulerAngles.z = 0
				var_102_4.localEulerAngles.x = 0
				var_102_4.localEulerAngles = var_102_4.localEulerAngles
			end

			local var_102_6 = 0
			local var_102_7 = 1.075

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(317103025)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 43 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 43)

				if (43 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 43)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103025", "story_v_out_317103.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103025", "story_v_out_317103.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_317103", "317103025", "story_v_out_317103.awb")

						arg_99_1:RecordAudio("317103025", var_102_13)
						arg_99_1:RecordAudio("317103025", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317103", "317103025", "story_v_out_317103.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317103", "317103025", "story_v_out_317103.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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

		arg_99_1:InitPlayNodeList()
	end,
	Play317103026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317103026
		arg_103_1.duration_ = 6.83

		local var_103_0 = {
			zh = 5,
			ja = 6.833
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play317103027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.575

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(317103026)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 23 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 23)

				if (23 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 23)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103026", "story_v_out_317103.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_317103", "317103026", "story_v_out_317103.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_317103", "317103026", "story_v_out_317103.awb")

						arg_103_1:RecordAudio("317103026", var_106_6)
						arg_103_1:RecordAudio("317103026", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317103", "317103026", "story_v_out_317103.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317103", "317103026", "story_v_out_317103.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play317103027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317103027
		arg_107_1.duration_ = 8.23

		local var_107_0 = {
			zh = 8.233,
			ja = 6.633
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
				arg_107_0:Play317103028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) and arg_107_1.var_.characterEffect2079ui_story == nil then
				arg_107_1.var_.characterEffect2079ui_story = arg_107_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) then
				if arg_107_1.var_.characterEffect2079ui_story and not isNil(arg_107_1.actors_["2079ui_story"]) then
					arg_107_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) and arg_107_1.var_.characterEffect2079ui_story then
				arg_107_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_110_2 = arg_107_1.actors_["2079ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos2079ui_story = var_110_2.localPosition
			end

			local var_110_3 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_107_1.time_ - 0) / var_110_3)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(0, -1.28, -5.6)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_110_4 = arg_107_1.actors_["2078ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos2078ui_story = var_110_4.localPosition
			end

			local var_110_5 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(0, 100, 0)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			local var_110_6 = 0
			local var_110_7 = 0.85

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(317103027)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 34 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 34)

				if (34 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 34)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103027", "story_v_out_317103.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103027", "story_v_out_317103.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_317103", "317103027", "story_v_out_317103.awb")

						arg_107_1:RecordAudio("317103027", var_110_13)
						arg_107_1:RecordAudio("317103027", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317103", "317103027", "story_v_out_317103.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317103", "317103027", "story_v_out_317103.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play317103028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317103028
		arg_111_1.duration_ = 9.8

		local var_111_0 = {
			zh = 9,
			ja = 9.8
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play317103029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1015ui_story"]) and arg_111_1.var_.characterEffect1015ui_story == nil then
				arg_111_1.var_.characterEffect1015ui_story = arg_111_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1015ui_story"]) then
				if arg_111_1.var_.characterEffect1015ui_story and not isNil(arg_111_1.actors_["1015ui_story"]) then
					arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1015ui_story"]) and arg_111_1.var_.characterEffect1015ui_story then
				arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_114_2 = arg_111_1.actors_["2078ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect2078ui_story == nil then
				arg_111_1.var_.characterEffect2078ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect2078ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_111_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_3)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect2078ui_story then
				arg_111_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_111_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_114_4 = arg_111_1.actors_["1015ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1015ui_story = var_114_4.localPosition
			end

			local var_114_5 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 then
				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_111_1.time_ - 0) / var_114_5)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0, -1.15, -6.2)
				var_114_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_4.position).x, (manager.ui.mainCamera.transform.position - var_114_4.position).y, (manager.ui.mainCamera.transform.position - var_114_4.position).z)
				var_114_4.localEulerAngles.z = 0
				var_114_4.localEulerAngles.x = 0
				var_114_4.localEulerAngles = var_114_4.localEulerAngles
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_6 = arg_111_1.actors_["2079ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos2079ui_story = var_114_6.localPosition
			end

			local var_114_7 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				var_114_6.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_7)
				var_114_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_6.position).x, (manager.ui.mainCamera.transform.position - var_114_6.position).y, (manager.ui.mainCamera.transform.position - var_114_6.position).z)
				var_114_6.localEulerAngles.z = 0
				var_114_6.localEulerAngles.x = 0
				var_114_6.localEulerAngles = var_114_6.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				var_114_6.localPosition = Vector3.New(0, 100, 0)
				var_114_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_6.position).x, (manager.ui.mainCamera.transform.position - var_114_6.position).y, (manager.ui.mainCamera.transform.position - var_114_6.position).z)
				var_114_6.localEulerAngles.z = 0
				var_114_6.localEulerAngles.x = 0
				var_114_6.localEulerAngles = var_114_6.localEulerAngles
			end

			local var_114_8 = 0
			local var_114_9 = 1.3

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(317103028)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 52 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 52)

				if (52 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 52)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103028", "story_v_out_317103.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_317103", "317103028", "story_v_out_317103.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_317103", "317103028", "story_v_out_317103.awb")

						arg_111_1:RecordAudio("317103028", var_114_15)
						arg_111_1:RecordAudio("317103028", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317103", "317103028", "story_v_out_317103.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317103", "317103028", "story_v_out_317103.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play317103029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317103029
		arg_115_1.duration_ = 3.9

		local var_115_0 = {
			zh = 1.999999999999,
			ja = 3.9
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
				arg_115_0:Play317103030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1093ui_story"]) and arg_115_1.var_.characterEffect1093ui_story == nil then
				arg_115_1.var_.characterEffect1093ui_story = arg_115_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1093ui_story"]) then
				if arg_115_1.var_.characterEffect1093ui_story and not isNil(arg_115_1.actors_["1093ui_story"]) then
					arg_115_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1093ui_story"]) and arg_115_1.var_.characterEffect1093ui_story then
				arg_115_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_118_2 = arg_115_1.actors_["1093ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1093ui_story = var_118_2.localPosition
			end

			local var_118_3 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_115_1.time_ - 0) / var_118_3)
				var_118_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_2.position).x, (manager.ui.mainCamera.transform.position - var_118_2.position).y, (manager.ui.mainCamera.transform.position - var_118_2.position).z)
				var_118_2.localEulerAngles.z = 0
				var_118_2.localEulerAngles.x = 0
				var_118_2.localEulerAngles = var_118_2.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_118_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_2.position).x, (manager.ui.mainCamera.transform.position - var_118_2.position).y, (manager.ui.mainCamera.transform.position - var_118_2.position).z)
				var_118_2.localEulerAngles.z = 0
				var_118_2.localEulerAngles.x = 0
				var_118_2.localEulerAngles = var_118_2.localEulerAngles
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_4 = arg_115_1.actors_["1015ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1015ui_story = var_118_4.localPosition
			end

			local var_118_5 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_5)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(0, 100, 0)
				var_118_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_4.position).x, (manager.ui.mainCamera.transform.position - var_118_4.position).y, (manager.ui.mainCamera.transform.position - var_118_4.position).z)
				var_118_4.localEulerAngles.z = 0
				var_118_4.localEulerAngles.x = 0
				var_118_4.localEulerAngles = var_118_4.localEulerAngles
			end

			local var_118_6 = 0
			local var_118_7 = 0.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(317103029)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 5 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 5)

				if (5 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 5)) > 0 and var_118_7 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103029", "story_v_out_317103.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103029", "story_v_out_317103.awb") / 1000

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_317103", "317103029", "story_v_out_317103.awb")

						arg_115_1:RecordAudio("317103029", var_118_13)
						arg_115_1:RecordAudio("317103029", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317103", "317103029", "story_v_out_317103.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317103", "317103029", "story_v_out_317103.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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

		arg_115_1:InitPlayNodeList()
	end,
	Play317103030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317103030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play317103031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1093ui_story"]) and arg_119_1.var_.characterEffect1093ui_story == nil then
				arg_119_1.var_.characterEffect1093ui_story = arg_119_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1093ui_story"]) then
				if arg_119_1.var_.characterEffect1093ui_story and not isNil(arg_119_1.actors_["1093ui_story"]) then
					arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1093ui_story"]) and arg_119_1.var_.characterEffect1093ui_story then
				arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.725

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(317103030).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 29 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 29)

				if (29 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 29)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play317103031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 317103031
		arg_123_1.duration_ = 2

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play317103032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1015ui_story"]) and arg_123_1.var_.characterEffect1015ui_story == nil then
				arg_123_1.var_.characterEffect1015ui_story = arg_123_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1015ui_story"]) then
				if arg_123_1.var_.characterEffect1015ui_story and not isNil(arg_123_1.actors_["1015ui_story"]) then
					arg_123_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1015ui_story"]) and arg_123_1.var_.characterEffect1015ui_story then
				arg_123_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["1015ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1015ui_story = var_126_2.localPosition
			end

			local var_126_3 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_123_1.time_ - 0) / var_126_3)
				var_126_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_2.position).x, (manager.ui.mainCamera.transform.position - var_126_2.position).y, (manager.ui.mainCamera.transform.position - var_126_2.position).z)
				var_126_2.localEulerAngles.z = 0
				var_126_2.localEulerAngles.x = 0
				var_126_2.localEulerAngles = var_126_2.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, -1.15, -6.2)
				var_126_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_2.position).x, (manager.ui.mainCamera.transform.position - var_126_2.position).y, (manager.ui.mainCamera.transform.position - var_126_2.position).z)
				var_126_2.localEulerAngles.z = 0
				var_126_2.localEulerAngles.x = 0
				var_126_2.localEulerAngles = var_126_2.localEulerAngles
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = arg_123_1.actors_["1093ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1093ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(0, 100, 0)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = 0
			local var_126_7 = 0.075

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(317103031)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 3 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 3)

				if (3 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 3)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103031", "story_v_out_317103.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103031", "story_v_out_317103.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_317103", "317103031", "story_v_out_317103.awb")

						arg_123_1:RecordAudio("317103031", var_126_13)
						arg_123_1:RecordAudio("317103031", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_317103", "317103031", "story_v_out_317103.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_317103", "317103031", "story_v_out_317103.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play317103032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 317103032
		arg_127_1.duration_ = 7.93

		local var_127_0 = {
			zh = 4.9,
			ja = 7.933
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play317103033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1093ui_story"]) and arg_127_1.var_.characterEffect1093ui_story == nil then
				arg_127_1.var_.characterEffect1093ui_story = arg_127_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1093ui_story"]) then
				if arg_127_1.var_.characterEffect1093ui_story and not isNil(arg_127_1.actors_["1093ui_story"]) then
					arg_127_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1093ui_story"]) and arg_127_1.var_.characterEffect1093ui_story then
				arg_127_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["1093ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1093ui_story = var_130_2.localPosition
			end

			local var_130_3 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_127_1.time_ - 0) / var_130_3)
				var_130_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_2.position).x, (manager.ui.mainCamera.transform.position - var_130_2.position).y, (manager.ui.mainCamera.transform.position - var_130_2.position).z)
				var_130_2.localEulerAngles.z = 0
				var_130_2.localEulerAngles.x = 0
				var_130_2.localEulerAngles = var_130_2.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_130_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_2.position).x, (manager.ui.mainCamera.transform.position - var_130_2.position).y, (manager.ui.mainCamera.transform.position - var_130_2.position).z)
				var_130_2.localEulerAngles.z = 0
				var_130_2.localEulerAngles.x = 0
				var_130_2.localEulerAngles = var_130_2.localEulerAngles
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_130_4 = arg_127_1.actors_["1015ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1015ui_story = var_130_4.localPosition
			end

			local var_130_5 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_5)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, 100, 0)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			local var_130_6 = 0
			local var_130_7 = 0.425

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(317103032)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 17 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 17)

				if (17 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 17)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103032", "story_v_out_317103.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103032", "story_v_out_317103.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_317103", "317103032", "story_v_out_317103.awb")

						arg_127_1:RecordAudio("317103032", var_130_13)
						arg_127_1:RecordAudio("317103032", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_317103", "317103032", "story_v_out_317103.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_317103", "317103032", "story_v_out_317103.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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

		arg_127_1:InitPlayNodeList()
	end,
	Play317103033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 317103033
		arg_131_1.duration_ = 6.57

		local var_131_0 = {
			zh = 3.5,
			ja = 6.566
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
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1015ui_story"]) and arg_131_1.var_.characterEffect1015ui_story == nil then
				arg_131_1.var_.characterEffect1015ui_story = arg_131_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1015ui_story"]) then
				if arg_131_1.var_.characterEffect1015ui_story and not isNil(arg_131_1.actors_["1015ui_story"]) then
					arg_131_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1015ui_story"]) and arg_131_1.var_.characterEffect1015ui_story then
				arg_131_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["1015ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1015ui_story = var_134_2.localPosition
			end

			local var_134_3 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_131_1.time_ - 0) / var_134_3)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -1.15, -6.2)
				var_134_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_2.position).x, (manager.ui.mainCamera.transform.position - var_134_2.position).y, (manager.ui.mainCamera.transform.position - var_134_2.position).z)
				var_134_2.localEulerAngles.z = 0
				var_134_2.localEulerAngles.x = 0
				var_134_2.localEulerAngles = var_134_2.localEulerAngles
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = arg_131_1.actors_["1093ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1093ui_story = var_134_4.localPosition
			end

			local var_134_5 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 then
				var_134_4.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_5)
				var_134_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_4.position).x, (manager.ui.mainCamera.transform.position - var_134_4.position).y, (manager.ui.mainCamera.transform.position - var_134_4.position).z)
				var_134_4.localEulerAngles.z = 0
				var_134_4.localEulerAngles.x = 0
				var_134_4.localEulerAngles = var_134_4.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 then
				var_134_4.localPosition = Vector3.New(0, 100, 0)
				var_134_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_4.position).x, (manager.ui.mainCamera.transform.position - var_134_4.position).y, (manager.ui.mainCamera.transform.position - var_134_4.position).z)
				var_134_4.localEulerAngles.z = 0
				var_134_4.localEulerAngles.x = 0
				var_134_4.localEulerAngles = var_134_4.localEulerAngles
			end

			local var_134_6 = 0
			local var_134_7 = 0.35

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(317103033)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 14 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 14)

				if (14 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 14)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103033", "story_v_out_317103.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_317103", "317103033", "story_v_out_317103.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_317103", "317103033", "story_v_out_317103.awb")

						arg_131_1:RecordAudio("317103033", var_134_13)
						arg_131_1:RecordAudio("317103033", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317103", "317103033", "story_v_out_317103.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317103", "317103033", "story_v_out_317103.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f"
	},
	voices = {
		"story_v_out_317103.awb"
	}
}
