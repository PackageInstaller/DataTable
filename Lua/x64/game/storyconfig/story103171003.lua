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
			local var_4_0 = "K09f"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.K09f

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.675

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(317103001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 27
				local var_4_28 = utf8.len(var_4_26)
				local var_4_29 = var_4_27 <= 0 and var_4_23 or var_4_23 * (var_4_28 / var_4_27)

				if var_4_29 > 0 and var_4_23 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_22 = var_4_22 + 0.3

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_22 + 0.3
			local var_4_31 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
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
			local var_10_0 = "1015ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Asset.Load("Char/" .. "1015ui_story")

				if not isNil(var_10_1) then
					local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_7_1.stage_.transform)

					var_10_2.name = var_10_0
					var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_0] = var_10_2

					local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

					var_10_3.enabled = true

					local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

					if var_10_4 then
						var_10_4:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_3.transform, false)

					arg_7_1.var_[var_10_0 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_5 = arg_7_1.actors_["1015ui_story"]
			local var_10_6 = 0

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1015ui_story == nil then
				arg_7_1.var_.characterEffect1015ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_7 = 0.200000002980232

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_7 and not isNil(var_10_5) then
				local var_10_8 = (arg_7_1.time_ - var_10_6) / var_10_7

				if arg_7_1.var_.characterEffect1015ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_6 + var_10_7 and arg_7_1.time_ < var_10_6 + var_10_7 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1015ui_story then
				arg_7_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_10_9 = "1093ui_story"

			if arg_7_1.actors_[var_10_9] == nil then
				local var_10_10 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_10_10) then
					local var_10_11 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_7_1.stage_.transform)

					var_10_11.name = var_10_9
					var_10_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_9] = var_10_11

					local var_10_12 = var_10_11:GetComponentInChildren(typeof(CharacterEffect))

					var_10_12.enabled = true

					local var_10_13 = GameObjectTools.GetOrAddComponent(var_10_11, typeof(DynamicBoneHelper))

					if var_10_13 then
						var_10_13:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_12.transform, false)

					arg_7_1.var_[var_10_9 .. "Animator"] = var_10_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_9 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_9 .. "LipSync"] = var_10_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_14 = arg_7_1.actors_["1093ui_story"]
			local var_10_15 = 0

			if var_10_15 < arg_7_1.time_ and arg_7_1.time_ <= var_10_15 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1093ui_story == nil then
				arg_7_1.var_.characterEffect1093ui_story = var_10_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_16 = 0.200000002980232

			if var_10_15 <= arg_7_1.time_ and arg_7_1.time_ < var_10_15 + var_10_16 and not isNil(var_10_14) then
				local var_10_17 = (arg_7_1.time_ - var_10_15) / var_10_16

				if arg_7_1.var_.characterEffect1093ui_story and not isNil(var_10_14) then
					local var_10_18 = Mathf.Lerp(0, 0.5, var_10_17)

					arg_7_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1093ui_story.fillRatio = var_10_18
				end
			end

			if arg_7_1.time_ >= var_10_15 + var_10_16 and arg_7_1.time_ < var_10_15 + var_10_16 + arg_10_0 and not isNil(var_10_14) and arg_7_1.var_.characterEffect1093ui_story then
				local var_10_19 = 0.5

				arg_7_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1093ui_story.fillRatio = var_10_19
			end

			local var_10_20 = arg_7_1.actors_["1015ui_story"].transform
			local var_10_21 = 0

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 then
				arg_7_1.var_.moveOldPos1015ui_story = var_10_20.localPosition
			end

			local var_10_22 = 0.001

			if var_10_21 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_21) / var_10_22
				local var_10_24 = Vector3.New(-0.7, -1.15, -6.2)

				var_10_20.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1015ui_story, var_10_24, var_10_23)

				local var_10_25 = manager.ui.mainCamera.transform.position - var_10_20.position

				var_10_20.forward = Vector3.New(var_10_25.x, var_10_25.y, var_10_25.z)

				local var_10_26 = var_10_20.localEulerAngles

				var_10_26.z = 0
				var_10_26.x = 0
				var_10_20.localEulerAngles = var_10_26
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 then
				var_10_20.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_10_27 = manager.ui.mainCamera.transform.position - var_10_20.position

				var_10_20.forward = Vector3.New(var_10_27.x, var_10_27.y, var_10_27.z)

				local var_10_28 = var_10_20.localEulerAngles

				var_10_28.z = 0
				var_10_28.x = 0
				var_10_20.localEulerAngles = var_10_28
			end

			local var_10_29 = 0

			if var_10_29 < arg_7_1.time_ and arg_7_1.time_ <= var_10_29 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_10_30 = 0

			if var_10_30 < arg_7_1.time_ and arg_7_1.time_ <= var_10_30 + arg_10_0 then
				arg_7_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_10_31 = arg_7_1.actors_["1093ui_story"].transform
			local var_10_32 = 0

			if var_10_32 < arg_7_1.time_ and arg_7_1.time_ <= var_10_32 + arg_10_0 then
				arg_7_1.var_.moveOldPos1093ui_story = var_10_31.localPosition
			end

			local var_10_33 = 0.001

			if var_10_32 <= arg_7_1.time_ and arg_7_1.time_ < var_10_32 + var_10_33 then
				local var_10_34 = (arg_7_1.time_ - var_10_32) / var_10_33
				local var_10_35 = Vector3.New(0.7, -1.11, -5.88)

				var_10_31.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1093ui_story, var_10_35, var_10_34)

				local var_10_36 = manager.ui.mainCamera.transform.position - var_10_31.position

				var_10_31.forward = Vector3.New(var_10_36.x, var_10_36.y, var_10_36.z)

				local var_10_37 = var_10_31.localEulerAngles

				var_10_37.z = 0
				var_10_37.x = 0
				var_10_31.localEulerAngles = var_10_37
			end

			if arg_7_1.time_ >= var_10_32 + var_10_33 and arg_7_1.time_ < var_10_32 + var_10_33 + arg_10_0 then
				var_10_31.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_10_38 = manager.ui.mainCamera.transform.position - var_10_31.position

				var_10_31.forward = Vector3.New(var_10_38.x, var_10_38.y, var_10_38.z)

				local var_10_39 = var_10_31.localEulerAngles

				var_10_39.z = 0
				var_10_39.x = 0
				var_10_31.localEulerAngles = var_10_39
			end

			local var_10_40 = 0

			if var_10_40 < arg_7_1.time_ and arg_7_1.time_ <= var_10_40 + arg_10_0 then
				arg_7_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_10_41 = 0
			local var_10_42 = 0.55

			if var_10_41 < arg_7_1.time_ and arg_7_1.time_ <= var_10_41 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_43 = arg_7_1:FormatText(StoryNameCfg[479].name)

				arg_7_1.leftNameTxt_.text = var_10_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_44 = arg_7_1:GetWordFromCfg(317103002)
				local var_10_45 = arg_7_1:FormatText(var_10_44.content)

				arg_7_1.text_.text = var_10_45

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_46 = 22
				local var_10_47 = utf8.len(var_10_45)
				local var_10_48 = var_10_46 <= 0 and var_10_42 or var_10_42 * (var_10_47 / var_10_46)

				if var_10_48 > 0 and var_10_42 < var_10_48 then
					arg_7_1.talkMaxDuration = var_10_48

					if var_10_48 + var_10_41 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_48 + var_10_41
					end
				end

				arg_7_1.text_.text = var_10_45
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103002", "story_v_out_317103.awb") ~= 0 then
					local var_10_49 = manager.audio:GetVoiceLength("story_v_out_317103", "317103002", "story_v_out_317103.awb") / 1000

					if var_10_49 + var_10_41 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_49 + var_10_41
					end

					if var_10_44.prefab_name ~= "" and arg_7_1.actors_[var_10_44.prefab_name] ~= nil then
						local var_10_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_44.prefab_name].transform, "story_v_out_317103", "317103002", "story_v_out_317103.awb")

						arg_7_1:RecordAudio("317103002", var_10_50)
						arg_7_1:RecordAudio("317103002", var_10_50)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_317103", "317103002", "story_v_out_317103.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_317103", "317103002", "story_v_out_317103.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_51 = math.max(var_10_42, arg_7_1.talkMaxDuration)

			if var_10_41 <= arg_7_1.time_ and arg_7_1.time_ < var_10_41 + var_10_51 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_41) / var_10_51

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_41 + var_10_51 and arg_7_1.time_ < var_10_41 + var_10_51 + arg_10_0 then
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
			local var_14_0 = arg_11_1.actors_["1015ui_story"].transform
			local var_14_1 = 0

			if var_14_1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_1 + arg_14_0 then
				arg_11_1.var_.moveOldPos1015ui_story = var_14_0.localPosition
			end

			local var_14_2 = 0.001

			if var_14_1 <= arg_11_1.time_ and arg_11_1.time_ < var_14_1 + var_14_2 then
				local var_14_3 = (arg_11_1.time_ - var_14_1) / var_14_2
				local var_14_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_14_0.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1015ui_story, var_14_4, var_14_3)

				local var_14_5 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_5.x, var_14_5.y, var_14_5.z)

				local var_14_6 = var_14_0.localEulerAngles

				var_14_6.z = 0
				var_14_6.x = 0
				var_14_0.localEulerAngles = var_14_6
			end

			if arg_11_1.time_ >= var_14_1 + var_14_2 and arg_11_1.time_ < var_14_1 + var_14_2 + arg_14_0 then
				var_14_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_14_7 = manager.ui.mainCamera.transform.position - var_14_0.position

				var_14_0.forward = Vector3.New(var_14_7.x, var_14_7.y, var_14_7.z)

				local var_14_8 = var_14_0.localEulerAngles

				var_14_8.z = 0
				var_14_8.x = 0
				var_14_0.localEulerAngles = var_14_8
			end

			local var_14_9 = arg_11_1.actors_["1093ui_story"].transform
			local var_14_10 = 0

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 then
				arg_11_1.var_.moveOldPos1093ui_story = var_14_9.localPosition
			end

			local var_14_11 = 0.001

			if var_14_10 <= arg_11_1.time_ and arg_11_1.time_ < var_14_10 + var_14_11 then
				local var_14_12 = (arg_11_1.time_ - var_14_10) / var_14_11
				local var_14_13 = Vector3.New(0.7, -1.11, -5.88)

				var_14_9.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1093ui_story, var_14_13, var_14_12)

				local var_14_14 = manager.ui.mainCamera.transform.position - var_14_9.position

				var_14_9.forward = Vector3.New(var_14_14.x, var_14_14.y, var_14_14.z)

				local var_14_15 = var_14_9.localEulerAngles

				var_14_15.z = 0
				var_14_15.x = 0
				var_14_9.localEulerAngles = var_14_15
			end

			if arg_11_1.time_ >= var_14_10 + var_14_11 and arg_11_1.time_ < var_14_10 + var_14_11 + arg_14_0 then
				var_14_9.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_14_16 = manager.ui.mainCamera.transform.position - var_14_9.position

				var_14_9.forward = Vector3.New(var_14_16.x, var_14_16.y, var_14_16.z)

				local var_14_17 = var_14_9.localEulerAngles

				var_14_17.z = 0
				var_14_17.x = 0
				var_14_9.localEulerAngles = var_14_17
			end

			local var_14_18 = 0

			if var_14_18 < arg_11_1.time_ and arg_11_1.time_ <= var_14_18 + arg_14_0 then
				arg_11_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_14_19 = 0

			if var_14_19 < arg_11_1.time_ and arg_11_1.time_ <= var_14_19 + arg_14_0 then
				arg_11_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_14_20 = arg_11_1.actors_["1015ui_story"]
			local var_14_21 = 0

			if var_14_21 < arg_11_1.time_ and arg_11_1.time_ <= var_14_21 + arg_14_0 and not isNil(var_14_20) and arg_11_1.var_.characterEffect1015ui_story == nil then
				arg_11_1.var_.characterEffect1015ui_story = var_14_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_22 = 0.200000002980232

			if var_14_21 <= arg_11_1.time_ and arg_11_1.time_ < var_14_21 + var_14_22 and not isNil(var_14_20) then
				local var_14_23 = (arg_11_1.time_ - var_14_21) / var_14_22

				if arg_11_1.var_.characterEffect1015ui_story and not isNil(var_14_20) then
					local var_14_24 = Mathf.Lerp(0, 0.5, var_14_23)

					arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1015ui_story.fillRatio = var_14_24
				end
			end

			if arg_11_1.time_ >= var_14_21 + var_14_22 and arg_11_1.time_ < var_14_21 + var_14_22 + arg_14_0 and not isNil(var_14_20) and arg_11_1.var_.characterEffect1015ui_story then
				local var_14_25 = 0.5

				arg_11_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1015ui_story.fillRatio = var_14_25
			end

			local var_14_26 = arg_11_1.actors_["1093ui_story"]
			local var_14_27 = 0

			if var_14_27 < arg_11_1.time_ and arg_11_1.time_ <= var_14_27 + arg_14_0 and not isNil(var_14_26) and arg_11_1.var_.characterEffect1093ui_story == nil then
				arg_11_1.var_.characterEffect1093ui_story = var_14_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_28 = 0.200000002980232

			if var_14_27 <= arg_11_1.time_ and arg_11_1.time_ < var_14_27 + var_14_28 and not isNil(var_14_26) then
				local var_14_29 = (arg_11_1.time_ - var_14_27) / var_14_28

				if arg_11_1.var_.characterEffect1093ui_story and not isNil(var_14_26) then
					arg_11_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_27 + var_14_28 and arg_11_1.time_ < var_14_27 + var_14_28 + arg_14_0 and not isNil(var_14_26) and arg_11_1.var_.characterEffect1093ui_story then
				arg_11_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_14_30 = 0
			local var_14_31 = 0.875

			if var_14_30 < arg_11_1.time_ and arg_11_1.time_ <= var_14_30 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_32 = arg_11_1:FormatText(StoryNameCfg[73].name)

				arg_11_1.leftNameTxt_.text = var_14_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_33 = arg_11_1:GetWordFromCfg(317103003)
				local var_14_34 = arg_11_1:FormatText(var_14_33.content)

				arg_11_1.text_.text = var_14_34

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_35 = 35
				local var_14_36 = utf8.len(var_14_34)
				local var_14_37 = var_14_35 <= 0 and var_14_31 or var_14_31 * (var_14_36 / var_14_35)

				if var_14_37 > 0 and var_14_31 < var_14_37 then
					arg_11_1.talkMaxDuration = var_14_37

					if var_14_37 + var_14_30 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_37 + var_14_30
					end
				end

				arg_11_1.text_.text = var_14_34
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103003", "story_v_out_317103.awb") ~= 0 then
					local var_14_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103003", "story_v_out_317103.awb") / 1000

					if var_14_38 + var_14_30 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_38 + var_14_30
					end

					if var_14_33.prefab_name ~= "" and arg_11_1.actors_[var_14_33.prefab_name] ~= nil then
						local var_14_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_33.prefab_name].transform, "story_v_out_317103", "317103003", "story_v_out_317103.awb")

						arg_11_1:RecordAudio("317103003", var_14_39)
						arg_11_1:RecordAudio("317103003", var_14_39)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_317103", "317103003", "story_v_out_317103.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_317103", "317103003", "story_v_out_317103.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_40 = math.max(var_14_31, arg_11_1.talkMaxDuration)

			if var_14_30 <= arg_11_1.time_ and arg_11_1.time_ < var_14_30 + var_14_40 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_30) / var_14_40

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_30 + var_14_40 and arg_11_1.time_ < var_14_30 + var_14_40 + arg_14_0 then
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
			local var_18_0 = arg_15_1.actors_["1015ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1015ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1015ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = 0

			if var_18_9 < arg_15_1.time_ and arg_15_1.time_ <= var_18_9 + arg_18_0 then
				arg_15_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_18_11 = arg_15_1.actors_["1093ui_story"].transform
			local var_18_12 = 0

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.var_.moveOldPos1093ui_story = var_18_11.localPosition
			end

			local var_18_13 = 0.001

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_13 then
				local var_18_14 = (arg_15_1.time_ - var_18_12) / var_18_13
				local var_18_15 = Vector3.New(0.7, -1.11, -5.88)

				var_18_11.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1093ui_story, var_18_15, var_18_14)

				local var_18_16 = manager.ui.mainCamera.transform.position - var_18_11.position

				var_18_11.forward = Vector3.New(var_18_16.x, var_18_16.y, var_18_16.z)

				local var_18_17 = var_18_11.localEulerAngles

				var_18_17.z = 0
				var_18_17.x = 0
				var_18_11.localEulerAngles = var_18_17
			end

			if arg_15_1.time_ >= var_18_12 + var_18_13 and arg_15_1.time_ < var_18_12 + var_18_13 + arg_18_0 then
				var_18_11.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_18_18 = manager.ui.mainCamera.transform.position - var_18_11.position

				var_18_11.forward = Vector3.New(var_18_18.x, var_18_18.y, var_18_18.z)

				local var_18_19 = var_18_11.localEulerAngles

				var_18_19.z = 0
				var_18_19.x = 0
				var_18_11.localEulerAngles = var_18_19
			end

			local var_18_20 = arg_15_1.actors_["1015ui_story"]
			local var_18_21 = 0

			if var_18_21 < arg_15_1.time_ and arg_15_1.time_ <= var_18_21 + arg_18_0 and not isNil(var_18_20) and arg_15_1.var_.characterEffect1015ui_story == nil then
				arg_15_1.var_.characterEffect1015ui_story = var_18_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_22 = 0.200000002980232

			if var_18_21 <= arg_15_1.time_ and arg_15_1.time_ < var_18_21 + var_18_22 and not isNil(var_18_20) then
				local var_18_23 = (arg_15_1.time_ - var_18_21) / var_18_22

				if arg_15_1.var_.characterEffect1015ui_story and not isNil(var_18_20) then
					arg_15_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_21 + var_18_22 and arg_15_1.time_ < var_18_21 + var_18_22 + arg_18_0 and not isNil(var_18_20) and arg_15_1.var_.characterEffect1015ui_story then
				arg_15_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_18_24 = arg_15_1.actors_["1093ui_story"]
			local var_18_25 = 0

			if var_18_25 < arg_15_1.time_ and arg_15_1.time_ <= var_18_25 + arg_18_0 and not isNil(var_18_24) and arg_15_1.var_.characterEffect1093ui_story == nil then
				arg_15_1.var_.characterEffect1093ui_story = var_18_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_26 = 0.200000002980232

			if var_18_25 <= arg_15_1.time_ and arg_15_1.time_ < var_18_25 + var_18_26 and not isNil(var_18_24) then
				local var_18_27 = (arg_15_1.time_ - var_18_25) / var_18_26

				if arg_15_1.var_.characterEffect1093ui_story and not isNil(var_18_24) then
					local var_18_28 = Mathf.Lerp(0, 0.5, var_18_27)

					arg_15_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1093ui_story.fillRatio = var_18_28
				end
			end

			if arg_15_1.time_ >= var_18_25 + var_18_26 and arg_15_1.time_ < var_18_25 + var_18_26 + arg_18_0 and not isNil(var_18_24) and arg_15_1.var_.characterEffect1093ui_story then
				local var_18_29 = 0.5

				arg_15_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1093ui_story.fillRatio = var_18_29
			end

			local var_18_30 = 0
			local var_18_31 = 0.55

			if var_18_30 < arg_15_1.time_ and arg_15_1.time_ <= var_18_30 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_32 = arg_15_1:FormatText(StoryNameCfg[479].name)

				arg_15_1.leftNameTxt_.text = var_18_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_33 = arg_15_1:GetWordFromCfg(317103004)
				local var_18_34 = arg_15_1:FormatText(var_18_33.content)

				arg_15_1.text_.text = var_18_34

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_35 = 22
				local var_18_36 = utf8.len(var_18_34)
				local var_18_37 = var_18_35 <= 0 and var_18_31 or var_18_31 * (var_18_36 / var_18_35)

				if var_18_37 > 0 and var_18_31 < var_18_37 then
					arg_15_1.talkMaxDuration = var_18_37

					if var_18_37 + var_18_30 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_37 + var_18_30
					end
				end

				arg_15_1.text_.text = var_18_34
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103004", "story_v_out_317103.awb") ~= 0 then
					local var_18_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103004", "story_v_out_317103.awb") / 1000

					if var_18_38 + var_18_30 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_38 + var_18_30
					end

					if var_18_33.prefab_name ~= "" and arg_15_1.actors_[var_18_33.prefab_name] ~= nil then
						local var_18_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_33.prefab_name].transform, "story_v_out_317103", "317103004", "story_v_out_317103.awb")

						arg_15_1:RecordAudio("317103004", var_18_39)
						arg_15_1:RecordAudio("317103004", var_18_39)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_317103", "317103004", "story_v_out_317103.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_317103", "317103004", "story_v_out_317103.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_40 = math.max(var_18_31, arg_15_1.talkMaxDuration)

			if var_18_30 <= arg_15_1.time_ and arg_15_1.time_ < var_18_30 + var_18_40 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_30) / var_18_40

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_30 + var_18_40 and arg_15_1.time_ < var_18_30 + var_18_40 + arg_18_0 then
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
			local var_22_0 = arg_19_1.actors_["1015ui_story"].transform
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.var_.moveOldPos1015ui_story = var_22_0.localPosition
			end

			local var_22_2 = 0.001

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2
				local var_22_4 = Vector3.New(0, 100, 0)

				var_22_0.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1015ui_story, var_22_4, var_22_3)

				local var_22_5 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_5.x, var_22_5.y, var_22_5.z)

				local var_22_6 = var_22_0.localEulerAngles

				var_22_6.z = 0
				var_22_6.x = 0
				var_22_0.localEulerAngles = var_22_6
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 then
				var_22_0.localPosition = Vector3.New(0, 100, 0)

				local var_22_7 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_7.x, var_22_7.y, var_22_7.z)

				local var_22_8 = var_22_0.localEulerAngles

				var_22_8.z = 0
				var_22_8.x = 0
				var_22_0.localEulerAngles = var_22_8
			end

			local var_22_9 = arg_19_1.actors_["1093ui_story"].transform
			local var_22_10 = 0

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.var_.moveOldPos1093ui_story = var_22_9.localPosition
			end

			local var_22_11 = 0.001

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_11 then
				local var_22_12 = (arg_19_1.time_ - var_22_10) / var_22_11
				local var_22_13 = Vector3.New(0, 100, 0)

				var_22_9.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1093ui_story, var_22_13, var_22_12)

				local var_22_14 = manager.ui.mainCamera.transform.position - var_22_9.position

				var_22_9.forward = Vector3.New(var_22_14.x, var_22_14.y, var_22_14.z)

				local var_22_15 = var_22_9.localEulerAngles

				var_22_15.z = 0
				var_22_15.x = 0
				var_22_9.localEulerAngles = var_22_15
			end

			if arg_19_1.time_ >= var_22_10 + var_22_11 and arg_19_1.time_ < var_22_10 + var_22_11 + arg_22_0 then
				var_22_9.localPosition = Vector3.New(0, 100, 0)

				local var_22_16 = manager.ui.mainCamera.transform.position - var_22_9.position

				var_22_9.forward = Vector3.New(var_22_16.x, var_22_16.y, var_22_16.z)

				local var_22_17 = var_22_9.localEulerAngles

				var_22_17.z = 0
				var_22_17.x = 0
				var_22_9.localEulerAngles = var_22_17
			end

			local var_22_18 = arg_19_1.actors_["1015ui_story"]
			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1015ui_story == nil then
				arg_19_1.var_.characterEffect1015ui_story = var_22_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_20 = 0.200000002980232

			if var_22_19 <= arg_19_1.time_ and arg_19_1.time_ < var_22_19 + var_22_20 and not isNil(var_22_18) then
				local var_22_21 = (arg_19_1.time_ - var_22_19) / var_22_20

				if arg_19_1.var_.characterEffect1015ui_story and not isNil(var_22_18) then
					local var_22_22 = Mathf.Lerp(0, 0.5, var_22_21)

					arg_19_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1015ui_story.fillRatio = var_22_22
				end
			end

			if arg_19_1.time_ >= var_22_19 + var_22_20 and arg_19_1.time_ < var_22_19 + var_22_20 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1015ui_story then
				local var_22_23 = 0.5

				arg_19_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1015ui_story.fillRatio = var_22_23
			end

			local var_22_24 = 0
			local var_22_25 = 0.75

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_26 = arg_19_1:GetWordFromCfg(317103005)
				local var_22_27 = arg_19_1:FormatText(var_22_26.content)

				arg_19_1.text_.text = var_22_27

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_28 = 30
				local var_22_29 = utf8.len(var_22_27)
				local var_22_30 = var_22_28 <= 0 and var_22_25 or var_22_25 * (var_22_29 / var_22_28)

				if var_22_30 > 0 and var_22_25 < var_22_30 then
					arg_19_1.talkMaxDuration = var_22_30

					if var_22_30 + var_22_24 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_30 + var_22_24
					end
				end

				arg_19_1.text_.text = var_22_27
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_31 = math.max(var_22_25, arg_19_1.talkMaxDuration)

			if var_22_24 <= arg_19_1.time_ and arg_19_1.time_ < var_22_24 + var_22_31 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_24) / var_22_31

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_24 + var_22_31 and arg_19_1.time_ < var_22_24 + var_22_31 + arg_22_0 then
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
			local var_26_0 = arg_23_1.actors_["1015ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1015ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1015ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = 0

			if var_26_9 < arg_23_1.time_ and arg_23_1.time_ <= var_26_9 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_11 = arg_23_1.actors_["1093ui_story"].transform
			local var_26_12 = 0

			if var_26_12 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.var_.moveOldPos1093ui_story = var_26_11.localPosition
			end

			local var_26_13 = 0.001

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_13 then
				local var_26_14 = (arg_23_1.time_ - var_26_12) / var_26_13
				local var_26_15 = Vector3.New(0.7, -1.11, -5.88)

				var_26_11.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1093ui_story, var_26_15, var_26_14)

				local var_26_16 = manager.ui.mainCamera.transform.position - var_26_11.position

				var_26_11.forward = Vector3.New(var_26_16.x, var_26_16.y, var_26_16.z)

				local var_26_17 = var_26_11.localEulerAngles

				var_26_17.z = 0
				var_26_17.x = 0
				var_26_11.localEulerAngles = var_26_17
			end

			if arg_23_1.time_ >= var_26_12 + var_26_13 and arg_23_1.time_ < var_26_12 + var_26_13 + arg_26_0 then
				var_26_11.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_26_18 = manager.ui.mainCamera.transform.position - var_26_11.position

				var_26_11.forward = Vector3.New(var_26_18.x, var_26_18.y, var_26_18.z)

				local var_26_19 = var_26_11.localEulerAngles

				var_26_19.z = 0
				var_26_19.x = 0
				var_26_11.localEulerAngles = var_26_19
			end

			local var_26_20 = arg_23_1.actors_["1015ui_story"]
			local var_26_21 = 0

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 and not isNil(var_26_20) and arg_23_1.var_.characterEffect1015ui_story == nil then
				arg_23_1.var_.characterEffect1015ui_story = var_26_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_22 = 0.200000002980232

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_22 and not isNil(var_26_20) then
				local var_26_23 = (arg_23_1.time_ - var_26_21) / var_26_22

				if arg_23_1.var_.characterEffect1015ui_story and not isNil(var_26_20) then
					arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_21 + var_26_22 and arg_23_1.time_ < var_26_21 + var_26_22 + arg_26_0 and not isNil(var_26_20) and arg_23_1.var_.characterEffect1015ui_story then
				arg_23_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_26_24 = arg_23_1.actors_["1093ui_story"]
			local var_26_25 = 0

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 and not isNil(var_26_24) and arg_23_1.var_.characterEffect1093ui_story == nil then
				arg_23_1.var_.characterEffect1093ui_story = var_26_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_26 = 0.200000002980232

			if var_26_25 <= arg_23_1.time_ and arg_23_1.time_ < var_26_25 + var_26_26 and not isNil(var_26_24) then
				local var_26_27 = (arg_23_1.time_ - var_26_25) / var_26_26

				if arg_23_1.var_.characterEffect1093ui_story and not isNil(var_26_24) then
					local var_26_28 = Mathf.Lerp(0, 0.5, var_26_27)

					arg_23_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1093ui_story.fillRatio = var_26_28
				end
			end

			if arg_23_1.time_ >= var_26_25 + var_26_26 and arg_23_1.time_ < var_26_25 + var_26_26 + arg_26_0 and not isNil(var_26_24) and arg_23_1.var_.characterEffect1093ui_story then
				local var_26_29 = 0.5

				arg_23_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1093ui_story.fillRatio = var_26_29
			end

			local var_26_30 = 0
			local var_26_31 = 1.5

			if var_26_30 < arg_23_1.time_ and arg_23_1.time_ <= var_26_30 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_32 = arg_23_1:FormatText(StoryNameCfg[479].name)

				arg_23_1.leftNameTxt_.text = var_26_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_33 = arg_23_1:GetWordFromCfg(317103006)
				local var_26_34 = arg_23_1:FormatText(var_26_33.content)

				arg_23_1.text_.text = var_26_34

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_35 = 60
				local var_26_36 = utf8.len(var_26_34)
				local var_26_37 = var_26_35 <= 0 and var_26_31 or var_26_31 * (var_26_36 / var_26_35)

				if var_26_37 > 0 and var_26_31 < var_26_37 then
					arg_23_1.talkMaxDuration = var_26_37

					if var_26_37 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_37 + var_26_30
					end
				end

				arg_23_1.text_.text = var_26_34
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103006", "story_v_out_317103.awb") ~= 0 then
					local var_26_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103006", "story_v_out_317103.awb") / 1000

					if var_26_38 + var_26_30 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_38 + var_26_30
					end

					if var_26_33.prefab_name ~= "" and arg_23_1.actors_[var_26_33.prefab_name] ~= nil then
						local var_26_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_33.prefab_name].transform, "story_v_out_317103", "317103006", "story_v_out_317103.awb")

						arg_23_1:RecordAudio("317103006", var_26_39)
						arg_23_1:RecordAudio("317103006", var_26_39)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_317103", "317103006", "story_v_out_317103.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_317103", "317103006", "story_v_out_317103.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_40 = math.max(var_26_31, arg_23_1.talkMaxDuration)

			if var_26_30 <= arg_23_1.time_ and arg_23_1.time_ < var_26_30 + var_26_40 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_30) / var_26_40

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_30 + var_26_40 and arg_23_1.time_ < var_26_30 + var_26_40 + arg_26_0 then
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
			local var_30_0 = arg_27_1.actors_["1015ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1015ui_story == nil then
				arg_27_1.var_.characterEffect1015ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1015ui_story and not isNil(var_30_0) then
					local var_30_4 = Mathf.Lerp(0, 0.5, var_30_3)

					arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1015ui_story.fillRatio = var_30_4
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1015ui_story then
				local var_30_5 = 0.5

				arg_27_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1015ui_story.fillRatio = var_30_5
			end

			local var_30_6 = 0
			local var_30_7 = 0.575

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(317103007)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 23
				local var_30_11 = utf8.len(var_30_9)
				local var_30_12 = var_30_10 <= 0 and var_30_7 or var_30_7 * (var_30_11 / var_30_10)

				if var_30_12 > 0 and var_30_7 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12

					if var_30_12 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_13 and arg_27_1.time_ < var_30_6 + var_30_13 + arg_30_0 then
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
			local var_34_0 = arg_31_1.actors_["1015ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1015ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1015ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1093ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos1093ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0.7, -1.11, -5.88)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1093ui_story, var_34_13, var_34_12)

				local var_34_14 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_14.x, var_34_14.y, var_34_14.z)

				local var_34_15 = var_34_9.localEulerAngles

				var_34_15.z = 0
				var_34_15.x = 0
				var_34_9.localEulerAngles = var_34_15
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				var_34_9.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_9.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_9.localEulerAngles = var_34_17
			end

			local var_34_18 = 0

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			local var_34_19 = 0

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_34_20 = arg_31_1.actors_["1015ui_story"]
			local var_34_21 = 0

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 and not isNil(var_34_20) and arg_31_1.var_.characterEffect1015ui_story == nil then
				arg_31_1.var_.characterEffect1015ui_story = var_34_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_22 = 0.200000002980232

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_22 and not isNil(var_34_20) then
				local var_34_23 = (arg_31_1.time_ - var_34_21) / var_34_22

				if arg_31_1.var_.characterEffect1015ui_story and not isNil(var_34_20) then
					local var_34_24 = Mathf.Lerp(0, 0.5, var_34_23)

					arg_31_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1015ui_story.fillRatio = var_34_24
				end
			end

			if arg_31_1.time_ >= var_34_21 + var_34_22 and arg_31_1.time_ < var_34_21 + var_34_22 + arg_34_0 and not isNil(var_34_20) and arg_31_1.var_.characterEffect1015ui_story then
				local var_34_25 = 0.5

				arg_31_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1015ui_story.fillRatio = var_34_25
			end

			local var_34_26 = arg_31_1.actors_["1093ui_story"]
			local var_34_27 = 0

			if var_34_27 < arg_31_1.time_ and arg_31_1.time_ <= var_34_27 + arg_34_0 and not isNil(var_34_26) and arg_31_1.var_.characterEffect1093ui_story == nil then
				arg_31_1.var_.characterEffect1093ui_story = var_34_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_28 = 0.200000002980232

			if var_34_27 <= arg_31_1.time_ and arg_31_1.time_ < var_34_27 + var_34_28 and not isNil(var_34_26) then
				local var_34_29 = (arg_31_1.time_ - var_34_27) / var_34_28

				if arg_31_1.var_.characterEffect1093ui_story and not isNil(var_34_26) then
					arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_27 + var_34_28 and arg_31_1.time_ < var_34_27 + var_34_28 + arg_34_0 and not isNil(var_34_26) and arg_31_1.var_.characterEffect1093ui_story then
				arg_31_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_34_30 = 0
			local var_34_31 = 0.3

			if var_34_30 < arg_31_1.time_ and arg_31_1.time_ <= var_34_30 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_32 = arg_31_1:FormatText(StoryNameCfg[73].name)

				arg_31_1.leftNameTxt_.text = var_34_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_33 = arg_31_1:GetWordFromCfg(317103008)
				local var_34_34 = arg_31_1:FormatText(var_34_33.content)

				arg_31_1.text_.text = var_34_34

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_35 = 12
				local var_34_36 = utf8.len(var_34_34)
				local var_34_37 = var_34_35 <= 0 and var_34_31 or var_34_31 * (var_34_36 / var_34_35)

				if var_34_37 > 0 and var_34_31 < var_34_37 then
					arg_31_1.talkMaxDuration = var_34_37

					if var_34_37 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_37 + var_34_30
					end
				end

				arg_31_1.text_.text = var_34_34
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103008", "story_v_out_317103.awb") ~= 0 then
					local var_34_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103008", "story_v_out_317103.awb") / 1000

					if var_34_38 + var_34_30 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_38 + var_34_30
					end

					if var_34_33.prefab_name ~= "" and arg_31_1.actors_[var_34_33.prefab_name] ~= nil then
						local var_34_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_33.prefab_name].transform, "story_v_out_317103", "317103008", "story_v_out_317103.awb")

						arg_31_1:RecordAudio("317103008", var_34_39)
						arg_31_1:RecordAudio("317103008", var_34_39)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_317103", "317103008", "story_v_out_317103.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_317103", "317103008", "story_v_out_317103.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_40 = math.max(var_34_31, arg_31_1.talkMaxDuration)

			if var_34_30 <= arg_31_1.time_ and arg_31_1.time_ < var_34_30 + var_34_40 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_30) / var_34_40

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_30 + var_34_40 and arg_31_1.time_ < var_34_30 + var_34_40 + arg_34_0 then
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
			local var_38_0 = arg_35_1.actors_["1015ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1015ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1015ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1093ui_story"].transform
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.var_.moveOldPos1093ui_story = var_38_9.localPosition
			end

			local var_38_11 = 0.001

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11
				local var_38_13 = Vector3.New(0.7, -1.11, -5.88)

				var_38_9.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1093ui_story, var_38_13, var_38_12)

				local var_38_14 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_14.x, var_38_14.y, var_38_14.z)

				local var_38_15 = var_38_9.localEulerAngles

				var_38_15.z = 0
				var_38_15.x = 0
				var_38_9.localEulerAngles = var_38_15
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 then
				var_38_9.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_38_16 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_16.x, var_38_16.y, var_38_16.z)

				local var_38_17 = var_38_9.localEulerAngles

				var_38_17.z = 0
				var_38_17.x = 0
				var_38_9.localEulerAngles = var_38_17
			end

			local var_38_18 = arg_35_1.actors_["1015ui_story"]
			local var_38_19 = 0

			if var_38_19 < arg_35_1.time_ and arg_35_1.time_ <= var_38_19 + arg_38_0 and not isNil(var_38_18) and arg_35_1.var_.characterEffect1015ui_story == nil then
				arg_35_1.var_.characterEffect1015ui_story = var_38_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_20 = 0.200000002980232

			if var_38_19 <= arg_35_1.time_ and arg_35_1.time_ < var_38_19 + var_38_20 and not isNil(var_38_18) then
				local var_38_21 = (arg_35_1.time_ - var_38_19) / var_38_20

				if arg_35_1.var_.characterEffect1015ui_story and not isNil(var_38_18) then
					arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_19 + var_38_20 and arg_35_1.time_ < var_38_19 + var_38_20 + arg_38_0 and not isNil(var_38_18) and arg_35_1.var_.characterEffect1015ui_story then
				arg_35_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_38_22 = 0

			if var_38_22 < arg_35_1.time_ and arg_35_1.time_ <= var_38_22 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_38_23 = 0

			if var_38_23 < arg_35_1.time_ and arg_35_1.time_ <= var_38_23 + arg_38_0 then
				arg_35_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_24 = arg_35_1.actors_["1093ui_story"]
			local var_38_25 = 0

			if var_38_25 < arg_35_1.time_ and arg_35_1.time_ <= var_38_25 + arg_38_0 and not isNil(var_38_24) and arg_35_1.var_.characterEffect1093ui_story == nil then
				arg_35_1.var_.characterEffect1093ui_story = var_38_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_26 = 0.200000002980232

			if var_38_25 <= arg_35_1.time_ and arg_35_1.time_ < var_38_25 + var_38_26 and not isNil(var_38_24) then
				local var_38_27 = (arg_35_1.time_ - var_38_25) / var_38_26

				if arg_35_1.var_.characterEffect1093ui_story and not isNil(var_38_24) then
					local var_38_28 = Mathf.Lerp(0, 0.5, var_38_27)

					arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1093ui_story.fillRatio = var_38_28
				end
			end

			if arg_35_1.time_ >= var_38_25 + var_38_26 and arg_35_1.time_ < var_38_25 + var_38_26 + arg_38_0 and not isNil(var_38_24) and arg_35_1.var_.characterEffect1093ui_story then
				local var_38_29 = 0.5

				arg_35_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1093ui_story.fillRatio = var_38_29
			end

			local var_38_30 = 0
			local var_38_31 = 0.45

			if var_38_30 < arg_35_1.time_ and arg_35_1.time_ <= var_38_30 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_32 = arg_35_1:FormatText(StoryNameCfg[479].name)

				arg_35_1.leftNameTxt_.text = var_38_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_33 = arg_35_1:GetWordFromCfg(317103009)
				local var_38_34 = arg_35_1:FormatText(var_38_33.content)

				arg_35_1.text_.text = var_38_34

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_35 = 18
				local var_38_36 = utf8.len(var_38_34)
				local var_38_37 = var_38_35 <= 0 and var_38_31 or var_38_31 * (var_38_36 / var_38_35)

				if var_38_37 > 0 and var_38_31 < var_38_37 then
					arg_35_1.talkMaxDuration = var_38_37

					if var_38_37 + var_38_30 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_37 + var_38_30
					end
				end

				arg_35_1.text_.text = var_38_34
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103009", "story_v_out_317103.awb") ~= 0 then
					local var_38_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103009", "story_v_out_317103.awb") / 1000

					if var_38_38 + var_38_30 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_38 + var_38_30
					end

					if var_38_33.prefab_name ~= "" and arg_35_1.actors_[var_38_33.prefab_name] ~= nil then
						local var_38_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_33.prefab_name].transform, "story_v_out_317103", "317103009", "story_v_out_317103.awb")

						arg_35_1:RecordAudio("317103009", var_38_39)
						arg_35_1:RecordAudio("317103009", var_38_39)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_317103", "317103009", "story_v_out_317103.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_317103", "317103009", "story_v_out_317103.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_40 = math.max(var_38_31, arg_35_1.talkMaxDuration)

			if var_38_30 <= arg_35_1.time_ and arg_35_1.time_ < var_38_30 + var_38_40 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_30) / var_38_40

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_30 + var_38_40 and arg_35_1.time_ < var_38_30 + var_38_40 + arg_38_0 then
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
			local var_42_0 = arg_39_1.actors_["1015ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1015ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(0, 100, 0)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1015ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(0, 100, 0)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1093ui_story"].transform
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1.var_.moveOldPos1093ui_story = var_42_9.localPosition
			end

			local var_42_11 = 0.001

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11
				local var_42_13 = Vector3.New(0, 100, 0)

				var_42_9.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1093ui_story, var_42_13, var_42_12)

				local var_42_14 = manager.ui.mainCamera.transform.position - var_42_9.position

				var_42_9.forward = Vector3.New(var_42_14.x, var_42_14.y, var_42_14.z)

				local var_42_15 = var_42_9.localEulerAngles

				var_42_15.z = 0
				var_42_15.x = 0
				var_42_9.localEulerAngles = var_42_15
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 then
				var_42_9.localPosition = Vector3.New(0, 100, 0)

				local var_42_16 = manager.ui.mainCamera.transform.position - var_42_9.position

				var_42_9.forward = Vector3.New(var_42_16.x, var_42_16.y, var_42_16.z)

				local var_42_17 = var_42_9.localEulerAngles

				var_42_17.z = 0
				var_42_17.x = 0
				var_42_9.localEulerAngles = var_42_17
			end

			local var_42_18 = 0
			local var_42_19 = 0.425

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_20 = arg_39_1:GetWordFromCfg(317103010)
				local var_42_21 = arg_39_1:FormatText(var_42_20.content)

				arg_39_1.text_.text = var_42_21

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_22 = 17
				local var_42_23 = utf8.len(var_42_21)
				local var_42_24 = var_42_22 <= 0 and var_42_19 or var_42_19 * (var_42_23 / var_42_22)

				if var_42_24 > 0 and var_42_19 < var_42_24 then
					arg_39_1.talkMaxDuration = var_42_24

					if var_42_24 + var_42_18 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_24 + var_42_18
					end
				end

				arg_39_1.text_.text = var_42_21
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_25 = math.max(var_42_19, arg_39_1.talkMaxDuration)

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_25 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_18) / var_42_25

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_18 + var_42_25 and arg_39_1.time_ < var_42_18 + var_42_25 + arg_42_0 then
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
			local var_46_0 = arg_43_1.actors_["1015ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1015ui_story == nil then
				arg_43_1.var_.characterEffect1015ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1015ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1015ui_story then
				arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_46_4 = arg_43_1.actors_["1093ui_story"]
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1093ui_story == nil then
				arg_43_1.var_.characterEffect1093ui_story = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 and not isNil(var_46_4) then
				local var_46_7 = (arg_43_1.time_ - var_46_5) / var_46_6

				if arg_43_1.var_.characterEffect1093ui_story and not isNil(var_46_4) then
					local var_46_8 = Mathf.Lerp(0, 0.5, var_46_7)

					arg_43_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1093ui_story.fillRatio = var_46_8
				end
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1093ui_story then
				local var_46_9 = 0.5

				arg_43_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1093ui_story.fillRatio = var_46_9
			end

			local var_46_10 = arg_43_1.actors_["1015ui_story"].transform
			local var_46_11 = 0

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.var_.moveOldPos1015ui_story = var_46_10.localPosition
			end

			local var_46_12 = 0.001

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_12 then
				local var_46_13 = (arg_43_1.time_ - var_46_11) / var_46_12
				local var_46_14 = Vector3.New(-0.7, -1.15, -6.2)

				var_46_10.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1015ui_story, var_46_14, var_46_13)

				local var_46_15 = manager.ui.mainCamera.transform.position - var_46_10.position

				var_46_10.forward = Vector3.New(var_46_15.x, var_46_15.y, var_46_15.z)

				local var_46_16 = var_46_10.localEulerAngles

				var_46_16.z = 0
				var_46_16.x = 0
				var_46_10.localEulerAngles = var_46_16
			end

			if arg_43_1.time_ >= var_46_11 + var_46_12 and arg_43_1.time_ < var_46_11 + var_46_12 + arg_46_0 then
				var_46_10.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_46_17 = manager.ui.mainCamera.transform.position - var_46_10.position

				var_46_10.forward = Vector3.New(var_46_17.x, var_46_17.y, var_46_17.z)

				local var_46_18 = var_46_10.localEulerAngles

				var_46_18.z = 0
				var_46_18.x = 0
				var_46_10.localEulerAngles = var_46_18
			end

			local var_46_19 = 0

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_21 = arg_43_1.actors_["1093ui_story"].transform
			local var_46_22 = 0

			if var_46_22 < arg_43_1.time_ and arg_43_1.time_ <= var_46_22 + arg_46_0 then
				arg_43_1.var_.moveOldPos1093ui_story = var_46_21.localPosition
			end

			local var_46_23 = 0.001

			if var_46_22 <= arg_43_1.time_ and arg_43_1.time_ < var_46_22 + var_46_23 then
				local var_46_24 = (arg_43_1.time_ - var_46_22) / var_46_23
				local var_46_25 = Vector3.New(0.7, -1.11, -5.88)

				var_46_21.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1093ui_story, var_46_25, var_46_24)

				local var_46_26 = manager.ui.mainCamera.transform.position - var_46_21.position

				var_46_21.forward = Vector3.New(var_46_26.x, var_46_26.y, var_46_26.z)

				local var_46_27 = var_46_21.localEulerAngles

				var_46_27.z = 0
				var_46_27.x = 0
				var_46_21.localEulerAngles = var_46_27
			end

			if arg_43_1.time_ >= var_46_22 + var_46_23 and arg_43_1.time_ < var_46_22 + var_46_23 + arg_46_0 then
				var_46_21.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_46_28 = manager.ui.mainCamera.transform.position - var_46_21.position

				var_46_21.forward = Vector3.New(var_46_28.x, var_46_28.y, var_46_28.z)

				local var_46_29 = var_46_21.localEulerAngles

				var_46_29.z = 0
				var_46_29.x = 0
				var_46_21.localEulerAngles = var_46_29
			end

			local var_46_30 = 0
			local var_46_31 = 0.75

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_32 = arg_43_1:FormatText(StoryNameCfg[479].name)

				arg_43_1.leftNameTxt_.text = var_46_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_33 = arg_43_1:GetWordFromCfg(317103011)
				local var_46_34 = arg_43_1:FormatText(var_46_33.content)

				arg_43_1.text_.text = var_46_34

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_35 = 30
				local var_46_36 = utf8.len(var_46_34)
				local var_46_37 = var_46_35 <= 0 and var_46_31 or var_46_31 * (var_46_36 / var_46_35)

				if var_46_37 > 0 and var_46_31 < var_46_37 then
					arg_43_1.talkMaxDuration = var_46_37

					if var_46_37 + var_46_30 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_37 + var_46_30
					end
				end

				arg_43_1.text_.text = var_46_34
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103011", "story_v_out_317103.awb") ~= 0 then
					local var_46_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103011", "story_v_out_317103.awb") / 1000

					if var_46_38 + var_46_30 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_38 + var_46_30
					end

					if var_46_33.prefab_name ~= "" and arg_43_1.actors_[var_46_33.prefab_name] ~= nil then
						local var_46_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_33.prefab_name].transform, "story_v_out_317103", "317103011", "story_v_out_317103.awb")

						arg_43_1:RecordAudio("317103011", var_46_39)
						arg_43_1:RecordAudio("317103011", var_46_39)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_317103", "317103011", "story_v_out_317103.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_317103", "317103011", "story_v_out_317103.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_40 = math.max(var_46_31, arg_43_1.talkMaxDuration)

			if var_46_30 <= arg_43_1.time_ and arg_43_1.time_ < var_46_30 + var_46_40 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_30) / var_46_40

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_30 + var_46_40 and arg_43_1.time_ < var_46_30 + var_46_40 + arg_46_0 then
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
			local var_50_0 = 0
			local var_50_1 = 1.85

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[479].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:GetWordFromCfg(317103012)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 74
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103012", "story_v_out_317103.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_317103", "317103012", "story_v_out_317103.awb") / 1000

					if var_50_8 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_0
					end

					if var_50_3.prefab_name ~= "" and arg_47_1.actors_[var_50_3.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_3.prefab_name].transform, "story_v_out_317103", "317103012", "story_v_out_317103.awb")

						arg_47_1:RecordAudio("317103012", var_50_9)
						arg_47_1:RecordAudio("317103012", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_317103", "317103012", "story_v_out_317103.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_317103", "317103012", "story_v_out_317103.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_10 and arg_47_1.time_ < var_50_0 + var_50_10 + arg_50_0 then
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
			local var_54_0 = 0
			local var_54_1 = 1.575

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[479].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(317103013)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 63
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103013", "story_v_out_317103.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_317103", "317103013", "story_v_out_317103.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_317103", "317103013", "story_v_out_317103.awb")

						arg_51_1:RecordAudio("317103013", var_54_9)
						arg_51_1:RecordAudio("317103013", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_317103", "317103013", "story_v_out_317103.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_317103", "317103013", "story_v_out_317103.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
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
			local var_58_0 = 0
			local var_58_1 = 0.825

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_2 = arg_55_1:FormatText(StoryNameCfg[479].name)

				arg_55_1.leftNameTxt_.text = var_58_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:GetWordFromCfg(317103014)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 33
				local var_58_6 = utf8.len(var_58_4)
				local var_58_7 = var_58_5 <= 0 and var_58_1 or var_58_1 * (var_58_6 / var_58_5)

				if var_58_7 > 0 and var_58_1 < var_58_7 then
					arg_55_1.talkMaxDuration = var_58_7

					if var_58_7 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103014", "story_v_out_317103.awb") ~= 0 then
					local var_58_8 = manager.audio:GetVoiceLength("story_v_out_317103", "317103014", "story_v_out_317103.awb") / 1000

					if var_58_8 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_0
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_317103", "317103014", "story_v_out_317103.awb")

						arg_55_1:RecordAudio("317103014", var_58_9)
						arg_55_1:RecordAudio("317103014", var_58_9)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_317103", "317103014", "story_v_out_317103.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_317103", "317103014", "story_v_out_317103.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_10 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_10 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_10

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_10 and arg_55_1.time_ < var_58_0 + var_58_10 + arg_58_0 then
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
			local var_62_0 = arg_59_1.actors_["1015ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1015ui_story == nil then
				arg_59_1.var_.characterEffect1015ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1015ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1015ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1015ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1015ui_story.fillRatio = var_62_5
			end

			local var_62_6 = arg_59_1.actors_["1093ui_story"]
			local var_62_7 = 0

			if var_62_7 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1093ui_story == nil then
				arg_59_1.var_.characterEffect1093ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_8 = 0.200000002980232

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_8 and not isNil(var_62_6) then
				local var_62_9 = (arg_59_1.time_ - var_62_7) / var_62_8

				if arg_59_1.var_.characterEffect1093ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_7 + var_62_8 and arg_59_1.time_ < var_62_7 + var_62_8 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1093ui_story then
				arg_59_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_62_10 = arg_59_1.actors_["1015ui_story"].transform
			local var_62_11 = 0

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1.var_.moveOldPos1015ui_story = var_62_10.localPosition
			end

			local var_62_12 = 0.001

			if var_62_11 <= arg_59_1.time_ and arg_59_1.time_ < var_62_11 + var_62_12 then
				local var_62_13 = (arg_59_1.time_ - var_62_11) / var_62_12
				local var_62_14 = Vector3.New(-0.7, -1.15, -6.2)

				var_62_10.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1015ui_story, var_62_14, var_62_13)

				local var_62_15 = manager.ui.mainCamera.transform.position - var_62_10.position

				var_62_10.forward = Vector3.New(var_62_15.x, var_62_15.y, var_62_15.z)

				local var_62_16 = var_62_10.localEulerAngles

				var_62_16.z = 0
				var_62_16.x = 0
				var_62_10.localEulerAngles = var_62_16
			end

			if arg_59_1.time_ >= var_62_11 + var_62_12 and arg_59_1.time_ < var_62_11 + var_62_12 + arg_62_0 then
				var_62_10.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_62_17 = manager.ui.mainCamera.transform.position - var_62_10.position

				var_62_10.forward = Vector3.New(var_62_17.x, var_62_17.y, var_62_17.z)

				local var_62_18 = var_62_10.localEulerAngles

				var_62_18.z = 0
				var_62_18.x = 0
				var_62_10.localEulerAngles = var_62_18
			end

			local var_62_19 = arg_59_1.actors_["1093ui_story"].transform
			local var_62_20 = 0

			if var_62_20 < arg_59_1.time_ and arg_59_1.time_ <= var_62_20 + arg_62_0 then
				arg_59_1.var_.moveOldPos1093ui_story = var_62_19.localPosition
			end

			local var_62_21 = 0.001

			if var_62_20 <= arg_59_1.time_ and arg_59_1.time_ < var_62_20 + var_62_21 then
				local var_62_22 = (arg_59_1.time_ - var_62_20) / var_62_21
				local var_62_23 = Vector3.New(0.7, -1.11, -5.88)

				var_62_19.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1093ui_story, var_62_23, var_62_22)

				local var_62_24 = manager.ui.mainCamera.transform.position - var_62_19.position

				var_62_19.forward = Vector3.New(var_62_24.x, var_62_24.y, var_62_24.z)

				local var_62_25 = var_62_19.localEulerAngles

				var_62_25.z = 0
				var_62_25.x = 0
				var_62_19.localEulerAngles = var_62_25
			end

			if arg_59_1.time_ >= var_62_20 + var_62_21 and arg_59_1.time_ < var_62_20 + var_62_21 + arg_62_0 then
				var_62_19.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_62_26 = manager.ui.mainCamera.transform.position - var_62_19.position

				var_62_19.forward = Vector3.New(var_62_26.x, var_62_26.y, var_62_26.z)

				local var_62_27 = var_62_19.localEulerAngles

				var_62_27.z = 0
				var_62_27.x = 0
				var_62_19.localEulerAngles = var_62_27
			end

			local var_62_28 = 0

			if var_62_28 < arg_59_1.time_ and arg_59_1.time_ <= var_62_28 + arg_62_0 then
				arg_59_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_62_29 = 0

			if var_62_29 < arg_59_1.time_ and arg_59_1.time_ <= var_62_29 + arg_62_0 then
				arg_59_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_30 = 0
			local var_62_31 = 1.175

			if var_62_30 < arg_59_1.time_ and arg_59_1.time_ <= var_62_30 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_32 = arg_59_1:FormatText(StoryNameCfg[73].name)

				arg_59_1.leftNameTxt_.text = var_62_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_33 = arg_59_1:GetWordFromCfg(317103015)
				local var_62_34 = arg_59_1:FormatText(var_62_33.content)

				arg_59_1.text_.text = var_62_34

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_35 = 47
				local var_62_36 = utf8.len(var_62_34)
				local var_62_37 = var_62_35 <= 0 and var_62_31 or var_62_31 * (var_62_36 / var_62_35)

				if var_62_37 > 0 and var_62_31 < var_62_37 then
					arg_59_1.talkMaxDuration = var_62_37

					if var_62_37 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_37 + var_62_30
					end
				end

				arg_59_1.text_.text = var_62_34
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103015", "story_v_out_317103.awb") ~= 0 then
					local var_62_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103015", "story_v_out_317103.awb") / 1000

					if var_62_38 + var_62_30 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_38 + var_62_30
					end

					if var_62_33.prefab_name ~= "" and arg_59_1.actors_[var_62_33.prefab_name] ~= nil then
						local var_62_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_33.prefab_name].transform, "story_v_out_317103", "317103015", "story_v_out_317103.awb")

						arg_59_1:RecordAudio("317103015", var_62_39)
						arg_59_1:RecordAudio("317103015", var_62_39)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317103", "317103015", "story_v_out_317103.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317103", "317103015", "story_v_out_317103.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_40 = math.max(var_62_31, arg_59_1.talkMaxDuration)

			if var_62_30 <= arg_59_1.time_ and arg_59_1.time_ < var_62_30 + var_62_40 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_30) / var_62_40

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_30 + var_62_40 and arg_59_1.time_ < var_62_30 + var_62_40 + arg_62_0 then
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
			local var_66_0 = arg_63_1.actors_["1015ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1015ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1093ui_story"]
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1093ui_story == nil then
				arg_63_1.var_.characterEffect1093ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.200000002980232

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 and not isNil(var_66_4) then
				local var_66_7 = (arg_63_1.time_ - var_66_5) / var_66_6

				if arg_63_1.var_.characterEffect1093ui_story and not isNil(var_66_4) then
					local var_66_8 = Mathf.Lerp(0, 0.5, var_66_7)

					arg_63_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1093ui_story.fillRatio = var_66_8
				end
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1093ui_story then
				local var_66_9 = 0.5

				arg_63_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1093ui_story.fillRatio = var_66_9
			end

			local var_66_10 = 0
			local var_66_11 = 1.925

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_12 = arg_63_1:FormatText(StoryNameCfg[479].name)

				arg_63_1.leftNameTxt_.text = var_66_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_13 = arg_63_1:GetWordFromCfg(317103016)
				local var_66_14 = arg_63_1:FormatText(var_66_13.content)

				arg_63_1.text_.text = var_66_14

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_15 = 77
				local var_66_16 = utf8.len(var_66_14)
				local var_66_17 = var_66_15 <= 0 and var_66_11 or var_66_11 * (var_66_16 / var_66_15)

				if var_66_17 > 0 and var_66_11 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17

					if var_66_17 + var_66_10 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_10
					end
				end

				arg_63_1.text_.text = var_66_14
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103016", "story_v_out_317103.awb") ~= 0 then
					local var_66_18 = manager.audio:GetVoiceLength("story_v_out_317103", "317103016", "story_v_out_317103.awb") / 1000

					if var_66_18 + var_66_10 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_10
					end

					if var_66_13.prefab_name ~= "" and arg_63_1.actors_[var_66_13.prefab_name] ~= nil then
						local var_66_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_13.prefab_name].transform, "story_v_out_317103", "317103016", "story_v_out_317103.awb")

						arg_63_1:RecordAudio("317103016", var_66_19)
						arg_63_1:RecordAudio("317103016", var_66_19)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317103", "317103016", "story_v_out_317103.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317103", "317103016", "story_v_out_317103.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_20 = math.max(var_66_11, arg_63_1.talkMaxDuration)

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_20 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_10) / var_66_20

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_10 + var_66_20 and arg_63_1.time_ < var_66_10 + var_66_20 + arg_66_0 then
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
			local var_70_0 = arg_67_1.actors_["1015ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1015ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(-0.7, -1.15, -6.2)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1015ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(-0.7, -1.15, -6.2)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = 0

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_11 = arg_67_1.actors_["1093ui_story"].transform
			local var_70_12 = 0

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.var_.moveOldPos1093ui_story = var_70_11.localPosition
			end

			local var_70_13 = 0.001

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_13 then
				local var_70_14 = (arg_67_1.time_ - var_70_12) / var_70_13
				local var_70_15 = Vector3.New(0.7, -1.11, -5.88)

				var_70_11.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1093ui_story, var_70_15, var_70_14)

				local var_70_16 = manager.ui.mainCamera.transform.position - var_70_11.position

				var_70_11.forward = Vector3.New(var_70_16.x, var_70_16.y, var_70_16.z)

				local var_70_17 = var_70_11.localEulerAngles

				var_70_17.z = 0
				var_70_17.x = 0
				var_70_11.localEulerAngles = var_70_17
			end

			if arg_67_1.time_ >= var_70_12 + var_70_13 and arg_67_1.time_ < var_70_12 + var_70_13 + arg_70_0 then
				var_70_11.localPosition = Vector3.New(0.7, -1.11, -5.88)

				local var_70_18 = manager.ui.mainCamera.transform.position - var_70_11.position

				var_70_11.forward = Vector3.New(var_70_18.x, var_70_18.y, var_70_18.z)

				local var_70_19 = var_70_11.localEulerAngles

				var_70_19.z = 0
				var_70_19.x = 0
				var_70_11.localEulerAngles = var_70_19
			end

			local var_70_20 = 0
			local var_70_21 = 0.85

			if var_70_20 < arg_67_1.time_ and arg_67_1.time_ <= var_70_20 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_22 = arg_67_1:FormatText(StoryNameCfg[479].name)

				arg_67_1.leftNameTxt_.text = var_70_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_23 = arg_67_1:GetWordFromCfg(317103017)
				local var_70_24 = arg_67_1:FormatText(var_70_23.content)

				arg_67_1.text_.text = var_70_24

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_25 = 34
				local var_70_26 = utf8.len(var_70_24)
				local var_70_27 = var_70_25 <= 0 and var_70_21 or var_70_21 * (var_70_26 / var_70_25)

				if var_70_27 > 0 and var_70_21 < var_70_27 then
					arg_67_1.talkMaxDuration = var_70_27

					if var_70_27 + var_70_20 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_27 + var_70_20
					end
				end

				arg_67_1.text_.text = var_70_24
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103017", "story_v_out_317103.awb") ~= 0 then
					local var_70_28 = manager.audio:GetVoiceLength("story_v_out_317103", "317103017", "story_v_out_317103.awb") / 1000

					if var_70_28 + var_70_20 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_28 + var_70_20
					end

					if var_70_23.prefab_name ~= "" and arg_67_1.actors_[var_70_23.prefab_name] ~= nil then
						local var_70_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_23.prefab_name].transform, "story_v_out_317103", "317103017", "story_v_out_317103.awb")

						arg_67_1:RecordAudio("317103017", var_70_29)
						arg_67_1:RecordAudio("317103017", var_70_29)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_317103", "317103017", "story_v_out_317103.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_317103", "317103017", "story_v_out_317103.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_30 = math.max(var_70_21, arg_67_1.talkMaxDuration)

			if var_70_20 <= arg_67_1.time_ and arg_67_1.time_ < var_70_20 + var_70_30 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_20) / var_70_30

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_20 + var_70_30 and arg_67_1.time_ < var_70_20 + var_70_30 + arg_70_0 then
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
			local var_74_0 = "2078ui_story"

			if arg_71_1.actors_[var_74_0] == nil then
				local var_74_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_74_1) then
					local var_74_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_71_1.stage_.transform)

					var_74_2.name = var_74_0
					var_74_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_71_1.actors_[var_74_0] = var_74_2

					local var_74_3 = var_74_2:GetComponentInChildren(typeof(CharacterEffect))

					var_74_3.enabled = true

					local var_74_4 = GameObjectTools.GetOrAddComponent(var_74_2, typeof(DynamicBoneHelper))

					if var_74_4 then
						var_74_4:EnableDynamicBone(false)
					end

					arg_71_1:ShowWeapon(var_74_3.transform, false)

					arg_71_1.var_[var_74_0 .. "Animator"] = var_74_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_71_1.var_[var_74_0 .. "Animator"].applyRootMotion = true
					arg_71_1.var_[var_74_0 .. "LipSync"] = var_74_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_74_5 = arg_71_1.actors_["2078ui_story"]
			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect2078ui_story == nil then
				arg_71_1.var_.characterEffect2078ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_7 = 0.200000002980232

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_7 and not isNil(var_74_5) then
				local var_74_8 = (arg_71_1.time_ - var_74_6) / var_74_7

				if arg_71_1.var_.characterEffect2078ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_6 + var_74_7 and arg_71_1.time_ < var_74_6 + var_74_7 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect2078ui_story then
				arg_71_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_74_9 = arg_71_1.actors_["1015ui_story"].transform
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.var_.moveOldPos1015ui_story = var_74_9.localPosition
			end

			local var_74_11 = 0.001

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11
				local var_74_13 = Vector3.New(0, 100, 0)

				var_74_9.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1015ui_story, var_74_13, var_74_12)

				local var_74_14 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_14.x, var_74_14.y, var_74_14.z)

				local var_74_15 = var_74_9.localEulerAngles

				var_74_15.z = 0
				var_74_15.x = 0
				var_74_9.localEulerAngles = var_74_15
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 then
				var_74_9.localPosition = Vector3.New(0, 100, 0)

				local var_74_16 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_16.x, var_74_16.y, var_74_16.z)

				local var_74_17 = var_74_9.localEulerAngles

				var_74_17.z = 0
				var_74_17.x = 0
				var_74_9.localEulerAngles = var_74_17
			end

			local var_74_18 = arg_71_1.actors_["1093ui_story"].transform
			local var_74_19 = 0

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1.var_.moveOldPos1093ui_story = var_74_18.localPosition
			end

			local var_74_20 = 0.001

			if var_74_19 <= arg_71_1.time_ and arg_71_1.time_ < var_74_19 + var_74_20 then
				local var_74_21 = (arg_71_1.time_ - var_74_19) / var_74_20
				local var_74_22 = Vector3.New(0, 100, 0)

				var_74_18.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1093ui_story, var_74_22, var_74_21)

				local var_74_23 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_23.x, var_74_23.y, var_74_23.z)

				local var_74_24 = var_74_18.localEulerAngles

				var_74_24.z = 0
				var_74_24.x = 0
				var_74_18.localEulerAngles = var_74_24
			end

			if arg_71_1.time_ >= var_74_19 + var_74_20 and arg_71_1.time_ < var_74_19 + var_74_20 + arg_74_0 then
				var_74_18.localPosition = Vector3.New(0, 100, 0)

				local var_74_25 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_25.x, var_74_25.y, var_74_25.z)

				local var_74_26 = var_74_18.localEulerAngles

				var_74_26.z = 0
				var_74_26.x = 0
				var_74_18.localEulerAngles = var_74_26
			end

			local var_74_27 = arg_71_1.actors_["2078ui_story"].transform
			local var_74_28 = 0

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1.var_.moveOldPos2078ui_story = var_74_27.localPosition
			end

			local var_74_29 = 0.001

			if var_74_28 <= arg_71_1.time_ and arg_71_1.time_ < var_74_28 + var_74_29 then
				local var_74_30 = (arg_71_1.time_ - var_74_28) / var_74_29
				local var_74_31 = Vector3.New(0, -1.28, -5.6)

				var_74_27.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos2078ui_story, var_74_31, var_74_30)

				local var_74_32 = manager.ui.mainCamera.transform.position - var_74_27.position

				var_74_27.forward = Vector3.New(var_74_32.x, var_74_32.y, var_74_32.z)

				local var_74_33 = var_74_27.localEulerAngles

				var_74_33.z = 0
				var_74_33.x = 0
				var_74_27.localEulerAngles = var_74_33
			end

			if arg_71_1.time_ >= var_74_28 + var_74_29 and arg_71_1.time_ < var_74_28 + var_74_29 + arg_74_0 then
				var_74_27.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_74_34 = manager.ui.mainCamera.transform.position - var_74_27.position

				var_74_27.forward = Vector3.New(var_74_34.x, var_74_34.y, var_74_34.z)

				local var_74_35 = var_74_27.localEulerAngles

				var_74_35.z = 0
				var_74_35.x = 0
				var_74_27.localEulerAngles = var_74_35
			end

			local var_74_36 = 0

			if var_74_36 < arg_71_1.time_ and arg_71_1.time_ <= var_74_36 + arg_74_0 then
				arg_71_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_74_37 = 0
			local var_74_38 = 0.85

			if var_74_37 < arg_71_1.time_ and arg_71_1.time_ <= var_74_37 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_39 = arg_71_1:FormatText(StoryNameCfg[530].name)

				arg_71_1.leftNameTxt_.text = var_74_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_40 = arg_71_1:GetWordFromCfg(317103018)
				local var_74_41 = arg_71_1:FormatText(var_74_40.content)

				arg_71_1.text_.text = var_74_41

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_42 = 34
				local var_74_43 = utf8.len(var_74_41)
				local var_74_44 = var_74_42 <= 0 and var_74_38 or var_74_38 * (var_74_43 / var_74_42)

				if var_74_44 > 0 and var_74_38 < var_74_44 then
					arg_71_1.talkMaxDuration = var_74_44

					if var_74_44 + var_74_37 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_44 + var_74_37
					end
				end

				arg_71_1.text_.text = var_74_41
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103018", "story_v_out_317103.awb") ~= 0 then
					local var_74_45 = manager.audio:GetVoiceLength("story_v_out_317103", "317103018", "story_v_out_317103.awb") / 1000

					if var_74_45 + var_74_37 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_45 + var_74_37
					end

					if var_74_40.prefab_name ~= "" and arg_71_1.actors_[var_74_40.prefab_name] ~= nil then
						local var_74_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_40.prefab_name].transform, "story_v_out_317103", "317103018", "story_v_out_317103.awb")

						arg_71_1:RecordAudio("317103018", var_74_46)
						arg_71_1:RecordAudio("317103018", var_74_46)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_317103", "317103018", "story_v_out_317103.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_317103", "317103018", "story_v_out_317103.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_47 = math.max(var_74_38, arg_71_1.talkMaxDuration)

			if var_74_37 <= arg_71_1.time_ and arg_71_1.time_ < var_74_37 + var_74_47 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_37) / var_74_47

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_37 + var_74_47 and arg_71_1.time_ < var_74_37 + var_74_47 + arg_74_0 then
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
			local var_78_0 = arg_75_1.actors_["2078ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos2078ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -1.28, -5.6)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos2078ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_78_10 = "2079ui_story"

			if arg_75_1.actors_[var_78_10] == nil then
				local var_78_11 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_78_11) then
					local var_78_12 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_75_1.stage_.transform)

					var_78_12.name = var_78_10
					var_78_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_10] = var_78_12

					local var_78_13 = var_78_12:GetComponentInChildren(typeof(CharacterEffect))

					var_78_13.enabled = true

					local var_78_14 = GameObjectTools.GetOrAddComponent(var_78_12, typeof(DynamicBoneHelper))

					if var_78_14 then
						var_78_14:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_13.transform, false)

					arg_75_1.var_[var_78_10 .. "Animator"] = var_78_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_10 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_10 .. "LipSync"] = var_78_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_15 = arg_75_1.actors_["2079ui_story"]
			local var_78_16 = 0

			if var_78_16 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.characterEffect2079ui_story == nil then
				arg_75_1.var_.characterEffect2079ui_story = var_78_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_17 = 0.2

			if var_78_16 <= arg_75_1.time_ and arg_75_1.time_ < var_78_16 + var_78_17 and not isNil(var_78_15) then
				local var_78_18 = (arg_75_1.time_ - var_78_16) / var_78_17

				if arg_75_1.var_.characterEffect2079ui_story and not isNil(var_78_15) then
					arg_75_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_16 + var_78_17 and arg_75_1.time_ < var_78_16 + var_78_17 + arg_78_0 and not isNil(var_78_15) and arg_75_1.var_.characterEffect2079ui_story then
				arg_75_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_78_19 = 0
			local var_78_20 = 0.55

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_21 = arg_75_1:FormatText(StoryNameCfg[528].name)

				arg_75_1.leftNameTxt_.text = var_78_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_22 = arg_75_1:GetWordFromCfg(317103019)
				local var_78_23 = arg_75_1:FormatText(var_78_22.content)

				arg_75_1.text_.text = var_78_23

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_24 = 22
				local var_78_25 = utf8.len(var_78_23)
				local var_78_26 = var_78_24 <= 0 and var_78_20 or var_78_20 * (var_78_25 / var_78_24)

				if var_78_26 > 0 and var_78_20 < var_78_26 then
					arg_75_1.talkMaxDuration = var_78_26

					if var_78_26 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_26 + var_78_19
					end
				end

				arg_75_1.text_.text = var_78_23
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103019", "story_v_out_317103.awb") ~= 0 then
					local var_78_27 = manager.audio:GetVoiceLength("story_v_out_317103", "317103019", "story_v_out_317103.awb") / 1000

					if var_78_27 + var_78_19 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_19
					end

					if var_78_22.prefab_name ~= "" and arg_75_1.actors_[var_78_22.prefab_name] ~= nil then
						local var_78_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_22.prefab_name].transform, "story_v_out_317103", "317103019", "story_v_out_317103.awb")

						arg_75_1:RecordAudio("317103019", var_78_28)
						arg_75_1:RecordAudio("317103019", var_78_28)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_317103", "317103019", "story_v_out_317103.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_317103", "317103019", "story_v_out_317103.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_29 = math.max(var_78_20, arg_75_1.talkMaxDuration)

			if var_78_19 <= arg_75_1.time_ and arg_75_1.time_ < var_78_19 + var_78_29 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_19) / var_78_29

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_19 + var_78_29 and arg_75_1.time_ < var_78_19 + var_78_29 + arg_78_0 then
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
			local var_82_0 = arg_79_1.actors_["1015ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1015ui_story == nil then
				arg_79_1.var_.characterEffect1015ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1015ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1015ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1015ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1015ui_story.fillRatio = var_82_5
			end

			local var_82_6 = arg_79_1.actors_["1093ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1093ui_story == nil then
				arg_79_1.var_.characterEffect1093ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.200000002980232

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect1093ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1093ui_story then
				arg_79_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_82_10 = arg_79_1.actors_["1015ui_story"].transform
			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.var_.moveOldPos1015ui_story = var_82_10.localPosition
			end

			local var_82_12 = 0.001

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_11) / var_82_12
				local var_82_14 = Vector3.New(0.7, -1.15, -6.2)

				var_82_10.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1015ui_story, var_82_14, var_82_13)

				local var_82_15 = manager.ui.mainCamera.transform.position - var_82_10.position

				var_82_10.forward = Vector3.New(var_82_15.x, var_82_15.y, var_82_15.z)

				local var_82_16 = var_82_10.localEulerAngles

				var_82_16.z = 0
				var_82_16.x = 0
				var_82_10.localEulerAngles = var_82_16
			end

			if arg_79_1.time_ >= var_82_11 + var_82_12 and arg_79_1.time_ < var_82_11 + var_82_12 + arg_82_0 then
				var_82_10.localPosition = Vector3.New(0.7, -1.15, -6.2)

				local var_82_17 = manager.ui.mainCamera.transform.position - var_82_10.position

				var_82_10.forward = Vector3.New(var_82_17.x, var_82_17.y, var_82_17.z)

				local var_82_18 = var_82_10.localEulerAngles

				var_82_18.z = 0
				var_82_18.x = 0
				var_82_10.localEulerAngles = var_82_18
			end

			local var_82_19 = arg_79_1.actors_["1093ui_story"].transform
			local var_82_20 = 0

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1.var_.moveOldPos1093ui_story = var_82_19.localPosition
			end

			local var_82_21 = 0.001

			if var_82_20 <= arg_79_1.time_ and arg_79_1.time_ < var_82_20 + var_82_21 then
				local var_82_22 = (arg_79_1.time_ - var_82_20) / var_82_21
				local var_82_23 = Vector3.New(-0.7, -1.11, -5.88)

				var_82_19.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1093ui_story, var_82_23, var_82_22)

				local var_82_24 = manager.ui.mainCamera.transform.position - var_82_19.position

				var_82_19.forward = Vector3.New(var_82_24.x, var_82_24.y, var_82_24.z)

				local var_82_25 = var_82_19.localEulerAngles

				var_82_25.z = 0
				var_82_25.x = 0
				var_82_19.localEulerAngles = var_82_25
			end

			if arg_79_1.time_ >= var_82_20 + var_82_21 and arg_79_1.time_ < var_82_20 + var_82_21 + arg_82_0 then
				var_82_19.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_82_26 = manager.ui.mainCamera.transform.position - var_82_19.position

				var_82_19.forward = Vector3.New(var_82_26.x, var_82_26.y, var_82_26.z)

				local var_82_27 = var_82_19.localEulerAngles

				var_82_27.z = 0
				var_82_27.x = 0
				var_82_19.localEulerAngles = var_82_27
			end

			local var_82_28 = 0

			if var_82_28 < arg_79_1.time_ and arg_79_1.time_ <= var_82_28 + arg_82_0 then
				arg_79_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			local var_82_29 = 0

			if var_82_29 < arg_79_1.time_ and arg_79_1.time_ <= var_82_29 + arg_82_0 then
				arg_79_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_30 = arg_79_1.actors_["2078ui_story"].transform
			local var_82_31 = 0

			if var_82_31 < arg_79_1.time_ and arg_79_1.time_ <= var_82_31 + arg_82_0 then
				arg_79_1.var_.moveOldPos2078ui_story = var_82_30.localPosition
			end

			local var_82_32 = 0.001

			if var_82_31 <= arg_79_1.time_ and arg_79_1.time_ < var_82_31 + var_82_32 then
				local var_82_33 = (arg_79_1.time_ - var_82_31) / var_82_32
				local var_82_34 = Vector3.New(0, 100, 0)

				var_82_30.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos2078ui_story, var_82_34, var_82_33)

				local var_82_35 = manager.ui.mainCamera.transform.position - var_82_30.position

				var_82_30.forward = Vector3.New(var_82_35.x, var_82_35.y, var_82_35.z)

				local var_82_36 = var_82_30.localEulerAngles

				var_82_36.z = 0
				var_82_36.x = 0
				var_82_30.localEulerAngles = var_82_36
			end

			if arg_79_1.time_ >= var_82_31 + var_82_32 and arg_79_1.time_ < var_82_31 + var_82_32 + arg_82_0 then
				var_82_30.localPosition = Vector3.New(0, 100, 0)

				local var_82_37 = manager.ui.mainCamera.transform.position - var_82_30.position

				var_82_30.forward = Vector3.New(var_82_37.x, var_82_37.y, var_82_37.z)

				local var_82_38 = var_82_30.localEulerAngles

				var_82_38.z = 0
				var_82_38.x = 0
				var_82_30.localEulerAngles = var_82_38
			end

			local var_82_39 = 0
			local var_82_40 = 0.575

			if var_82_39 < arg_79_1.time_ and arg_79_1.time_ <= var_82_39 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_41 = arg_79_1:FormatText(StoryNameCfg[73].name)

				arg_79_1.leftNameTxt_.text = var_82_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_42 = arg_79_1:GetWordFromCfg(317103020)
				local var_82_43 = arg_79_1:FormatText(var_82_42.content)

				arg_79_1.text_.text = var_82_43

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_44 = 23
				local var_82_45 = utf8.len(var_82_43)
				local var_82_46 = var_82_44 <= 0 and var_82_40 or var_82_40 * (var_82_45 / var_82_44)

				if var_82_46 > 0 and var_82_40 < var_82_46 then
					arg_79_1.talkMaxDuration = var_82_46

					if var_82_46 + var_82_39 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_46 + var_82_39
					end
				end

				arg_79_1.text_.text = var_82_43
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103020", "story_v_out_317103.awb") ~= 0 then
					local var_82_47 = manager.audio:GetVoiceLength("story_v_out_317103", "317103020", "story_v_out_317103.awb") / 1000

					if var_82_47 + var_82_39 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_47 + var_82_39
					end

					if var_82_42.prefab_name ~= "" and arg_79_1.actors_[var_82_42.prefab_name] ~= nil then
						local var_82_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_42.prefab_name].transform, "story_v_out_317103", "317103020", "story_v_out_317103.awb")

						arg_79_1:RecordAudio("317103020", var_82_48)
						arg_79_1:RecordAudio("317103020", var_82_48)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_317103", "317103020", "story_v_out_317103.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_317103", "317103020", "story_v_out_317103.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_49 = math.max(var_82_40, arg_79_1.talkMaxDuration)

			if var_82_39 <= arg_79_1.time_ and arg_79_1.time_ < var_82_39 + var_82_49 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_39) / var_82_49

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_39 + var_82_49 and arg_79_1.time_ < var_82_39 + var_82_49 + arg_82_0 then
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
			local var_86_0 = arg_83_1.actors_["1015ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1015ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1015ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1093ui_story"].transform
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos1093ui_story = var_86_9.localPosition
			end

			local var_86_11 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11
				local var_86_13 = Vector3.New(0, 100, 0)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1093ui_story, var_86_13, var_86_12)

				local var_86_14 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_14.x, var_86_14.y, var_86_14.z)

				local var_86_15 = var_86_9.localEulerAngles

				var_86_15.z = 0
				var_86_15.x = 0
				var_86_9.localEulerAngles = var_86_15
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0, 100, 0)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_9.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_9.localEulerAngles = var_86_17
			end

			local var_86_18 = 0
			local var_86_19 = 0.7

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_20 = arg_83_1:GetWordFromCfg(317103021)
				local var_86_21 = arg_83_1:FormatText(var_86_20.content)

				arg_83_1.text_.text = var_86_21

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_22 = 28
				local var_86_23 = utf8.len(var_86_21)
				local var_86_24 = var_86_22 <= 0 and var_86_19 or var_86_19 * (var_86_23 / var_86_22)

				if var_86_24 > 0 and var_86_19 < var_86_24 then
					arg_83_1.talkMaxDuration = var_86_24

					if var_86_24 + var_86_18 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_24 + var_86_18
					end
				end

				arg_83_1.text_.text = var_86_21
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_25 = math.max(var_86_19, arg_83_1.talkMaxDuration)

			if var_86_18 <= arg_83_1.time_ and arg_83_1.time_ < var_86_18 + var_86_25 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_18) / var_86_25

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_18 + var_86_25 and arg_83_1.time_ < var_86_18 + var_86_25 + arg_86_0 then
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
			local var_90_0 = arg_87_1.actors_["1015ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1015ui_story == nil then
				arg_87_1.var_.characterEffect1015ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1015ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1015ui_story then
				arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["1015ui_story"].transform
			local var_90_5 = 0

			if var_90_5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.var_.moveOldPos1015ui_story = var_90_4.localPosition
			end

			local var_90_6 = 0.001

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = (arg_87_1.time_ - var_90_5) / var_90_6
				local var_90_8 = Vector3.New(0, -1.15, -6.2)

				var_90_4.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1015ui_story, var_90_8, var_90_7)

				local var_90_9 = manager.ui.mainCamera.transform.position - var_90_4.position

				var_90_4.forward = Vector3.New(var_90_9.x, var_90_9.y, var_90_9.z)

				local var_90_10 = var_90_4.localEulerAngles

				var_90_10.z = 0
				var_90_10.x = 0
				var_90_4.localEulerAngles = var_90_10
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				var_90_4.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_90_11 = manager.ui.mainCamera.transform.position - var_90_4.position

				var_90_4.forward = Vector3.New(var_90_11.x, var_90_11.y, var_90_11.z)

				local var_90_12 = var_90_4.localEulerAngles

				var_90_12.z = 0
				var_90_12.x = 0
				var_90_4.localEulerAngles = var_90_12
			end

			local var_90_13 = 0

			if var_90_13 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_90_14 = 0

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_15 = 0
			local var_90_16 = 0.8

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[479].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_18 = arg_87_1:GetWordFromCfg(317103022)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 32
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103022", "story_v_out_317103.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_317103", "317103022", "story_v_out_317103.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_out_317103", "317103022", "story_v_out_317103.awb")

						arg_87_1:RecordAudio("317103022", var_90_24)
						arg_87_1:RecordAudio("317103022", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_317103", "317103022", "story_v_out_317103.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_317103", "317103022", "story_v_out_317103.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
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
			local var_94_0 = arg_91_1.actors_["2078ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect2078ui_story == nil then
				arg_91_1.var_.characterEffect2078ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect2078ui_story and not isNil(var_94_0) then
					arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect2078ui_story then
				arg_91_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_94_4 = arg_91_1.actors_["2078ui_story"].transform
			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.var_.moveOldPos2078ui_story = var_94_4.localPosition
			end

			local var_94_6 = 0.001

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 then
				local var_94_7 = (arg_91_1.time_ - var_94_5) / var_94_6
				local var_94_8 = Vector3.New(0, -1.28, -5.6)

				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos2078ui_story, var_94_8, var_94_7)

				local var_94_9 = manager.ui.mainCamera.transform.position - var_94_4.position

				var_94_4.forward = Vector3.New(var_94_9.x, var_94_9.y, var_94_9.z)

				local var_94_10 = var_94_4.localEulerAngles

				var_94_10.z = 0
				var_94_10.x = 0
				var_94_4.localEulerAngles = var_94_10
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_94_11 = manager.ui.mainCamera.transform.position - var_94_4.position

				var_94_4.forward = Vector3.New(var_94_11.x, var_94_11.y, var_94_11.z)

				local var_94_12 = var_94_4.localEulerAngles

				var_94_12.z = 0
				var_94_12.x = 0
				var_94_4.localEulerAngles = var_94_12
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_94_14 = arg_91_1.actors_["1015ui_story"].transform
			local var_94_15 = 0

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.var_.moveOldPos1015ui_story = var_94_14.localPosition
			end

			local var_94_16 = 0.001

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_16 then
				local var_94_17 = (arg_91_1.time_ - var_94_15) / var_94_16
				local var_94_18 = Vector3.New(0, 100, 0)

				var_94_14.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1015ui_story, var_94_18, var_94_17)

				local var_94_19 = manager.ui.mainCamera.transform.position - var_94_14.position

				var_94_14.forward = Vector3.New(var_94_19.x, var_94_19.y, var_94_19.z)

				local var_94_20 = var_94_14.localEulerAngles

				var_94_20.z = 0
				var_94_20.x = 0
				var_94_14.localEulerAngles = var_94_20
			end

			if arg_91_1.time_ >= var_94_15 + var_94_16 and arg_91_1.time_ < var_94_15 + var_94_16 + arg_94_0 then
				var_94_14.localPosition = Vector3.New(0, 100, 0)

				local var_94_21 = manager.ui.mainCamera.transform.position - var_94_14.position

				var_94_14.forward = Vector3.New(var_94_21.x, var_94_21.y, var_94_21.z)

				local var_94_22 = var_94_14.localEulerAngles

				var_94_22.z = 0
				var_94_22.x = 0
				var_94_14.localEulerAngles = var_94_22
			end

			local var_94_23 = 0
			local var_94_24 = 1

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_25 = arg_91_1:FormatText(StoryNameCfg[530].name)

				arg_91_1.leftNameTxt_.text = var_94_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(317103023)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 40
				local var_94_29 = utf8.len(var_94_27)
				local var_94_30 = var_94_28 <= 0 and var_94_24 or var_94_24 * (var_94_29 / var_94_28)

				if var_94_30 > 0 and var_94_24 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103023", "story_v_out_317103.awb") ~= 0 then
					local var_94_31 = manager.audio:GetVoiceLength("story_v_out_317103", "317103023", "story_v_out_317103.awb") / 1000

					if var_94_31 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_31 + var_94_23
					end

					if var_94_26.prefab_name ~= "" and arg_91_1.actors_[var_94_26.prefab_name] ~= nil then
						local var_94_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_26.prefab_name].transform, "story_v_out_317103", "317103023", "story_v_out_317103.awb")

						arg_91_1:RecordAudio("317103023", var_94_32)
						arg_91_1:RecordAudio("317103023", var_94_32)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_317103", "317103023", "story_v_out_317103.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_317103", "317103023", "story_v_out_317103.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_33 = math.max(var_94_24, arg_91_1.talkMaxDuration)

			if var_94_23 <= arg_91_1.time_ and arg_91_1.time_ < var_94_23 + var_94_33 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_23) / var_94_33

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_23 + var_94_33 and arg_91_1.time_ < var_94_23 + var_94_33 + arg_94_0 then
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
			local var_98_0 = arg_95_1.actors_["1093ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1093ui_story == nil then
				arg_95_1.var_.characterEffect1093ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1093ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1093ui_story then
				arg_95_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_98_4 = arg_95_1.actors_["1093ui_story"].transform
			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.var_.moveOldPos1093ui_story = var_98_4.localPosition
			end

			local var_98_6 = 0.001

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 then
				local var_98_7 = (arg_95_1.time_ - var_98_5) / var_98_6
				local var_98_8 = Vector3.New(0, -1.11, -5.88)

				var_98_4.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1093ui_story, var_98_8, var_98_7)

				local var_98_9 = manager.ui.mainCamera.transform.position - var_98_4.position

				var_98_4.forward = Vector3.New(var_98_9.x, var_98_9.y, var_98_9.z)

				local var_98_10 = var_98_4.localEulerAngles

				var_98_10.z = 0
				var_98_10.x = 0
				var_98_4.localEulerAngles = var_98_10
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 then
				var_98_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_98_11 = manager.ui.mainCamera.transform.position - var_98_4.position

				var_98_4.forward = Vector3.New(var_98_11.x, var_98_11.y, var_98_11.z)

				local var_98_12 = var_98_4.localEulerAngles

				var_98_12.z = 0
				var_98_12.x = 0
				var_98_4.localEulerAngles = var_98_12
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_98_15 = arg_95_1.actors_["2078ui_story"].transform
			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1.var_.moveOldPos2078ui_story = var_98_15.localPosition
			end

			local var_98_17 = 0.001

			if var_98_16 <= arg_95_1.time_ and arg_95_1.time_ < var_98_16 + var_98_17 then
				local var_98_18 = (arg_95_1.time_ - var_98_16) / var_98_17
				local var_98_19 = Vector3.New(0, 100, 0)

				var_98_15.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos2078ui_story, var_98_19, var_98_18)

				local var_98_20 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_20.x, var_98_20.y, var_98_20.z)

				local var_98_21 = var_98_15.localEulerAngles

				var_98_21.z = 0
				var_98_21.x = 0
				var_98_15.localEulerAngles = var_98_21
			end

			if arg_95_1.time_ >= var_98_16 + var_98_17 and arg_95_1.time_ < var_98_16 + var_98_17 + arg_98_0 then
				var_98_15.localPosition = Vector3.New(0, 100, 0)

				local var_98_22 = manager.ui.mainCamera.transform.position - var_98_15.position

				var_98_15.forward = Vector3.New(var_98_22.x, var_98_22.y, var_98_22.z)

				local var_98_23 = var_98_15.localEulerAngles

				var_98_23.z = 0
				var_98_23.x = 0
				var_98_15.localEulerAngles = var_98_23
			end

			local var_98_24 = 0
			local var_98_25 = 0.65

			if var_98_24 < arg_95_1.time_ and arg_95_1.time_ <= var_98_24 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_26 = arg_95_1:FormatText(StoryNameCfg[73].name)

				arg_95_1.leftNameTxt_.text = var_98_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_27 = arg_95_1:GetWordFromCfg(317103024)
				local var_98_28 = arg_95_1:FormatText(var_98_27.content)

				arg_95_1.text_.text = var_98_28

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_29 = 26
				local var_98_30 = utf8.len(var_98_28)
				local var_98_31 = var_98_29 <= 0 and var_98_25 or var_98_25 * (var_98_30 / var_98_29)

				if var_98_31 > 0 and var_98_25 < var_98_31 then
					arg_95_1.talkMaxDuration = var_98_31

					if var_98_31 + var_98_24 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_31 + var_98_24
					end
				end

				arg_95_1.text_.text = var_98_28
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103024", "story_v_out_317103.awb") ~= 0 then
					local var_98_32 = manager.audio:GetVoiceLength("story_v_out_317103", "317103024", "story_v_out_317103.awb") / 1000

					if var_98_32 + var_98_24 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_32 + var_98_24
					end

					if var_98_27.prefab_name ~= "" and arg_95_1.actors_[var_98_27.prefab_name] ~= nil then
						local var_98_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_27.prefab_name].transform, "story_v_out_317103", "317103024", "story_v_out_317103.awb")

						arg_95_1:RecordAudio("317103024", var_98_33)
						arg_95_1:RecordAudio("317103024", var_98_33)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317103", "317103024", "story_v_out_317103.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317103", "317103024", "story_v_out_317103.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_34 = math.max(var_98_25, arg_95_1.talkMaxDuration)

			if var_98_24 <= arg_95_1.time_ and arg_95_1.time_ < var_98_24 + var_98_34 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_24) / var_98_34

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_24 + var_98_34 and arg_95_1.time_ < var_98_24 + var_98_34 + arg_98_0 then
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
			local var_102_0 = arg_99_1.actors_["2078ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect2078ui_story == nil then
				arg_99_1.var_.characterEffect2078ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect2078ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect2078ui_story then
				arg_99_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["2078ui_story"].transform
			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.var_.moveOldPos2078ui_story = var_102_4.localPosition
			end

			local var_102_6 = 0.001

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_6 then
				local var_102_7 = (arg_99_1.time_ - var_102_5) / var_102_6
				local var_102_8 = Vector3.New(0, -1.28, -5.6)

				var_102_4.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos2078ui_story, var_102_8, var_102_7)

				local var_102_9 = manager.ui.mainCamera.transform.position - var_102_4.position

				var_102_4.forward = Vector3.New(var_102_9.x, var_102_9.y, var_102_9.z)

				local var_102_10 = var_102_4.localEulerAngles

				var_102_10.z = 0
				var_102_10.x = 0
				var_102_4.localEulerAngles = var_102_10
			end

			if arg_99_1.time_ >= var_102_5 + var_102_6 and arg_99_1.time_ < var_102_5 + var_102_6 + arg_102_0 then
				var_102_4.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_102_11 = manager.ui.mainCamera.transform.position - var_102_4.position

				var_102_4.forward = Vector3.New(var_102_11.x, var_102_11.y, var_102_11.z)

				local var_102_12 = var_102_4.localEulerAngles

				var_102_12.z = 0
				var_102_12.x = 0
				var_102_4.localEulerAngles = var_102_12
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_102_14 = arg_99_1.actors_["1093ui_story"].transform
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.var_.moveOldPos1093ui_story = var_102_14.localPosition
			end

			local var_102_16 = 0.001

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16
				local var_102_18 = Vector3.New(0, 100, 0)

				var_102_14.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1093ui_story, var_102_18, var_102_17)

				local var_102_19 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_19.x, var_102_19.y, var_102_19.z)

				local var_102_20 = var_102_14.localEulerAngles

				var_102_20.z = 0
				var_102_20.x = 0
				var_102_14.localEulerAngles = var_102_20
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 then
				var_102_14.localPosition = Vector3.New(0, 100, 0)

				local var_102_21 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_21.x, var_102_21.y, var_102_21.z)

				local var_102_22 = var_102_14.localEulerAngles

				var_102_22.z = 0
				var_102_22.x = 0
				var_102_14.localEulerAngles = var_102_22
			end

			local var_102_23 = 0
			local var_102_24 = 1.075

			if var_102_23 < arg_99_1.time_ and arg_99_1.time_ <= var_102_23 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_25 = arg_99_1:FormatText(StoryNameCfg[528].name)

				arg_99_1.leftNameTxt_.text = var_102_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_26 = arg_99_1:GetWordFromCfg(317103025)
				local var_102_27 = arg_99_1:FormatText(var_102_26.content)

				arg_99_1.text_.text = var_102_27

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_28 = 43
				local var_102_29 = utf8.len(var_102_27)
				local var_102_30 = var_102_28 <= 0 and var_102_24 or var_102_24 * (var_102_29 / var_102_28)

				if var_102_30 > 0 and var_102_24 < var_102_30 then
					arg_99_1.talkMaxDuration = var_102_30

					if var_102_30 + var_102_23 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_30 + var_102_23
					end
				end

				arg_99_1.text_.text = var_102_27
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103025", "story_v_out_317103.awb") ~= 0 then
					local var_102_31 = manager.audio:GetVoiceLength("story_v_out_317103", "317103025", "story_v_out_317103.awb") / 1000

					if var_102_31 + var_102_23 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_31 + var_102_23
					end

					if var_102_26.prefab_name ~= "" and arg_99_1.actors_[var_102_26.prefab_name] ~= nil then
						local var_102_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_26.prefab_name].transform, "story_v_out_317103", "317103025", "story_v_out_317103.awb")

						arg_99_1:RecordAudio("317103025", var_102_32)
						arg_99_1:RecordAudio("317103025", var_102_32)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317103", "317103025", "story_v_out_317103.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317103", "317103025", "story_v_out_317103.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_33 = math.max(var_102_24, arg_99_1.talkMaxDuration)

			if var_102_23 <= arg_99_1.time_ and arg_99_1.time_ < var_102_23 + var_102_33 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_23) / var_102_33

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_23 + var_102_33 and arg_99_1.time_ < var_102_23 + var_102_33 + arg_102_0 then
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
			local var_106_0 = 0
			local var_106_1 = 0.575

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[528].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(317103026)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 23
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103026", "story_v_out_317103.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_317103", "317103026", "story_v_out_317103.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_317103", "317103026", "story_v_out_317103.awb")

						arg_103_1:RecordAudio("317103026", var_106_9)
						arg_103_1:RecordAudio("317103026", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317103", "317103026", "story_v_out_317103.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317103", "317103026", "story_v_out_317103.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
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
			local var_110_0 = arg_107_1.actors_["2079ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect2079ui_story == nil then
				arg_107_1.var_.characterEffect2079ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect2079ui_story and not isNil(var_110_0) then
					arg_107_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect2079ui_story then
				arg_107_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_110_4 = arg_107_1.actors_["2079ui_story"].transform
			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.var_.moveOldPos2079ui_story = var_110_4.localPosition
			end

			local var_110_6 = 0.001

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6
				local var_110_8 = Vector3.New(0, -1.28, -5.6)

				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos2079ui_story, var_110_8, var_110_7)

				local var_110_9 = manager.ui.mainCamera.transform.position - var_110_4.position

				var_110_4.forward = Vector3.New(var_110_9.x, var_110_9.y, var_110_9.z)

				local var_110_10 = var_110_4.localEulerAngles

				var_110_10.z = 0
				var_110_10.x = 0
				var_110_4.localEulerAngles = var_110_10
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(0, -1.28, -5.6)

				local var_110_11 = manager.ui.mainCamera.transform.position - var_110_4.position

				var_110_4.forward = Vector3.New(var_110_11.x, var_110_11.y, var_110_11.z)

				local var_110_12 = var_110_4.localEulerAngles

				var_110_12.z = 0
				var_110_12.x = 0
				var_110_4.localEulerAngles = var_110_12
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_110_14 = arg_107_1.actors_["2078ui_story"].transform
			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.var_.moveOldPos2078ui_story = var_110_14.localPosition
			end

			local var_110_16 = 0.001

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_16 then
				local var_110_17 = (arg_107_1.time_ - var_110_15) / var_110_16
				local var_110_18 = Vector3.New(0, 100, 0)

				var_110_14.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos2078ui_story, var_110_18, var_110_17)

				local var_110_19 = manager.ui.mainCamera.transform.position - var_110_14.position

				var_110_14.forward = Vector3.New(var_110_19.x, var_110_19.y, var_110_19.z)

				local var_110_20 = var_110_14.localEulerAngles

				var_110_20.z = 0
				var_110_20.x = 0
				var_110_14.localEulerAngles = var_110_20
			end

			if arg_107_1.time_ >= var_110_15 + var_110_16 and arg_107_1.time_ < var_110_15 + var_110_16 + arg_110_0 then
				var_110_14.localPosition = Vector3.New(0, 100, 0)

				local var_110_21 = manager.ui.mainCamera.transform.position - var_110_14.position

				var_110_14.forward = Vector3.New(var_110_21.x, var_110_21.y, var_110_21.z)

				local var_110_22 = var_110_14.localEulerAngles

				var_110_22.z = 0
				var_110_22.x = 0
				var_110_14.localEulerAngles = var_110_22
			end

			local var_110_23 = 0
			local var_110_24 = 0.85

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[530].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(317103027)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 34
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103027", "story_v_out_317103.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_317103", "317103027", "story_v_out_317103.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_317103", "317103027", "story_v_out_317103.awb")

						arg_107_1:RecordAudio("317103027", var_110_32)
						arg_107_1:RecordAudio("317103027", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317103", "317103027", "story_v_out_317103.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317103", "317103027", "story_v_out_317103.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
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
			local var_114_0 = arg_111_1.actors_["1015ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1015ui_story == nil then
				arg_111_1.var_.characterEffect1015ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1015ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1015ui_story then
				arg_111_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["2078ui_story"]
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect2078ui_story == nil then
				arg_111_1.var_.characterEffect2078ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 and not isNil(var_114_4) then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6

				if arg_111_1.var_.characterEffect2078ui_story and not isNil(var_114_4) then
					local var_114_8 = Mathf.Lerp(0, 0.5, var_114_7)

					arg_111_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_111_1.var_.characterEffect2078ui_story.fillRatio = var_114_8
				end
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect2078ui_story then
				local var_114_9 = 0.5

				arg_111_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_111_1.var_.characterEffect2078ui_story.fillRatio = var_114_9
			end

			local var_114_10 = arg_111_1.actors_["1015ui_story"].transform
			local var_114_11 = 0

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.var_.moveOldPos1015ui_story = var_114_10.localPosition
			end

			local var_114_12 = 0.001

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_12 then
				local var_114_13 = (arg_111_1.time_ - var_114_11) / var_114_12
				local var_114_14 = Vector3.New(0, -1.15, -6.2)

				var_114_10.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1015ui_story, var_114_14, var_114_13)

				local var_114_15 = manager.ui.mainCamera.transform.position - var_114_10.position

				var_114_10.forward = Vector3.New(var_114_15.x, var_114_15.y, var_114_15.z)

				local var_114_16 = var_114_10.localEulerAngles

				var_114_16.z = 0
				var_114_16.x = 0
				var_114_10.localEulerAngles = var_114_16
			end

			if arg_111_1.time_ >= var_114_11 + var_114_12 and arg_111_1.time_ < var_114_11 + var_114_12 + arg_114_0 then
				var_114_10.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_114_17 = manager.ui.mainCamera.transform.position - var_114_10.position

				var_114_10.forward = Vector3.New(var_114_17.x, var_114_17.y, var_114_17.z)

				local var_114_18 = var_114_10.localEulerAngles

				var_114_18.z = 0
				var_114_18.x = 0
				var_114_10.localEulerAngles = var_114_18
			end

			local var_114_19 = 0

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_21 = arg_111_1.actors_["2079ui_story"].transform
			local var_114_22 = 0

			if var_114_22 < arg_111_1.time_ and arg_111_1.time_ <= var_114_22 + arg_114_0 then
				arg_111_1.var_.moveOldPos2079ui_story = var_114_21.localPosition
			end

			local var_114_23 = 0.001

			if var_114_22 <= arg_111_1.time_ and arg_111_1.time_ < var_114_22 + var_114_23 then
				local var_114_24 = (arg_111_1.time_ - var_114_22) / var_114_23
				local var_114_25 = Vector3.New(0, 100, 0)

				var_114_21.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos2079ui_story, var_114_25, var_114_24)

				local var_114_26 = manager.ui.mainCamera.transform.position - var_114_21.position

				var_114_21.forward = Vector3.New(var_114_26.x, var_114_26.y, var_114_26.z)

				local var_114_27 = var_114_21.localEulerAngles

				var_114_27.z = 0
				var_114_27.x = 0
				var_114_21.localEulerAngles = var_114_27
			end

			if arg_111_1.time_ >= var_114_22 + var_114_23 and arg_111_1.time_ < var_114_22 + var_114_23 + arg_114_0 then
				var_114_21.localPosition = Vector3.New(0, 100, 0)

				local var_114_28 = manager.ui.mainCamera.transform.position - var_114_21.position

				var_114_21.forward = Vector3.New(var_114_28.x, var_114_28.y, var_114_28.z)

				local var_114_29 = var_114_21.localEulerAngles

				var_114_29.z = 0
				var_114_29.x = 0
				var_114_21.localEulerAngles = var_114_29
			end

			local var_114_30 = 0
			local var_114_31 = 1.3

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_32 = arg_111_1:FormatText(StoryNameCfg[479].name)

				arg_111_1.leftNameTxt_.text = var_114_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(317103028)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 52
				local var_114_36 = utf8.len(var_114_34)
				local var_114_37 = var_114_35 <= 0 and var_114_31 or var_114_31 * (var_114_36 / var_114_35)

				if var_114_37 > 0 and var_114_31 < var_114_37 then
					arg_111_1.talkMaxDuration = var_114_37

					if var_114_37 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_37 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_34
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103028", "story_v_out_317103.awb") ~= 0 then
					local var_114_38 = manager.audio:GetVoiceLength("story_v_out_317103", "317103028", "story_v_out_317103.awb") / 1000

					if var_114_38 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_38 + var_114_30
					end

					if var_114_33.prefab_name ~= "" and arg_111_1.actors_[var_114_33.prefab_name] ~= nil then
						local var_114_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_33.prefab_name].transform, "story_v_out_317103", "317103028", "story_v_out_317103.awb")

						arg_111_1:RecordAudio("317103028", var_114_39)
						arg_111_1:RecordAudio("317103028", var_114_39)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_317103", "317103028", "story_v_out_317103.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_317103", "317103028", "story_v_out_317103.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_40 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_30 <= arg_111_1.time_ and arg_111_1.time_ < var_114_30 + var_114_40 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_30) / var_114_40

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_30 + var_114_40 and arg_111_1.time_ < var_114_30 + var_114_40 + arg_114_0 then
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
			local var_118_0 = arg_115_1.actors_["1093ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1093ui_story == nil then
				arg_115_1.var_.characterEffect1093ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1093ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1093ui_story then
				arg_115_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_118_4 = arg_115_1.actors_["1093ui_story"].transform
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.var_.moveOldPos1093ui_story = var_118_4.localPosition
			end

			local var_118_6 = 0.001

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 then
				local var_118_7 = (arg_115_1.time_ - var_118_5) / var_118_6
				local var_118_8 = Vector3.New(0, -1.11, -5.88)

				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1093ui_story, var_118_8, var_118_7)

				local var_118_9 = manager.ui.mainCamera.transform.position - var_118_4.position

				var_118_4.forward = Vector3.New(var_118_9.x, var_118_9.y, var_118_9.z)

				local var_118_10 = var_118_4.localEulerAngles

				var_118_10.z = 0
				var_118_10.x = 0
				var_118_4.localEulerAngles = var_118_10
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_118_11 = manager.ui.mainCamera.transform.position - var_118_4.position

				var_118_4.forward = Vector3.New(var_118_11.x, var_118_11.y, var_118_11.z)

				local var_118_12 = var_118_4.localEulerAngles

				var_118_12.z = 0
				var_118_12.x = 0
				var_118_4.localEulerAngles = var_118_12
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_15 = arg_115_1.actors_["1015ui_story"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos1015ui_story = var_118_15.localPosition
			end

			local var_118_17 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_17 then
				local var_118_18 = (arg_115_1.time_ - var_118_16) / var_118_17
				local var_118_19 = Vector3.New(0, 100, 0)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1015ui_story, var_118_19, var_118_18)

				local var_118_20 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_20.x, var_118_20.y, var_118_20.z)

				local var_118_21 = var_118_15.localEulerAngles

				var_118_21.z = 0
				var_118_21.x = 0
				var_118_15.localEulerAngles = var_118_21
			end

			if arg_115_1.time_ >= var_118_16 + var_118_17 and arg_115_1.time_ < var_118_16 + var_118_17 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(0, 100, 0)

				local var_118_22 = manager.ui.mainCamera.transform.position - var_118_15.position

				var_118_15.forward = Vector3.New(var_118_22.x, var_118_22.y, var_118_22.z)

				local var_118_23 = var_118_15.localEulerAngles

				var_118_23.z = 0
				var_118_23.x = 0
				var_118_15.localEulerAngles = var_118_23
			end

			local var_118_24 = 0
			local var_118_25 = 0.125

			if var_118_24 < arg_115_1.time_ and arg_115_1.time_ <= var_118_24 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_26 = arg_115_1:FormatText(StoryNameCfg[73].name)

				arg_115_1.leftNameTxt_.text = var_118_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_27 = arg_115_1:GetWordFromCfg(317103029)
				local var_118_28 = arg_115_1:FormatText(var_118_27.content)

				arg_115_1.text_.text = var_118_28

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_29 = 5
				local var_118_30 = utf8.len(var_118_28)
				local var_118_31 = var_118_29 <= 0 and var_118_25 or var_118_25 * (var_118_30 / var_118_29)

				if var_118_31 > 0 and var_118_25 < var_118_31 then
					arg_115_1.talkMaxDuration = var_118_31

					if var_118_31 + var_118_24 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_31 + var_118_24
					end
				end

				arg_115_1.text_.text = var_118_28
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103029", "story_v_out_317103.awb") ~= 0 then
					local var_118_32 = manager.audio:GetVoiceLength("story_v_out_317103", "317103029", "story_v_out_317103.awb") / 1000

					if var_118_32 + var_118_24 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_32 + var_118_24
					end

					if var_118_27.prefab_name ~= "" and arg_115_1.actors_[var_118_27.prefab_name] ~= nil then
						local var_118_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_27.prefab_name].transform, "story_v_out_317103", "317103029", "story_v_out_317103.awb")

						arg_115_1:RecordAudio("317103029", var_118_33)
						arg_115_1:RecordAudio("317103029", var_118_33)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317103", "317103029", "story_v_out_317103.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317103", "317103029", "story_v_out_317103.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_34 = math.max(var_118_25, arg_115_1.talkMaxDuration)

			if var_118_24 <= arg_115_1.time_ and arg_115_1.time_ < var_118_24 + var_118_34 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_24) / var_118_34

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_24 + var_118_34 and arg_115_1.time_ < var_118_24 + var_118_34 + arg_118_0 then
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
			local var_122_0 = arg_119_1.actors_["1093ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1093ui_story == nil then
				arg_119_1.var_.characterEffect1093ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1093ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1093ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1093ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1093ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0
			local var_122_7 = 0.725

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(317103030)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 29
				local var_122_11 = utf8.len(var_122_9)
				local var_122_12 = var_122_10 <= 0 and var_122_7 or var_122_7 * (var_122_11 / var_122_10)

				if var_122_12 > 0 and var_122_7 < var_122_12 then
					arg_119_1.talkMaxDuration = var_122_12

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_13 and arg_119_1.time_ < var_122_6 + var_122_13 + arg_122_0 then
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
			local var_126_0 = arg_123_1.actors_["1015ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1015ui_story == nil then
				arg_123_1.var_.characterEffect1015ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1015ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1015ui_story then
				arg_123_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["1015ui_story"].transform
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.var_.moveOldPos1015ui_story = var_126_4.localPosition
			end

			local var_126_6 = 0.001

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6
				local var_126_8 = Vector3.New(0, -1.15, -6.2)

				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1015ui_story, var_126_8, var_126_7)

				local var_126_9 = manager.ui.mainCamera.transform.position - var_126_4.position

				var_126_4.forward = Vector3.New(var_126_9.x, var_126_9.y, var_126_9.z)

				local var_126_10 = var_126_4.localEulerAngles

				var_126_10.z = 0
				var_126_10.x = 0
				var_126_4.localEulerAngles = var_126_10
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_126_11 = manager.ui.mainCamera.transform.position - var_126_4.position

				var_126_4.forward = Vector3.New(var_126_11.x, var_126_11.y, var_126_11.z)

				local var_126_12 = var_126_4.localEulerAngles

				var_126_12.z = 0
				var_126_12.x = 0
				var_126_4.localEulerAngles = var_126_12
			end

			local var_126_13 = 0

			if var_126_13 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_126_14 = 0

			if var_126_14 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_15 = arg_123_1.actors_["1093ui_story"].transform
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.var_.moveOldPos1093ui_story = var_126_15.localPosition
			end

			local var_126_17 = 0.001

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17
				local var_126_19 = Vector3.New(0, 100, 0)

				var_126_15.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1093ui_story, var_126_19, var_126_18)

				local var_126_20 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_20.x, var_126_20.y, var_126_20.z)

				local var_126_21 = var_126_15.localEulerAngles

				var_126_21.z = 0
				var_126_21.x = 0
				var_126_15.localEulerAngles = var_126_21
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				var_126_15.localPosition = Vector3.New(0, 100, 0)

				local var_126_22 = manager.ui.mainCamera.transform.position - var_126_15.position

				var_126_15.forward = Vector3.New(var_126_22.x, var_126_22.y, var_126_22.z)

				local var_126_23 = var_126_15.localEulerAngles

				var_126_23.z = 0
				var_126_23.x = 0
				var_126_15.localEulerAngles = var_126_23
			end

			local var_126_24 = 0
			local var_126_25 = 0.075

			if var_126_24 < arg_123_1.time_ and arg_123_1.time_ <= var_126_24 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_26 = arg_123_1:FormatText(StoryNameCfg[479].name)

				arg_123_1.leftNameTxt_.text = var_126_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_27 = arg_123_1:GetWordFromCfg(317103031)
				local var_126_28 = arg_123_1:FormatText(var_126_27.content)

				arg_123_1.text_.text = var_126_28

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_29 = 3
				local var_126_30 = utf8.len(var_126_28)
				local var_126_31 = var_126_29 <= 0 and var_126_25 or var_126_25 * (var_126_30 / var_126_29)

				if var_126_31 > 0 and var_126_25 < var_126_31 then
					arg_123_1.talkMaxDuration = var_126_31

					if var_126_31 + var_126_24 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_31 + var_126_24
					end
				end

				arg_123_1.text_.text = var_126_28
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103031", "story_v_out_317103.awb") ~= 0 then
					local var_126_32 = manager.audio:GetVoiceLength("story_v_out_317103", "317103031", "story_v_out_317103.awb") / 1000

					if var_126_32 + var_126_24 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_32 + var_126_24
					end

					if var_126_27.prefab_name ~= "" and arg_123_1.actors_[var_126_27.prefab_name] ~= nil then
						local var_126_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_27.prefab_name].transform, "story_v_out_317103", "317103031", "story_v_out_317103.awb")

						arg_123_1:RecordAudio("317103031", var_126_33)
						arg_123_1:RecordAudio("317103031", var_126_33)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_317103", "317103031", "story_v_out_317103.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_317103", "317103031", "story_v_out_317103.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_34 = math.max(var_126_25, arg_123_1.talkMaxDuration)

			if var_126_24 <= arg_123_1.time_ and arg_123_1.time_ < var_126_24 + var_126_34 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_24) / var_126_34

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_24 + var_126_34 and arg_123_1.time_ < var_126_24 + var_126_34 + arg_126_0 then
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
			local var_130_0 = arg_127_1.actors_["1093ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1093ui_story == nil then
				arg_127_1.var_.characterEffect1093ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1093ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1093ui_story then
				arg_127_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["1093ui_story"].transform
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.var_.moveOldPos1093ui_story = var_130_4.localPosition
			end

			local var_130_6 = 0.001

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = (arg_127_1.time_ - var_130_5) / var_130_6
				local var_130_8 = Vector3.New(0, -1.11, -5.88)

				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1093ui_story, var_130_8, var_130_7)

				local var_130_9 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_9.x, var_130_9.y, var_130_9.z)

				local var_130_10 = var_130_4.localEulerAngles

				var_130_10.z = 0
				var_130_10.x = 0
				var_130_4.localEulerAngles = var_130_10
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_130_11 = manager.ui.mainCamera.transform.position - var_130_4.position

				var_130_4.forward = Vector3.New(var_130_11.x, var_130_11.y, var_130_11.z)

				local var_130_12 = var_130_4.localEulerAngles

				var_130_12.z = 0
				var_130_12.x = 0
				var_130_4.localEulerAngles = var_130_12
			end

			local var_130_13 = 0

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_130_15 = arg_127_1.actors_["1015ui_story"].transform
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.var_.moveOldPos1015ui_story = var_130_15.localPosition
			end

			local var_130_17 = 0.001

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Vector3.New(0, 100, 0)

				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1015ui_story, var_130_19, var_130_18)

				local var_130_20 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_20.x, var_130_20.y, var_130_20.z)

				local var_130_21 = var_130_15.localEulerAngles

				var_130_21.z = 0
				var_130_21.x = 0
				var_130_15.localEulerAngles = var_130_21
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(0, 100, 0)

				local var_130_22 = manager.ui.mainCamera.transform.position - var_130_15.position

				var_130_15.forward = Vector3.New(var_130_22.x, var_130_22.y, var_130_22.z)

				local var_130_23 = var_130_15.localEulerAngles

				var_130_23.z = 0
				var_130_23.x = 0
				var_130_15.localEulerAngles = var_130_23
			end

			local var_130_24 = 0
			local var_130_25 = 0.425

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_26 = arg_127_1:FormatText(StoryNameCfg[73].name)

				arg_127_1.leftNameTxt_.text = var_130_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_27 = arg_127_1:GetWordFromCfg(317103032)
				local var_130_28 = arg_127_1:FormatText(var_130_27.content)

				arg_127_1.text_.text = var_130_28

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_29 = 17
				local var_130_30 = utf8.len(var_130_28)
				local var_130_31 = var_130_29 <= 0 and var_130_25 or var_130_25 * (var_130_30 / var_130_29)

				if var_130_31 > 0 and var_130_25 < var_130_31 then
					arg_127_1.talkMaxDuration = var_130_31

					if var_130_31 + var_130_24 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_31 + var_130_24
					end
				end

				arg_127_1.text_.text = var_130_28
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103032", "story_v_out_317103.awb") ~= 0 then
					local var_130_32 = manager.audio:GetVoiceLength("story_v_out_317103", "317103032", "story_v_out_317103.awb") / 1000

					if var_130_32 + var_130_24 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_32 + var_130_24
					end

					if var_130_27.prefab_name ~= "" and arg_127_1.actors_[var_130_27.prefab_name] ~= nil then
						local var_130_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_27.prefab_name].transform, "story_v_out_317103", "317103032", "story_v_out_317103.awb")

						arg_127_1:RecordAudio("317103032", var_130_33)
						arg_127_1:RecordAudio("317103032", var_130_33)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_317103", "317103032", "story_v_out_317103.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_317103", "317103032", "story_v_out_317103.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_34 = math.max(var_130_25, arg_127_1.talkMaxDuration)

			if var_130_24 <= arg_127_1.time_ and arg_127_1.time_ < var_130_24 + var_130_34 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_24) / var_130_34

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_24 + var_130_34 and arg_127_1.time_ < var_130_24 + var_130_34 + arg_130_0 then
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
			local var_134_0 = arg_131_1.actors_["1015ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1015ui_story == nil then
				arg_131_1.var_.characterEffect1015ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1015ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1015ui_story then
				arg_131_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1015ui_story"].transform
			local var_134_5 = 0

			if var_134_5 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.var_.moveOldPos1015ui_story = var_134_4.localPosition
			end

			local var_134_6 = 0.001

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_6 then
				local var_134_7 = (arg_131_1.time_ - var_134_5) / var_134_6
				local var_134_8 = Vector3.New(0, -1.15, -6.2)

				var_134_4.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1015ui_story, var_134_8, var_134_7)

				local var_134_9 = manager.ui.mainCamera.transform.position - var_134_4.position

				var_134_4.forward = Vector3.New(var_134_9.x, var_134_9.y, var_134_9.z)

				local var_134_10 = var_134_4.localEulerAngles

				var_134_10.z = 0
				var_134_10.x = 0
				var_134_4.localEulerAngles = var_134_10
			end

			if arg_131_1.time_ >= var_134_5 + var_134_6 and arg_131_1.time_ < var_134_5 + var_134_6 + arg_134_0 then
				var_134_4.localPosition = Vector3.New(0, -1.15, -6.2)

				local var_134_11 = manager.ui.mainCamera.transform.position - var_134_4.position

				var_134_4.forward = Vector3.New(var_134_11.x, var_134_11.y, var_134_11.z)

				local var_134_12 = var_134_4.localEulerAngles

				var_134_12.z = 0
				var_134_12.x = 0
				var_134_4.localEulerAngles = var_134_12
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_15 = arg_131_1.actors_["1093ui_story"].transform
			local var_134_16 = 0

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.var_.moveOldPos1093ui_story = var_134_15.localPosition
			end

			local var_134_17 = 0.001

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_17 then
				local var_134_18 = (arg_131_1.time_ - var_134_16) / var_134_17
				local var_134_19 = Vector3.New(0, 100, 0)

				var_134_15.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1093ui_story, var_134_19, var_134_18)

				local var_134_20 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_20.x, var_134_20.y, var_134_20.z)

				local var_134_21 = var_134_15.localEulerAngles

				var_134_21.z = 0
				var_134_21.x = 0
				var_134_15.localEulerAngles = var_134_21
			end

			if arg_131_1.time_ >= var_134_16 + var_134_17 and arg_131_1.time_ < var_134_16 + var_134_17 + arg_134_0 then
				var_134_15.localPosition = Vector3.New(0, 100, 0)

				local var_134_22 = manager.ui.mainCamera.transform.position - var_134_15.position

				var_134_15.forward = Vector3.New(var_134_22.x, var_134_22.y, var_134_22.z)

				local var_134_23 = var_134_15.localEulerAngles

				var_134_23.z = 0
				var_134_23.x = 0
				var_134_15.localEulerAngles = var_134_23
			end

			local var_134_24 = 0
			local var_134_25 = 0.35

			if var_134_24 < arg_131_1.time_ and arg_131_1.time_ <= var_134_24 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_26 = arg_131_1:FormatText(StoryNameCfg[479].name)

				arg_131_1.leftNameTxt_.text = var_134_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_27 = arg_131_1:GetWordFromCfg(317103033)
				local var_134_28 = arg_131_1:FormatText(var_134_27.content)

				arg_131_1.text_.text = var_134_28

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_29 = 14
				local var_134_30 = utf8.len(var_134_28)
				local var_134_31 = var_134_29 <= 0 and var_134_25 or var_134_25 * (var_134_30 / var_134_29)

				if var_134_31 > 0 and var_134_25 < var_134_31 then
					arg_131_1.talkMaxDuration = var_134_31

					if var_134_31 + var_134_24 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_31 + var_134_24
					end
				end

				arg_131_1.text_.text = var_134_28
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317103", "317103033", "story_v_out_317103.awb") ~= 0 then
					local var_134_32 = manager.audio:GetVoiceLength("story_v_out_317103", "317103033", "story_v_out_317103.awb") / 1000

					if var_134_32 + var_134_24 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_32 + var_134_24
					end

					if var_134_27.prefab_name ~= "" and arg_131_1.actors_[var_134_27.prefab_name] ~= nil then
						local var_134_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_27.prefab_name].transform, "story_v_out_317103", "317103033", "story_v_out_317103.awb")

						arg_131_1:RecordAudio("317103033", var_134_33)
						arg_131_1:RecordAudio("317103033", var_134_33)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_317103", "317103033", "story_v_out_317103.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_317103", "317103033", "story_v_out_317103.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_34 = math.max(var_134_25, arg_131_1.talkMaxDuration)

			if var_134_24 <= arg_131_1.time_ and arg_131_1.time_ < var_134_24 + var_134_34 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_24) / var_134_34

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_24 + var_134_34 and arg_131_1.time_ < var_134_24 + var_134_34 + arg_134_0 then
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
