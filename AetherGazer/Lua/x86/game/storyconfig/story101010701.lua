return {
	Play101071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_6 = "A00"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = arg_1_1.bgs_.A00
			local var_4_9 = 0

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				local var_4_10 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_10 then
					arg_1_1.var_.alphaOldValueA00 = var_4_10.color.a
					arg_1_1.var_.alphaMatValueA00 = var_4_10
				end

				arg_1_1.var_.alphaOldValueA00 = 0
			end

			local var_4_11 = 1.5

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_11 then
				local var_4_12 = (arg_1_1.time_ - var_4_9) / var_4_11
				local var_4_13 = Mathf.Lerp(arg_1_1.var_.alphaOldValueA00, 1, var_4_12)

				if arg_1_1.var_.alphaMatValueA00 then
					local var_4_14 = arg_1_1.var_.alphaMatValueA00.color

					var_4_14.a = var_4_13
					arg_1_1.var_.alphaMatValueA00.color = var_4_14
				end
			end

			if arg_1_1.time_ >= var_4_9 + var_4_11 and arg_1_1.time_ < var_4_9 + var_4_11 + arg_4_0 and arg_1_1.var_.alphaMatValueA00 then
				local var_4_15 = arg_1_1.var_.alphaMatValueA00
				local var_4_16 = var_4_15.color

				var_4_16.a = 1
				var_4_15.color = var_4_16
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = manager.ui.mainCamera.transform.localPosition
				local var_4_19 = Vector3.New(0, 0, 10) + Vector3.New(var_4_18.x, var_4_18.y, 0)
				local var_4_20 = arg_1_1.bgs_.A00

				var_4_20.transform.localPosition = var_4_19
				var_4_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_21 = var_4_20:GetComponent("SpriteRenderer")

				if var_4_21 and var_4_21.sprite then
					local var_4_22 = (var_4_20.transform.localPosition - var_4_18).z
					local var_4_23 = manager.ui.mainCameraCom_
					local var_4_24 = 2 * var_4_22 * Mathf.Tan(var_4_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_25 = var_4_24 * var_4_23.aspect
					local var_4_26 = var_4_21.sprite.bounds.size.x
					local var_4_27 = var_4_21.sprite.bounds.size.y
					local var_4_28 = var_4_25 / var_4_26
					local var_4_29 = var_4_24 / var_4_27
					local var_4_30 = var_4_29 < var_4_28 and var_4_28 or var_4_29

					var_4_20.transform.localScale = Vector3.New(var_4_30, var_4_30, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A00" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 2

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 2
			local var_4_34 = 0.25

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_36 = arg_1_1:GetWordFromCfg(101071001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 10
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_34 or var_4_34 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_34 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_33 = var_4_33 + 0.3

					if var_4_40 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_33 + 0.3
			local var_4_42 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play101071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 101071002
		arg_8_1.duration_ = 3.63

		local var_8_0 = {
			ja = 2.966,
			ko = 2.3,
			zh = 2.266,
			en = 3.633
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play101071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["1084ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(0, -0.97, -6)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_11_20 = 0
			local var_11_21 = 0.275

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_23 = arg_8_1:GetWordFromCfg(101071002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 11
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_21 or var_11_21 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_21 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071002", "story_v_out_101071.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_101071", "101071002", "story_v_out_101071.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_101071", "101071002", "story_v_out_101071.awb")

						arg_8_1:RecordAudio("101071002", var_11_29)
						arg_8_1:RecordAudio("101071002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_101071", "101071002", "story_v_out_101071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_101071", "101071002", "story_v_out_101071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_30 and arg_8_1.time_ < var_11_20 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play101071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 101071003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play101071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1084ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.475

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(101071003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 19
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play101071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 101071004
		arg_16_1.duration_ = 6.13

		local var_16_0 = {
			ja = 6.133,
			ko = 1.999999999999,
			zh = 3.533,
			en = 2.533
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play101071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1019ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1019ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_9.localPosition
			end

			local var_19_11 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11
				local var_19_13 = Vector3.New(0, -0.97, -6)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_13, var_19_12)

				local var_19_14 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_14.x, var_19_14.y, var_19_14.z)

				local var_19_15 = var_19_9.localEulerAngles

				var_19_15.z = 0
				var_19_15.x = 0
				var_19_9.localEulerAngles = var_19_15
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_9.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_9.localEulerAngles = var_19_17
			end

			local var_19_18 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_19 = 0.033

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_18.localPosition
			end

			local var_19_20 = 0.5

			if var_19_19 <= arg_16_1.time_ and arg_16_1.time_ < var_19_19 + var_19_20 then
				local var_19_21 = (arg_16_1.time_ - var_19_19) / var_19_20
				local var_19_22 = Vector3.New(0.7, -0.97, -6)

				var_19_18.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_22, var_19_21)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_18.position

				var_19_18.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_18.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_18.localEulerAngles = var_19_24
			end

			if arg_16_1.time_ >= var_19_19 + var_19_20 and arg_16_1.time_ < var_19_19 + var_19_20 + arg_19_0 then
				var_19_18.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_19_25 = manager.ui.mainCamera.transform.position - var_19_18.position

				var_19_18.forward = Vector3.New(var_19_25.x, var_19_25.y, var_19_25.z)

				local var_19_26 = var_19_18.localEulerAngles

				var_19_26.z = 0
				var_19_26.x = 0
				var_19_18.localEulerAngles = var_19_26
			end

			local var_19_27 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_28 = 0

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_27.localPosition
			end

			local var_19_29 = 0.001

			if var_19_28 <= arg_16_1.time_ and arg_16_1.time_ < var_19_28 + var_19_29 then
				local var_19_30 = (arg_16_1.time_ - var_19_28) / var_19_29
				local var_19_31 = Vector3.New(-0.7, -1.08, -5.9)

				var_19_27.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_31, var_19_30)

				local var_19_32 = manager.ui.mainCamera.transform.position - var_19_27.position

				var_19_27.forward = Vector3.New(var_19_32.x, var_19_32.y, var_19_32.z)

				local var_19_33 = var_19_27.localEulerAngles

				var_19_33.z = 0
				var_19_33.x = 0
				var_19_27.localEulerAngles = var_19_33
			end

			if arg_16_1.time_ >= var_19_28 + var_19_29 and arg_16_1.time_ < var_19_28 + var_19_29 + arg_19_0 then
				var_19_27.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_19_34 = manager.ui.mainCamera.transform.position - var_19_27.position

				var_19_27.forward = Vector3.New(var_19_34.x, var_19_34.y, var_19_34.z)

				local var_19_35 = var_19_27.localEulerAngles

				var_19_35.z = 0
				var_19_35.x = 0
				var_19_27.localEulerAngles = var_19_35
			end

			local var_19_36 = 0

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_19_37 = 0

			if var_19_37 < arg_16_1.time_ and arg_16_1.time_ <= var_19_37 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_38 = 0
			local var_19_39 = 0.4

			if var_19_38 < arg_16_1.time_ and arg_16_1.time_ <= var_19_38 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_40 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_41 = arg_16_1:GetWordFromCfg(101071004)
				local var_19_42 = arg_16_1:FormatText(var_19_41.content)

				arg_16_1.text_.text = var_19_42

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_43 = 16
				local var_19_44 = utf8.len(var_19_42)
				local var_19_45 = var_19_43 <= 0 and var_19_39 or var_19_39 * (var_19_44 / var_19_43)

				if var_19_45 > 0 and var_19_39 < var_19_45 then
					arg_16_1.talkMaxDuration = var_19_45

					if var_19_45 + var_19_38 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_45 + var_19_38
					end
				end

				arg_16_1.text_.text = var_19_42
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071004", "story_v_out_101071.awb") ~= 0 then
					local var_19_46 = manager.audio:GetVoiceLength("story_v_out_101071", "101071004", "story_v_out_101071.awb") / 1000

					if var_19_46 + var_19_38 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_46 + var_19_38
					end

					if var_19_41.prefab_name ~= "" and arg_16_1.actors_[var_19_41.prefab_name] ~= nil then
						local var_19_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_41.prefab_name].transform, "story_v_out_101071", "101071004", "story_v_out_101071.awb")

						arg_16_1:RecordAudio("101071004", var_19_47)
						arg_16_1:RecordAudio("101071004", var_19_47)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_101071", "101071004", "story_v_out_101071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_101071", "101071004", "story_v_out_101071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_48 = math.max(var_19_39, arg_16_1.talkMaxDuration)

			if var_19_38 <= arg_16_1.time_ and arg_16_1.time_ < var_19_38 + var_19_48 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_38) / var_19_48

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_38 + var_19_48 and arg_16_1.time_ < var_19_38 + var_19_48 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play101071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 101071005
		arg_20_1.duration_ = 5.7

		local var_20_0 = {
			ja = 4.5,
			ko = 5.7,
			zh = 4,
			en = 5.066
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play101071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1084ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_23_4 = 0

			if var_23_4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action427")
			end

			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.45

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:GetWordFromCfg(101071005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 18
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071005", "story_v_out_101071.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071005", "story_v_out_101071.awb") / 1000

					if var_23_14 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_6
					end

					if var_23_9.prefab_name ~= "" and arg_20_1.actors_[var_23_9.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_9.prefab_name].transform, "story_v_out_101071", "101071005", "story_v_out_101071.awb")

						arg_20_1:RecordAudio("101071005", var_23_15)
						arg_20_1:RecordAudio("101071005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_101071", "101071005", "story_v_out_101071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_101071", "101071005", "story_v_out_101071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_16 and arg_20_1.time_ < var_23_6 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play101071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 101071006
		arg_24_1.duration_ = 0.1

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"

			SetActive(arg_24_1.choicesGo_, true)

			for iter_25_0, iter_25_1 in ipairs(arg_24_1.choices_) do
				local var_25_0 = iter_25_0 <= 2

				SetActive(iter_25_1.go, var_25_0)
			end

			arg_24_1.choices_[1].txt.text = arg_24_1:FormatText(StoryChoiceCfg[10].name)
			arg_24_1.choices_[2].txt.text = arg_24_1:FormatText(StoryChoiceCfg[11].name)
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play101071007(arg_24_1)
			end

			if arg_26_0 == 2 then
				arg_24_0:Play101071007(arg_24_1)
			end

			arg_24_1:RecordChoiceLog(101071006, 10, 11)
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1084ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1084ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = var_27_5
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play101071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 101071007
		arg_28_1.duration_ = 15.13

		local var_28_0 = {
			ja = 15.133,
			ko = 7.933,
			zh = 7.066,
			en = 7.766
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play101071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1019ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_4 = "1019ui_story"

			if arg_28_1.actors_[var_31_4] == nil then
				local var_31_5 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_31_5) then
					local var_31_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

					var_31_6.name = var_31_4
					var_31_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_4] = var_31_6

					local var_31_7 = var_31_6:GetComponentInChildren(typeof(CharacterEffect))

					var_31_7.enabled = true

					local var_31_8 = GameObjectTools.GetOrAddComponent(var_31_6, typeof(DynamicBoneHelper))

					if var_31_8 then
						var_31_8:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_7.transform, false)

					arg_28_1.var_[var_31_4 .. "Animator"] = var_31_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_4 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_4 .. "LipSync"] = var_31_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_9 = 0

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_31_10 = "1019ui_story"

			if arg_28_1.actors_[var_31_10] == nil then
				local var_31_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_31_11) then
					local var_31_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

					var_31_12.name = var_31_10
					var_31_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_10] = var_31_12

					local var_31_13 = var_31_12:GetComponentInChildren(typeof(CharacterEffect))

					var_31_13.enabled = true

					local var_31_14 = GameObjectTools.GetOrAddComponent(var_31_12, typeof(DynamicBoneHelper))

					if var_31_14 then
						var_31_14:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_13.transform, false)

					arg_28_1.var_[var_31_10 .. "Animator"] = var_31_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_10 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_10 .. "LipSync"] = var_31_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_16 = 0
			local var_31_17 = 0.9

			if var_31_16 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_18 = arg_28_1:FormatText(StoryNameCfg[13].name)

				arg_28_1.leftNameTxt_.text = var_31_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_19 = arg_28_1:GetWordFromCfg(101071007)
				local var_31_20 = arg_28_1:FormatText(var_31_19.content)

				arg_28_1.text_.text = var_31_20

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 35
				local var_31_22 = utf8.len(var_31_20)
				local var_31_23 = var_31_21 <= 0 and var_31_17 or var_31_17 * (var_31_22 / var_31_21)

				if var_31_23 > 0 and var_31_17 < var_31_23 then
					arg_28_1.talkMaxDuration = var_31_23

					if var_31_23 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_16
					end
				end

				arg_28_1.text_.text = var_31_20
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071007", "story_v_out_101071.awb") ~= 0 then
					local var_31_24 = manager.audio:GetVoiceLength("story_v_out_101071", "101071007", "story_v_out_101071.awb") / 1000

					if var_31_24 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_24 + var_31_16
					end

					if var_31_19.prefab_name ~= "" and arg_28_1.actors_[var_31_19.prefab_name] ~= nil then
						local var_31_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_19.prefab_name].transform, "story_v_out_101071", "101071007", "story_v_out_101071.awb")

						arg_28_1:RecordAudio("101071007", var_31_25)
						arg_28_1:RecordAudio("101071007", var_31_25)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_101071", "101071007", "story_v_out_101071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_101071", "101071007", "story_v_out_101071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_26 = math.max(var_31_17, arg_28_1.talkMaxDuration)

			if var_31_16 <= arg_28_1.time_ and arg_28_1.time_ < var_31_16 + var_31_26 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_16) / var_31_26

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_16 + var_31_26 and arg_28_1.time_ < var_31_16 + var_31_26 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play101071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 101071008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play101071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1019ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1019ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_35_7 = 0
			local var_35_8 = 0.325

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_9 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_10 = arg_32_1:GetWordFromCfg(101071008)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 13
				local var_35_13 = utf8.len(var_35_11)
				local var_35_14 = var_35_12 <= 0 and var_35_8 or var_35_8 * (var_35_13 / var_35_12)

				if var_35_14 > 0 and var_35_8 < var_35_14 then
					arg_32_1.talkMaxDuration = var_35_14

					if var_35_14 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_15 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_7) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_7 + var_35_15 and arg_32_1.time_ < var_35_7 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play101071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 101071009
		arg_36_1.duration_ = 4.3

		local var_36_0 = {
			ja = 4.3,
			ko = 2.833,
			zh = 2.2,
			en = 2
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play101071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1019ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_39_5 = 0
			local var_39_6 = 0.3

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_7 = arg_36_1:FormatText(StoryNameCfg[13].name)

				arg_36_1.leftNameTxt_.text = var_39_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(101071009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 12
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_6 or var_39_6 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_6 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071009", "story_v_out_101071.awb") ~= 0 then
					local var_39_13 = manager.audio:GetVoiceLength("story_v_out_101071", "101071009", "story_v_out_101071.awb") / 1000

					if var_39_13 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_5
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_101071", "101071009", "story_v_out_101071.awb")

						arg_36_1:RecordAudio("101071009", var_39_14)
						arg_36_1:RecordAudio("101071009", var_39_14)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_101071", "101071009", "story_v_out_101071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_101071", "101071009", "story_v_out_101071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_15 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_15 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_15

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_15 and arg_36_1.time_ < var_39_5 + var_39_15 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play101071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 101071010
		arg_40_1.duration_ = 4.5

		local var_40_0 = {
			ja = 4.5,
			ko = 2.933,
			zh = 2.033,
			en = 2.5
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play101071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1019ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1019ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1019ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action476")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_43_12 = 0
			local var_43_13 = 0.225

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(101071010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 8
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071010", "story_v_out_101071.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071010", "story_v_out_101071.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_101071", "101071010", "story_v_out_101071.awb")

						arg_40_1:RecordAudio("101071010", var_43_21)
						arg_40_1:RecordAudio("101071010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_101071", "101071010", "story_v_out_101071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_101071", "101071010", "story_v_out_101071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play101071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 101071011
		arg_44_1.duration_ = 17.33

		local var_44_0 = {
			ja = 17.333,
			ko = 10.766,
			zh = 10.9,
			en = 10.533
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play101071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1019ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1084ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_12 = 0
			local var_47_13 = 1.475

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(101071011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 59
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071011", "story_v_out_101071.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071011", "story_v_out_101071.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_101071", "101071011", "story_v_out_101071.awb")

						arg_44_1:RecordAudio("101071011", var_47_21)
						arg_44_1:RecordAudio("101071011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_101071", "101071011", "story_v_out_101071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_101071", "101071011", "story_v_out_101071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play101071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 101071012
		arg_48_1.duration_ = 6.7

		local var_48_0 = {
			ja = 6.7,
			ko = 4.433,
			zh = 4.166,
			en = 3.3
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play101071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4613")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_12 = 0
			local var_51_13 = 0.45

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(101071012)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 18
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071012", "story_v_out_101071.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071012", "story_v_out_101071.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_101071", "101071012", "story_v_out_101071.awb")

						arg_48_1:RecordAudio("101071012", var_51_21)
						arg_48_1:RecordAudio("101071012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_101071", "101071012", "story_v_out_101071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_101071", "101071012", "story_v_out_101071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play101071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 101071013
		arg_52_1.duration_ = 4.83

		local var_52_0 = {
			ja = 4.833,
			ko = 3.333,
			zh = 3.566,
			en = 3.5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play101071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1019ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1084ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_11 = 0
			local var_55_12 = 0.425

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_13 = arg_52_1:FormatText(StoryNameCfg[13].name)

				arg_52_1.leftNameTxt_.text = var_55_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(101071013)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_16 = 17
				local var_55_17 = utf8.len(var_55_15)
				local var_55_18 = var_55_16 <= 0 and var_55_12 or var_55_12 * (var_55_17 / var_55_16)

				if var_55_18 > 0 and var_55_12 < var_55_18 then
					arg_52_1.talkMaxDuration = var_55_18

					if var_55_18 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071013", "story_v_out_101071.awb") ~= 0 then
					local var_55_19 = manager.audio:GetVoiceLength("story_v_out_101071", "101071013", "story_v_out_101071.awb") / 1000

					if var_55_19 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_11
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_101071", "101071013", "story_v_out_101071.awb")

						arg_52_1:RecordAudio("101071013", var_55_20)
						arg_52_1:RecordAudio("101071013", var_55_20)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_101071", "101071013", "story_v_out_101071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_101071", "101071013", "story_v_out_101071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_21 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_21 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_11) / var_55_21

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_11 + var_55_21 and arg_52_1.time_ < var_55_11 + var_55_21 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play101071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 101071014
		arg_56_1.duration_ = 10.53

		local var_56_0 = {
			ja = 10.533,
			ko = 7,
			zh = 7.3,
			en = 7.733
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play101071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_1 = 0
			local var_59_2 = 0.925

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_3 = arg_56_1:FormatText(StoryNameCfg[13].name)

				arg_56_1.leftNameTxt_.text = var_59_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(101071014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 37
				local var_59_7 = utf8.len(var_59_5)
				local var_59_8 = var_59_6 <= 0 and var_59_2 or var_59_2 * (var_59_7 / var_59_6)

				if var_59_8 > 0 and var_59_2 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8

					if var_59_8 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071014", "story_v_out_101071.awb") ~= 0 then
					local var_59_9 = manager.audio:GetVoiceLength("story_v_out_101071", "101071014", "story_v_out_101071.awb") / 1000

					if var_59_9 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_1
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_101071", "101071014", "story_v_out_101071.awb")

						arg_56_1:RecordAudio("101071014", var_59_10)
						arg_56_1:RecordAudio("101071014", var_59_10)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_101071", "101071014", "story_v_out_101071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_101071", "101071014", "story_v_out_101071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_11 and arg_56_1.time_ < var_59_1 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play101071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 101071015
		arg_60_1.duration_ = 8.23

		local var_60_0 = {
			ja = 8.233,
			ko = 5.633,
			zh = 5.966,
			en = 6.766
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play101071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1084ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1019ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1019ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1019ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4138")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_63_12 = 0
			local var_63_13 = 0.75

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(101071015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 30
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071015", "story_v_out_101071.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071015", "story_v_out_101071.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_101071", "101071015", "story_v_out_101071.awb")

						arg_60_1:RecordAudio("101071015", var_63_21)
						arg_60_1:RecordAudio("101071015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_101071", "101071015", "story_v_out_101071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_101071", "101071015", "story_v_out_101071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play101071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 101071016
		arg_64_1.duration_ = 14

		local var_64_0 = {
			ja = 14,
			ko = 9.266,
			zh = 8.6,
			en = 11.9
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play101071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1019ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_11 = 0
			local var_67_12 = 1.05

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_13 = arg_64_1:FormatText(StoryNameCfg[13].name)

				arg_64_1.leftNameTxt_.text = var_67_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(101071016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 42
				local var_67_17 = utf8.len(var_67_15)
				local var_67_18 = var_67_16 <= 0 and var_67_12 or var_67_12 * (var_67_17 / var_67_16)

				if var_67_18 > 0 and var_67_12 < var_67_18 then
					arg_64_1.talkMaxDuration = var_67_18

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071016", "story_v_out_101071.awb") ~= 0 then
					local var_67_19 = manager.audio:GetVoiceLength("story_v_out_101071", "101071016", "story_v_out_101071.awb") / 1000

					if var_67_19 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_101071", "101071016", "story_v_out_101071.awb")

						arg_64_1:RecordAudio("101071016", var_67_20)
						arg_64_1:RecordAudio("101071016", var_67_20)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_101071", "101071016", "story_v_out_101071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_101071", "101071016", "story_v_out_101071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_21 and arg_64_1.time_ < var_67_11 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play101071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 101071017
		arg_68_1.duration_ = 0.1

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"

			SetActive(arg_68_1.choicesGo_, true)

			for iter_69_0, iter_69_1 in ipairs(arg_68_1.choices_) do
				local var_69_0 = iter_69_0 <= 2

				SetActive(iter_69_1.go, var_69_0)
			end

			arg_68_1.choices_[1].txt.text = arg_68_1:FormatText(StoryChoiceCfg[12].name)
			arg_68_1.choices_[2].txt.text = arg_68_1:FormatText(StoryChoiceCfg[13].name)
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play101071020(arg_68_1)
			end

			if arg_70_0 == 2 then
				arg_68_0:Play101071018(arg_68_1)
			end

			arg_68_1:RecordChoiceLog(101071017, 12, 13)
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1019ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1019ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1019ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1019ui_story.fillRatio = var_71_5
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play101071020 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 101071020
		arg_72_1.duration_ = 5.57

		local var_72_0 = {
			ja = 5.566,
			ko = 2.266,
			zh = 2.666,
			en = 2.9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play101071021(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1019ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1019ui_story == nil then
				arg_72_1.var_.characterEffect1019ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1019ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1019ui_story then
				arg_72_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_4.localPosition
			end

			local var_75_6 = 0.001

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6
				local var_75_8 = Vector3.New(0.7, -0.97, -6)

				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_8, var_75_7)

				local var_75_9 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_9.x, var_75_9.y, var_75_9.z)

				local var_75_10 = var_75_4.localEulerAngles

				var_75_10.z = 0
				var_75_10.x = 0
				var_75_4.localEulerAngles = var_75_10
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_75_11 = manager.ui.mainCamera.transform.position - var_75_4.position

				var_75_4.forward = Vector3.New(var_75_11.x, var_75_11.y, var_75_11.z)

				local var_75_12 = var_75_4.localEulerAngles

				var_75_12.z = 0
				var_75_12.x = 0
				var_75_4.localEulerAngles = var_75_12
			end

			local var_75_13 = arg_72_1.actors_["1019ui_story"].transform
			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.var_.moveOldPos1019ui_story = var_75_13.localPosition
			end

			local var_75_15 = 0.001

			if var_75_14 <= arg_72_1.time_ and arg_72_1.time_ < var_75_14 + var_75_15 then
				local var_75_16 = (arg_72_1.time_ - var_75_14) / var_75_15
				local var_75_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_75_13.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1019ui_story, var_75_17, var_75_16)

				local var_75_18 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_18.x, var_75_18.y, var_75_18.z)

				local var_75_19 = var_75_13.localEulerAngles

				var_75_19.z = 0
				var_75_19.x = 0
				var_75_13.localEulerAngles = var_75_19
			end

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				var_75_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_75_20 = manager.ui.mainCamera.transform.position - var_75_13.position

				var_75_13.forward = Vector3.New(var_75_20.x, var_75_20.y, var_75_20.z)

				local var_75_21 = var_75_13.localEulerAngles

				var_75_21.z = 0
				var_75_21.x = 0
				var_75_13.localEulerAngles = var_75_21
			end

			local var_75_22 = 0

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_75_23 = 0

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_75_24 = 0
			local var_75_25 = 0.35

			if var_75_24 < arg_72_1.time_ and arg_72_1.time_ <= var_75_24 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_26 = arg_72_1:FormatText(StoryNameCfg[13].name)

				arg_72_1.leftNameTxt_.text = var_75_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_27 = arg_72_1:GetWordFromCfg(101071020)
				local var_75_28 = arg_72_1:FormatText(var_75_27.content)

				arg_72_1.text_.text = var_75_28

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_29 = 14
				local var_75_30 = utf8.len(var_75_28)
				local var_75_31 = var_75_29 <= 0 and var_75_25 or var_75_25 * (var_75_30 / var_75_29)

				if var_75_31 > 0 and var_75_25 < var_75_31 then
					arg_72_1.talkMaxDuration = var_75_31

					if var_75_31 + var_75_24 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_24
					end
				end

				arg_72_1.text_.text = var_75_28
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071020", "story_v_out_101071.awb") ~= 0 then
					local var_75_32 = manager.audio:GetVoiceLength("story_v_out_101071", "101071020", "story_v_out_101071.awb") / 1000

					if var_75_32 + var_75_24 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_32 + var_75_24
					end

					if var_75_27.prefab_name ~= "" and arg_72_1.actors_[var_75_27.prefab_name] ~= nil then
						local var_75_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_27.prefab_name].transform, "story_v_out_101071", "101071020", "story_v_out_101071.awb")

						arg_72_1:RecordAudio("101071020", var_75_33)
						arg_72_1:RecordAudio("101071020", var_75_33)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_101071", "101071020", "story_v_out_101071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_101071", "101071020", "story_v_out_101071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_34 = math.max(var_75_25, arg_72_1.talkMaxDuration)

			if var_75_24 <= arg_72_1.time_ and arg_72_1.time_ < var_75_24 + var_75_34 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_24) / var_75_34

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_24 + var_75_34 and arg_72_1.time_ < var_75_24 + var_75_34 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play101071021 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 101071021
		arg_76_1.duration_ = 14.33

		local var_76_0 = {
			ja = 14.333,
			ko = 9.033,
			zh = 7.766,
			en = 8.666
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play101071022(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1019ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1084ui_story"].transform
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_4.localPosition
			end

			local var_79_6 = 0.001

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6
				local var_79_8 = Vector3.New(0.7, -0.97, -6)

				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, var_79_8, var_79_7)

				local var_79_9 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_9.x, var_79_9.y, var_79_9.z)

				local var_79_10 = var_79_4.localEulerAngles

				var_79_10.z = 0
				var_79_10.x = 0
				var_79_4.localEulerAngles = var_79_10
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_79_11 = manager.ui.mainCamera.transform.position - var_79_4.position

				var_79_4.forward = Vector3.New(var_79_11.x, var_79_11.y, var_79_11.z)

				local var_79_12 = var_79_4.localEulerAngles

				var_79_12.z = 0
				var_79_12.x = 0
				var_79_4.localEulerAngles = var_79_12
			end

			local var_79_13 = arg_76_1.actors_["1019ui_story"].transform
			local var_79_14 = 0

			if var_79_14 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_13.localPosition
			end

			local var_79_15 = 0.001

			if var_79_14 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_15 then
				local var_79_16 = (arg_76_1.time_ - var_79_14) / var_79_15
				local var_79_17 = Vector3.New(-0.7, -1.08, -5.9)

				var_79_13.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, var_79_17, var_79_16)

				local var_79_18 = manager.ui.mainCamera.transform.position - var_79_13.position

				var_79_13.forward = Vector3.New(var_79_18.x, var_79_18.y, var_79_18.z)

				local var_79_19 = var_79_13.localEulerAngles

				var_79_19.z = 0
				var_79_19.x = 0
				var_79_13.localEulerAngles = var_79_19
			end

			if arg_76_1.time_ >= var_79_14 + var_79_15 and arg_76_1.time_ < var_79_14 + var_79_15 + arg_79_0 then
				var_79_13.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_79_20 = manager.ui.mainCamera.transform.position - var_79_13.position

				var_79_13.forward = Vector3.New(var_79_20.x, var_79_20.y, var_79_20.z)

				local var_79_21 = var_79_13.localEulerAngles

				var_79_21.z = 0
				var_79_21.x = 0
				var_79_13.localEulerAngles = var_79_21
			end

			local var_79_22 = 0

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_23 = 0
			local var_79_24 = 0.95

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_25 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_26 = arg_76_1:GetWordFromCfg(101071021)
				local var_79_27 = arg_76_1:FormatText(var_79_26.content)

				arg_76_1.text_.text = var_79_27

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_28 = 38
				local var_79_29 = utf8.len(var_79_27)
				local var_79_30 = var_79_28 <= 0 and var_79_24 or var_79_24 * (var_79_29 / var_79_28)

				if var_79_30 > 0 and var_79_24 < var_79_30 then
					arg_76_1.talkMaxDuration = var_79_30

					if var_79_30 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_30 + var_79_23
					end
				end

				arg_76_1.text_.text = var_79_27
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071021", "story_v_out_101071.awb") ~= 0 then
					local var_79_31 = manager.audio:GetVoiceLength("story_v_out_101071", "101071021", "story_v_out_101071.awb") / 1000

					if var_79_31 + var_79_23 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_31 + var_79_23
					end

					if var_79_26.prefab_name ~= "" and arg_76_1.actors_[var_79_26.prefab_name] ~= nil then
						local var_79_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_26.prefab_name].transform, "story_v_out_101071", "101071021", "story_v_out_101071.awb")

						arg_76_1:RecordAudio("101071021", var_79_32)
						arg_76_1:RecordAudio("101071021", var_79_32)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_101071", "101071021", "story_v_out_101071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_101071", "101071021", "story_v_out_101071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_24, arg_76_1.talkMaxDuration)

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_23) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_23 + var_79_33 and arg_76_1.time_ < var_79_23 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play101071022 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 101071022
		arg_80_1.duration_ = 7.7

		local var_80_0 = {
			ja = 7.7,
			ko = 6.833,
			zh = 6.533,
			en = 6.566
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play101071023(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_83_1 = 0
			local var_83_2 = 0.825

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_3 = arg_80_1:FormatText(StoryNameCfg[13].name)

				arg_80_1.leftNameTxt_.text = var_83_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(101071022)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 33
				local var_83_7 = utf8.len(var_83_5)
				local var_83_8 = var_83_6 <= 0 and var_83_2 or var_83_2 * (var_83_7 / var_83_6)

				if var_83_8 > 0 and var_83_2 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071022", "story_v_out_101071.awb") ~= 0 then
					local var_83_9 = manager.audio:GetVoiceLength("story_v_out_101071", "101071022", "story_v_out_101071.awb") / 1000

					if var_83_9 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_1
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_101071", "101071022", "story_v_out_101071.awb")

						arg_80_1:RecordAudio("101071022", var_83_10)
						arg_80_1:RecordAudio("101071022", var_83_10)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_101071", "101071022", "story_v_out_101071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_101071", "101071022", "story_v_out_101071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_11 and arg_80_1.time_ < var_83_1 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play101071023 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 101071023
		arg_84_1.duration_ = 5.03

		local var_84_0 = {
			ja = 5.033,
			ko = 2.666,
			zh = 4.133,
			en = 3
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play101071024(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1019ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.1

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1019ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1019ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1019ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1019ui_story.fillRatio = var_87_9
			end

			local var_87_10 = arg_84_1.actors_["1019ui_story"].transform
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_10.localPosition
			end

			local var_87_12 = 0.001

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12
				local var_87_14 = Vector3.New(-0.7, -1.08, -5.9)

				var_87_10.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, var_87_14, var_87_13)

				local var_87_15 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_15.x, var_87_15.y, var_87_15.z)

				local var_87_16 = var_87_10.localEulerAngles

				var_87_16.z = 0
				var_87_16.x = 0
				var_87_10.localEulerAngles = var_87_16
			end

			if arg_84_1.time_ >= var_87_11 + var_87_12 and arg_84_1.time_ < var_87_11 + var_87_12 + arg_87_0 then
				var_87_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_87_17 = manager.ui.mainCamera.transform.position - var_87_10.position

				var_87_10.forward = Vector3.New(var_87_17.x, var_87_17.y, var_87_17.z)

				local var_87_18 = var_87_10.localEulerAngles

				var_87_18.z = 0
				var_87_18.x = 0
				var_87_10.localEulerAngles = var_87_18
			end

			local var_87_19 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_20 = 0

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_19.localPosition
			end

			local var_87_21 = 0.001

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_21 then
				local var_87_22 = (arg_84_1.time_ - var_87_20) / var_87_21
				local var_87_23 = Vector3.New(0.7, -0.97, -6)

				var_87_19.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_23, var_87_22)

				local var_87_24 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_24.x, var_87_24.y, var_87_24.z)

				local var_87_25 = var_87_19.localEulerAngles

				var_87_25.z = 0
				var_87_25.x = 0
				var_87_19.localEulerAngles = var_87_25
			end

			if arg_84_1.time_ >= var_87_20 + var_87_21 and arg_84_1.time_ < var_87_20 + var_87_21 + arg_87_0 then
				var_87_19.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_87_26 = manager.ui.mainCamera.transform.position - var_87_19.position

				var_87_19.forward = Vector3.New(var_87_26.x, var_87_26.y, var_87_26.z)

				local var_87_27 = var_87_19.localEulerAngles

				var_87_27.z = 0
				var_87_27.x = 0
				var_87_19.localEulerAngles = var_87_27
			end

			local var_87_28 = 0

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_87_29 = 0

			if var_87_29 < arg_84_1.time_ and arg_84_1.time_ <= var_87_29 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_30 = 0
			local var_87_31 = 0.325

			if var_87_30 < arg_84_1.time_ and arg_84_1.time_ <= var_87_30 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_32 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_33 = arg_84_1:GetWordFromCfg(101071023)
				local var_87_34 = arg_84_1:FormatText(var_87_33.content)

				arg_84_1.text_.text = var_87_34

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_35 = 13
				local var_87_36 = utf8.len(var_87_34)
				local var_87_37 = var_87_35 <= 0 and var_87_31 or var_87_31 * (var_87_36 / var_87_35)

				if var_87_37 > 0 and var_87_31 < var_87_37 then
					arg_84_1.talkMaxDuration = var_87_37

					if var_87_37 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_37 + var_87_30
					end
				end

				arg_84_1.text_.text = var_87_34
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071023", "story_v_out_101071.awb") ~= 0 then
					local var_87_38 = manager.audio:GetVoiceLength("story_v_out_101071", "101071023", "story_v_out_101071.awb") / 1000

					if var_87_38 + var_87_30 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_30
					end

					if var_87_33.prefab_name ~= "" and arg_84_1.actors_[var_87_33.prefab_name] ~= nil then
						local var_87_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_33.prefab_name].transform, "story_v_out_101071", "101071023", "story_v_out_101071.awb")

						arg_84_1:RecordAudio("101071023", var_87_39)
						arg_84_1:RecordAudio("101071023", var_87_39)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_101071", "101071023", "story_v_out_101071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_101071", "101071023", "story_v_out_101071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_40 = math.max(var_87_31, arg_84_1.talkMaxDuration)

			if var_87_30 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_40 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_30) / var_87_40

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_30 + var_87_40 and arg_84_1.time_ < var_87_30 + var_87_40 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play101071024 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 101071024
		arg_88_1.duration_ = 7.67

		local var_88_0 = {
			ja = 7.666,
			ko = 3.933,
			zh = 5,
			en = 4.133
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play101071025(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1084ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_5
			end

			local var_91_6 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_7 = 0

			if var_91_7 < arg_88_1.time_ and arg_88_1.time_ <= var_91_7 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_6.localPosition
			end

			local var_91_8 = 0.001

			if var_91_7 <= arg_88_1.time_ and arg_88_1.time_ < var_91_7 + var_91_8 then
				local var_91_9 = (arg_88_1.time_ - var_91_7) / var_91_8
				local var_91_10 = Vector3.New(0, 100, 0)

				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_10, var_91_9)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_6.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_6.localEulerAngles = var_91_12
			end

			if arg_88_1.time_ >= var_91_7 + var_91_8 and arg_88_1.time_ < var_91_7 + var_91_8 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(0, 100, 0)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_6.position

				var_91_6.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_6.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_6.localEulerAngles = var_91_14
			end

			local var_91_15 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_15.localPosition
			end

			local var_91_17 = 0.001

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17
				local var_91_19 = Vector3.New(0, 100, 0)

				var_91_15.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_19, var_91_18)

				local var_91_20 = manager.ui.mainCamera.transform.position - var_91_15.position

				var_91_15.forward = Vector3.New(var_91_20.x, var_91_20.y, var_91_20.z)

				local var_91_21 = var_91_15.localEulerAngles

				var_91_21.z = 0
				var_91_21.x = 0
				var_91_15.localEulerAngles = var_91_21
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				var_91_15.localPosition = Vector3.New(0, 100, 0)

				local var_91_22 = manager.ui.mainCamera.transform.position - var_91_15.position

				var_91_15.forward = Vector3.New(var_91_22.x, var_91_22.y, var_91_22.z)

				local var_91_23 = var_91_15.localEulerAngles

				var_91_23.z = 0
				var_91_23.x = 0
				var_91_15.localEulerAngles = var_91_23
			end

			local var_91_24 = 0
			local var_91_25 = 0.325

			if var_91_24 < arg_88_1.time_ and arg_88_1.time_ <= var_91_24 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_26 = arg_88_1:FormatText(StoryNameCfg[36].name)

				arg_88_1.leftNameTxt_.text = var_91_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_27 = arg_88_1:GetWordFromCfg(101071024)
				local var_91_28 = arg_88_1:FormatText(var_91_27.content)

				arg_88_1.text_.text = var_91_28

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_29 = 13
				local var_91_30 = utf8.len(var_91_28)
				local var_91_31 = var_91_29 <= 0 and var_91_25 or var_91_25 * (var_91_30 / var_91_29)

				if var_91_31 > 0 and var_91_25 < var_91_31 then
					arg_88_1.talkMaxDuration = var_91_31

					if var_91_31 + var_91_24 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_31 + var_91_24
					end
				end

				arg_88_1.text_.text = var_91_28
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071024", "story_v_out_101071.awb") ~= 0 then
					local var_91_32 = manager.audio:GetVoiceLength("story_v_out_101071", "101071024", "story_v_out_101071.awb") / 1000

					if var_91_32 + var_91_24 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_32 + var_91_24
					end

					if var_91_27.prefab_name ~= "" and arg_88_1.actors_[var_91_27.prefab_name] ~= nil then
						local var_91_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_27.prefab_name].transform, "story_v_out_101071", "101071024", "story_v_out_101071.awb")

						arg_88_1:RecordAudio("101071024", var_91_33)
						arg_88_1:RecordAudio("101071024", var_91_33)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_101071", "101071024", "story_v_out_101071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_101071", "101071024", "story_v_out_101071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_34 = math.max(var_91_25, arg_88_1.talkMaxDuration)

			if var_91_24 <= arg_88_1.time_ and arg_88_1.time_ < var_91_24 + var_91_34 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_24) / var_91_34

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_24 + var_91_34 and arg_88_1.time_ < var_91_24 + var_91_34 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play101071025 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 101071025
		arg_92_1.duration_ = 3.07

		local var_92_0 = {
			ja = 2.4,
			ko = 2.266,
			zh = 3.066,
			en = 2.566
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play101071026(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 1

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				local var_95_2 = "play"
				local var_95_3 = "effect"

				arg_92_1:AudioAction(var_95_2, var_95_3, "se_story", "se_story_gasgate_open", "")
			end

			local var_95_4 = 0
			local var_95_5 = 0.275

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_6 = arg_92_1:FormatText(StoryNameCfg[13].name)

				arg_92_1.leftNameTxt_.text = var_95_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_7 = arg_92_1:GetWordFromCfg(101071025)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 11
				local var_95_10 = utf8.len(var_95_8)
				local var_95_11 = var_95_9 <= 0 and var_95_5 or var_95_5 * (var_95_10 / var_95_9)

				if var_95_11 > 0 and var_95_5 < var_95_11 then
					arg_92_1.talkMaxDuration = var_95_11

					if var_95_11 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071025", "story_v_out_101071.awb") ~= 0 then
					local var_95_12 = manager.audio:GetVoiceLength("story_v_out_101071", "101071025", "story_v_out_101071.awb") / 1000

					if var_95_12 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_4
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_101071", "101071025", "story_v_out_101071.awb")

						arg_92_1:RecordAudio("101071025", var_95_13)
						arg_92_1:RecordAudio("101071025", var_95_13)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_101071", "101071025", "story_v_out_101071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_101071", "101071025", "story_v_out_101071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_14 and arg_92_1.time_ < var_95_4 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play101071026 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 101071026
		arg_96_1.duration_ = 2.97

		local var_96_0 = {
			ja = 2.533,
			ko = 2.6,
			zh = 2.966,
			en = 2.766
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play101071027(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1019ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1019ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1019ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.175

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[37].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_9 = arg_96_1:GetWordFromCfg(101071026)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 7
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071026", "story_v_out_101071.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071026", "story_v_out_101071.awb") / 1000

					if var_99_14 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_6
					end

					if var_99_9.prefab_name ~= "" and arg_96_1.actors_[var_99_9.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_9.prefab_name].transform, "story_v_out_101071", "101071026", "story_v_out_101071.awb")

						arg_96_1:RecordAudio("101071026", var_99_15)
						arg_96_1:RecordAudio("101071026", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_101071", "101071026", "story_v_out_101071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_101071", "101071026", "story_v_out_101071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_16 and arg_96_1.time_ < var_99_6 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play101071027 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 101071027
		arg_100_1.duration_ = 9

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play101071028(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = "S0101"

			if arg_100_1.bgs_[var_103_0] == nil then
				local var_103_1 = Object.Instantiate(arg_100_1.paintGo_)

				var_103_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_103_0)
				var_103_1.name = var_103_0
				var_103_1.transform.parent = arg_100_1.stage_.transform
				var_103_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.bgs_[var_103_0] = var_103_1
			end

			local var_103_2 = 2

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				local var_103_3 = manager.ui.mainCamera.transform.localPosition
				local var_103_4 = Vector3.New(0, 0, 10) + Vector3.New(var_103_3.x, var_103_3.y, 0)
				local var_103_5 = arg_100_1.bgs_.S0101

				var_103_5.transform.localPosition = var_103_4
				var_103_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_103_6 = var_103_5:GetComponent("SpriteRenderer")

				if var_103_6 and var_103_6.sprite then
					local var_103_7 = (var_103_5.transform.localPosition - var_103_3).z
					local var_103_8 = manager.ui.mainCameraCom_
					local var_103_9 = 2 * var_103_7 * Mathf.Tan(var_103_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_103_10 = var_103_9 * var_103_8.aspect
					local var_103_11 = var_103_6.sprite.bounds.size.x
					local var_103_12 = var_103_6.sprite.bounds.size.y
					local var_103_13 = var_103_10 / var_103_11
					local var_103_14 = var_103_9 / var_103_12
					local var_103_15 = var_103_14 < var_103_13 and var_103_13 or var_103_14

					var_103_5.transform.localScale = Vector3.New(var_103_15, var_103_15, 0)
				end

				for iter_103_0, iter_103_1 in pairs(arg_100_1.bgs_) do
					if iter_103_0 ~= "S0101" then
						iter_103_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_17 = 2

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17
				local var_103_19 = Color.New(0, 0, 0)

				var_103_19.a = Mathf.Lerp(0, 1, var_103_18)
				arg_100_1.mask_.color = var_103_19
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 then
				local var_103_20 = Color.New(0, 0, 0)

				var_103_20.a = 1
				arg_100_1.mask_.color = var_103_20
			end

			local var_103_21 = 2

			if var_103_21 < arg_100_1.time_ and arg_100_1.time_ <= var_103_21 + arg_103_0 then
				arg_100_1.mask_.enabled = true
				arg_100_1.mask_.raycastTarget = true

				arg_100_1:SetGaussion(false)
			end

			local var_103_22 = 2

			if var_103_21 <= arg_100_1.time_ and arg_100_1.time_ < var_103_21 + var_103_22 then
				local var_103_23 = (arg_100_1.time_ - var_103_21) / var_103_22
				local var_103_24 = Color.New(0, 0, 0)

				var_103_24.a = Mathf.Lerp(1, 0, var_103_23)
				arg_100_1.mask_.color = var_103_24
			end

			if arg_100_1.time_ >= var_103_21 + var_103_22 and arg_100_1.time_ < var_103_21 + var_103_22 + arg_103_0 then
				local var_103_25 = Color.New(0, 0, 0)
				local var_103_26 = 0

				arg_100_1.mask_.enabled = false
				var_103_25.a = var_103_26
				arg_100_1.mask_.color = var_103_25
			end

			local var_103_27 = arg_100_1.bgs_.S0101.transform
			local var_103_28 = 2

			if var_103_28 < arg_100_1.time_ and arg_100_1.time_ <= var_103_28 + arg_103_0 then
				arg_100_1.var_.moveOldPosS0101 = var_103_27.localPosition
			end

			local var_103_29 = 0.001

			if var_103_28 <= arg_100_1.time_ and arg_100_1.time_ < var_103_28 + var_103_29 then
				local var_103_30 = (arg_100_1.time_ - var_103_28) / var_103_29
				local var_103_31 = Vector3.New(0, 1, 9)

				var_103_27.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosS0101, var_103_31, var_103_30)
			end

			if arg_100_1.time_ >= var_103_28 + var_103_29 and arg_100_1.time_ < var_103_28 + var_103_29 + arg_103_0 then
				var_103_27.localPosition = Vector3.New(0, 1, 9)
			end

			local var_103_32 = arg_100_1.bgs_.S0101.transform
			local var_103_33 = 2.01666666666667

			if var_103_33 < arg_100_1.time_ and arg_100_1.time_ <= var_103_33 + arg_103_0 then
				arg_100_1.var_.moveOldPosS0101 = var_103_32.localPosition
			end

			local var_103_34 = 5

			if var_103_33 <= arg_100_1.time_ and arg_100_1.time_ < var_103_33 + var_103_34 then
				local var_103_35 = (arg_100_1.time_ - var_103_33) / var_103_34
				local var_103_36 = Vector3.New(0, 1, 10)

				var_103_32.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPosS0101, var_103_36, var_103_35)
			end

			if arg_100_1.time_ >= var_103_33 + var_103_34 and arg_100_1.time_ < var_103_33 + var_103_34 + arg_103_0 then
				var_103_32.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_100_1.frameCnt_ <= 1 then
				arg_100_1.dialog_:SetActive(false)
			end

			local var_103_37 = 4
			local var_103_38 = 0.6

			if var_103_37 < arg_100_1.time_ and arg_100_1.time_ <= var_103_37 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0

				arg_100_1.dialog_:SetActive(true)

				arg_100_1.dialogCg_.alpha = 0

				local var_103_39 = LeanTween.value(arg_100_1.dialog_, 0, 1, 0.3)

				var_103_39:setOnUpdate(LuaHelper.FloatAction(function(arg_104_0)
					arg_100_1.dialogCg_.alpha = arg_104_0
				end))
				var_103_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_100_1.dialog_)
					var_103_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_100_1.duration_ = arg_100_1.duration_ + 0.3

				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_40 = arg_100_1:GetWordFromCfg(101071027)
				local var_103_41 = arg_100_1:FormatText(var_103_40.content)

				arg_100_1.text_.text = var_103_41

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_42 = 24
				local var_103_43 = utf8.len(var_103_41)
				local var_103_44 = var_103_42 <= 0 and var_103_38 or var_103_38 * (var_103_43 / var_103_42)

				if var_103_44 > 0 and var_103_38 < var_103_44 then
					arg_100_1.talkMaxDuration = var_103_44
					var_103_37 = var_103_37 + 0.3

					if var_103_44 + var_103_37 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_44 + var_103_37
					end
				end

				arg_100_1.text_.text = var_103_41
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_45 = var_103_37 + 0.3
			local var_103_46 = math.max(var_103_38, arg_100_1.talkMaxDuration)

			if var_103_45 <= arg_100_1.time_ and arg_100_1.time_ < var_103_45 + var_103_46 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_45) / var_103_46

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_45 + var_103_46 and arg_100_1.time_ < var_103_45 + var_103_46 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play101071028 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 101071028
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play101071029(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_109_1 = 0
			local var_109_2 = 1.75

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(101071028)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 70
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_2 or var_109_2 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_2 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_8 and arg_106_1.time_ < var_109_1 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play101071029 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 101071029
		arg_110_1.duration_ = 10.87

		local var_110_0 = {
			ja = 10.866,
			ko = 9.466,
			zh = 9.433,
			en = 10.8
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play101071030(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1019ui_story"]
			local var_113_1 = 4

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1019ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_113_4 = 2

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				local var_113_5 = manager.ui.mainCamera.transform.localPosition
				local var_113_6 = Vector3.New(0, 0, 10) + Vector3.New(var_113_5.x, var_113_5.y, 0)
				local var_113_7 = arg_110_1.bgs_.A00

				var_113_7.transform.localPosition = var_113_6
				var_113_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_8 = var_113_7:GetComponent("SpriteRenderer")

				if var_113_8 and var_113_8.sprite then
					local var_113_9 = (var_113_7.transform.localPosition - var_113_5).z
					local var_113_10 = manager.ui.mainCameraCom_
					local var_113_11 = 2 * var_113_9 * Mathf.Tan(var_113_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_113_12 = var_113_11 * var_113_10.aspect
					local var_113_13 = var_113_8.sprite.bounds.size.x
					local var_113_14 = var_113_8.sprite.bounds.size.y
					local var_113_15 = var_113_12 / var_113_13
					local var_113_16 = var_113_11 / var_113_14
					local var_113_17 = var_113_16 < var_113_15 and var_113_15 or var_113_16

					var_113_7.transform.localScale = Vector3.New(var_113_17, var_113_17, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "A00" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_18 = arg_110_1.actors_["1019ui_story"].transform
			local var_113_19 = 4

			if var_113_19 < arg_110_1.time_ and arg_110_1.time_ <= var_113_19 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_18.localPosition
			end

			local var_113_20 = 0.001

			if var_113_19 <= arg_110_1.time_ and arg_110_1.time_ < var_113_19 + var_113_20 then
				local var_113_21 = (arg_110_1.time_ - var_113_19) / var_113_20
				local var_113_22 = Vector3.New(-0.7, -1.08, -5.9)

				var_113_18.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, var_113_22, var_113_21)

				local var_113_23 = manager.ui.mainCamera.transform.position - var_113_18.position

				var_113_18.forward = Vector3.New(var_113_23.x, var_113_23.y, var_113_23.z)

				local var_113_24 = var_113_18.localEulerAngles

				var_113_24.z = 0
				var_113_24.x = 0
				var_113_18.localEulerAngles = var_113_24
			end

			if arg_110_1.time_ >= var_113_19 + var_113_20 and arg_110_1.time_ < var_113_19 + var_113_20 + arg_113_0 then
				var_113_18.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_113_25 = manager.ui.mainCamera.transform.position - var_113_18.position

				var_113_18.forward = Vector3.New(var_113_25.x, var_113_25.y, var_113_25.z)

				local var_113_26 = var_113_18.localEulerAngles

				var_113_26.z = 0
				var_113_26.x = 0
				var_113_18.localEulerAngles = var_113_26
			end

			local var_113_27 = 4

			if var_113_27 < arg_110_1.time_ and arg_110_1.time_ <= var_113_27 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_113_28 = 4

			if var_113_28 < arg_110_1.time_ and arg_110_1.time_ <= var_113_28 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_113_29 = 0

			if var_113_29 < arg_110_1.time_ and arg_110_1.time_ <= var_113_29 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_30 = 2

			if var_113_29 <= arg_110_1.time_ and arg_110_1.time_ < var_113_29 + var_113_30 then
				local var_113_31 = (arg_110_1.time_ - var_113_29) / var_113_30
				local var_113_32 = Color.New(0, 0, 0)

				var_113_32.a = Mathf.Lerp(0, 1, var_113_31)
				arg_110_1.mask_.color = var_113_32
			end

			if arg_110_1.time_ >= var_113_29 + var_113_30 and arg_110_1.time_ < var_113_29 + var_113_30 + arg_113_0 then
				local var_113_33 = Color.New(0, 0, 0)

				var_113_33.a = 1
				arg_110_1.mask_.color = var_113_33
			end

			local var_113_34 = 2

			if var_113_34 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_35 = 2

			if var_113_34 <= arg_110_1.time_ and arg_110_1.time_ < var_113_34 + var_113_35 then
				local var_113_36 = (arg_110_1.time_ - var_113_34) / var_113_35
				local var_113_37 = Color.New(0, 0, 0)

				var_113_37.a = Mathf.Lerp(1, 0, var_113_36)
				arg_110_1.mask_.color = var_113_37
			end

			if arg_110_1.time_ >= var_113_34 + var_113_35 and arg_110_1.time_ < var_113_34 + var_113_35 + arg_113_0 then
				local var_113_38 = Color.New(0, 0, 0)
				local var_113_39 = 0

				arg_110_1.mask_.enabled = false
				var_113_38.a = var_113_39
				arg_110_1.mask_.color = var_113_38
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_40 = 4
			local var_113_41 = 0.775

			if var_113_40 < arg_110_1.time_ and arg_110_1.time_ <= var_113_40 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_42 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_42:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_43 = arg_110_1:FormatText(StoryNameCfg[13].name)

				arg_110_1.leftNameTxt_.text = var_113_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_44 = arg_110_1:GetWordFromCfg(101071029)
				local var_113_45 = arg_110_1:FormatText(var_113_44.content)

				arg_110_1.text_.text = var_113_45

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_46 = 28
				local var_113_47 = utf8.len(var_113_45)
				local var_113_48 = var_113_46 <= 0 and var_113_41 or var_113_41 * (var_113_47 / var_113_46)

				if var_113_48 > 0 and var_113_41 < var_113_48 then
					arg_110_1.talkMaxDuration = var_113_48
					var_113_40 = var_113_40 + 0.3

					if var_113_48 + var_113_40 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_48 + var_113_40
					end
				end

				arg_110_1.text_.text = var_113_45
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071029", "story_v_out_101071.awb") ~= 0 then
					local var_113_49 = manager.audio:GetVoiceLength("story_v_out_101071", "101071029", "story_v_out_101071.awb") / 1000

					if var_113_49 + var_113_40 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_49 + var_113_40
					end

					if var_113_44.prefab_name ~= "" and arg_110_1.actors_[var_113_44.prefab_name] ~= nil then
						local var_113_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_44.prefab_name].transform, "story_v_out_101071", "101071029", "story_v_out_101071.awb")

						arg_110_1:RecordAudio("101071029", var_113_50)
						arg_110_1:RecordAudio("101071029", var_113_50)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_101071", "101071029", "story_v_out_101071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_101071", "101071029", "story_v_out_101071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_51 = var_113_40 + 0.3
			local var_113_52 = math.max(var_113_41, arg_110_1.talkMaxDuration)

			if var_113_51 <= arg_110_1.time_ and arg_110_1.time_ < var_113_51 + var_113_52 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_51) / var_113_52

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_51 + var_113_52 and arg_110_1.time_ < var_113_51 + var_113_52 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play101071030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 101071030
		arg_116_1.duration_ = 6.8

		local var_116_0 = {
			ja = 2.666,
			ko = 6.066,
			zh = 6.366,
			en = 6.8
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play101071031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = "1011ui_story"

			if arg_116_1.actors_[var_119_0] == nil then
				local var_119_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_119_1) then
					local var_119_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_116_1.stage_.transform)

					var_119_2.name = var_119_0
					var_119_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_116_1.actors_[var_119_0] = var_119_2

					local var_119_3 = var_119_2:GetComponentInChildren(typeof(CharacterEffect))

					var_119_3.enabled = true

					local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_2, typeof(DynamicBoneHelper))

					if var_119_4 then
						var_119_4:EnableDynamicBone(false)
					end

					arg_116_1:ShowWeapon(var_119_3.transform, false)

					arg_116_1.var_[var_119_0 .. "Animator"] = var_119_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_116_1.var_[var_119_0 .. "Animator"].applyRootMotion = true
					arg_116_1.var_[var_119_0 .. "LipSync"] = var_119_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_119_5 = arg_116_1.actors_["1011ui_story"]
			local var_119_6 = 0

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1011ui_story == nil then
				arg_116_1.var_.characterEffect1011ui_story = var_119_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.1

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_7 and not isNil(var_119_5) then
				local var_119_8 = (arg_116_1.time_ - var_119_6) / var_119_7

				if arg_116_1.var_.characterEffect1011ui_story and not isNil(var_119_5) then
					arg_116_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_6 + var_119_7 and arg_116_1.time_ < var_119_6 + var_119_7 + arg_119_0 and not isNil(var_119_5) and arg_116_1.var_.characterEffect1011ui_story then
				arg_116_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_119_9 = arg_116_1.actors_["1019ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.1

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1019ui_story and not isNil(var_119_9) then
					local var_119_13 = Mathf.Lerp(0, 0.5, var_119_12)

					arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1019ui_story.fillRatio = var_119_13
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1019ui_story then
				local var_119_14 = 0.5

				arg_116_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1019ui_story.fillRatio = var_119_14
			end

			local var_119_15 = arg_116_1.actors_["1011ui_story"].transform
			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1.var_.moveOldPos1011ui_story = var_119_15.localPosition
			end

			local var_119_17 = 0.001

			if var_119_16 <= arg_116_1.time_ and arg_116_1.time_ < var_119_16 + var_119_17 then
				local var_119_18 = (arg_116_1.time_ - var_119_16) / var_119_17
				local var_119_19 = Vector3.New(0.7, -0.71, -6)

				var_119_15.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1011ui_story, var_119_19, var_119_18)

				local var_119_20 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_20.x, var_119_20.y, var_119_20.z)

				local var_119_21 = var_119_15.localEulerAngles

				var_119_21.z = 0
				var_119_21.x = 0
				var_119_15.localEulerAngles = var_119_21
			end

			if arg_116_1.time_ >= var_119_16 + var_119_17 and arg_116_1.time_ < var_119_16 + var_119_17 + arg_119_0 then
				var_119_15.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_119_22 = manager.ui.mainCamera.transform.position - var_119_15.position

				var_119_15.forward = Vector3.New(var_119_22.x, var_119_22.y, var_119_22.z)

				local var_119_23 = var_119_15.localEulerAngles

				var_119_23.z = 0
				var_119_23.x = 0
				var_119_15.localEulerAngles = var_119_23
			end

			local var_119_24 = 0

			if var_119_24 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_119_25 = 0

			if var_119_25 < arg_116_1.time_ and arg_116_1.time_ <= var_119_25 + arg_119_0 then
				arg_116_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_26 = 0
			local var_119_27 = 0.5

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_28 = arg_116_1:FormatText(StoryNameCfg[37].name)

				arg_116_1.leftNameTxt_.text = var_119_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_29 = arg_116_1:GetWordFromCfg(101071030)
				local var_119_30 = arg_116_1:FormatText(var_119_29.content)

				arg_116_1.text_.text = var_119_30

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_31 = 20
				local var_119_32 = utf8.len(var_119_30)
				local var_119_33 = var_119_31 <= 0 and var_119_27 or var_119_27 * (var_119_32 / var_119_31)

				if var_119_33 > 0 and var_119_27 < var_119_33 then
					arg_116_1.talkMaxDuration = var_119_33

					if var_119_33 + var_119_26 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_33 + var_119_26
					end
				end

				arg_116_1.text_.text = var_119_30
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071030", "story_v_out_101071.awb") ~= 0 then
					local var_119_34 = manager.audio:GetVoiceLength("story_v_out_101071", "101071030", "story_v_out_101071.awb") / 1000

					if var_119_34 + var_119_26 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_34 + var_119_26
					end

					if var_119_29.prefab_name ~= "" and arg_116_1.actors_[var_119_29.prefab_name] ~= nil then
						local var_119_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_29.prefab_name].transform, "story_v_out_101071", "101071030", "story_v_out_101071.awb")

						arg_116_1:RecordAudio("101071030", var_119_35)
						arg_116_1:RecordAudio("101071030", var_119_35)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_101071", "101071030", "story_v_out_101071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_101071", "101071030", "story_v_out_101071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_36 = math.max(var_119_27, arg_116_1.talkMaxDuration)

			if var_119_26 <= arg_116_1.time_ and arg_116_1.time_ < var_119_26 + var_119_36 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_26) / var_119_36

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_26 + var_119_36 and arg_116_1.time_ < var_119_26 + var_119_36 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play101071031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 101071031
		arg_120_1.duration_ = 0.1

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"

			SetActive(arg_120_1.choicesGo_, true)

			for iter_121_0, iter_121_1 in ipairs(arg_120_1.choices_) do
				local var_121_0 = iter_121_0 <= 2

				SetActive(iter_121_1.go, var_121_0)
			end

			arg_120_1.choices_[1].txt.text = arg_120_1:FormatText(StoryChoiceCfg[14].name)
			arg_120_1.choices_[2].txt.text = arg_120_1:FormatText(StoryChoiceCfg[15].name)
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play101071032(arg_120_1)
			end

			if arg_122_0 == 2 then
				arg_120_0:Play101071034(arg_120_1)
			end

			arg_120_1:RecordChoiceLog(101071031, 14, 15)
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1011ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1011ui_story == nil then
				arg_120_1.var_.characterEffect1011ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.1

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1011ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1011ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1011ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1011ui_story.fillRatio = var_123_5
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play101071032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 101071032
		arg_124_1.duration_ = 8.43

		local var_124_0 = {
			ja = 8.433,
			ko = 5.3,
			zh = 7,
			en = 5.466
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play101071035(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1019ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1019ui_story == nil then
				arg_124_1.var_.characterEffect1019ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1019ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1019ui_story then
				arg_124_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_127_4 = 0

			if var_127_4 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_127_5 = 0
			local var_127_6 = 0.75

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_7 = arg_124_1:FormatText(StoryNameCfg[13].name)

				arg_124_1.leftNameTxt_.text = var_127_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(101071032)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 30
				local var_127_11 = utf8.len(var_127_9)
				local var_127_12 = var_127_10 <= 0 and var_127_6 or var_127_6 * (var_127_11 / var_127_10)

				if var_127_12 > 0 and var_127_6 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071032", "story_v_out_101071.awb") ~= 0 then
					local var_127_13 = manager.audio:GetVoiceLength("story_v_out_101071", "101071032", "story_v_out_101071.awb") / 1000

					if var_127_13 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_5
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_101071", "101071032", "story_v_out_101071.awb")

						arg_124_1:RecordAudio("101071032", var_127_14)
						arg_124_1:RecordAudio("101071032", var_127_14)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_101071", "101071032", "story_v_out_101071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_101071", "101071032", "story_v_out_101071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_15 = math.max(var_127_6, arg_124_1.talkMaxDuration)

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_15 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_5) / var_127_15

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_5 + var_127_15 and arg_124_1.time_ < var_127_5 + var_127_15 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play101071035 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 101071035
		arg_128_1.duration_ = 5.3

		local var_128_0 = {
			ja = 5.066,
			ko = 4.8,
			zh = 5.3,
			en = 5.066
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play101071036(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1084ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1084ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["1019ui_story"].transform
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.var_.moveOldPos1019ui_story = var_131_4.localPosition
			end

			local var_131_6 = 0.001

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6
				local var_131_8 = Vector3.New(0, 100, 0)

				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1019ui_story, var_131_8, var_131_7)

				local var_131_9 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_9.x, var_131_9.y, var_131_9.z)

				local var_131_10 = var_131_4.localEulerAngles

				var_131_10.z = 0
				var_131_10.x = 0
				var_131_4.localEulerAngles = var_131_10
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, 100, 0)

				local var_131_11 = manager.ui.mainCamera.transform.position - var_131_4.position

				var_131_4.forward = Vector3.New(var_131_11.x, var_131_11.y, var_131_11.z)

				local var_131_12 = var_131_4.localEulerAngles

				var_131_12.z = 0
				var_131_12.x = 0
				var_131_4.localEulerAngles = var_131_12
			end

			local var_131_13 = arg_128_1.actors_["1084ui_story"].transform
			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.var_.moveOldPos1084ui_story = var_131_13.localPosition
			end

			local var_131_15 = 0.001

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_15 then
				local var_131_16 = (arg_128_1.time_ - var_131_14) / var_131_15
				local var_131_17 = Vector3.New(-0.7, -0.97, -6)

				var_131_13.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1084ui_story, var_131_17, var_131_16)

				local var_131_18 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_18.x, var_131_18.y, var_131_18.z)

				local var_131_19 = var_131_13.localEulerAngles

				var_131_19.z = 0
				var_131_19.x = 0
				var_131_13.localEulerAngles = var_131_19
			end

			if arg_128_1.time_ >= var_131_14 + var_131_15 and arg_128_1.time_ < var_131_14 + var_131_15 + arg_131_0 then
				var_131_13.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_131_20 = manager.ui.mainCamera.transform.position - var_131_13.position

				var_131_13.forward = Vector3.New(var_131_20.x, var_131_20.y, var_131_20.z)

				local var_131_21 = var_131_13.localEulerAngles

				var_131_21.z = 0
				var_131_21.x = 0
				var_131_13.localEulerAngles = var_131_21
			end

			local var_131_22 = 0

			if var_131_22 < arg_128_1.time_ and arg_128_1.time_ <= var_131_22 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_131_23 = 0

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_131_24 = 0
			local var_131_25 = 0.5

			if var_131_24 < arg_128_1.time_ and arg_128_1.time_ <= var_131_24 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_26 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_27 = arg_128_1:GetWordFromCfg(101071035)
				local var_131_28 = arg_128_1:FormatText(var_131_27.content)

				arg_128_1.text_.text = var_131_28

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_29 = 20
				local var_131_30 = utf8.len(var_131_28)
				local var_131_31 = var_131_29 <= 0 and var_131_25 or var_131_25 * (var_131_30 / var_131_29)

				if var_131_31 > 0 and var_131_25 < var_131_31 then
					arg_128_1.talkMaxDuration = var_131_31

					if var_131_31 + var_131_24 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_31 + var_131_24
					end
				end

				arg_128_1.text_.text = var_131_28
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071035", "story_v_out_101071.awb") ~= 0 then
					local var_131_32 = manager.audio:GetVoiceLength("story_v_out_101071", "101071035", "story_v_out_101071.awb") / 1000

					if var_131_32 + var_131_24 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_32 + var_131_24
					end

					if var_131_27.prefab_name ~= "" and arg_128_1.actors_[var_131_27.prefab_name] ~= nil then
						local var_131_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_27.prefab_name].transform, "story_v_out_101071", "101071035", "story_v_out_101071.awb")

						arg_128_1:RecordAudio("101071035", var_131_33)
						arg_128_1:RecordAudio("101071035", var_131_33)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_101071", "101071035", "story_v_out_101071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_101071", "101071035", "story_v_out_101071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_34 = math.max(var_131_25, arg_128_1.talkMaxDuration)

			if var_131_24 <= arg_128_1.time_ and arg_128_1.time_ < var_131_24 + var_131_34 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_24) / var_131_34

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_24 + var_131_34 and arg_128_1.time_ < var_131_24 + var_131_34 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play101071036 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 101071036
		arg_132_1.duration_ = 4.9

		local var_132_0 = {
			ja = 4.233,
			ko = 4.9,
			zh = 4,
			en = 4.133
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play101071037(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4513")
			end

			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_135_2 = 0
			local var_135_3 = 0.525

			if var_135_2 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_4 = arg_132_1:FormatText(StoryNameCfg[6].name)

				arg_132_1.leftNameTxt_.text = var_135_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_5 = arg_132_1:GetWordFromCfg(101071036)
				local var_135_6 = arg_132_1:FormatText(var_135_5.content)

				arg_132_1.text_.text = var_135_6

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 21
				local var_135_8 = utf8.len(var_135_6)
				local var_135_9 = var_135_7 <= 0 and var_135_3 or var_135_3 * (var_135_8 / var_135_7)

				if var_135_9 > 0 and var_135_3 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_6
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071036", "story_v_out_101071.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071036", "story_v_out_101071.awb") / 1000

					if var_135_10 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_2
					end

					if var_135_5.prefab_name ~= "" and arg_132_1.actors_[var_135_5.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_5.prefab_name].transform, "story_v_out_101071", "101071036", "story_v_out_101071.awb")

						arg_132_1:RecordAudio("101071036", var_135_11)
						arg_132_1:RecordAudio("101071036", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_101071", "101071036", "story_v_out_101071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_101071", "101071036", "story_v_out_101071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_12 and arg_132_1.time_ < var_135_2 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play101071037 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 101071037
		arg_136_1.duration_ = 6.2

		local var_136_0 = {
			ja = 6.2,
			ko = 4.533,
			zh = 3.9,
			en = 4.833
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play101071038(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1011ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1011ui_story == nil then
				arg_136_1.var_.characterEffect1011ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1011ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1011ui_story then
				arg_136_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1084ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1084ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1084ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_139_12 = 0
			local var_139_13 = 0.475

			if var_139_12 < arg_136_1.time_ and arg_136_1.time_ <= var_139_12 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_14 = arg_136_1:FormatText(StoryNameCfg[37].name)

				arg_136_1.leftNameTxt_.text = var_139_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_15 = arg_136_1:GetWordFromCfg(101071037)
				local var_139_16 = arg_136_1:FormatText(var_139_15.content)

				arg_136_1.text_.text = var_139_16

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_17 = 19
				local var_139_18 = utf8.len(var_139_16)
				local var_139_19 = var_139_17 <= 0 and var_139_13 or var_139_13 * (var_139_18 / var_139_17)

				if var_139_19 > 0 and var_139_13 < var_139_19 then
					arg_136_1.talkMaxDuration = var_139_19

					if var_139_19 + var_139_12 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_19 + var_139_12
					end
				end

				arg_136_1.text_.text = var_139_16
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071037", "story_v_out_101071.awb") ~= 0 then
					local var_139_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071037", "story_v_out_101071.awb") / 1000

					if var_139_20 + var_139_12 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_20 + var_139_12
					end

					if var_139_15.prefab_name ~= "" and arg_136_1.actors_[var_139_15.prefab_name] ~= nil then
						local var_139_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_15.prefab_name].transform, "story_v_out_101071", "101071037", "story_v_out_101071.awb")

						arg_136_1:RecordAudio("101071037", var_139_21)
						arg_136_1:RecordAudio("101071037", var_139_21)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_101071", "101071037", "story_v_out_101071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_101071", "101071037", "story_v_out_101071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_22 = math.max(var_139_13, arg_136_1.talkMaxDuration)

			if var_139_12 <= arg_136_1.time_ and arg_136_1.time_ < var_139_12 + var_139_22 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_12) / var_139_22

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_12 + var_139_22 and arg_136_1.time_ < var_139_12 + var_139_22 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play101071038 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 101071038
		arg_140_1.duration_ = 8.43

		local var_140_0 = {
			ja = 7.266,
			ko = 5.533,
			zh = 6.6,
			en = 8.433
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play101071039(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1084ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1084ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1084ui_story then
				arg_140_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1011ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1011ui_story == nil then
				arg_140_1.var_.characterEffect1011ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.1

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect1011ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1011ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1011ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1011ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_143_11 = 0

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_143_12 = 0
			local var_143_13 = 0.85

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[6].name)

				arg_140_1.leftNameTxt_.text = var_143_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:GetWordFromCfg(101071038)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 31
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071038", "story_v_out_101071.awb") ~= 0 then
					local var_143_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071038", "story_v_out_101071.awb") / 1000

					if var_143_20 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_12
					end

					if var_143_15.prefab_name ~= "" and arg_140_1.actors_[var_143_15.prefab_name] ~= nil then
						local var_143_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_15.prefab_name].transform, "story_v_out_101071", "101071038", "story_v_out_101071.awb")

						arg_140_1:RecordAudio("101071038", var_143_21)
						arg_140_1:RecordAudio("101071038", var_143_21)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_101071", "101071038", "story_v_out_101071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_101071", "101071038", "story_v_out_101071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_22 and arg_140_1.time_ < var_143_12 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play101071039 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 101071039
		arg_144_1.duration_ = 8.1

		local var_144_0 = {
			ja = 8.1,
			ko = 7.6,
			zh = 6,
			en = 6.766
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play101071040(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1019ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1019ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["1084ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1084ui_story == nil then
				arg_144_1.var_.characterEffect1084ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect1084ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1084ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect1084ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1084ui_story.fillRatio = var_147_9
			end

			local var_147_10 = arg_144_1.actors_["1084ui_story"].transform
			local var_147_11 = 0

			if var_147_11 < arg_144_1.time_ and arg_144_1.time_ <= var_147_11 + arg_147_0 then
				arg_144_1.var_.moveOldPos1084ui_story = var_147_10.localPosition
			end

			local var_147_12 = 0.001

			if var_147_11 <= arg_144_1.time_ and arg_144_1.time_ < var_147_11 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_11) / var_147_12
				local var_147_14 = Vector3.New(0, 100, 0)

				var_147_10.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1084ui_story, var_147_14, var_147_13)

				local var_147_15 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_15.x, var_147_15.y, var_147_15.z)

				local var_147_16 = var_147_10.localEulerAngles

				var_147_16.z = 0
				var_147_16.x = 0
				var_147_10.localEulerAngles = var_147_16
			end

			if arg_144_1.time_ >= var_147_11 + var_147_12 and arg_144_1.time_ < var_147_11 + var_147_12 + arg_147_0 then
				var_147_10.localPosition = Vector3.New(0, 100, 0)

				local var_147_17 = manager.ui.mainCamera.transform.position - var_147_10.position

				var_147_10.forward = Vector3.New(var_147_17.x, var_147_17.y, var_147_17.z)

				local var_147_18 = var_147_10.localEulerAngles

				var_147_18.z = 0
				var_147_18.x = 0
				var_147_10.localEulerAngles = var_147_18
			end

			local var_147_19 = arg_144_1.actors_["1011ui_story"].transform
			local var_147_20 = 0

			if var_147_20 < arg_144_1.time_ and arg_144_1.time_ <= var_147_20 + arg_147_0 then
				arg_144_1.var_.moveOldPos1011ui_story = var_147_19.localPosition
			end

			local var_147_21 = 0.001

			if var_147_20 <= arg_144_1.time_ and arg_144_1.time_ < var_147_20 + var_147_21 then
				local var_147_22 = (arg_144_1.time_ - var_147_20) / var_147_21
				local var_147_23 = Vector3.New(0.7, -0.71, -6)

				var_147_19.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1011ui_story, var_147_23, var_147_22)

				local var_147_24 = manager.ui.mainCamera.transform.position - var_147_19.position

				var_147_19.forward = Vector3.New(var_147_24.x, var_147_24.y, var_147_24.z)

				local var_147_25 = var_147_19.localEulerAngles

				var_147_25.z = 0
				var_147_25.x = 0
				var_147_19.localEulerAngles = var_147_25
			end

			if arg_144_1.time_ >= var_147_20 + var_147_21 and arg_144_1.time_ < var_147_20 + var_147_21 + arg_147_0 then
				var_147_19.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_147_26 = manager.ui.mainCamera.transform.position - var_147_19.position

				var_147_19.forward = Vector3.New(var_147_26.x, var_147_26.y, var_147_26.z)

				local var_147_27 = var_147_19.localEulerAngles

				var_147_27.z = 0
				var_147_27.x = 0
				var_147_19.localEulerAngles = var_147_27
			end

			local var_147_28 = arg_144_1.actors_["1019ui_story"].transform
			local var_147_29 = 0

			if var_147_29 < arg_144_1.time_ and arg_144_1.time_ <= var_147_29 + arg_147_0 then
				arg_144_1.var_.moveOldPos1019ui_story = var_147_28.localPosition
			end

			local var_147_30 = 0.001

			if var_147_29 <= arg_144_1.time_ and arg_144_1.time_ < var_147_29 + var_147_30 then
				local var_147_31 = (arg_144_1.time_ - var_147_29) / var_147_30
				local var_147_32 = Vector3.New(-0.7, -1.08, -5.9)

				var_147_28.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1019ui_story, var_147_32, var_147_31)

				local var_147_33 = manager.ui.mainCamera.transform.position - var_147_28.position

				var_147_28.forward = Vector3.New(var_147_33.x, var_147_33.y, var_147_33.z)

				local var_147_34 = var_147_28.localEulerAngles

				var_147_34.z = 0
				var_147_34.x = 0
				var_147_28.localEulerAngles = var_147_34
			end

			if arg_144_1.time_ >= var_147_29 + var_147_30 and arg_144_1.time_ < var_147_29 + var_147_30 + arg_147_0 then
				var_147_28.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_147_35 = manager.ui.mainCamera.transform.position - var_147_28.position

				var_147_28.forward = Vector3.New(var_147_35.x, var_147_35.y, var_147_35.z)

				local var_147_36 = var_147_28.localEulerAngles

				var_147_36.z = 0
				var_147_36.x = 0
				var_147_28.localEulerAngles = var_147_36
			end

			local var_147_37 = 0

			if var_147_37 < arg_144_1.time_ and arg_144_1.time_ <= var_147_37 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_147_38 = 0

			if var_147_38 < arg_144_1.time_ and arg_144_1.time_ <= var_147_38 + arg_147_0 then
				arg_144_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_39 = 0
			local var_147_40 = 0.75

			if var_147_39 < arg_144_1.time_ and arg_144_1.time_ <= var_147_39 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_41 = arg_144_1:FormatText(StoryNameCfg[13].name)

				arg_144_1.leftNameTxt_.text = var_147_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_42 = arg_144_1:GetWordFromCfg(101071039)
				local var_147_43 = arg_144_1:FormatText(var_147_42.content)

				arg_144_1.text_.text = var_147_43

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_44 = 29
				local var_147_45 = utf8.len(var_147_43)
				local var_147_46 = var_147_44 <= 0 and var_147_40 or var_147_40 * (var_147_45 / var_147_44)

				if var_147_46 > 0 and var_147_40 < var_147_46 then
					arg_144_1.talkMaxDuration = var_147_46

					if var_147_46 + var_147_39 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_46 + var_147_39
					end
				end

				arg_144_1.text_.text = var_147_43
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071039", "story_v_out_101071.awb") ~= 0 then
					local var_147_47 = manager.audio:GetVoiceLength("story_v_out_101071", "101071039", "story_v_out_101071.awb") / 1000

					if var_147_47 + var_147_39 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_47 + var_147_39
					end

					if var_147_42.prefab_name ~= "" and arg_144_1.actors_[var_147_42.prefab_name] ~= nil then
						local var_147_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_42.prefab_name].transform, "story_v_out_101071", "101071039", "story_v_out_101071.awb")

						arg_144_1:RecordAudio("101071039", var_147_48)
						arg_144_1:RecordAudio("101071039", var_147_48)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_101071", "101071039", "story_v_out_101071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_101071", "101071039", "story_v_out_101071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_49 = math.max(var_147_40, arg_144_1.talkMaxDuration)

			if var_147_39 <= arg_144_1.time_ and arg_144_1.time_ < var_147_39 + var_147_49 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_39) / var_147_49

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_39 + var_147_49 and arg_144_1.time_ < var_147_39 + var_147_49 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play101071040 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 101071040
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play101071041(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1019ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1019ui_story and not isNil(var_151_0) then
					local var_151_4 = Mathf.Lerp(0, 0.5, var_151_3)

					arg_148_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1019ui_story.fillRatio = var_151_4
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1019ui_story then
				local var_151_5 = 0.5

				arg_148_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1019ui_story.fillRatio = var_151_5
			end

			local var_151_6 = 0
			local var_151_7 = 0.7

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_8 = arg_148_1:GetWordFromCfg(101071040)
				local var_151_9 = arg_148_1:FormatText(var_151_8.content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 28
				local var_151_11 = utf8.len(var_151_9)
				local var_151_12 = var_151_10 <= 0 and var_151_7 or var_151_7 * (var_151_11 / var_151_10)

				if var_151_12 > 0 and var_151_7 < var_151_12 then
					arg_148_1.talkMaxDuration = var_151_12

					if var_151_12 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_12 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_13 and arg_148_1.time_ < var_151_6 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play101071041 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 101071041
		arg_152_1.duration_ = 15.17

		local var_152_0 = {
			ja = 15.166,
			ko = 12.533,
			zh = 10.3,
			en = 11.2
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play101071042(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1019ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1019ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1019ui_story then
				arg_152_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_155_4 = 0

			if var_155_4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_155_6 = 0
			local var_155_7 = 1.3

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[13].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_9 = arg_152_1:GetWordFromCfg(101071041)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 52
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071041", "story_v_out_101071.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_101071", "101071041", "story_v_out_101071.awb") / 1000

					if var_155_14 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_6
					end

					if var_155_9.prefab_name ~= "" and arg_152_1.actors_[var_155_9.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_9.prefab_name].transform, "story_v_out_101071", "101071041", "story_v_out_101071.awb")

						arg_152_1:RecordAudio("101071041", var_155_15)
						arg_152_1:RecordAudio("101071041", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_101071", "101071041", "story_v_out_101071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_101071", "101071041", "story_v_out_101071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_16 and arg_152_1.time_ < var_155_6 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play101071042 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 101071042
		arg_156_1.duration_ = 12

		local var_156_0 = {
			ja = 12,
			ko = 10.466,
			zh = 9.566,
			en = 10.4
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play101071043(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_159_1 = 0
			local var_159_2 = 1.175

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_3 = arg_156_1:FormatText(StoryNameCfg[13].name)

				arg_156_1.leftNameTxt_.text = var_159_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_4 = arg_156_1:GetWordFromCfg(101071042)
				local var_159_5 = arg_156_1:FormatText(var_159_4.content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_6 = 47
				local var_159_7 = utf8.len(var_159_5)
				local var_159_8 = var_159_6 <= 0 and var_159_2 or var_159_2 * (var_159_7 / var_159_6)

				if var_159_8 > 0 and var_159_2 < var_159_8 then
					arg_156_1.talkMaxDuration = var_159_8

					if var_159_8 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071042", "story_v_out_101071.awb") ~= 0 then
					local var_159_9 = manager.audio:GetVoiceLength("story_v_out_101071", "101071042", "story_v_out_101071.awb") / 1000

					if var_159_9 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_1
					end

					if var_159_4.prefab_name ~= "" and arg_156_1.actors_[var_159_4.prefab_name] ~= nil then
						local var_159_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_4.prefab_name].transform, "story_v_out_101071", "101071042", "story_v_out_101071.awb")

						arg_156_1:RecordAudio("101071042", var_159_10)
						arg_156_1:RecordAudio("101071042", var_159_10)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_101071", "101071042", "story_v_out_101071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_101071", "101071042", "story_v_out_101071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_11 and arg_156_1.time_ < var_159_1 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play101071043 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 101071043
		arg_160_1.duration_ = 2

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play101071044(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1084ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.1

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["1019ui_story"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1019ui_story == nil then
				arg_160_1.var_.characterEffect1019ui_story = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.1

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect1019ui_story and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1019ui_story.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1019ui_story then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1019ui_story.fillRatio = var_163_9
			end

			local var_163_10 = arg_160_1.actors_["1084ui_story"].transform
			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_10.localPosition
			end

			local var_163_12 = 0.001

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_11) / var_163_12
				local var_163_14 = Vector3.New(0.7, -0.97, -6)

				var_163_10.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, var_163_14, var_163_13)

				local var_163_15 = manager.ui.mainCamera.transform.position - var_163_10.position

				var_163_10.forward = Vector3.New(var_163_15.x, var_163_15.y, var_163_15.z)

				local var_163_16 = var_163_10.localEulerAngles

				var_163_16.z = 0
				var_163_16.x = 0
				var_163_10.localEulerAngles = var_163_16
			end

			if arg_160_1.time_ >= var_163_11 + var_163_12 and arg_160_1.time_ < var_163_11 + var_163_12 + arg_163_0 then
				var_163_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_163_17 = manager.ui.mainCamera.transform.position - var_163_10.position

				var_163_10.forward = Vector3.New(var_163_17.x, var_163_17.y, var_163_17.z)

				local var_163_18 = var_163_10.localEulerAngles

				var_163_18.z = 0
				var_163_18.x = 0
				var_163_10.localEulerAngles = var_163_18
			end

			local var_163_19 = 0

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_163_20 = 0

			if var_163_20 < arg_160_1.time_ and arg_160_1.time_ <= var_163_20 + arg_163_0 then
				arg_160_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_163_21 = 0

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_163_22 = arg_160_1.actors_["1019ui_story"].transform
			local var_163_23 = 0

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.var_.moveOldPos1019ui_story = var_163_22.localPosition
			end

			local var_163_24 = 0.001

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Vector3.New(-0.7, -1.08, -5.9)

				var_163_22.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1019ui_story, var_163_26, var_163_25)

				local var_163_27 = manager.ui.mainCamera.transform.position - var_163_22.position

				var_163_22.forward = Vector3.New(var_163_27.x, var_163_27.y, var_163_27.z)

				local var_163_28 = var_163_22.localEulerAngles

				var_163_28.z = 0
				var_163_28.x = 0
				var_163_22.localEulerAngles = var_163_28
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				var_163_22.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_163_29 = manager.ui.mainCamera.transform.position - var_163_22.position

				var_163_22.forward = Vector3.New(var_163_29.x, var_163_29.y, var_163_29.z)

				local var_163_30 = var_163_22.localEulerAngles

				var_163_30.z = 0
				var_163_30.x = 0
				var_163_22.localEulerAngles = var_163_30
			end

			local var_163_31 = arg_160_1.actors_["1011ui_story"].transform
			local var_163_32 = 0

			if var_163_32 < arg_160_1.time_ and arg_160_1.time_ <= var_163_32 + arg_163_0 then
				arg_160_1.var_.moveOldPos1011ui_story = var_163_31.localPosition
			end

			local var_163_33 = 0.001

			if var_163_32 <= arg_160_1.time_ and arg_160_1.time_ < var_163_32 + var_163_33 then
				local var_163_34 = (arg_160_1.time_ - var_163_32) / var_163_33
				local var_163_35 = Vector3.New(0, 100, 0)

				var_163_31.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1011ui_story, var_163_35, var_163_34)

				local var_163_36 = manager.ui.mainCamera.transform.position - var_163_31.position

				var_163_31.forward = Vector3.New(var_163_36.x, var_163_36.y, var_163_36.z)

				local var_163_37 = var_163_31.localEulerAngles

				var_163_37.z = 0
				var_163_37.x = 0
				var_163_31.localEulerAngles = var_163_37
			end

			if arg_160_1.time_ >= var_163_32 + var_163_33 and arg_160_1.time_ < var_163_32 + var_163_33 + arg_163_0 then
				var_163_31.localPosition = Vector3.New(0, 100, 0)

				local var_163_38 = manager.ui.mainCamera.transform.position - var_163_31.position

				var_163_31.forward = Vector3.New(var_163_38.x, var_163_38.y, var_163_38.z)

				local var_163_39 = var_163_31.localEulerAngles

				var_163_39.z = 0
				var_163_39.x = 0
				var_163_31.localEulerAngles = var_163_39
			end

			local var_163_40 = 0
			local var_163_41 = 0.1

			if var_163_40 < arg_160_1.time_ and arg_160_1.time_ <= var_163_40 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_42 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_43 = arg_160_1:GetWordFromCfg(101071043)
				local var_163_44 = arg_160_1:FormatText(var_163_43.content)

				arg_160_1.text_.text = var_163_44

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_45 = 4
				local var_163_46 = utf8.len(var_163_44)
				local var_163_47 = var_163_45 <= 0 and var_163_41 or var_163_41 * (var_163_46 / var_163_45)

				if var_163_47 > 0 and var_163_41 < var_163_47 then
					arg_160_1.talkMaxDuration = var_163_47

					if var_163_47 + var_163_40 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_47 + var_163_40
					end
				end

				arg_160_1.text_.text = var_163_44
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071043", "story_v_out_101071.awb") ~= 0 then
					local var_163_48 = manager.audio:GetVoiceLength("story_v_out_101071", "101071043", "story_v_out_101071.awb") / 1000

					if var_163_48 + var_163_40 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_48 + var_163_40
					end

					if var_163_43.prefab_name ~= "" and arg_160_1.actors_[var_163_43.prefab_name] ~= nil then
						local var_163_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_43.prefab_name].transform, "story_v_out_101071", "101071043", "story_v_out_101071.awb")

						arg_160_1:RecordAudio("101071043", var_163_49)
						arg_160_1:RecordAudio("101071043", var_163_49)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_101071", "101071043", "story_v_out_101071.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_101071", "101071043", "story_v_out_101071.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_50 = math.max(var_163_41, arg_160_1.talkMaxDuration)

			if var_163_40 <= arg_160_1.time_ and arg_160_1.time_ < var_163_40 + var_163_50 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_40) / var_163_50

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_40 + var_163_50 and arg_160_1.time_ < var_163_40 + var_163_50 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play101071044 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 101071044
		arg_164_1.duration_ = 13.5

		local var_164_0 = {
			ja = 13.5,
			ko = 11.366,
			zh = 10.8,
			en = 12.933
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play101071045(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1019ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story == nil then
				arg_164_1.var_.characterEffect1019ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.1

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1019ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1019ui_story then
				arg_164_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_167_5 = arg_164_1.actors_["1084ui_story"]
			local var_167_6 = 0

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_7 = 0.1

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_7 and not isNil(var_167_5) then
				local var_167_8 = (arg_164_1.time_ - var_167_6) / var_167_7

				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_5) then
					local var_167_9 = Mathf.Lerp(0, 0.5, var_167_8)

					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_9
				end
			end

			if arg_164_1.time_ >= var_167_6 + var_167_7 and arg_164_1.time_ < var_167_6 + var_167_7 + arg_167_0 and not isNil(var_167_5) and arg_164_1.var_.characterEffect1084ui_story then
				local var_167_10 = 0.5

				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_10
			end

			local var_167_11 = 0
			local var_167_12 = 1.25

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_13 = arg_164_1:FormatText(StoryNameCfg[13].name)

				arg_164_1.leftNameTxt_.text = var_167_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_14 = arg_164_1:GetWordFromCfg(101071044)
				local var_167_15 = arg_164_1:FormatText(var_167_14.content)

				arg_164_1.text_.text = var_167_15

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_16 = 50
				local var_167_17 = utf8.len(var_167_15)
				local var_167_18 = var_167_16 <= 0 and var_167_12 or var_167_12 * (var_167_17 / var_167_16)

				if var_167_18 > 0 and var_167_12 < var_167_18 then
					arg_164_1.talkMaxDuration = var_167_18

					if var_167_18 + var_167_11 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_18 + var_167_11
					end
				end

				arg_164_1.text_.text = var_167_15
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071044", "story_v_out_101071.awb") ~= 0 then
					local var_167_19 = manager.audio:GetVoiceLength("story_v_out_101071", "101071044", "story_v_out_101071.awb") / 1000

					if var_167_19 + var_167_11 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_19 + var_167_11
					end

					if var_167_14.prefab_name ~= "" and arg_164_1.actors_[var_167_14.prefab_name] ~= nil then
						local var_167_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_14.prefab_name].transform, "story_v_out_101071", "101071044", "story_v_out_101071.awb")

						arg_164_1:RecordAudio("101071044", var_167_20)
						arg_164_1:RecordAudio("101071044", var_167_20)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_101071", "101071044", "story_v_out_101071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_101071", "101071044", "story_v_out_101071.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_21 = math.max(var_167_12, arg_164_1.talkMaxDuration)

			if var_167_11 <= arg_164_1.time_ and arg_164_1.time_ < var_167_11 + var_167_21 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_11) / var_167_21

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_11 + var_167_21 and arg_164_1.time_ < var_167_11 + var_167_21 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play101071045 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 101071045
		arg_168_1.duration_ = 10.5

		local var_168_0 = {
			ja = 10.333,
			ko = 9.633,
			zh = 9.733,
			en = 10.5
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play101071046(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_171_1 = 0
			local var_171_2 = 1.25

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_3 = arg_168_1:FormatText(StoryNameCfg[13].name)

				arg_168_1.leftNameTxt_.text = var_171_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(101071045)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_6 = 50
				local var_171_7 = utf8.len(var_171_5)
				local var_171_8 = var_171_6 <= 0 and var_171_2 or var_171_2 * (var_171_7 / var_171_6)

				if var_171_8 > 0 and var_171_2 < var_171_8 then
					arg_168_1.talkMaxDuration = var_171_8

					if var_171_8 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071045", "story_v_out_101071.awb") ~= 0 then
					local var_171_9 = manager.audio:GetVoiceLength("story_v_out_101071", "101071045", "story_v_out_101071.awb") / 1000

					if var_171_9 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_1
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_101071", "101071045", "story_v_out_101071.awb")

						arg_168_1:RecordAudio("101071045", var_171_10)
						arg_168_1:RecordAudio("101071045", var_171_10)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_101071", "101071045", "story_v_out_101071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_101071", "101071045", "story_v_out_101071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_11 and arg_168_1.time_ < var_171_1 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play101071046 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 101071046
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play101071047(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1019ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1019ui_story == nil then
				arg_172_1.var_.characterEffect1019ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.1

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1019ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1019ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1019ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1019ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.675

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(101071046)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 27
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play101071047 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 101071047
		arg_176_1.duration_ = 9.63

		local var_176_0 = {
			ja = 9.633,
			ko = 5.3,
			zh = 6.066,
			en = 8.333
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play101071048(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1019ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1019ui_story == nil then
				arg_176_1.var_.characterEffect1019ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.1

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1019ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1019ui_story then
				arg_176_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_179_5 = 0
			local var_179_6 = 0.775

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_7 = arg_176_1:FormatText(StoryNameCfg[13].name)

				arg_176_1.leftNameTxt_.text = var_179_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(101071047)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 31
				local var_179_11 = utf8.len(var_179_9)
				local var_179_12 = var_179_10 <= 0 and var_179_6 or var_179_6 * (var_179_11 / var_179_10)

				if var_179_12 > 0 and var_179_6 < var_179_12 then
					arg_176_1.talkMaxDuration = var_179_12

					if var_179_12 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071047", "story_v_out_101071.awb") ~= 0 then
					local var_179_13 = manager.audio:GetVoiceLength("story_v_out_101071", "101071047", "story_v_out_101071.awb") / 1000

					if var_179_13 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_5
					end

					if var_179_8.prefab_name ~= "" and arg_176_1.actors_[var_179_8.prefab_name] ~= nil then
						local var_179_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_8.prefab_name].transform, "story_v_out_101071", "101071047", "story_v_out_101071.awb")

						arg_176_1:RecordAudio("101071047", var_179_14)
						arg_176_1:RecordAudio("101071047", var_179_14)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_101071", "101071047", "story_v_out_101071.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_101071", "101071047", "story_v_out_101071.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_15 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_15 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_15

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_15 and arg_176_1.time_ < var_179_5 + var_179_15 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play101071048 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 101071048
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play101071049(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1019ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1019ui_story == nil then
				arg_180_1.var_.characterEffect1019ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.1

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1019ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1019ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1019ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1019ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.2

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(101071048)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 8
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play101071049 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 101071049
		arg_184_1.duration_ = 8.2

		local var_184_0 = {
			ja = 7.9,
			ko = 5.933,
			zh = 8.2,
			en = 6.2
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play101071050(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1019ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1019ui_story == nil then
				arg_184_1.var_.characterEffect1019ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.1

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1019ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1019ui_story then
				arg_184_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_187_5 = 0
			local var_187_6 = 0.975

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_7 = arg_184_1:FormatText(StoryNameCfg[13].name)

				arg_184_1.leftNameTxt_.text = var_187_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_8 = arg_184_1:GetWordFromCfg(101071049)
				local var_187_9 = arg_184_1:FormatText(var_187_8.content)

				arg_184_1.text_.text = var_187_9

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 39
				local var_187_11 = utf8.len(var_187_9)
				local var_187_12 = var_187_10 <= 0 and var_187_6 or var_187_6 * (var_187_11 / var_187_10)

				if var_187_12 > 0 and var_187_6 < var_187_12 then
					arg_184_1.talkMaxDuration = var_187_12

					if var_187_12 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_9
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071049", "story_v_out_101071.awb") ~= 0 then
					local var_187_13 = manager.audio:GetVoiceLength("story_v_out_101071", "101071049", "story_v_out_101071.awb") / 1000

					if var_187_13 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_5
					end

					if var_187_8.prefab_name ~= "" and arg_184_1.actors_[var_187_8.prefab_name] ~= nil then
						local var_187_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_8.prefab_name].transform, "story_v_out_101071", "101071049", "story_v_out_101071.awb")

						arg_184_1:RecordAudio("101071049", var_187_14)
						arg_184_1:RecordAudio("101071049", var_187_14)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_101071", "101071049", "story_v_out_101071.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_101071", "101071049", "story_v_out_101071.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_15 and arg_184_1.time_ < var_187_5 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play101071050 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 101071050
		arg_188_1.duration_ = 4.17

		local var_188_0 = {
			ja = 4.166,
			ko = 3.7,
			zh = 2.966,
			en = 3.2
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play101071051(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1084ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.1

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1084ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1084ui_story then
				arg_188_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_191_4 = arg_188_1.actors_["1019ui_story"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1019ui_story == nil then
				arg_188_1.var_.characterEffect1019ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.1

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.characterEffect1019ui_story and not isNil(var_191_4) then
					local var_191_8 = Mathf.Lerp(0, 0.5, var_191_7)

					arg_188_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1019ui_story.fillRatio = var_191_8
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1019ui_story then
				local var_191_9 = 0.5

				arg_188_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1019ui_story.fillRatio = var_191_9
			end

			local var_191_10 = arg_188_1.actors_["1019ui_story"].transform
			local var_191_11 = 0

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.var_.moveOldPos1019ui_story = var_191_10.localPosition
			end

			local var_191_12 = 0.001

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_12 then
				local var_191_13 = (arg_188_1.time_ - var_191_11) / var_191_12
				local var_191_14 = Vector3.New(-0.7, -1.08, -5.9)

				var_191_10.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1019ui_story, var_191_14, var_191_13)

				local var_191_15 = manager.ui.mainCamera.transform.position - var_191_10.position

				var_191_10.forward = Vector3.New(var_191_15.x, var_191_15.y, var_191_15.z)

				local var_191_16 = var_191_10.localEulerAngles

				var_191_16.z = 0
				var_191_16.x = 0
				var_191_10.localEulerAngles = var_191_16
			end

			if arg_188_1.time_ >= var_191_11 + var_191_12 and arg_188_1.time_ < var_191_11 + var_191_12 + arg_191_0 then
				var_191_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_191_17 = manager.ui.mainCamera.transform.position - var_191_10.position

				var_191_10.forward = Vector3.New(var_191_17.x, var_191_17.y, var_191_17.z)

				local var_191_18 = var_191_10.localEulerAngles

				var_191_18.z = 0
				var_191_18.x = 0
				var_191_10.localEulerAngles = var_191_18
			end

			local var_191_19 = arg_188_1.actors_["1084ui_story"].transform
			local var_191_20 = 0

			if var_191_20 < arg_188_1.time_ and arg_188_1.time_ <= var_191_20 + arg_191_0 then
				arg_188_1.var_.moveOldPos1084ui_story = var_191_19.localPosition
			end

			local var_191_21 = 0.001

			if var_191_20 <= arg_188_1.time_ and arg_188_1.time_ < var_191_20 + var_191_21 then
				local var_191_22 = (arg_188_1.time_ - var_191_20) / var_191_21
				local var_191_23 = Vector3.New(0.7, -0.97, -6)

				var_191_19.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1084ui_story, var_191_23, var_191_22)

				local var_191_24 = manager.ui.mainCamera.transform.position - var_191_19.position

				var_191_19.forward = Vector3.New(var_191_24.x, var_191_24.y, var_191_24.z)

				local var_191_25 = var_191_19.localEulerAngles

				var_191_25.z = 0
				var_191_25.x = 0
				var_191_19.localEulerAngles = var_191_25
			end

			if arg_188_1.time_ >= var_191_20 + var_191_21 and arg_188_1.time_ < var_191_20 + var_191_21 + arg_191_0 then
				var_191_19.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_191_26 = manager.ui.mainCamera.transform.position - var_191_19.position

				var_191_19.forward = Vector3.New(var_191_26.x, var_191_26.y, var_191_26.z)

				local var_191_27 = var_191_19.localEulerAngles

				var_191_27.z = 0
				var_191_27.x = 0
				var_191_19.localEulerAngles = var_191_27
			end

			local var_191_28 = 0

			if var_191_28 < arg_188_1.time_ and arg_188_1.time_ <= var_191_28 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_191_29 = 0

			if var_191_29 < arg_188_1.time_ and arg_188_1.time_ <= var_191_29 + arg_191_0 then
				arg_188_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_191_30 = 0
			local var_191_31 = 0.325

			if var_191_30 < arg_188_1.time_ and arg_188_1.time_ <= var_191_30 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_32 = arg_188_1:FormatText(StoryNameCfg[6].name)

				arg_188_1.leftNameTxt_.text = var_191_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_33 = arg_188_1:GetWordFromCfg(101071050)
				local var_191_34 = arg_188_1:FormatText(var_191_33.content)

				arg_188_1.text_.text = var_191_34

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_35 = 13
				local var_191_36 = utf8.len(var_191_34)
				local var_191_37 = var_191_35 <= 0 and var_191_31 or var_191_31 * (var_191_36 / var_191_35)

				if var_191_37 > 0 and var_191_31 < var_191_37 then
					arg_188_1.talkMaxDuration = var_191_37

					if var_191_37 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_37 + var_191_30
					end
				end

				arg_188_1.text_.text = var_191_34
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071050", "story_v_out_101071.awb") ~= 0 then
					local var_191_38 = manager.audio:GetVoiceLength("story_v_out_101071", "101071050", "story_v_out_101071.awb") / 1000

					if var_191_38 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_38 + var_191_30
					end

					if var_191_33.prefab_name ~= "" and arg_188_1.actors_[var_191_33.prefab_name] ~= nil then
						local var_191_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_33.prefab_name].transform, "story_v_out_101071", "101071050", "story_v_out_101071.awb")

						arg_188_1:RecordAudio("101071050", var_191_39)
						arg_188_1:RecordAudio("101071050", var_191_39)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_101071", "101071050", "story_v_out_101071.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_101071", "101071050", "story_v_out_101071.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_40 = math.max(var_191_31, arg_188_1.talkMaxDuration)

			if var_191_30 <= arg_188_1.time_ and arg_188_1.time_ < var_191_30 + var_191_40 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_30) / var_191_40

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_30 + var_191_40 and arg_188_1.time_ < var_191_30 + var_191_40 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play101071051 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 101071051
		arg_192_1.duration_ = 6.37

		local var_192_0 = {
			ja = 5.2,
			ko = 4.866,
			zh = 5.566,
			en = 6.366
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play101071052(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1019ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1019ui_story == nil then
				arg_192_1.var_.characterEffect1019ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.1

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1019ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1019ui_story then
				arg_192_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["1084ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1084ui_story == nil then
				arg_192_1.var_.characterEffect1084ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.1

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect1084ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1084ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect1084ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1084ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_195_11 = 0

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_195_12 = 0
			local var_195_13 = 0.6

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_14 = arg_192_1:FormatText(StoryNameCfg[13].name)

				arg_192_1.leftNameTxt_.text = var_195_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_15 = arg_192_1:GetWordFromCfg(101071051)
				local var_195_16 = arg_192_1:FormatText(var_195_15.content)

				arg_192_1.text_.text = var_195_16

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 24
				local var_195_18 = utf8.len(var_195_16)
				local var_195_19 = var_195_17 <= 0 and var_195_13 or var_195_13 * (var_195_18 / var_195_17)

				if var_195_19 > 0 and var_195_13 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19

					if var_195_19 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_16
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071051", "story_v_out_101071.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071051", "story_v_out_101071.awb") / 1000

					if var_195_20 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_12
					end

					if var_195_15.prefab_name ~= "" and arg_192_1.actors_[var_195_15.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_15.prefab_name].transform, "story_v_out_101071", "101071051", "story_v_out_101071.awb")

						arg_192_1:RecordAudio("101071051", var_195_21)
						arg_192_1:RecordAudio("101071051", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_101071", "101071051", "story_v_out_101071.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_101071", "101071051", "story_v_out_101071.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_22 and arg_192_1.time_ < var_195_12 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play101071052 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 101071052
		arg_196_1.duration_ = 6.83

		local var_196_0 = {
			ja = 6.833,
			ko = 5,
			zh = 4.266,
			en = 4.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play101071053(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_199_2 = 0
			local var_199_3 = 0.575

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_4 = arg_196_1:FormatText(StoryNameCfg[13].name)

				arg_196_1.leftNameTxt_.text = var_199_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:GetWordFromCfg(101071052)
				local var_199_6 = arg_196_1:FormatText(var_199_5.content)

				arg_196_1.text_.text = var_199_6

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 23
				local var_199_8 = utf8.len(var_199_6)
				local var_199_9 = var_199_7 <= 0 and var_199_3 or var_199_3 * (var_199_8 / var_199_7)

				if var_199_9 > 0 and var_199_3 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_6
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071052", "story_v_out_101071.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_101071", "101071052", "story_v_out_101071.awb") / 1000

					if var_199_10 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_2
					end

					if var_199_5.prefab_name ~= "" and arg_196_1.actors_[var_199_5.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_5.prefab_name].transform, "story_v_out_101071", "101071052", "story_v_out_101071.awb")

						arg_196_1:RecordAudio("101071052", var_199_11)
						arg_196_1:RecordAudio("101071052", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_101071", "101071052", "story_v_out_101071.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_101071", "101071052", "story_v_out_101071.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_12 and arg_196_1.time_ < var_199_2 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play101071053 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 101071053
		arg_200_1.duration_ = 2.27

		local var_200_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.266,
			en = 1.999999999999
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play101071054(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1011ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1011ui_story == nil then
				arg_200_1.var_.characterEffect1011ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.1

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1011ui_story and not isNil(var_203_0) then
					arg_200_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1011ui_story then
				arg_200_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_203_4 = arg_200_1.actors_["1019ui_story"]
			local var_203_5 = 0

			if var_203_5 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1019ui_story == nil then
				arg_200_1.var_.characterEffect1019ui_story = var_203_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_6 = 0.1

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_6 and not isNil(var_203_4) then
				local var_203_7 = (arg_200_1.time_ - var_203_5) / var_203_6

				if arg_200_1.var_.characterEffect1019ui_story and not isNil(var_203_4) then
					local var_203_8 = Mathf.Lerp(0, 0.5, var_203_7)

					arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1019ui_story.fillRatio = var_203_8
				end
			end

			if arg_200_1.time_ >= var_203_5 + var_203_6 and arg_200_1.time_ < var_203_5 + var_203_6 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect1019ui_story then
				local var_203_9 = 0.5

				arg_200_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1019ui_story.fillRatio = var_203_9
			end

			local var_203_10 = arg_200_1.actors_["1084ui_story"].transform
			local var_203_11 = 0

			if var_203_11 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1.var_.moveOldPos1084ui_story = var_203_10.localPosition
			end

			local var_203_12 = 0.001

			if var_203_11 <= arg_200_1.time_ and arg_200_1.time_ < var_203_11 + var_203_12 then
				local var_203_13 = (arg_200_1.time_ - var_203_11) / var_203_12
				local var_203_14 = Vector3.New(0.7, -0.97, -6)

				var_203_10.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1084ui_story, var_203_14, var_203_13)

				local var_203_15 = manager.ui.mainCamera.transform.position - var_203_10.position

				var_203_10.forward = Vector3.New(var_203_15.x, var_203_15.y, var_203_15.z)

				local var_203_16 = var_203_10.localEulerAngles

				var_203_16.z = 0
				var_203_16.x = 0
				var_203_10.localEulerAngles = var_203_16
			end

			if arg_200_1.time_ >= var_203_11 + var_203_12 and arg_200_1.time_ < var_203_11 + var_203_12 + arg_203_0 then
				var_203_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_203_17 = manager.ui.mainCamera.transform.position - var_203_10.position

				var_203_10.forward = Vector3.New(var_203_17.x, var_203_17.y, var_203_17.z)

				local var_203_18 = var_203_10.localEulerAngles

				var_203_18.z = 0
				var_203_18.x = 0
				var_203_10.localEulerAngles = var_203_18
			end

			local var_203_19 = arg_200_1.actors_["1019ui_story"].transform
			local var_203_20 = 0

			if var_203_20 < arg_200_1.time_ and arg_200_1.time_ <= var_203_20 + arg_203_0 then
				arg_200_1.var_.moveOldPos1019ui_story = var_203_19.localPosition
			end

			local var_203_21 = 0.001

			if var_203_20 <= arg_200_1.time_ and arg_200_1.time_ < var_203_20 + var_203_21 then
				local var_203_22 = (arg_200_1.time_ - var_203_20) / var_203_21
				local var_203_23 = Vector3.New(0, 100, 0)

				var_203_19.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1019ui_story, var_203_23, var_203_22)

				local var_203_24 = manager.ui.mainCamera.transform.position - var_203_19.position

				var_203_19.forward = Vector3.New(var_203_24.x, var_203_24.y, var_203_24.z)

				local var_203_25 = var_203_19.localEulerAngles

				var_203_25.z = 0
				var_203_25.x = 0
				var_203_19.localEulerAngles = var_203_25
			end

			if arg_200_1.time_ >= var_203_20 + var_203_21 and arg_200_1.time_ < var_203_20 + var_203_21 + arg_203_0 then
				var_203_19.localPosition = Vector3.New(0, 100, 0)

				local var_203_26 = manager.ui.mainCamera.transform.position - var_203_19.position

				var_203_19.forward = Vector3.New(var_203_26.x, var_203_26.y, var_203_26.z)

				local var_203_27 = var_203_19.localEulerAngles

				var_203_27.z = 0
				var_203_27.x = 0
				var_203_19.localEulerAngles = var_203_27
			end

			local var_203_28 = arg_200_1.actors_["1011ui_story"].transform
			local var_203_29 = 0

			if var_203_29 < arg_200_1.time_ and arg_200_1.time_ <= var_203_29 + arg_203_0 then
				arg_200_1.var_.moveOldPos1011ui_story = var_203_28.localPosition
			end

			local var_203_30 = 0.001

			if var_203_29 <= arg_200_1.time_ and arg_200_1.time_ < var_203_29 + var_203_30 then
				local var_203_31 = (arg_200_1.time_ - var_203_29) / var_203_30
				local var_203_32 = Vector3.New(-0.7, -0.71, -6)

				var_203_28.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1011ui_story, var_203_32, var_203_31)

				local var_203_33 = manager.ui.mainCamera.transform.position - var_203_28.position

				var_203_28.forward = Vector3.New(var_203_33.x, var_203_33.y, var_203_33.z)

				local var_203_34 = var_203_28.localEulerAngles

				var_203_34.z = 0
				var_203_34.x = 0
				var_203_28.localEulerAngles = var_203_34
			end

			if arg_200_1.time_ >= var_203_29 + var_203_30 and arg_200_1.time_ < var_203_29 + var_203_30 + arg_203_0 then
				var_203_28.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_203_35 = manager.ui.mainCamera.transform.position - var_203_28.position

				var_203_28.forward = Vector3.New(var_203_35.x, var_203_35.y, var_203_35.z)

				local var_203_36 = var_203_28.localEulerAngles

				var_203_36.z = 0
				var_203_36.x = 0
				var_203_28.localEulerAngles = var_203_36
			end

			local var_203_37 = 0

			if var_203_37 < arg_200_1.time_ and arg_200_1.time_ <= var_203_37 + arg_203_0 then
				arg_200_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_203_38 = 0

			if var_203_38 < arg_200_1.time_ and arg_200_1.time_ <= var_203_38 + arg_203_0 then
				arg_200_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_203_39 = 0

			if var_203_39 < arg_200_1.time_ and arg_200_1.time_ <= var_203_39 + arg_203_0 then
				arg_200_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_203_40 = 0
			local var_203_41 = 0.05

			if var_203_40 < arg_200_1.time_ and arg_200_1.time_ <= var_203_40 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_42 = arg_200_1:FormatText(StoryNameCfg[37].name)

				arg_200_1.leftNameTxt_.text = var_203_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_43 = arg_200_1:GetWordFromCfg(101071053)
				local var_203_44 = arg_200_1:FormatText(var_203_43.content)

				arg_200_1.text_.text = var_203_44

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_45 = 2
				local var_203_46 = utf8.len(var_203_44)
				local var_203_47 = var_203_45 <= 0 and var_203_41 or var_203_41 * (var_203_46 / var_203_45)

				if var_203_47 > 0 and var_203_41 < var_203_47 then
					arg_200_1.talkMaxDuration = var_203_47

					if var_203_47 + var_203_40 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_47 + var_203_40
					end
				end

				arg_200_1.text_.text = var_203_44
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071053", "story_v_out_101071.awb") ~= 0 then
					local var_203_48 = manager.audio:GetVoiceLength("story_v_out_101071", "101071053", "story_v_out_101071.awb") / 1000

					if var_203_48 + var_203_40 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_48 + var_203_40
					end

					if var_203_43.prefab_name ~= "" and arg_200_1.actors_[var_203_43.prefab_name] ~= nil then
						local var_203_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_43.prefab_name].transform, "story_v_out_101071", "101071053", "story_v_out_101071.awb")

						arg_200_1:RecordAudio("101071053", var_203_49)
						arg_200_1:RecordAudio("101071053", var_203_49)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_101071", "101071053", "story_v_out_101071.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_101071", "101071053", "story_v_out_101071.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_50 = math.max(var_203_41, arg_200_1.talkMaxDuration)

			if var_203_40 <= arg_200_1.time_ and arg_200_1.time_ < var_203_40 + var_203_50 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_40) / var_203_50

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_40 + var_203_50 and arg_200_1.time_ < var_203_40 + var_203_50 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play101071054 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 101071054
		arg_204_1.duration_ = 3.8

		local var_204_0 = {
			ja = 3.8,
			ko = 2.266,
			zh = 2.4,
			en = 2.3
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play101071055(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1019ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story == nil then
				arg_204_1.var_.characterEffect1019ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.1

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1019ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1019ui_story then
				arg_204_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_207_4 = arg_204_1.actors_["1011ui_story"]
			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1011ui_story == nil then
				arg_204_1.var_.characterEffect1011ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_6 = 0.1

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 and not isNil(var_207_4) then
				local var_207_7 = (arg_204_1.time_ - var_207_5) / var_207_6

				if arg_204_1.var_.characterEffect1011ui_story and not isNil(var_207_4) then
					local var_207_8 = Mathf.Lerp(0, 0.5, var_207_7)

					arg_204_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1011ui_story.fillRatio = var_207_8
				end
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1011ui_story then
				local var_207_9 = 0.5

				arg_204_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1011ui_story.fillRatio = var_207_9
			end

			local var_207_10 = arg_204_1.actors_["1011ui_story"].transform
			local var_207_11 = 0

			if var_207_11 < arg_204_1.time_ and arg_204_1.time_ <= var_207_11 + arg_207_0 then
				arg_204_1.var_.moveOldPos1011ui_story = var_207_10.localPosition
			end

			local var_207_12 = 0.001

			if var_207_11 <= arg_204_1.time_ and arg_204_1.time_ < var_207_11 + var_207_12 then
				local var_207_13 = (arg_204_1.time_ - var_207_11) / var_207_12
				local var_207_14 = Vector3.New(-0.7, -0.71, -6)

				var_207_10.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1011ui_story, var_207_14, var_207_13)

				local var_207_15 = manager.ui.mainCamera.transform.position - var_207_10.position

				var_207_10.forward = Vector3.New(var_207_15.x, var_207_15.y, var_207_15.z)

				local var_207_16 = var_207_10.localEulerAngles

				var_207_16.z = 0
				var_207_16.x = 0
				var_207_10.localEulerAngles = var_207_16
			end

			if arg_204_1.time_ >= var_207_11 + var_207_12 and arg_204_1.time_ < var_207_11 + var_207_12 + arg_207_0 then
				var_207_10.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_207_17 = manager.ui.mainCamera.transform.position - var_207_10.position

				var_207_10.forward = Vector3.New(var_207_17.x, var_207_17.y, var_207_17.z)

				local var_207_18 = var_207_10.localEulerAngles

				var_207_18.z = 0
				var_207_18.x = 0
				var_207_10.localEulerAngles = var_207_18
			end

			local var_207_19 = arg_204_1.actors_["1019ui_story"].transform
			local var_207_20 = 0

			if var_207_20 < arg_204_1.time_ and arg_204_1.time_ <= var_207_20 + arg_207_0 then
				arg_204_1.var_.moveOldPos1019ui_story = var_207_19.localPosition
			end

			local var_207_21 = 0.001

			if var_207_20 <= arg_204_1.time_ and arg_204_1.time_ < var_207_20 + var_207_21 then
				local var_207_22 = (arg_204_1.time_ - var_207_20) / var_207_21
				local var_207_23 = Vector3.New(0.7, -1.08, -5.9)

				var_207_19.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1019ui_story, var_207_23, var_207_22)

				local var_207_24 = manager.ui.mainCamera.transform.position - var_207_19.position

				var_207_19.forward = Vector3.New(var_207_24.x, var_207_24.y, var_207_24.z)

				local var_207_25 = var_207_19.localEulerAngles

				var_207_25.z = 0
				var_207_25.x = 0
				var_207_19.localEulerAngles = var_207_25
			end

			if arg_204_1.time_ >= var_207_20 + var_207_21 and arg_204_1.time_ < var_207_20 + var_207_21 + arg_207_0 then
				var_207_19.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_207_26 = manager.ui.mainCamera.transform.position - var_207_19.position

				var_207_19.forward = Vector3.New(var_207_26.x, var_207_26.y, var_207_26.z)

				local var_207_27 = var_207_19.localEulerAngles

				var_207_27.z = 0
				var_207_27.x = 0
				var_207_19.localEulerAngles = var_207_27
			end

			local var_207_28 = 0

			if var_207_28 < arg_204_1.time_ and arg_204_1.time_ <= var_207_28 + arg_207_0 then
				arg_204_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_207_29 = arg_204_1.actors_["1084ui_story"].transform
			local var_207_30 = 0

			if var_207_30 < arg_204_1.time_ and arg_204_1.time_ <= var_207_30 + arg_207_0 then
				arg_204_1.var_.moveOldPos1084ui_story = var_207_29.localPosition
			end

			local var_207_31 = 0.001

			if var_207_30 <= arg_204_1.time_ and arg_204_1.time_ < var_207_30 + var_207_31 then
				local var_207_32 = (arg_204_1.time_ - var_207_30) / var_207_31
				local var_207_33 = Vector3.New(0, 100, 0)

				var_207_29.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1084ui_story, var_207_33, var_207_32)

				local var_207_34 = manager.ui.mainCamera.transform.position - var_207_29.position

				var_207_29.forward = Vector3.New(var_207_34.x, var_207_34.y, var_207_34.z)

				local var_207_35 = var_207_29.localEulerAngles

				var_207_35.z = 0
				var_207_35.x = 0
				var_207_29.localEulerAngles = var_207_35
			end

			if arg_204_1.time_ >= var_207_30 + var_207_31 and arg_204_1.time_ < var_207_30 + var_207_31 + arg_207_0 then
				var_207_29.localPosition = Vector3.New(0, 100, 0)

				local var_207_36 = manager.ui.mainCamera.transform.position - var_207_29.position

				var_207_29.forward = Vector3.New(var_207_36.x, var_207_36.y, var_207_36.z)

				local var_207_37 = var_207_29.localEulerAngles

				var_207_37.z = 0
				var_207_37.x = 0
				var_207_29.localEulerAngles = var_207_37
			end

			local var_207_38 = 0
			local var_207_39 = 0.225

			if var_207_38 < arg_204_1.time_ and arg_204_1.time_ <= var_207_38 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_40 = arg_204_1:FormatText(StoryNameCfg[13].name)

				arg_204_1.leftNameTxt_.text = var_207_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_41 = arg_204_1:GetWordFromCfg(101071054)
				local var_207_42 = arg_204_1:FormatText(var_207_41.content)

				arg_204_1.text_.text = var_207_42

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_43 = 10
				local var_207_44 = utf8.len(var_207_42)
				local var_207_45 = var_207_43 <= 0 and var_207_39 or var_207_39 * (var_207_44 / var_207_43)

				if var_207_45 > 0 and var_207_39 < var_207_45 then
					arg_204_1.talkMaxDuration = var_207_45

					if var_207_45 + var_207_38 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_45 + var_207_38
					end
				end

				arg_204_1.text_.text = var_207_42
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071054", "story_v_out_101071.awb") ~= 0 then
					local var_207_46 = manager.audio:GetVoiceLength("story_v_out_101071", "101071054", "story_v_out_101071.awb") / 1000

					if var_207_46 + var_207_38 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_46 + var_207_38
					end

					if var_207_41.prefab_name ~= "" and arg_204_1.actors_[var_207_41.prefab_name] ~= nil then
						local var_207_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_41.prefab_name].transform, "story_v_out_101071", "101071054", "story_v_out_101071.awb")

						arg_204_1:RecordAudio("101071054", var_207_47)
						arg_204_1:RecordAudio("101071054", var_207_47)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_101071", "101071054", "story_v_out_101071.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_101071", "101071054", "story_v_out_101071.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_48 = math.max(var_207_39, arg_204_1.talkMaxDuration)

			if var_207_38 <= arg_204_1.time_ and arg_204_1.time_ < var_207_38 + var_207_48 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_38) / var_207_48

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_38 + var_207_48 and arg_204_1.time_ < var_207_38 + var_207_48 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play101071055 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 101071055
		arg_208_1.duration_ = 6.97

		local var_208_0 = {
			ja = 6.966,
			ko = 4.6,
			zh = 4.6,
			en = 4.633
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play101071056(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1011ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1011ui_story == nil then
				arg_208_1.var_.characterEffect1011ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.1

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1011ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1011ui_story then
				arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_211_4 = arg_208_1.actors_["1019ui_story"]
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect1019ui_story == nil then
				arg_208_1.var_.characterEffect1019ui_story = var_211_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_6 = 0.1

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 and not isNil(var_211_4) then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6

				if arg_208_1.var_.characterEffect1019ui_story and not isNil(var_211_4) then
					local var_211_8 = Mathf.Lerp(0, 0.5, var_211_7)

					arg_208_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1019ui_story.fillRatio = var_211_8
				end
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect1019ui_story then
				local var_211_9 = 0.5

				arg_208_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1019ui_story.fillRatio = var_211_9
			end

			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			local var_211_11 = 0

			if var_211_11 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_211_12 = 0
			local var_211_13 = 0.375

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_14 = arg_208_1:FormatText(StoryNameCfg[37].name)

				arg_208_1.leftNameTxt_.text = var_211_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_15 = arg_208_1:GetWordFromCfg(101071055)
				local var_211_16 = arg_208_1:FormatText(var_211_15.content)

				arg_208_1.text_.text = var_211_16

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_17 = 15
				local var_211_18 = utf8.len(var_211_16)
				local var_211_19 = var_211_17 <= 0 and var_211_13 or var_211_13 * (var_211_18 / var_211_17)

				if var_211_19 > 0 and var_211_13 < var_211_19 then
					arg_208_1.talkMaxDuration = var_211_19

					if var_211_19 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_19 + var_211_12
					end
				end

				arg_208_1.text_.text = var_211_16
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071055", "story_v_out_101071.awb") ~= 0 then
					local var_211_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071055", "story_v_out_101071.awb") / 1000

					if var_211_20 + var_211_12 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_20 + var_211_12
					end

					if var_211_15.prefab_name ~= "" and arg_208_1.actors_[var_211_15.prefab_name] ~= nil then
						local var_211_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_15.prefab_name].transform, "story_v_out_101071", "101071055", "story_v_out_101071.awb")

						arg_208_1:RecordAudio("101071055", var_211_21)
						arg_208_1:RecordAudio("101071055", var_211_21)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_101071", "101071055", "story_v_out_101071.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_101071", "101071055", "story_v_out_101071.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = math.max(var_211_13, arg_208_1.talkMaxDuration)

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_22 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_12) / var_211_22

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_12 + var_211_22 and arg_208_1.time_ < var_211_12 + var_211_22 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play101071056 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 101071056
		arg_212_1.duration_ = 6.93

		local var_212_0 = {
			ja = 6.933,
			ko = 4,
			zh = 5.533,
			en = 5.233
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play101071057(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1019ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1019ui_story == nil then
				arg_212_1.var_.characterEffect1019ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.1

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1019ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1019ui_story then
				arg_212_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_215_4 = arg_212_1.actors_["1011ui_story"]
			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1011ui_story == nil then
				arg_212_1.var_.characterEffect1011ui_story = var_215_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.1

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_6 and not isNil(var_215_4) then
				local var_215_7 = (arg_212_1.time_ - var_215_5) / var_215_6

				if arg_212_1.var_.characterEffect1011ui_story and not isNil(var_215_4) then
					local var_215_8 = Mathf.Lerp(0, 0.5, var_215_7)

					arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1011ui_story.fillRatio = var_215_8
				end
			end

			if arg_212_1.time_ >= var_215_5 + var_215_6 and arg_212_1.time_ < var_215_5 + var_215_6 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1011ui_story then
				local var_215_9 = 0.5

				arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1011ui_story.fillRatio = var_215_9
			end

			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_215_11 = 0
			local var_215_12 = 0.7

			if var_215_11 < arg_212_1.time_ and arg_212_1.time_ <= var_215_11 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_13 = arg_212_1:FormatText(StoryNameCfg[13].name)

				arg_212_1.leftNameTxt_.text = var_215_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_14 = arg_212_1:GetWordFromCfg(101071056)
				local var_215_15 = arg_212_1:FormatText(var_215_14.content)

				arg_212_1.text_.text = var_215_15

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_16 = 28
				local var_215_17 = utf8.len(var_215_15)
				local var_215_18 = var_215_16 <= 0 and var_215_12 or var_215_12 * (var_215_17 / var_215_16)

				if var_215_18 > 0 and var_215_12 < var_215_18 then
					arg_212_1.talkMaxDuration = var_215_18

					if var_215_18 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_18 + var_215_11
					end
				end

				arg_212_1.text_.text = var_215_15
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071056", "story_v_out_101071.awb") ~= 0 then
					local var_215_19 = manager.audio:GetVoiceLength("story_v_out_101071", "101071056", "story_v_out_101071.awb") / 1000

					if var_215_19 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_19 + var_215_11
					end

					if var_215_14.prefab_name ~= "" and arg_212_1.actors_[var_215_14.prefab_name] ~= nil then
						local var_215_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_14.prefab_name].transform, "story_v_out_101071", "101071056", "story_v_out_101071.awb")

						arg_212_1:RecordAudio("101071056", var_215_20)
						arg_212_1:RecordAudio("101071056", var_215_20)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_101071", "101071056", "story_v_out_101071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_101071", "101071056", "story_v_out_101071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_21 = math.max(var_215_12, arg_212_1.talkMaxDuration)

			if var_215_11 <= arg_212_1.time_ and arg_212_1.time_ < var_215_11 + var_215_21 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_11) / var_215_21

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_11 + var_215_21 and arg_212_1.time_ < var_215_11 + var_215_21 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play101071057 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 101071057
		arg_216_1.duration_ = 4.3

		local var_216_0 = {
			ja = 3.566,
			ko = 4.066,
			zh = 4.3,
			en = 3.2
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play101071058(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_219_1 = 0
			local var_219_2 = 0.55

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_3 = arg_216_1:FormatText(StoryNameCfg[13].name)

				arg_216_1.leftNameTxt_.text = var_219_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_4 = arg_216_1:GetWordFromCfg(101071057)
				local var_219_5 = arg_216_1:FormatText(var_219_4.content)

				arg_216_1.text_.text = var_219_5

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 22
				local var_219_7 = utf8.len(var_219_5)
				local var_219_8 = var_219_6 <= 0 and var_219_2 or var_219_2 * (var_219_7 / var_219_6)

				if var_219_8 > 0 and var_219_2 < var_219_8 then
					arg_216_1.talkMaxDuration = var_219_8

					if var_219_8 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_5
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071057", "story_v_out_101071.awb") ~= 0 then
					local var_219_9 = manager.audio:GetVoiceLength("story_v_out_101071", "101071057", "story_v_out_101071.awb") / 1000

					if var_219_9 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_1
					end

					if var_219_4.prefab_name ~= "" and arg_216_1.actors_[var_219_4.prefab_name] ~= nil then
						local var_219_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_4.prefab_name].transform, "story_v_out_101071", "101071057", "story_v_out_101071.awb")

						arg_216_1:RecordAudio("101071057", var_219_10)
						arg_216_1:RecordAudio("101071057", var_219_10)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_101071", "101071057", "story_v_out_101071.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_101071", "101071057", "story_v_out_101071.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_11 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_11 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_11

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_11 and arg_216_1.time_ < var_219_1 + var_219_11 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play101071058 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 101071058
		arg_220_1.duration_ = 8.8

		local var_220_0 = {
			ja = 7,
			ko = 8.3,
			zh = 8.233,
			en = 8.8
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play101071059(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1011ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1011ui_story == nil then
				arg_220_1.var_.characterEffect1011ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.1

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1011ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1011ui_story then
				arg_220_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_223_4 = arg_220_1.actors_["1019ui_story"]
			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect1019ui_story == nil then
				arg_220_1.var_.characterEffect1019ui_story = var_223_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_6 = 0.1

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_6 and not isNil(var_223_4) then
				local var_223_7 = (arg_220_1.time_ - var_223_5) / var_223_6

				if arg_220_1.var_.characterEffect1019ui_story and not isNil(var_223_4) then
					local var_223_8 = Mathf.Lerp(0, 0.5, var_223_7)

					arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1019ui_story.fillRatio = var_223_8
				end
			end

			if arg_220_1.time_ >= var_223_5 + var_223_6 and arg_220_1.time_ < var_223_5 + var_223_6 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect1019ui_story then
				local var_223_9 = 0.5

				arg_220_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1019ui_story.fillRatio = var_223_9
			end

			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 then
				arg_220_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_223_11 = 0

			if var_223_11 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_223_12 = 0
			local var_223_13 = 0.875

			if var_223_12 < arg_220_1.time_ and arg_220_1.time_ <= var_223_12 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_14 = arg_220_1:FormatText(StoryNameCfg[37].name)

				arg_220_1.leftNameTxt_.text = var_223_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_15 = arg_220_1:GetWordFromCfg(101071058)
				local var_223_16 = arg_220_1:FormatText(var_223_15.content)

				arg_220_1.text_.text = var_223_16

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_17 = 35
				local var_223_18 = utf8.len(var_223_16)
				local var_223_19 = var_223_17 <= 0 and var_223_13 or var_223_13 * (var_223_18 / var_223_17)

				if var_223_19 > 0 and var_223_13 < var_223_19 then
					arg_220_1.talkMaxDuration = var_223_19

					if var_223_19 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_19 + var_223_12
					end
				end

				arg_220_1.text_.text = var_223_16
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071058", "story_v_out_101071.awb") ~= 0 then
					local var_223_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071058", "story_v_out_101071.awb") / 1000

					if var_223_20 + var_223_12 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_20 + var_223_12
					end

					if var_223_15.prefab_name ~= "" and arg_220_1.actors_[var_223_15.prefab_name] ~= nil then
						local var_223_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_15.prefab_name].transform, "story_v_out_101071", "101071058", "story_v_out_101071.awb")

						arg_220_1:RecordAudio("101071058", var_223_21)
						arg_220_1:RecordAudio("101071058", var_223_21)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_101071", "101071058", "story_v_out_101071.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_101071", "101071058", "story_v_out_101071.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_22 = math.max(var_223_13, arg_220_1.talkMaxDuration)

			if var_223_12 <= arg_220_1.time_ and arg_220_1.time_ < var_223_12 + var_223_22 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_12) / var_223_22

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_12 + var_223_22 and arg_220_1.time_ < var_223_12 + var_223_22 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play101071059 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 101071059
		arg_224_1.duration_ = 7.93

		local var_224_0 = {
			ja = 7.933,
			ko = 3.733,
			zh = 4.166,
			en = 3.5
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
			arg_224_1.auto_ = false
		end

		function arg_224_1.playNext_(arg_226_0)
			arg_224_1.onStoryFinished_()
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1019ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1019ui_story == nil then
				arg_224_1.var_.characterEffect1019ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.1

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1019ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1019ui_story then
				arg_224_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_227_4 = arg_224_1.actors_["1011ui_story"]
			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1011ui_story == nil then
				arg_224_1.var_.characterEffect1011ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.1

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_6 and not isNil(var_227_4) then
				local var_227_7 = (arg_224_1.time_ - var_227_5) / var_227_6

				if arg_224_1.var_.characterEffect1011ui_story and not isNil(var_227_4) then
					local var_227_8 = Mathf.Lerp(0, 0.5, var_227_7)

					arg_224_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1011ui_story.fillRatio = var_227_8
				end
			end

			if arg_224_1.time_ >= var_227_5 + var_227_6 and arg_224_1.time_ < var_227_5 + var_227_6 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1011ui_story then
				local var_227_9 = 0.5

				arg_224_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1011ui_story.fillRatio = var_227_9
			end

			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_227_11 = 0

			if var_227_11 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_227_12 = 0
			local var_227_13 = 0.4

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[13].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(101071059)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 16
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071059", "story_v_out_101071.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_101071", "101071059", "story_v_out_101071.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_101071", "101071059", "story_v_out_101071.awb")

						arg_224_1:RecordAudio("101071059", var_227_21)
						arg_224_1:RecordAudio("101071059", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_101071", "101071059", "story_v_out_101071.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_101071", "101071059", "story_v_out_101071.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play101071034 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 101071034
		arg_228_1.duration_ = 8.4

		local var_228_0 = {
			ja = 8.4,
			ko = 5.466,
			zh = 4.633,
			en = 5.2
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play101071035(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1019ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1019ui_story == nil then
				arg_228_1.var_.characterEffect1019ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.1

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1019ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1019ui_story then
				arg_228_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["1011ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1011ui_story == nil then
				arg_228_1.var_.characterEffect1011ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.1

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect1011ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1011ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1011ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1011ui_story.fillRatio = var_231_9
			end

			local var_231_10 = "1019ui_story"

			if arg_228_1.actors_[var_231_10] == nil then
				local var_231_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_231_11) then
					local var_231_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_228_1.stage_.transform)

					var_231_12.name = var_231_10
					var_231_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_228_1.actors_[var_231_10] = var_231_12

					local var_231_13 = var_231_12:GetComponentInChildren(typeof(CharacterEffect))

					var_231_13.enabled = true

					local var_231_14 = GameObjectTools.GetOrAddComponent(var_231_12, typeof(DynamicBoneHelper))

					if var_231_14 then
						var_231_14:EnableDynamicBone(false)
					end

					arg_228_1:ShowWeapon(var_231_13.transform, false)

					arg_228_1.var_[var_231_10 .. "Animator"] = var_231_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_228_1.var_[var_231_10 .. "Animator"].applyRootMotion = true
					arg_228_1.var_[var_231_10 .. "LipSync"] = var_231_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_231_15 = 0

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_231_16 = 0
			local var_231_17 = 0.675

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_18 = arg_228_1:FormatText(StoryNameCfg[13].name)

				arg_228_1.leftNameTxt_.text = var_231_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_19 = arg_228_1:GetWordFromCfg(101071034)
				local var_231_20 = arg_228_1:FormatText(var_231_19.content)

				arg_228_1.text_.text = var_231_20

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_21 = 26
				local var_231_22 = utf8.len(var_231_20)
				local var_231_23 = var_231_21 <= 0 and var_231_17 or var_231_17 * (var_231_22 / var_231_21)

				if var_231_23 > 0 and var_231_17 < var_231_23 then
					arg_228_1.talkMaxDuration = var_231_23

					if var_231_23 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_16
					end
				end

				arg_228_1.text_.text = var_231_20
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071034", "story_v_out_101071.awb") ~= 0 then
					local var_231_24 = manager.audio:GetVoiceLength("story_v_out_101071", "101071034", "story_v_out_101071.awb") / 1000

					if var_231_24 + var_231_16 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_24 + var_231_16
					end

					if var_231_19.prefab_name ~= "" and arg_228_1.actors_[var_231_19.prefab_name] ~= nil then
						local var_231_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_19.prefab_name].transform, "story_v_out_101071", "101071034", "story_v_out_101071.awb")

						arg_228_1:RecordAudio("101071034", var_231_25)
						arg_228_1:RecordAudio("101071034", var_231_25)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_101071", "101071034", "story_v_out_101071.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_101071", "101071034", "story_v_out_101071.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_26 = math.max(var_231_17, arg_228_1.talkMaxDuration)

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_26 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_16) / var_231_26

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_16 + var_231_26 and arg_228_1.time_ < var_231_16 + var_231_26 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play101071018 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 101071018
		arg_232_1.duration_ = 9.03

		local var_232_0 = {
			ja = 9.033,
			ko = 6.8,
			zh = 5.833,
			en = 5.3
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play101071019(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1084ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1084ui_story == nil then
				arg_232_1.var_.characterEffect1084ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.1

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1084ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1084ui_story then
				arg_232_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_235_4 = arg_232_1.actors_["1019ui_story"].transform
			local var_235_5 = 0

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.var_.moveOldPos1019ui_story = var_235_4.localPosition
			end

			local var_235_6 = 0.001

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_6 then
				local var_235_7 = (arg_232_1.time_ - var_235_5) / var_235_6
				local var_235_8 = Vector3.New(-0.7, -1.08, -5.9)

				var_235_4.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1019ui_story, var_235_8, var_235_7)

				local var_235_9 = manager.ui.mainCamera.transform.position - var_235_4.position

				var_235_4.forward = Vector3.New(var_235_9.x, var_235_9.y, var_235_9.z)

				local var_235_10 = var_235_4.localEulerAngles

				var_235_10.z = 0
				var_235_10.x = 0
				var_235_4.localEulerAngles = var_235_10
			end

			if arg_232_1.time_ >= var_235_5 + var_235_6 and arg_232_1.time_ < var_235_5 + var_235_6 + arg_235_0 then
				var_235_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_235_11 = manager.ui.mainCamera.transform.position - var_235_4.position

				var_235_4.forward = Vector3.New(var_235_11.x, var_235_11.y, var_235_11.z)

				local var_235_12 = var_235_4.localEulerAngles

				var_235_12.z = 0
				var_235_12.x = 0
				var_235_4.localEulerAngles = var_235_12
			end

			local var_235_13 = arg_232_1.actors_["1084ui_story"].transform
			local var_235_14 = 0

			if var_235_14 < arg_232_1.time_ and arg_232_1.time_ <= var_235_14 + arg_235_0 then
				arg_232_1.var_.moveOldPos1084ui_story = var_235_13.localPosition
			end

			local var_235_15 = 0.001

			if var_235_14 <= arg_232_1.time_ and arg_232_1.time_ < var_235_14 + var_235_15 then
				local var_235_16 = (arg_232_1.time_ - var_235_14) / var_235_15
				local var_235_17 = Vector3.New(0.7, -0.97, -6)

				var_235_13.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1084ui_story, var_235_17, var_235_16)

				local var_235_18 = manager.ui.mainCamera.transform.position - var_235_13.position

				var_235_13.forward = Vector3.New(var_235_18.x, var_235_18.y, var_235_18.z)

				local var_235_19 = var_235_13.localEulerAngles

				var_235_19.z = 0
				var_235_19.x = 0
				var_235_13.localEulerAngles = var_235_19
			end

			if arg_232_1.time_ >= var_235_14 + var_235_15 and arg_232_1.time_ < var_235_14 + var_235_15 + arg_235_0 then
				var_235_13.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_235_20 = manager.ui.mainCamera.transform.position - var_235_13.position

				var_235_13.forward = Vector3.New(var_235_20.x, var_235_20.y, var_235_20.z)

				local var_235_21 = var_235_13.localEulerAngles

				var_235_21.z = 0
				var_235_21.x = 0
				var_235_13.localEulerAngles = var_235_21
			end

			local var_235_22 = "1084ui_story"

			if arg_232_1.actors_[var_235_22] == nil then
				local var_235_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_235_23) then
					local var_235_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_232_1.stage_.transform)

					var_235_24.name = var_235_22
					var_235_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_232_1.actors_[var_235_22] = var_235_24

					local var_235_25 = var_235_24:GetComponentInChildren(typeof(CharacterEffect))

					var_235_25.enabled = true

					local var_235_26 = GameObjectTools.GetOrAddComponent(var_235_24, typeof(DynamicBoneHelper))

					if var_235_26 then
						var_235_26:EnableDynamicBone(false)
					end

					arg_232_1:ShowWeapon(var_235_25.transform, false)

					arg_232_1.var_[var_235_22 .. "Animator"] = var_235_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_232_1.var_[var_235_22 .. "Animator"].applyRootMotion = true
					arg_232_1.var_[var_235_22 .. "LipSync"] = var_235_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_235_27 = 0

			if var_235_27 < arg_232_1.time_ and arg_232_1.time_ <= var_235_27 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action485")
			end

			local var_235_28 = "1084ui_story"

			if arg_232_1.actors_[var_235_28] == nil then
				local var_235_29 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_235_29) then
					local var_235_30 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_232_1.stage_.transform)

					var_235_30.name = var_235_28
					var_235_30.transform.localPosition = Vector3.New(0, 100, 0)
					arg_232_1.actors_[var_235_28] = var_235_30

					local var_235_31 = var_235_30:GetComponentInChildren(typeof(CharacterEffect))

					var_235_31.enabled = true

					local var_235_32 = GameObjectTools.GetOrAddComponent(var_235_30, typeof(DynamicBoneHelper))

					if var_235_32 then
						var_235_32:EnableDynamicBone(false)
					end

					arg_232_1:ShowWeapon(var_235_31.transform, false)

					arg_232_1.var_[var_235_28 .. "Animator"] = var_235_31.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_232_1.var_[var_235_28 .. "Animator"].applyRootMotion = true
					arg_232_1.var_[var_235_28 .. "LipSync"] = var_235_31.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_235_33 = 0

			if var_235_33 < arg_232_1.time_ and arg_232_1.time_ <= var_235_33 + arg_235_0 then
				arg_232_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_235_34 = 0
			local var_235_35 = 0.7

			if var_235_34 < arg_232_1.time_ and arg_232_1.time_ <= var_235_34 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_36 = arg_232_1:FormatText(StoryNameCfg[6].name)

				arg_232_1.leftNameTxt_.text = var_235_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_37 = arg_232_1:GetWordFromCfg(101071018)
				local var_235_38 = arg_232_1:FormatText(var_235_37.content)

				arg_232_1.text_.text = var_235_38

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_39 = 28
				local var_235_40 = utf8.len(var_235_38)
				local var_235_41 = var_235_39 <= 0 and var_235_35 or var_235_35 * (var_235_40 / var_235_39)

				if var_235_41 > 0 and var_235_35 < var_235_41 then
					arg_232_1.talkMaxDuration = var_235_41

					if var_235_41 + var_235_34 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_41 + var_235_34
					end
				end

				arg_232_1.text_.text = var_235_38
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_101071", "101071018", "story_v_out_101071.awb") ~= 0 then
					local var_235_42 = manager.audio:GetVoiceLength("story_v_out_101071", "101071018", "story_v_out_101071.awb") / 1000

					if var_235_42 + var_235_34 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_42 + var_235_34
					end

					if var_235_37.prefab_name ~= "" and arg_232_1.actors_[var_235_37.prefab_name] ~= nil then
						local var_235_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_37.prefab_name].transform, "story_v_out_101071", "101071018", "story_v_out_101071.awb")

						arg_232_1:RecordAudio("101071018", var_235_43)
						arg_232_1:RecordAudio("101071018", var_235_43)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_101071", "101071018", "story_v_out_101071.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_101071", "101071018", "story_v_out_101071.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_44 = math.max(var_235_35, arg_232_1.talkMaxDuration)

			if var_235_34 <= arg_232_1.time_ and arg_232_1.time_ < var_235_34 + var_235_44 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_34) / var_235_44

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_34 + var_235_44 and arg_232_1.time_ < var_235_34 + var_235_44 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play101071019 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 101071019
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play101071021(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1084ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1084ui_story == nil then
				arg_236_1.var_.characterEffect1084ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.1

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect1084ui_story and not isNil(var_239_0) then
					local var_239_4 = Mathf.Lerp(0, 0.5, var_239_3)

					arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_4
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect1084ui_story then
				local var_239_5 = 0.5

				arg_236_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1084ui_story.fillRatio = var_239_5
			end

			local var_239_6 = 0
			local var_239_7 = 0.4

			if var_239_6 < arg_236_1.time_ and arg_236_1.time_ <= var_239_6 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_8 = arg_236_1:FormatText(StoryNameCfg[7].name)

				arg_236_1.leftNameTxt_.text = var_239_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_9 = arg_236_1:GetWordFromCfg(101071019)
				local var_239_10 = arg_236_1:FormatText(var_239_9.content)

				arg_236_1.text_.text = var_239_10

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_11 = 16
				local var_239_12 = utf8.len(var_239_10)
				local var_239_13 = var_239_11 <= 0 and var_239_7 or var_239_7 * (var_239_12 / var_239_11)

				if var_239_13 > 0 and var_239_7 < var_239_13 then
					arg_236_1.talkMaxDuration = var_239_13

					if var_239_13 + var_239_6 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_13 + var_239_6
					end
				end

				arg_236_1.text_.text = var_239_10
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_14 = math.max(var_239_7, arg_236_1.talkMaxDuration)

			if var_239_6 <= arg_236_1.time_ and arg_236_1.time_ < var_239_6 + var_239_14 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_6) / var_239_14

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_6 + var_239_14 and arg_236_1.time_ < var_239_6 + var_239_14 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0101"
	},
	voices = {
		"story_v_out_101071.awb"
	}
}
