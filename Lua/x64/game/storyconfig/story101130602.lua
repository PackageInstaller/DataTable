return {
	Play113062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F01"

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
				local var_4_5 = arg_1_1.bgs_.F01

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
					if iter_4_0 ~= "F01" then
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

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1.96666666666667
			local var_4_29 = 0.533333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.25

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(113062001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 10
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113062002
		arg_9_1.duration_ = 8.5

		local var_9_0 = {
			ja = 8.5,
			ko = 7.333,
			zh = 7.6,
			en = 6.033
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1084ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(-0.7, -0.97, -6)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = 0

			if var_12_14 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_12_16 = arg_9_1.actors_["1084ui_story"]
			local var_12_17 = 0

			if var_12_17 < arg_9_1.time_ and arg_9_1.time_ <= var_12_17 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_18 = 0.2

			if var_12_17 <= arg_9_1.time_ and arg_9_1.time_ < var_12_17 + var_12_18 and not isNil(var_12_16) then
				local var_12_19 = (arg_9_1.time_ - var_12_17) / var_12_18

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_16) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_17 + var_12_18 and arg_9_1.time_ < var_12_17 + var_12_18 + arg_12_0 and not isNil(var_12_16) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_20 = 0
			local var_12_21 = 0.7

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[6].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(113062002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 28
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062002", "story_v_out_113062.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_113062", "113062002", "story_v_out_113062.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_113062", "113062002", "story_v_out_113062.awb")

						arg_9_1:RecordAudio("113062002", var_12_29)
						arg_9_1:RecordAudio("113062002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113062", "113062002", "story_v_out_113062.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113062", "113062002", "story_v_out_113062.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play113062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113062003
		arg_13_1.duration_ = 7.53

		local var_13_0 = {
			ja = 5.433,
			ko = 4.5,
			zh = 5.033,
			en = 7.533
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
				arg_13_0:Play113062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1084ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_5
			end

			local var_16_6 = "1042ui_story"

			if arg_13_1.actors_[var_16_6] == nil then
				local var_16_7 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_16_7) then
					local var_16_8 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_13_1.stage_.transform)

					var_16_8.name = var_16_6
					var_16_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_6] = var_16_8

					local var_16_9 = var_16_8:GetComponentInChildren(typeof(CharacterEffect))

					var_16_9.enabled = true

					local var_16_10 = GameObjectTools.GetOrAddComponent(var_16_8, typeof(DynamicBoneHelper))

					if var_16_10 then
						var_16_10:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_9.transform, false)

					arg_13_1.var_[var_16_6 .. "Animator"] = var_16_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_6 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_6 .. "LipSync"] = var_16_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_11 = arg_13_1.actors_["1042ui_story"].transform
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.var_.moveOldPos1042ui_story = var_16_11.localPosition
			end

			local var_16_13 = 0.001

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13
				local var_16_15 = Vector3.New(0.7, -1.06, -6.2)

				var_16_11.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1042ui_story, var_16_15, var_16_14)

				local var_16_16 = manager.ui.mainCamera.transform.position - var_16_11.position

				var_16_11.forward = Vector3.New(var_16_16.x, var_16_16.y, var_16_16.z)

				local var_16_17 = var_16_11.localEulerAngles

				var_16_17.z = 0
				var_16_17.x = 0
				var_16_11.localEulerAngles = var_16_17
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 then
				var_16_11.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_16_18 = manager.ui.mainCamera.transform.position - var_16_11.position

				var_16_11.forward = Vector3.New(var_16_18.x, var_16_18.y, var_16_18.z)

				local var_16_19 = var_16_11.localEulerAngles

				var_16_19.z = 0
				var_16_19.x = 0
				var_16_11.localEulerAngles = var_16_19
			end

			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_16_21 = 0

			if var_16_21 < arg_13_1.time_ and arg_13_1.time_ <= var_16_21 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_16_22 = arg_13_1.actors_["1042ui_story"]
			local var_16_23 = 0

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.characterEffect1042ui_story == nil then
				arg_13_1.var_.characterEffect1042ui_story = var_16_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_24 = 0.2

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_24 and not isNil(var_16_22) then
				local var_16_25 = (arg_13_1.time_ - var_16_23) / var_16_24

				if arg_13_1.var_.characterEffect1042ui_story and not isNil(var_16_22) then
					arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_23 + var_16_24 and arg_13_1.time_ < var_16_23 + var_16_24 + arg_16_0 and not isNil(var_16_22) and arg_13_1.var_.characterEffect1042ui_story then
				arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_16_26 = 0
			local var_16_27 = 0.45

			if var_16_26 < arg_13_1.time_ and arg_13_1.time_ <= var_16_26 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_28 = arg_13_1:FormatText(StoryNameCfg[205].name)

				arg_13_1.leftNameTxt_.text = var_16_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_29 = arg_13_1:GetWordFromCfg(113062003)
				local var_16_30 = arg_13_1:FormatText(var_16_29.content)

				arg_13_1.text_.text = var_16_30

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_31 = 18
				local var_16_32 = utf8.len(var_16_30)
				local var_16_33 = var_16_31 <= 0 and var_16_27 or var_16_27 * (var_16_32 / var_16_31)

				if var_16_33 > 0 and var_16_27 < var_16_33 then
					arg_13_1.talkMaxDuration = var_16_33

					if var_16_33 + var_16_26 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_26
					end
				end

				arg_13_1.text_.text = var_16_30
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062003", "story_v_out_113062.awb") ~= 0 then
					local var_16_34 = manager.audio:GetVoiceLength("story_v_out_113062", "113062003", "story_v_out_113062.awb") / 1000

					if var_16_34 + var_16_26 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_34 + var_16_26
					end

					if var_16_29.prefab_name ~= "" and arg_13_1.actors_[var_16_29.prefab_name] ~= nil then
						local var_16_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_29.prefab_name].transform, "story_v_out_113062", "113062003", "story_v_out_113062.awb")

						arg_13_1:RecordAudio("113062003", var_16_35)
						arg_13_1:RecordAudio("113062003", var_16_35)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113062", "113062003", "story_v_out_113062.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113062", "113062003", "story_v_out_113062.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_36 = math.max(var_16_27, arg_13_1.talkMaxDuration)

			if var_16_26 <= arg_13_1.time_ and arg_13_1.time_ < var_16_26 + var_16_36 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_26) / var_16_36

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_26 + var_16_36 and arg_13_1.time_ < var_16_26 + var_16_36 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play113062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113062004
		arg_17_1.duration_ = 2.7

		local var_17_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 1.999999999999,
			en = 2.133
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play113062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_20_1 = arg_17_1.actors_["1084ui_story"]
			local var_20_2 = 0

			if var_20_2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.2

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_3 and not isNil(var_20_1) then
				local var_20_4 = (arg_17_1.time_ - var_20_2) / var_20_3

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_2 + var_20_3 and arg_17_1.time_ < var_20_2 + var_20_3 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action464")
			end

			local var_20_6 = arg_17_1.actors_["1042ui_story"]
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1042ui_story == nil then
				arg_17_1.var_.characterEffect1042ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.2

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 and not isNil(var_20_6) then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8

				if arg_17_1.var_.characterEffect1042ui_story and not isNil(var_20_6) then
					local var_20_10 = Mathf.Lerp(0, 0.5, var_20_9)

					arg_17_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1042ui_story.fillRatio = var_20_10
				end
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1042ui_story then
				local var_20_11 = 0.5

				arg_17_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1042ui_story.fillRatio = var_20_11
			end

			local var_20_12 = 0
			local var_20_13 = 0.175

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_14 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_15 = arg_17_1:GetWordFromCfg(113062004)
				local var_20_16 = arg_17_1:FormatText(var_20_15.content)

				arg_17_1.text_.text = var_20_16

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 7
				local var_20_18 = utf8.len(var_20_16)
				local var_20_19 = var_20_17 <= 0 and var_20_13 or var_20_13 * (var_20_18 / var_20_17)

				if var_20_19 > 0 and var_20_13 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_16
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062004", "story_v_out_113062.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062004", "story_v_out_113062.awb") / 1000

					if var_20_20 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_12
					end

					if var_20_15.prefab_name ~= "" and arg_17_1.actors_[var_20_15.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_15.prefab_name].transform, "story_v_out_113062", "113062004", "story_v_out_113062.awb")

						arg_17_1:RecordAudio("113062004", var_20_21)
						arg_17_1:RecordAudio("113062004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113062", "113062004", "story_v_out_113062.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113062", "113062004", "story_v_out_113062.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_22 and arg_17_1.time_ < var_20_12 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play113062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113062005
		arg_21_1.duration_ = 0.5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"

			SetActive(arg_21_1.choicesGo_, true)

			for iter_22_0, iter_22_1 in ipairs(arg_21_1.choices_) do
				local var_22_0 = iter_22_0 <= 2

				SetActive(iter_22_1.go, var_22_0)
			end

			arg_21_1.choices_[1].txt.text = arg_21_1:FormatText(StoryChoiceCfg[189].name)
			arg_21_1.choices_[2].txt.text = arg_21_1:FormatText(StoryChoiceCfg[190].name)
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113062006(arg_21_1)
			end

			if arg_23_0 == 2 then
				arg_21_0:Play113062007(arg_21_1)
			end

			arg_21_1:RecordChoiceLog(113062005, 189, 190)
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			local var_24_7 = 0.5

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play113062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113062006
		arg_25_1.duration_ = 7.23

		local var_25_0 = {
			ja = 4.733,
			ko = 7.233,
			zh = 7.233,
			en = 7.133
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
				arg_25_0:Play113062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.8

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[10].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(113062006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 32
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062006", "story_v_out_113062.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_113062", "113062006", "story_v_out_113062.awb") / 1000

					if var_28_8 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_0
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_113062", "113062006", "story_v_out_113062.awb")

						arg_25_1:RecordAudio("113062006", var_28_9)
						arg_25_1:RecordAudio("113062006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113062", "113062006", "story_v_out_113062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113062", "113062006", "story_v_out_113062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_10 and arg_25_1.time_ < var_28_0 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113062007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113062007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			ja = 3.133,
			ko = 2.6,
			zh = 3.9,
			en = 3.133
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play113062008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "1042ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_29_1.stage_.transform)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

					var_32_3.enabled = true

					local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

					if var_32_4 then
						var_32_4:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_3.transform, false)

					arg_29_1.var_[var_32_0 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_0 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_0 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action428")
			end

			local var_32_6 = "1042ui_story"

			if arg_29_1.actors_[var_32_6] == nil then
				local var_32_7 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_32_7) then
					local var_32_8 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_29_1.stage_.transform)

					var_32_8.name = var_32_6
					var_32_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_29_1.actors_[var_32_6] = var_32_8

					local var_32_9 = var_32_8:GetComponentInChildren(typeof(CharacterEffect))

					var_32_9.enabled = true

					local var_32_10 = GameObjectTools.GetOrAddComponent(var_32_8, typeof(DynamicBoneHelper))

					if var_32_10 then
						var_32_10:EnableDynamicBone(false)
					end

					arg_29_1:ShowWeapon(var_32_9.transform, false)

					arg_29_1.var_[var_32_6 .. "Animator"] = var_32_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_29_1.var_[var_32_6 .. "Animator"].applyRootMotion = true
					arg_29_1.var_[var_32_6 .. "LipSync"] = var_32_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_32_12 = arg_29_1.actors_["1042ui_story"]
			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 and not isNil(var_32_12) and arg_29_1.var_.characterEffect1042ui_story == nil then
				arg_29_1.var_.characterEffect1042ui_story = var_32_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_14 = 0.2

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_14 and not isNil(var_32_12) then
				local var_32_15 = (arg_29_1.time_ - var_32_13) / var_32_14

				if arg_29_1.var_.characterEffect1042ui_story and not isNil(var_32_12) then
					arg_29_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_13 + var_32_14 and arg_29_1.time_ < var_32_13 + var_32_14 + arg_32_0 and not isNil(var_32_12) and arg_29_1.var_.characterEffect1042ui_story then
				arg_29_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_32_16 = 0
			local var_32_17 = 0.3

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[205].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(113062007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 12
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062007", "story_v_out_113062.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_113062", "113062007", "story_v_out_113062.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_113062", "113062007", "story_v_out_113062.awb")

						arg_29_1:RecordAudio("113062007", var_32_25)
						arg_29_1:RecordAudio("113062007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113062", "113062007", "story_v_out_113062.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113062", "113062007", "story_v_out_113062.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113062008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113062008
		arg_33_1.duration_ = 15

		local var_33_0 = {
			ja = 15,
			ko = 12.866,
			zh = 10.9,
			en = 12.933
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113062009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action482")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_2 = 0
			local var_36_3 = 1.35

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[205].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(113062008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 54
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062008", "story_v_out_113062.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062008", "story_v_out_113062.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_113062", "113062008", "story_v_out_113062.awb")

						arg_33_1:RecordAudio("113062008", var_36_11)
						arg_33_1:RecordAudio("113062008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113062", "113062008", "story_v_out_113062.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113062", "113062008", "story_v_out_113062.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113062009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113062009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113062010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1042ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1042ui_story == nil then
				arg_37_1.var_.characterEffect1042ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1042ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1042ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1042ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1042ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.5

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(113062009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 20
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113062010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113062010
		arg_41_1.duration_ = 7.02

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play113062011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.bgs_.F01
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				local var_44_2 = var_44_0:GetComponent("SpriteRenderer")

				if var_44_2 then
					arg_41_1.var_.alphaOldValueF01 = var_44_2.color.a
					arg_41_1.var_.alphaMatValueF01 = var_44_2
				end

				arg_41_1.var_.alphaOldValueF01 = 1
			end

			local var_44_3 = 2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_3 then
				local var_44_4 = (arg_41_1.time_ - var_44_1) / var_44_3
				local var_44_5 = Mathf.Lerp(arg_41_1.var_.alphaOldValueF01, 0, var_44_4)

				if arg_41_1.var_.alphaMatValueF01 then
					local var_44_6 = arg_41_1.var_.alphaMatValueF01.color

					var_44_6.a = var_44_5
					arg_41_1.var_.alphaMatValueF01.color = var_44_6
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_3 and arg_41_1.time_ < var_44_1 + var_44_3 + arg_44_0 and arg_41_1.var_.alphaMatValueF01 then
				local var_44_7 = arg_41_1.var_.alphaMatValueF01
				local var_44_8 = var_44_7.color

				var_44_8.a = 0
				var_44_7.color = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1084ui_story"].transform
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_9.localPosition
			end

			local var_44_11 = 0.001

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11
				local var_44_13 = Vector3.New(0, 100, 0)

				var_44_9.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, var_44_13, var_44_12)

				local var_44_14 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_14.x, var_44_14.y, var_44_14.z)

				local var_44_15 = var_44_9.localEulerAngles

				var_44_15.z = 0
				var_44_15.x = 0
				var_44_9.localEulerAngles = var_44_15
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 then
				var_44_9.localPosition = Vector3.New(0, 100, 0)

				local var_44_16 = manager.ui.mainCamera.transform.position - var_44_9.position

				var_44_9.forward = Vector3.New(var_44_16.x, var_44_16.y, var_44_16.z)

				local var_44_17 = var_44_9.localEulerAngles

				var_44_17.z = 0
				var_44_17.x = 0
				var_44_9.localEulerAngles = var_44_17
			end

			local var_44_18 = arg_41_1.actors_["1042ui_story"].transform
			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1.var_.moveOldPos1042ui_story = var_44_18.localPosition
			end

			local var_44_20 = 0.001

			if var_44_19 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_19) / var_44_20
				local var_44_22 = Vector3.New(0, 100, 0)

				var_44_18.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1042ui_story, var_44_22, var_44_21)

				local var_44_23 = manager.ui.mainCamera.transform.position - var_44_18.position

				var_44_18.forward = Vector3.New(var_44_23.x, var_44_23.y, var_44_23.z)

				local var_44_24 = var_44_18.localEulerAngles

				var_44_24.z = 0
				var_44_24.x = 0
				var_44_18.localEulerAngles = var_44_24
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				var_44_18.localPosition = Vector3.New(0, 100, 0)

				local var_44_25 = manager.ui.mainCamera.transform.position - var_44_18.position

				var_44_18.forward = Vector3.New(var_44_25.x, var_44_25.y, var_44_25.z)

				local var_44_26 = var_44_18.localEulerAngles

				var_44_26.z = 0
				var_44_26.x = 0
				var_44_18.localEulerAngles = var_44_26
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_27 = 2.01666666666667
			local var_44_28 = 0.6

			if var_44_27 < arg_41_1.time_ and arg_41_1.time_ <= var_44_27 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_29 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_29:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_30 = arg_41_1:GetWordFromCfg(113062010)
				local var_44_31 = arg_41_1:FormatText(var_44_30.content)

				arg_41_1.text_.text = var_44_31

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_32 = 24
				local var_44_33 = utf8.len(var_44_31)
				local var_44_34 = var_44_32 <= 0 and var_44_28 or var_44_28 * (var_44_33 / var_44_32)

				if var_44_34 > 0 and var_44_28 < var_44_34 then
					arg_41_1.talkMaxDuration = var_44_34
					var_44_27 = var_44_27 + 0.3

					if var_44_34 + var_44_27 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_34 + var_44_27
					end
				end

				arg_41_1.text_.text = var_44_31
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_35 = var_44_27 + 0.3
			local var_44_36 = math.max(var_44_28, arg_41_1.talkMaxDuration)

			if var_44_35 <= arg_41_1.time_ and arg_41_1.time_ < var_44_35 + var_44_36 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_35) / var_44_36

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_35 + var_44_36 and arg_41_1.time_ < var_44_35 + var_44_36 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play113062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113062011
		arg_47_1.duration_ = 14.67

		local var_47_0 = {
			ja = 11.766,
			ko = 14.666,
			zh = 11.2,
			en = 12.633
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
				arg_47_0:Play113062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.bgs_.F01
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				local var_50_2 = var_50_0:GetComponent("SpriteRenderer")

				if var_50_2 then
					arg_47_1.var_.alphaOldValueF01 = var_50_2.color.a
					arg_47_1.var_.alphaMatValueF01 = var_50_2
				end

				arg_47_1.var_.alphaOldValueF01 = 0
			end

			local var_50_3 = 2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_3 then
				local var_50_4 = (arg_47_1.time_ - var_50_1) / var_50_3
				local var_50_5 = Mathf.Lerp(arg_47_1.var_.alphaOldValueF01, 1, var_50_4)

				if arg_47_1.var_.alphaMatValueF01 then
					local var_50_6 = arg_47_1.var_.alphaMatValueF01.color

					var_50_6.a = var_50_5
					arg_47_1.var_.alphaMatValueF01.color = var_50_6
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_3 and arg_47_1.time_ < var_50_1 + var_50_3 + arg_50_0 and arg_47_1.var_.alphaMatValueF01 then
				local var_50_7 = arg_47_1.var_.alphaMatValueF01
				local var_50_8 = var_50_7.color

				var_50_8.a = 1
				var_50_7.color = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["1042ui_story"].transform
			local var_50_10 = 1.8

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.var_.moveOldPos1042ui_story = var_50_9.localPosition
			end

			local var_50_11 = 0.001

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_11 then
				local var_50_12 = (arg_47_1.time_ - var_50_10) / var_50_11
				local var_50_13 = Vector3.New(-0.7, -1.06, -6.2)

				var_50_9.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1042ui_story, var_50_13, var_50_12)

				local var_50_14 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_14.x, var_50_14.y, var_50_14.z)

				local var_50_15 = var_50_9.localEulerAngles

				var_50_15.z = 0
				var_50_15.x = 0
				var_50_9.localEulerAngles = var_50_15
			end

			if arg_47_1.time_ >= var_50_10 + var_50_11 and arg_47_1.time_ < var_50_10 + var_50_11 + arg_50_0 then
				var_50_9.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_50_16 = manager.ui.mainCamera.transform.position - var_50_9.position

				var_50_9.forward = Vector3.New(var_50_16.x, var_50_16.y, var_50_16.z)

				local var_50_17 = var_50_9.localEulerAngles

				var_50_17.z = 0
				var_50_17.x = 0
				var_50_9.localEulerAngles = var_50_17
			end

			local var_50_18 = 1.8

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_50_19 = 1.8

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_50_20 = arg_47_1.actors_["1042ui_story"]
			local var_50_21 = 1.8

			if var_50_21 < arg_47_1.time_ and arg_47_1.time_ <= var_50_21 + arg_50_0 and not isNil(var_50_20) and arg_47_1.var_.characterEffect1042ui_story == nil then
				arg_47_1.var_.characterEffect1042ui_story = var_50_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_22 = 0.2

			if var_50_21 <= arg_47_1.time_ and arg_47_1.time_ < var_50_21 + var_50_22 and not isNil(var_50_20) then
				local var_50_23 = (arg_47_1.time_ - var_50_21) / var_50_22

				if arg_47_1.var_.characterEffect1042ui_story and not isNil(var_50_20) then
					arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_21 + var_50_22 and arg_47_1.time_ < var_50_21 + var_50_22 + arg_50_0 and not isNil(var_50_20) and arg_47_1.var_.characterEffect1042ui_story then
				arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_24 = 2
			local var_50_25 = 1.275

			if var_50_24 < arg_47_1.time_ and arg_47_1.time_ <= var_50_24 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_26 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_26:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_27 = arg_47_1:FormatText(StoryNameCfg[205].name)

				arg_47_1.leftNameTxt_.text = var_50_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_28 = arg_47_1:GetWordFromCfg(113062011)
				local var_50_29 = arg_47_1:FormatText(var_50_28.content)

				arg_47_1.text_.text = var_50_29

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_30 = 51
				local var_50_31 = utf8.len(var_50_29)
				local var_50_32 = var_50_30 <= 0 and var_50_25 or var_50_25 * (var_50_31 / var_50_30)

				if var_50_32 > 0 and var_50_25 < var_50_32 then
					arg_47_1.talkMaxDuration = var_50_32
					var_50_24 = var_50_24 + 0.3

					if var_50_32 + var_50_24 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_32 + var_50_24
					end
				end

				arg_47_1.text_.text = var_50_29
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062011", "story_v_out_113062.awb") ~= 0 then
					local var_50_33 = manager.audio:GetVoiceLength("story_v_out_113062", "113062011", "story_v_out_113062.awb") / 1000

					if var_50_33 + var_50_24 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_33 + var_50_24
					end

					if var_50_28.prefab_name ~= "" and arg_47_1.actors_[var_50_28.prefab_name] ~= nil then
						local var_50_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_28.prefab_name].transform, "story_v_out_113062", "113062011", "story_v_out_113062.awb")

						arg_47_1:RecordAudio("113062011", var_50_34)
						arg_47_1:RecordAudio("113062011", var_50_34)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113062", "113062011", "story_v_out_113062.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113062", "113062011", "story_v_out_113062.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_35 = var_50_24 + 0.3
			local var_50_36 = math.max(var_50_25, arg_47_1.talkMaxDuration)

			if var_50_35 <= arg_47_1.time_ and arg_47_1.time_ < var_50_35 + var_50_36 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_35) / var_50_36

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_35 + var_50_36 and arg_47_1.time_ < var_50_35 + var_50_36 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play113062012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 113062012
		arg_53_1.duration_ = 10.53

		local var_53_0 = {
			ja = 10.533,
			ko = 6.166,
			zh = 6.7,
			en = 8.2
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play113062013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.9

			if var_56_2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_4 = arg_53_1:FormatText(StoryNameCfg[205].name)

				arg_53_1.leftNameTxt_.text = var_56_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:GetWordFromCfg(113062012)
				local var_56_6 = arg_53_1:FormatText(var_56_5.content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 30
				local var_56_8 = utf8.len(var_56_6)
				local var_56_9 = var_56_7 <= 0 and var_56_3 or var_56_3 * (var_56_8 / var_56_7)

				if var_56_9 > 0 and var_56_3 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062012", "story_v_out_113062.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062012", "story_v_out_113062.awb") / 1000

					if var_56_10 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_2
					end

					if var_56_5.prefab_name ~= "" and arg_53_1.actors_[var_56_5.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_5.prefab_name].transform, "story_v_out_113062", "113062012", "story_v_out_113062.awb")

						arg_53_1:RecordAudio("113062012", var_56_11)
						arg_53_1:RecordAudio("113062012", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_113062", "113062012", "story_v_out_113062.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_113062", "113062012", "story_v_out_113062.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_12 and arg_53_1.time_ < var_56_2 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play113062013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 113062013
		arg_57_1.duration_ = 9.53

		local var_57_0 = {
			ja = 9.533,
			ko = 6.633,
			zh = 7.333,
			en = 7.8
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
				arg_57_0:Play113062014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "1041ui_story"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_57_1.stage_.transform)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentInChildren(typeof(CharacterEffect))

					var_60_3.enabled = true

					local var_60_4 = GameObjectTools.GetOrAddComponent(var_60_2, typeof(DynamicBoneHelper))

					if var_60_4 then
						var_60_4:EnableDynamicBone(false)
					end

					arg_57_1:ShowWeapon(var_60_3.transform, false)

					arg_57_1.var_[var_60_0 .. "Animator"] = var_60_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_57_1.var_[var_60_0 .. "Animator"].applyRootMotion = true
					arg_57_1.var_[var_60_0 .. "LipSync"] = var_60_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_60_5 = arg_57_1.actors_["1041ui_story"].transform
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.var_.moveOldPos1041ui_story = var_60_5.localPosition
			end

			local var_60_7 = 0.001

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7
				local var_60_9 = Vector3.New(0.7, -1.11, -5.9)

				var_60_5.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1041ui_story, var_60_9, var_60_8)

				local var_60_10 = manager.ui.mainCamera.transform.position - var_60_5.position

				var_60_5.forward = Vector3.New(var_60_10.x, var_60_10.y, var_60_10.z)

				local var_60_11 = var_60_5.localEulerAngles

				var_60_11.z = 0
				var_60_11.x = 0
				var_60_5.localEulerAngles = var_60_11
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 then
				var_60_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_60_12 = manager.ui.mainCamera.transform.position - var_60_5.position

				var_60_5.forward = Vector3.New(var_60_12.x, var_60_12.y, var_60_12.z)

				local var_60_13 = var_60_5.localEulerAngles

				var_60_13.z = 0
				var_60_13.x = 0
				var_60_5.localEulerAngles = var_60_13
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_60_15 = 0

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_16 = arg_57_1.actors_["1041ui_story"]
			local var_60_17 = 0

			if var_60_17 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 and not isNil(var_60_16) and arg_57_1.var_.characterEffect1041ui_story == nil then
				arg_57_1.var_.characterEffect1041ui_story = var_60_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_18 = 0.2

			if var_60_17 <= arg_57_1.time_ and arg_57_1.time_ < var_60_17 + var_60_18 and not isNil(var_60_16) then
				local var_60_19 = (arg_57_1.time_ - var_60_17) / var_60_18

				if arg_57_1.var_.characterEffect1041ui_story and not isNil(var_60_16) then
					arg_57_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_17 + var_60_18 and arg_57_1.time_ < var_60_17 + var_60_18 + arg_60_0 and not isNil(var_60_16) and arg_57_1.var_.characterEffect1041ui_story then
				arg_57_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_60_20 = arg_57_1.actors_["1042ui_story"]
			local var_60_21 = 0

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 and not isNil(var_60_20) and arg_57_1.var_.characterEffect1042ui_story == nil then
				arg_57_1.var_.characterEffect1042ui_story = var_60_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_22 = 0.2

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_22 and not isNil(var_60_20) then
				local var_60_23 = (arg_57_1.time_ - var_60_21) / var_60_22

				if arg_57_1.var_.characterEffect1042ui_story and not isNil(var_60_20) then
					local var_60_24 = Mathf.Lerp(0, 0.5, var_60_23)

					arg_57_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1042ui_story.fillRatio = var_60_24
				end
			end

			if arg_57_1.time_ >= var_60_21 + var_60_22 and arg_57_1.time_ < var_60_21 + var_60_22 + arg_60_0 and not isNil(var_60_20) and arg_57_1.var_.characterEffect1042ui_story then
				local var_60_25 = 0.5

				arg_57_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1042ui_story.fillRatio = var_60_25
			end

			local var_60_26 = 0
			local var_60_27 = 0.875

			if var_60_26 < arg_57_1.time_ and arg_57_1.time_ <= var_60_26 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_28 = arg_57_1:FormatText(StoryNameCfg[208].name)

				arg_57_1.leftNameTxt_.text = var_60_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_29 = arg_57_1:GetWordFromCfg(113062013)
				local var_60_30 = arg_57_1:FormatText(var_60_29.content)

				arg_57_1.text_.text = var_60_30

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_31 = 35
				local var_60_32 = utf8.len(var_60_30)
				local var_60_33 = var_60_31 <= 0 and var_60_27 or var_60_27 * (var_60_32 / var_60_31)

				if var_60_33 > 0 and var_60_27 < var_60_33 then
					arg_57_1.talkMaxDuration = var_60_33

					if var_60_33 + var_60_26 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_33 + var_60_26
					end
				end

				arg_57_1.text_.text = var_60_30
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062013", "story_v_out_113062.awb") ~= 0 then
					local var_60_34 = manager.audio:GetVoiceLength("story_v_out_113062", "113062013", "story_v_out_113062.awb") / 1000

					if var_60_34 + var_60_26 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_34 + var_60_26
					end

					if var_60_29.prefab_name ~= "" and arg_57_1.actors_[var_60_29.prefab_name] ~= nil then
						local var_60_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_29.prefab_name].transform, "story_v_out_113062", "113062013", "story_v_out_113062.awb")

						arg_57_1:RecordAudio("113062013", var_60_35)
						arg_57_1:RecordAudio("113062013", var_60_35)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_113062", "113062013", "story_v_out_113062.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_113062", "113062013", "story_v_out_113062.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_36 = math.max(var_60_27, arg_57_1.talkMaxDuration)

			if var_60_26 <= arg_57_1.time_ and arg_57_1.time_ < var_60_26 + var_60_36 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_26) / var_60_36

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_26 + var_60_36 and arg_57_1.time_ < var_60_26 + var_60_36 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play113062014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 113062014
		arg_61_1.duration_ = 16.23

		local var_61_0 = {
			ja = 16.233,
			ko = 13.5,
			zh = 13.7,
			en = 12.833
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
				arg_61_0:Play113062015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1041ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1041ui_story == nil then
				arg_61_1.var_.characterEffect1041ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1041ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1041ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1041ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1041ui_story.fillRatio = var_64_5
			end

			local var_64_6 = arg_61_1.actors_["1042ui_story"]
			local var_64_7 = 0

			if var_64_7 < arg_61_1.time_ and arg_61_1.time_ <= var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1042ui_story == nil then
				arg_61_1.var_.characterEffect1042ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_8 = 0.2

			if var_64_7 <= arg_61_1.time_ and arg_61_1.time_ < var_64_7 + var_64_8 and not isNil(var_64_6) then
				local var_64_9 = (arg_61_1.time_ - var_64_7) / var_64_8

				if arg_61_1.var_.characterEffect1042ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_7 + var_64_8 and arg_61_1.time_ < var_64_7 + var_64_8 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1042ui_story then
				arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_64_11 = 0

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_2")
			end

			local var_64_12 = 0
			local var_64_13 = 1.425

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[205].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(113062014)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 55
				local var_64_18 = utf8.len(var_64_16)
				local var_64_19 = var_64_17 <= 0 and var_64_13 or var_64_13 * (var_64_18 / var_64_17)

				if var_64_19 > 0 and var_64_13 < var_64_19 then
					arg_61_1.talkMaxDuration = var_64_19

					if var_64_19 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_16
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062014", "story_v_out_113062.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062014", "story_v_out_113062.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_113062", "113062014", "story_v_out_113062.awb")

						arg_61_1:RecordAudio("113062014", var_64_21)
						arg_61_1:RecordAudio("113062014", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_113062", "113062014", "story_v_out_113062.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_113062", "113062014", "story_v_out_113062.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_22 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_22 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_22

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_22 and arg_61_1.time_ < var_64_12 + var_64_22 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play113062015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 113062015
		arg_65_1.duration_ = 12.83

		local var_65_0 = {
			ja = 12.833,
			ko = 10.366,
			zh = 10.8,
			en = 11.566
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
				arg_65_0:Play113062016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1042ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1042ui_story == nil then
				arg_65_1.var_.characterEffect1042ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1042ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1042ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1042ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1042ui_story.fillRatio = var_68_5
			end

			local var_68_6 = arg_65_1.actors_["1041ui_story"]
			local var_68_7 = 0

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1041ui_story == nil then
				arg_65_1.var_.characterEffect1041ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 and not isNil(var_68_6) then
				local var_68_9 = (arg_65_1.time_ - var_68_7) / var_68_8

				if arg_65_1.var_.characterEffect1041ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect1041ui_story then
				arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action2_1")
			end

			local var_68_11 = 0

			if var_68_11 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_12 = 0
			local var_68_13 = 1.15

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_14 = arg_65_1:FormatText(StoryNameCfg[208].name)

				arg_65_1.leftNameTxt_.text = var_68_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_15 = arg_65_1:GetWordFromCfg(113062015)
				local var_68_16 = arg_65_1:FormatText(var_68_15.content)

				arg_65_1.text_.text = var_68_16

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 46
				local var_68_18 = utf8.len(var_68_16)
				local var_68_19 = var_68_17 <= 0 and var_68_13 or var_68_13 * (var_68_18 / var_68_17)

				if var_68_19 > 0 and var_68_13 < var_68_19 then
					arg_65_1.talkMaxDuration = var_68_19

					if var_68_19 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_19 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_16
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062015", "story_v_out_113062.awb") ~= 0 then
					local var_68_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062015", "story_v_out_113062.awb") / 1000

					if var_68_20 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_12
					end

					if var_68_15.prefab_name ~= "" and arg_65_1.actors_[var_68_15.prefab_name] ~= nil then
						local var_68_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_15.prefab_name].transform, "story_v_out_113062", "113062015", "story_v_out_113062.awb")

						arg_65_1:RecordAudio("113062015", var_68_21)
						arg_65_1:RecordAudio("113062015", var_68_21)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_113062", "113062015", "story_v_out_113062.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_113062", "113062015", "story_v_out_113062.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_22 and arg_65_1.time_ < var_68_12 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play113062016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 113062016
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			ja = 4.6,
			ko = 3.533,
			zh = 4.5,
			en = 3.5
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
				arg_69_0:Play113062017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1041ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1041ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1041ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1042ui_story"].transform
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.var_.moveOldPos1042ui_story = var_72_9.localPosition
			end

			local var_72_11 = 0.001

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11
				local var_72_13 = Vector3.New(0, 100, 0)

				var_72_9.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1042ui_story, var_72_13, var_72_12)

				local var_72_14 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_14.x, var_72_14.y, var_72_14.z)

				local var_72_15 = var_72_9.localEulerAngles

				var_72_15.z = 0
				var_72_15.x = 0
				var_72_9.localEulerAngles = var_72_15
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 then
				var_72_9.localPosition = Vector3.New(0, 100, 0)

				local var_72_16 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_16.x, var_72_16.y, var_72_16.z)

				local var_72_17 = var_72_9.localEulerAngles

				var_72_17.z = 0
				var_72_17.x = 0
				var_72_9.localEulerAngles = var_72_17
			end

			local var_72_18 = arg_69_1.actors_["1084ui_story"].transform
			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.var_.moveOldPos1084ui_story = var_72_18.localPosition
			end

			local var_72_20 = 0.001

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_19) / var_72_20
				local var_72_22 = Vector3.New(-0.7, -0.97, -6)

				var_72_18.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1084ui_story, var_72_22, var_72_21)

				local var_72_23 = manager.ui.mainCamera.transform.position - var_72_18.position

				var_72_18.forward = Vector3.New(var_72_23.x, var_72_23.y, var_72_23.z)

				local var_72_24 = var_72_18.localEulerAngles

				var_72_24.z = 0
				var_72_24.x = 0
				var_72_18.localEulerAngles = var_72_24
			end

			if arg_69_1.time_ >= var_72_19 + var_72_20 and arg_69_1.time_ < var_72_19 + var_72_20 + arg_72_0 then
				var_72_18.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_72_25 = manager.ui.mainCamera.transform.position - var_72_18.position

				var_72_18.forward = Vector3.New(var_72_25.x, var_72_25.y, var_72_25.z)

				local var_72_26 = var_72_18.localEulerAngles

				var_72_26.z = 0
				var_72_26.x = 0
				var_72_18.localEulerAngles = var_72_26
			end

			local var_72_27 = 0

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_72_28 = 0

			if var_72_28 < arg_69_1.time_ and arg_69_1.time_ <= var_72_28 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_72_29 = arg_69_1.actors_["1084ui_story"]
			local var_72_30 = 0

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 and not isNil(var_72_29) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_31 = 0.2

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_31 and not isNil(var_72_29) then
				local var_72_32 = (arg_69_1.time_ - var_72_30) / var_72_31

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_29) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_30 + var_72_31 and arg_69_1.time_ < var_72_30 + var_72_31 + arg_72_0 and not isNil(var_72_29) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_33 = 0
			local var_72_34 = 0.375

			if var_72_33 < arg_69_1.time_ and arg_69_1.time_ <= var_72_33 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_35 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_36 = arg_69_1:GetWordFromCfg(113062016)
				local var_72_37 = arg_69_1:FormatText(var_72_36.content)

				arg_69_1.text_.text = var_72_37

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_38 = 15
				local var_72_39 = utf8.len(var_72_37)
				local var_72_40 = var_72_38 <= 0 and var_72_34 or var_72_34 * (var_72_39 / var_72_38)

				if var_72_40 > 0 and var_72_34 < var_72_40 then
					arg_69_1.talkMaxDuration = var_72_40

					if var_72_40 + var_72_33 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_40 + var_72_33
					end
				end

				arg_69_1.text_.text = var_72_37
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062016", "story_v_out_113062.awb") ~= 0 then
					local var_72_41 = manager.audio:GetVoiceLength("story_v_out_113062", "113062016", "story_v_out_113062.awb") / 1000

					if var_72_41 + var_72_33 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_41 + var_72_33
					end

					if var_72_36.prefab_name ~= "" and arg_69_1.actors_[var_72_36.prefab_name] ~= nil then
						local var_72_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_36.prefab_name].transform, "story_v_out_113062", "113062016", "story_v_out_113062.awb")

						arg_69_1:RecordAudio("113062016", var_72_42)
						arg_69_1:RecordAudio("113062016", var_72_42)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_113062", "113062016", "story_v_out_113062.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_113062", "113062016", "story_v_out_113062.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_43 = math.max(var_72_34, arg_69_1.talkMaxDuration)

			if var_72_33 <= arg_69_1.time_ and arg_69_1.time_ < var_72_33 + var_72_43 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_33) / var_72_43

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_33 + var_72_43 and arg_69_1.time_ < var_72_33 + var_72_43 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play113062017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 113062017
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			ja = 7.6,
			ko = 9.133,
			zh = 8.033,
			en = 9.4
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play113062018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1084ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_5
			end

			local var_76_6 = "1038ui_story"

			if arg_73_1.actors_[var_76_6] == nil then
				local var_76_7 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_76_7) then
					local var_76_8 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_73_1.stage_.transform)

					var_76_8.name = var_76_6
					var_76_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_73_1.actors_[var_76_6] = var_76_8

					local var_76_9 = var_76_8:GetComponentInChildren(typeof(CharacterEffect))

					var_76_9.enabled = true

					local var_76_10 = GameObjectTools.GetOrAddComponent(var_76_8, typeof(DynamicBoneHelper))

					if var_76_10 then
						var_76_10:EnableDynamicBone(false)
					end

					arg_73_1:ShowWeapon(var_76_9.transform, false)

					arg_73_1.var_[var_76_6 .. "Animator"] = var_76_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_73_1.var_[var_76_6 .. "Animator"].applyRootMotion = true
					arg_73_1.var_[var_76_6 .. "LipSync"] = var_76_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_76_11 = arg_73_1.actors_["1038ui_story"].transform
			local var_76_12 = 0

			if var_76_12 < arg_73_1.time_ and arg_73_1.time_ <= var_76_12 + arg_76_0 then
				arg_73_1.var_.moveOldPos1038ui_story = var_76_11.localPosition
			end

			local var_76_13 = 0.001

			if var_76_12 <= arg_73_1.time_ and arg_73_1.time_ < var_76_12 + var_76_13 then
				local var_76_14 = (arg_73_1.time_ - var_76_12) / var_76_13
				local var_76_15 = Vector3.New(0.7, -1.11, -5.9)

				var_76_11.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1038ui_story, var_76_15, var_76_14)

				local var_76_16 = manager.ui.mainCamera.transform.position - var_76_11.position

				var_76_11.forward = Vector3.New(var_76_16.x, var_76_16.y, var_76_16.z)

				local var_76_17 = var_76_11.localEulerAngles

				var_76_17.z = 0
				var_76_17.x = 0
				var_76_11.localEulerAngles = var_76_17
			end

			if arg_73_1.time_ >= var_76_12 + var_76_13 and arg_73_1.time_ < var_76_12 + var_76_13 + arg_76_0 then
				var_76_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_76_18 = manager.ui.mainCamera.transform.position - var_76_11.position

				var_76_11.forward = Vector3.New(var_76_18.x, var_76_18.y, var_76_18.z)

				local var_76_19 = var_76_11.localEulerAngles

				var_76_19.z = 0
				var_76_19.x = 0
				var_76_11.localEulerAngles = var_76_19
			end

			local var_76_20 = 0

			if var_76_20 < arg_73_1.time_ and arg_73_1.time_ <= var_76_20 + arg_76_0 then
				arg_73_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_76_21 = 0

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_22 = arg_73_1.actors_["1038ui_story"]
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.characterEffect1038ui_story == nil then
				arg_73_1.var_.characterEffect1038ui_story = var_76_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_24 = 0.2

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 and not isNil(var_76_22) then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24

				if arg_73_1.var_.characterEffect1038ui_story and not isNil(var_76_22) then
					arg_73_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.characterEffect1038ui_story then
				arg_73_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_76_26 = 0
			local var_76_27 = 0.975

			if var_76_26 < arg_73_1.time_ and arg_73_1.time_ <= var_76_26 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_28 = arg_73_1:FormatText(StoryNameCfg[94].name)

				arg_73_1.leftNameTxt_.text = var_76_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_29 = arg_73_1:GetWordFromCfg(113062017)
				local var_76_30 = arg_73_1:FormatText(var_76_29.content)

				arg_73_1.text_.text = var_76_30

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_31 = 39
				local var_76_32 = utf8.len(var_76_30)
				local var_76_33 = var_76_31 <= 0 and var_76_27 or var_76_27 * (var_76_32 / var_76_31)

				if var_76_33 > 0 and var_76_27 < var_76_33 then
					arg_73_1.talkMaxDuration = var_76_33

					if var_76_33 + var_76_26 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_33 + var_76_26
					end
				end

				arg_73_1.text_.text = var_76_30
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062017", "story_v_out_113062.awb") ~= 0 then
					local var_76_34 = manager.audio:GetVoiceLength("story_v_out_113062", "113062017", "story_v_out_113062.awb") / 1000

					if var_76_34 + var_76_26 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_34 + var_76_26
					end

					if var_76_29.prefab_name ~= "" and arg_73_1.actors_[var_76_29.prefab_name] ~= nil then
						local var_76_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_29.prefab_name].transform, "story_v_out_113062", "113062017", "story_v_out_113062.awb")

						arg_73_1:RecordAudio("113062017", var_76_35)
						arg_73_1:RecordAudio("113062017", var_76_35)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_113062", "113062017", "story_v_out_113062.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_113062", "113062017", "story_v_out_113062.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_36 = math.max(var_76_27, arg_73_1.talkMaxDuration)

			if var_76_26 <= arg_73_1.time_ and arg_73_1.time_ < var_76_26 + var_76_36 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_26) / var_76_36

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_26 + var_76_36 and arg_73_1.time_ < var_76_26 + var_76_36 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play113062018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 113062018
		arg_77_1.duration_ = 9.63

		local var_77_0 = {
			ja = 7,
			ko = 8.566,
			zh = 6.5,
			en = 9.633
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play113062019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.85

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_4 = arg_77_1:FormatText(StoryNameCfg[94].name)

				arg_77_1.leftNameTxt_.text = var_80_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:GetWordFromCfg(113062018)
				local var_80_6 = arg_77_1:FormatText(var_80_5.content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 34
				local var_80_8 = utf8.len(var_80_6)
				local var_80_9 = var_80_7 <= 0 and var_80_3 or var_80_3 * (var_80_8 / var_80_7)

				if var_80_9 > 0 and var_80_3 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062018", "story_v_out_113062.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_113062", "113062018", "story_v_out_113062.awb") / 1000

					if var_80_10 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_2
					end

					if var_80_5.prefab_name ~= "" and arg_77_1.actors_[var_80_5.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_5.prefab_name].transform, "story_v_out_113062", "113062018", "story_v_out_113062.awb")

						arg_77_1:RecordAudio("113062018", var_80_11)
						arg_77_1:RecordAudio("113062018", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_113062", "113062018", "story_v_out_113062.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_113062", "113062018", "story_v_out_113062.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_12 and arg_77_1.time_ < var_80_2 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play113062019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 113062019
		arg_81_1.duration_ = 13.77

		local var_81_0 = {
			ja = 8.4,
			ko = 13.766,
			zh = 10.4,
			en = 11.3
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
				arg_81_0:Play113062020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_84_1 = 0
			local var_84_2 = 1.275

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_3 = arg_81_1:FormatText(StoryNameCfg[94].name)

				arg_81_1.leftNameTxt_.text = var_84_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(113062019)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_6 = 52
				local var_84_7 = utf8.len(var_84_5)
				local var_84_8 = var_84_6 <= 0 and var_84_2 or var_84_2 * (var_84_7 / var_84_6)

				if var_84_8 > 0 and var_84_2 < var_84_8 then
					arg_81_1.talkMaxDuration = var_84_8

					if var_84_8 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062019", "story_v_out_113062.awb") ~= 0 then
					local var_84_9 = manager.audio:GetVoiceLength("story_v_out_113062", "113062019", "story_v_out_113062.awb") / 1000

					if var_84_9 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_1
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_113062", "113062019", "story_v_out_113062.awb")

						arg_81_1:RecordAudio("113062019", var_84_10)
						arg_81_1:RecordAudio("113062019", var_84_10)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_113062", "113062019", "story_v_out_113062.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_113062", "113062019", "story_v_out_113062.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_11 and arg_81_1.time_ < var_84_1 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play113062020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 113062020
		arg_85_1.duration_ = 5.63

		local var_85_0 = {
			ja = 3.366,
			ko = 5.633,
			zh = 3.3,
			en = 3.166
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play113062021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_88_4 = arg_85_1.actors_["1038ui_story"]
			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1038ui_story == nil then
				arg_85_1.var_.characterEffect1038ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.2

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 and not isNil(var_88_4) then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / var_88_6

				if arg_85_1.var_.characterEffect1038ui_story and not isNil(var_88_4) then
					local var_88_8 = Mathf.Lerp(0, 0.5, var_88_7)

					arg_85_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1038ui_story.fillRatio = var_88_8
				end
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1038ui_story then
				local var_88_9 = 0.5

				arg_85_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1038ui_story.fillRatio = var_88_9
			end

			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			local var_88_11 = 0

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_88_12 = 0
			local var_88_13 = 0.4

			if var_88_12 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_14 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_15 = arg_85_1:GetWordFromCfg(113062020)
				local var_88_16 = arg_85_1:FormatText(var_88_15.content)

				arg_85_1.text_.text = var_88_16

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_17 = 16
				local var_88_18 = utf8.len(var_88_16)
				local var_88_19 = var_88_17 <= 0 and var_88_13 or var_88_13 * (var_88_18 / var_88_17)

				if var_88_19 > 0 and var_88_13 < var_88_19 then
					arg_85_1.talkMaxDuration = var_88_19

					if var_88_19 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_19 + var_88_12
					end
				end

				arg_85_1.text_.text = var_88_16
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062020", "story_v_out_113062.awb") ~= 0 then
					local var_88_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062020", "story_v_out_113062.awb") / 1000

					if var_88_20 + var_88_12 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_20 + var_88_12
					end

					if var_88_15.prefab_name ~= "" and arg_85_1.actors_[var_88_15.prefab_name] ~= nil then
						local var_88_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_15.prefab_name].transform, "story_v_out_113062", "113062020", "story_v_out_113062.awb")

						arg_85_1:RecordAudio("113062020", var_88_21)
						arg_85_1:RecordAudio("113062020", var_88_21)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_113062", "113062020", "story_v_out_113062.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_113062", "113062020", "story_v_out_113062.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = math.max(var_88_13, arg_85_1.talkMaxDuration)

			if var_88_12 <= arg_85_1.time_ and arg_85_1.time_ < var_88_12 + var_88_22 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_12) / var_88_22

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_12 + var_88_22 and arg_85_1.time_ < var_88_12 + var_88_22 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play113062021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113062021
		arg_89_1.duration_ = 6.33

		local var_89_0 = {
			ja = 6.333,
			ko = 4.7,
			zh = 4.133,
			en = 6.2
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play113062022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1084ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_5
			end

			local var_92_6 = arg_89_1.actors_["1038ui_story"]
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1038ui_story == nil then
				arg_89_1.var_.characterEffect1038ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.2

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 and not isNil(var_92_6) then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8

				if arg_89_1.var_.characterEffect1038ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1038ui_story then
				arg_89_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_92_11 = 0
			local var_92_12 = 0.5

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_13 = arg_89_1:FormatText(StoryNameCfg[94].name)

				arg_89_1.leftNameTxt_.text = var_92_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_14 = arg_89_1:GetWordFromCfg(113062021)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 19
				local var_92_17 = utf8.len(var_92_15)
				local var_92_18 = var_92_16 <= 0 and var_92_12 or var_92_12 * (var_92_17 / var_92_16)

				if var_92_18 > 0 and var_92_12 < var_92_18 then
					arg_89_1.talkMaxDuration = var_92_18

					if var_92_18 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062021", "story_v_out_113062.awb") ~= 0 then
					local var_92_19 = manager.audio:GetVoiceLength("story_v_out_113062", "113062021", "story_v_out_113062.awb") / 1000

					if var_92_19 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_11
					end

					if var_92_14.prefab_name ~= "" and arg_89_1.actors_[var_92_14.prefab_name] ~= nil then
						local var_92_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_14.prefab_name].transform, "story_v_out_113062", "113062021", "story_v_out_113062.awb")

						arg_89_1:RecordAudio("113062021", var_92_20)
						arg_89_1:RecordAudio("113062021", var_92_20)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_113062", "113062021", "story_v_out_113062.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_113062", "113062021", "story_v_out_113062.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_21 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 <= arg_89_1.time_ and arg_89_1.time_ < var_92_11 + var_92_21 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_11) / var_92_21

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_11 + var_92_21 and arg_89_1.time_ < var_92_11 + var_92_21 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113062022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113062022
		arg_93_1.duration_ = 12.1

		local var_93_0 = {
			ja = 12.1,
			ko = 9.633,
			zh = 8.533,
			en = 9.033
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play113062023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1084ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1038ui_story"].transform
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.var_.moveOldPos1038ui_story = var_96_9.localPosition
			end

			local var_96_11 = 0.001

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11
				local var_96_13 = Vector3.New(0, 100, 0)

				var_96_9.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1038ui_story, var_96_13, var_96_12)

				local var_96_14 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_14.x, var_96_14.y, var_96_14.z)

				local var_96_15 = var_96_9.localEulerAngles

				var_96_15.z = 0
				var_96_15.x = 0
				var_96_9.localEulerAngles = var_96_15
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				var_96_9.localPosition = Vector3.New(0, 100, 0)

				local var_96_16 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_16.x, var_96_16.y, var_96_16.z)

				local var_96_17 = var_96_9.localEulerAngles

				var_96_17.z = 0
				var_96_17.x = 0
				var_96_9.localEulerAngles = var_96_17
			end

			local var_96_18 = "6045_story"

			if arg_93_1.actors_[var_96_18] == nil then
				local var_96_19 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_96_19) then
					local var_96_20 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_93_1.stage_.transform)

					var_96_20.name = var_96_18
					var_96_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_18] = var_96_20

					local var_96_21 = var_96_20:GetComponentInChildren(typeof(CharacterEffect))

					var_96_21.enabled = true

					local var_96_22 = GameObjectTools.GetOrAddComponent(var_96_20, typeof(DynamicBoneHelper))

					if var_96_22 then
						var_96_22:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_21.transform, false)

					arg_93_1.var_[var_96_18 .. "Animator"] = var_96_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_18 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_18 .. "LipSync"] = var_96_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_23 = arg_93_1.actors_["6045_story"].transform
			local var_96_24 = 0

			if var_96_24 < arg_93_1.time_ and arg_93_1.time_ <= var_96_24 + arg_96_0 then
				arg_93_1.var_.moveOldPos6045_story = var_96_23.localPosition

				local var_96_25 = GameObjectTools.GetOrAddComponent(var_96_23.gameObject, typeof(DynamicBoneHelper))

				if var_96_25 then
					var_96_25:EnableDynamicBone(false)
				end
			end

			local var_96_26 = 0.001

			if var_96_24 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_26 then
				local var_96_27 = (arg_93_1.time_ - var_96_24) / var_96_26
				local var_96_28 = Vector3.New(-0.7, -0.5, -6.3)

				var_96_23.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos6045_story, var_96_28, var_96_27)

				local var_96_29 = manager.ui.mainCamera.transform.position - var_96_23.position

				var_96_23.forward = Vector3.New(var_96_29.x, var_96_29.y, var_96_29.z)

				local var_96_30 = var_96_23.localEulerAngles

				var_96_30.z = 0
				var_96_30.x = 0
				var_96_23.localEulerAngles = var_96_30
			end

			if arg_93_1.time_ >= var_96_24 + var_96_26 and arg_93_1.time_ < var_96_24 + var_96_26 + arg_96_0 then
				var_96_23.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_96_31 = manager.ui.mainCamera.transform.position - var_96_23.position

				var_96_23.forward = Vector3.New(var_96_31.x, var_96_31.y, var_96_31.z)

				local var_96_32 = var_96_23.localEulerAngles

				var_96_32.z = 0
				var_96_32.x = 0
				var_96_23.localEulerAngles = var_96_32

				local var_96_33 = GameObjectTools.GetOrAddComponent(var_96_23.gameObject, typeof(DynamicBoneHelper))

				if var_96_33 then
					var_96_33:EnableDynamicBone(true)
				end
			end

			local var_96_34 = 0

			if var_96_34 < arg_93_1.time_ and arg_93_1.time_ <= var_96_34 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			local var_96_35 = 0

			if var_96_35 < arg_93_1.time_ and arg_93_1.time_ <= var_96_35 + arg_96_0 then
				arg_93_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_36 = arg_93_1.actors_["6045_story"]
			local var_96_37 = 0

			if var_96_37 < arg_93_1.time_ and arg_93_1.time_ <= var_96_37 + arg_96_0 and not isNil(var_96_36) and arg_93_1.var_.characterEffect6045_story == nil then
				arg_93_1.var_.characterEffect6045_story = var_96_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_38 = 0.2

			if var_96_37 <= arg_93_1.time_ and arg_93_1.time_ < var_96_37 + var_96_38 and not isNil(var_96_36) then
				local var_96_39 = (arg_93_1.time_ - var_96_37) / var_96_38

				if arg_93_1.var_.characterEffect6045_story and not isNil(var_96_36) then
					arg_93_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_37 + var_96_38 and arg_93_1.time_ < var_96_37 + var_96_38 + arg_96_0 and not isNil(var_96_36) and arg_93_1.var_.characterEffect6045_story then
				arg_93_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_96_40 = 0
			local var_96_41 = 0.7

			if var_96_40 < arg_93_1.time_ and arg_93_1.time_ <= var_96_40 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_42 = arg_93_1:FormatText(StoryNameCfg[215].name)

				arg_93_1.leftNameTxt_.text = var_96_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_43 = arg_93_1:GetWordFromCfg(113062022)
				local var_96_44 = arg_93_1:FormatText(var_96_43.content)

				arg_93_1.text_.text = var_96_44

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_45 = 28
				local var_96_46 = utf8.len(var_96_44)
				local var_96_47 = var_96_45 <= 0 and var_96_41 or var_96_41 * (var_96_46 / var_96_45)

				if var_96_47 > 0 and var_96_41 < var_96_47 then
					arg_93_1.talkMaxDuration = var_96_47

					if var_96_47 + var_96_40 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_47 + var_96_40
					end
				end

				arg_93_1.text_.text = var_96_44
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062022", "story_v_out_113062.awb") ~= 0 then
					local var_96_48 = manager.audio:GetVoiceLength("story_v_out_113062", "113062022", "story_v_out_113062.awb") / 1000

					if var_96_48 + var_96_40 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_48 + var_96_40
					end

					if var_96_43.prefab_name ~= "" and arg_93_1.actors_[var_96_43.prefab_name] ~= nil then
						local var_96_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_43.prefab_name].transform, "story_v_out_113062", "113062022", "story_v_out_113062.awb")

						arg_93_1:RecordAudio("113062022", var_96_49)
						arg_93_1:RecordAudio("113062022", var_96_49)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113062", "113062022", "story_v_out_113062.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113062", "113062022", "story_v_out_113062.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_50 = math.max(var_96_41, arg_93_1.talkMaxDuration)

			if var_96_40 <= arg_93_1.time_ and arg_93_1.time_ < var_96_40 + var_96_50 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_40) / var_96_50

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_40 + var_96_50 and arg_93_1.time_ < var_96_40 + var_96_50 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play113062023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113062023
		arg_97_1.duration_ = 3.47

		local var_97_0 = {
			ja = 3.466,
			ko = 3.033,
			zh = 2.766,
			en = 2.433
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play113062024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["6045_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect6045_story == nil then
				arg_97_1.var_.characterEffect6045_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect6045_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect6045_story.fillFlat = true
					arg_97_1.var_.characterEffect6045_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect6045_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect6045_story.fillFlat = true
				arg_97_1.var_.characterEffect6045_story.fillRatio = var_100_5
			end

			local var_100_6 = "6046_story"

			if arg_97_1.actors_[var_100_6] == nil then
				local var_100_7 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_100_7) then
					local var_100_8 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_97_1.stage_.transform)

					var_100_8.name = var_100_6
					var_100_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_97_1.actors_[var_100_6] = var_100_8

					local var_100_9 = var_100_8:GetComponentInChildren(typeof(CharacterEffect))

					var_100_9.enabled = true

					local var_100_10 = GameObjectTools.GetOrAddComponent(var_100_8, typeof(DynamicBoneHelper))

					if var_100_10 then
						var_100_10:EnableDynamicBone(false)
					end

					arg_97_1:ShowWeapon(var_100_9.transform, false)

					arg_97_1.var_[var_100_6 .. "Animator"] = var_100_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_97_1.var_[var_100_6 .. "Animator"].applyRootMotion = true
					arg_97_1.var_[var_100_6 .. "LipSync"] = var_100_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_100_11 = arg_97_1.actors_["6046_story"].transform
			local var_100_12 = 0

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.var_.moveOldPos6046_story = var_100_11.localPosition

				local var_100_13 = GameObjectTools.GetOrAddComponent(var_100_11.gameObject, typeof(DynamicBoneHelper))

				if var_100_13 then
					var_100_13:EnableDynamicBone(false)
				end
			end

			local var_100_14 = 0.001

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_14 then
				local var_100_15 = (arg_97_1.time_ - var_100_12) / var_100_14
				local var_100_16 = Vector3.New(0.7, -0.5, -6.3)

				var_100_11.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos6046_story, var_100_16, var_100_15)

				local var_100_17 = manager.ui.mainCamera.transform.position - var_100_11.position

				var_100_11.forward = Vector3.New(var_100_17.x, var_100_17.y, var_100_17.z)

				local var_100_18 = var_100_11.localEulerAngles

				var_100_18.z = 0
				var_100_18.x = 0
				var_100_11.localEulerAngles = var_100_18
			end

			if arg_97_1.time_ >= var_100_12 + var_100_14 and arg_97_1.time_ < var_100_12 + var_100_14 + arg_100_0 then
				var_100_11.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_100_19 = manager.ui.mainCamera.transform.position - var_100_11.position

				var_100_11.forward = Vector3.New(var_100_19.x, var_100_19.y, var_100_19.z)

				local var_100_20 = var_100_11.localEulerAngles

				var_100_20.z = 0
				var_100_20.x = 0
				var_100_11.localEulerAngles = var_100_20

				local var_100_21 = GameObjectTools.GetOrAddComponent(var_100_11.gameObject, typeof(DynamicBoneHelper))

				if var_100_21 then
					var_100_21:EnableDynamicBone(true)
				end
			end

			local var_100_22 = 0

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_100_23 = 0

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_100_24 = arg_97_1.actors_["6046_story"]
			local var_100_25 = 0

			if var_100_25 < arg_97_1.time_ and arg_97_1.time_ <= var_100_25 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect6046_story == nil then
				arg_97_1.var_.characterEffect6046_story = var_100_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_26 = 0.2

			if var_100_25 <= arg_97_1.time_ and arg_97_1.time_ < var_100_25 + var_100_26 and not isNil(var_100_24) then
				local var_100_27 = (arg_97_1.time_ - var_100_25) / var_100_26

				if arg_97_1.var_.characterEffect6046_story and not isNil(var_100_24) then
					arg_97_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_25 + var_100_26 and arg_97_1.time_ < var_100_25 + var_100_26 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect6046_story then
				arg_97_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_100_28 = 0
			local var_100_29 = 0.25

			if var_100_28 < arg_97_1.time_ and arg_97_1.time_ <= var_100_28 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_30 = arg_97_1:FormatText(StoryNameCfg[214].name)

				arg_97_1.leftNameTxt_.text = var_100_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_31 = arg_97_1:GetWordFromCfg(113062023)
				local var_100_32 = arg_97_1:FormatText(var_100_31.content)

				arg_97_1.text_.text = var_100_32

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_33 = 10
				local var_100_34 = utf8.len(var_100_32)
				local var_100_35 = var_100_33 <= 0 and var_100_29 or var_100_29 * (var_100_34 / var_100_33)

				if var_100_35 > 0 and var_100_29 < var_100_35 then
					arg_97_1.talkMaxDuration = var_100_35

					if var_100_35 + var_100_28 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_35 + var_100_28
					end
				end

				arg_97_1.text_.text = var_100_32
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062023", "story_v_out_113062.awb") ~= 0 then
					local var_100_36 = manager.audio:GetVoiceLength("story_v_out_113062", "113062023", "story_v_out_113062.awb") / 1000

					if var_100_36 + var_100_28 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_36 + var_100_28
					end

					if var_100_31.prefab_name ~= "" and arg_97_1.actors_[var_100_31.prefab_name] ~= nil then
						local var_100_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_31.prefab_name].transform, "story_v_out_113062", "113062023", "story_v_out_113062.awb")

						arg_97_1:RecordAudio("113062023", var_100_37)
						arg_97_1:RecordAudio("113062023", var_100_37)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113062", "113062023", "story_v_out_113062.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113062", "113062023", "story_v_out_113062.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_38 = math.max(var_100_29, arg_97_1.talkMaxDuration)

			if var_100_28 <= arg_97_1.time_ and arg_97_1.time_ < var_100_28 + var_100_38 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_28) / var_100_38

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_28 + var_100_38 and arg_97_1.time_ < var_100_28 + var_100_38 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play113062024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113062024
		arg_101_1.duration_ = 4.8

		local var_101_0 = {
			ja = 3.666,
			ko = 3.7,
			zh = 3.3,
			en = 4.8
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play113062025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["6046_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos6046_story = var_104_0.localPosition

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end
			end

			local var_104_3 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_3 then
				local var_104_4 = (arg_101_1.time_ - var_104_1) / var_104_3
				local var_104_5 = Vector3.New(0, 100, 0)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6046_story, var_104_5, var_104_4)

				local var_104_6 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_6.x, var_104_6.y, var_104_6.z)

				local var_104_7 = var_104_0.localEulerAngles

				var_104_7.z = 0
				var_104_7.x = 0
				var_104_0.localEulerAngles = var_104_7
			end

			if arg_101_1.time_ >= var_104_1 + var_104_3 and arg_101_1.time_ < var_104_1 + var_104_3 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, 100, 0)

				local var_104_8 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_8.x, var_104_8.y, var_104_8.z)

				local var_104_9 = var_104_0.localEulerAngles

				var_104_9.z = 0
				var_104_9.x = 0
				var_104_0.localEulerAngles = var_104_9

				local var_104_10 = GameObjectTools.GetOrAddComponent(var_104_0.gameObject, typeof(DynamicBoneHelper))

				if var_104_10 then
					var_104_10:EnableDynamicBone(true)
				end
			end

			local var_104_11 = arg_101_1.actors_["6045_story"].transform
			local var_104_12 = 0

			if var_104_12 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.var_.moveOldPos6045_story = var_104_11.localPosition

				local var_104_13 = GameObjectTools.GetOrAddComponent(var_104_11.gameObject, typeof(DynamicBoneHelper))

				if var_104_13 then
					var_104_13:EnableDynamicBone(false)
				end
			end

			local var_104_14 = 0.001

			if var_104_12 <= arg_101_1.time_ and arg_101_1.time_ < var_104_12 + var_104_14 then
				local var_104_15 = (arg_101_1.time_ - var_104_12) / var_104_14
				local var_104_16 = Vector3.New(0, 100, 0)

				var_104_11.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6045_story, var_104_16, var_104_15)

				local var_104_17 = manager.ui.mainCamera.transform.position - var_104_11.position

				var_104_11.forward = Vector3.New(var_104_17.x, var_104_17.y, var_104_17.z)

				local var_104_18 = var_104_11.localEulerAngles

				var_104_18.z = 0
				var_104_18.x = 0
				var_104_11.localEulerAngles = var_104_18
			end

			if arg_101_1.time_ >= var_104_12 + var_104_14 and arg_101_1.time_ < var_104_12 + var_104_14 + arg_104_0 then
				var_104_11.localPosition = Vector3.New(0, 100, 0)

				local var_104_19 = manager.ui.mainCamera.transform.position - var_104_11.position

				var_104_11.forward = Vector3.New(var_104_19.x, var_104_19.y, var_104_19.z)

				local var_104_20 = var_104_11.localEulerAngles

				var_104_20.z = 0
				var_104_20.x = 0
				var_104_11.localEulerAngles = var_104_20

				local var_104_21 = GameObjectTools.GetOrAddComponent(var_104_11.gameObject, typeof(DynamicBoneHelper))

				if var_104_21 then
					var_104_21:EnableDynamicBone(true)
				end
			end

			local var_104_22 = arg_101_1.actors_["1084ui_story"].transform
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_22.localPosition
			end

			local var_104_24 = 0.001

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24
				local var_104_26 = Vector3.New(-0.7, -0.97, -6)

				var_104_22.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, var_104_26, var_104_25)

				local var_104_27 = manager.ui.mainCamera.transform.position - var_104_22.position

				var_104_22.forward = Vector3.New(var_104_27.x, var_104_27.y, var_104_27.z)

				local var_104_28 = var_104_22.localEulerAngles

				var_104_28.z = 0
				var_104_28.x = 0
				var_104_22.localEulerAngles = var_104_28
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 then
				var_104_22.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_104_29 = manager.ui.mainCamera.transform.position - var_104_22.position

				var_104_22.forward = Vector3.New(var_104_29.x, var_104_29.y, var_104_29.z)

				local var_104_30 = var_104_22.localEulerAngles

				var_104_30.z = 0
				var_104_30.x = 0
				var_104_22.localEulerAngles = var_104_30
			end

			local var_104_31 = 0

			if var_104_31 < arg_101_1.time_ and arg_101_1.time_ <= var_104_31 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_104_32 = 0

			if var_104_32 < arg_101_1.time_ and arg_101_1.time_ <= var_104_32 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_104_33 = arg_101_1.actors_["1084ui_story"]
			local var_104_34 = 0

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 and not isNil(var_104_33) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_35 = 0.2

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_35 and not isNil(var_104_33) then
				local var_104_36 = (arg_101_1.time_ - var_104_34) / var_104_35

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_33) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_34 + var_104_35 and arg_101_1.time_ < var_104_34 + var_104_35 + arg_104_0 and not isNil(var_104_33) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_37 = 0
			local var_104_38 = 0.375

			if var_104_37 < arg_101_1.time_ and arg_101_1.time_ <= var_104_37 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_39 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_40 = arg_101_1:GetWordFromCfg(113062024)
				local var_104_41 = arg_101_1:FormatText(var_104_40.content)

				arg_101_1.text_.text = var_104_41

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_42 = 15
				local var_104_43 = utf8.len(var_104_41)
				local var_104_44 = var_104_42 <= 0 and var_104_38 or var_104_38 * (var_104_43 / var_104_42)

				if var_104_44 > 0 and var_104_38 < var_104_44 then
					arg_101_1.talkMaxDuration = var_104_44

					if var_104_44 + var_104_37 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_44 + var_104_37
					end
				end

				arg_101_1.text_.text = var_104_41
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062024", "story_v_out_113062.awb") ~= 0 then
					local var_104_45 = manager.audio:GetVoiceLength("story_v_out_113062", "113062024", "story_v_out_113062.awb") / 1000

					if var_104_45 + var_104_37 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_45 + var_104_37
					end

					if var_104_40.prefab_name ~= "" and arg_101_1.actors_[var_104_40.prefab_name] ~= nil then
						local var_104_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_40.prefab_name].transform, "story_v_out_113062", "113062024", "story_v_out_113062.awb")

						arg_101_1:RecordAudio("113062024", var_104_46)
						arg_101_1:RecordAudio("113062024", var_104_46)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113062", "113062024", "story_v_out_113062.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113062", "113062024", "story_v_out_113062.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_47 = math.max(var_104_38, arg_101_1.talkMaxDuration)

			if var_104_37 <= arg_101_1.time_ and arg_101_1.time_ < var_104_37 + var_104_47 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_37) / var_104_47

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_37 + var_104_47 and arg_101_1.time_ < var_104_37 + var_104_47 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play113062025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113062025
		arg_105_1.duration_ = 6.3

		local var_105_0 = {
			ja = 3.866,
			ko = 6.3,
			zh = 4.1,
			en = 4.633
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play113062026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["6045_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos6045_story = var_108_0.localPosition

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end
			end

			local var_108_3 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = Vector3.New(0.7, -0.5, -6.3)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos6045_story, var_108_5, var_108_4)

				local var_108_6 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_6.x, var_108_6.y, var_108_6.z)

				local var_108_7 = var_108_0.localEulerAngles

				var_108_7.z = 0
				var_108_7.x = 0
				var_108_0.localEulerAngles = var_108_7
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_108_8 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_8.x, var_108_8.y, var_108_8.z)

				local var_108_9 = var_108_0.localEulerAngles

				var_108_9.z = 0
				var_108_9.x = 0
				var_108_0.localEulerAngles = var_108_9

				local var_108_10 = GameObjectTools.GetOrAddComponent(var_108_0.gameObject, typeof(DynamicBoneHelper))

				if var_108_10 then
					var_108_10:EnableDynamicBone(true)
				end
			end

			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_108_12 = arg_105_1.actors_["6045_story"]
			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 and not isNil(var_108_12) and arg_105_1.var_.characterEffect6045_story == nil then
				arg_105_1.var_.characterEffect6045_story = var_108_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_14 = 0.2

			if var_108_13 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_14 and not isNil(var_108_12) then
				local var_108_15 = (arg_105_1.time_ - var_108_13) / var_108_14

				if arg_105_1.var_.characterEffect6045_story and not isNil(var_108_12) then
					arg_105_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_13 + var_108_14 and arg_105_1.time_ < var_108_13 + var_108_14 + arg_108_0 and not isNil(var_108_12) and arg_105_1.var_.characterEffect6045_story then
				arg_105_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_108_16 = arg_105_1.actors_["1084ui_story"]
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 and not isNil(var_108_16) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_18 = 0.2

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_18 and not isNil(var_108_16) then
				local var_108_19 = (arg_105_1.time_ - var_108_17) / var_108_18

				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_16) then
					local var_108_20 = Mathf.Lerp(0, 0.5, var_108_19)

					arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_20
				end
			end

			if arg_105_1.time_ >= var_108_17 + var_108_18 and arg_105_1.time_ < var_108_17 + var_108_18 + arg_108_0 and not isNil(var_108_16) and arg_105_1.var_.characterEffect1084ui_story then
				local var_108_21 = 0.5

				arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1084ui_story.fillRatio = var_108_21
			end

			local var_108_22 = 0
			local var_108_23 = 0.4

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_24 = arg_105_1:FormatText(StoryNameCfg[215].name)

				arg_105_1.leftNameTxt_.text = var_108_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_25 = arg_105_1:GetWordFromCfg(113062025)
				local var_108_26 = arg_105_1:FormatText(var_108_25.content)

				arg_105_1.text_.text = var_108_26

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_27 = 16
				local var_108_28 = utf8.len(var_108_26)
				local var_108_29 = var_108_27 <= 0 and var_108_23 or var_108_23 * (var_108_28 / var_108_27)

				if var_108_29 > 0 and var_108_23 < var_108_29 then
					arg_105_1.talkMaxDuration = var_108_29

					if var_108_29 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_29 + var_108_22
					end
				end

				arg_105_1.text_.text = var_108_26
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062025", "story_v_out_113062.awb") ~= 0 then
					local var_108_30 = manager.audio:GetVoiceLength("story_v_out_113062", "113062025", "story_v_out_113062.awb") / 1000

					if var_108_30 + var_108_22 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_22
					end

					if var_108_25.prefab_name ~= "" and arg_105_1.actors_[var_108_25.prefab_name] ~= nil then
						local var_108_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_25.prefab_name].transform, "story_v_out_113062", "113062025", "story_v_out_113062.awb")

						arg_105_1:RecordAudio("113062025", var_108_31)
						arg_105_1:RecordAudio("113062025", var_108_31)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113062", "113062025", "story_v_out_113062.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113062", "113062025", "story_v_out_113062.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_32 = math.max(var_108_23, arg_105_1.talkMaxDuration)

			if var_108_22 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_32 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_32

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_32 and arg_105_1.time_ < var_108_22 + var_108_32 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play113062026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113062026
		arg_109_1.duration_ = 4.83

		local var_109_0 = {
			ja = 3.5,
			ko = 4.833,
			zh = 2.4,
			en = 2.6
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play113062027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_112_2 = arg_109_1.actors_["1084ui_story"]
			local var_112_3 = 0

			if var_112_3 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.2

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_4 and not isNil(var_112_2) then
				local var_112_5 = (arg_109_1.time_ - var_112_3) / var_112_4

				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_3 + var_112_4 and arg_109_1.time_ < var_112_3 + var_112_4 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_112_6 = 0
			local var_112_7 = 0.325

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:GetWordFromCfg(113062026)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 13
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062026", "story_v_out_113062.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_113062", "113062026", "story_v_out_113062.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_113062", "113062026", "story_v_out_113062.awb")

						arg_109_1:RecordAudio("113062026", var_112_15)
						arg_109_1:RecordAudio("113062026", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113062", "113062026", "story_v_out_113062.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113062", "113062026", "story_v_out_113062.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play113062027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113062027
		arg_113_1.duration_ = 3.83

		local var_113_0 = {
			ja = 3.466,
			ko = 3.1,
			zh = 3.833,
			en = 3.6
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113062028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["6045_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos6045_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos6045_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["1042ui_story"].transform
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.var_.moveOldPos1042ui_story = var_116_11.localPosition
			end

			local var_116_13 = 0.001

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_13 then
				local var_116_14 = (arg_113_1.time_ - var_116_12) / var_116_13
				local var_116_15 = Vector3.New(0.7, -1.06, -6.2)

				var_116_11.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1042ui_story, var_116_15, var_116_14)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_11.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_11.localEulerAngles = var_116_17
			end

			if arg_113_1.time_ >= var_116_12 + var_116_13 and arg_113_1.time_ < var_116_12 + var_116_13 + arg_116_0 then
				var_116_11.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_116_18 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_18.x, var_116_18.y, var_116_18.z)

				local var_116_19 = var_116_11.localEulerAngles

				var_116_19.z = 0
				var_116_19.x = 0
				var_116_11.localEulerAngles = var_116_19
			end

			local var_116_20 = 0

			if var_116_20 < arg_113_1.time_ and arg_113_1.time_ <= var_116_20 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_116_21 = 0

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_116_22 = arg_113_1.actors_["1042ui_story"]
			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1042ui_story == nil then
				arg_113_1.var_.characterEffect1042ui_story = var_116_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_24 = 0.2

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 and not isNil(var_116_22) then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / var_116_24

				if arg_113_1.var_.characterEffect1042ui_story and not isNil(var_116_22) then
					arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1042ui_story then
				arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_116_26 = arg_113_1.actors_["1084ui_story"]
			local var_116_27 = 0

			if var_116_27 < arg_113_1.time_ and arg_113_1.time_ <= var_116_27 + arg_116_0 and not isNil(var_116_26) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_28 = 0.2

			if var_116_27 <= arg_113_1.time_ and arg_113_1.time_ < var_116_27 + var_116_28 and not isNil(var_116_26) then
				local var_116_29 = (arg_113_1.time_ - var_116_27) / var_116_28

				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_26) then
					local var_116_30 = Mathf.Lerp(0, 0.5, var_116_29)

					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_30
				end
			end

			if arg_113_1.time_ >= var_116_27 + var_116_28 and arg_113_1.time_ < var_116_27 + var_116_28 + arg_116_0 and not isNil(var_116_26) and arg_113_1.var_.characterEffect1084ui_story then
				local var_116_31 = 0.5

				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = var_116_31
			end

			local var_116_32 = 0
			local var_116_33 = 0.3

			if var_116_32 < arg_113_1.time_ and arg_113_1.time_ <= var_116_32 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_34 = arg_113_1:FormatText(StoryNameCfg[205].name)

				arg_113_1.leftNameTxt_.text = var_116_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_35 = arg_113_1:GetWordFromCfg(113062027)
				local var_116_36 = arg_113_1:FormatText(var_116_35.content)

				arg_113_1.text_.text = var_116_36

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_37 = 12
				local var_116_38 = utf8.len(var_116_36)
				local var_116_39 = var_116_37 <= 0 and var_116_33 or var_116_33 * (var_116_38 / var_116_37)

				if var_116_39 > 0 and var_116_33 < var_116_39 then
					arg_113_1.talkMaxDuration = var_116_39

					if var_116_39 + var_116_32 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_39 + var_116_32
					end
				end

				arg_113_1.text_.text = var_116_36
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062027", "story_v_out_113062.awb") ~= 0 then
					local var_116_40 = manager.audio:GetVoiceLength("story_v_out_113062", "113062027", "story_v_out_113062.awb") / 1000

					if var_116_40 + var_116_32 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_40 + var_116_32
					end

					if var_116_35.prefab_name ~= "" and arg_113_1.actors_[var_116_35.prefab_name] ~= nil then
						local var_116_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_35.prefab_name].transform, "story_v_out_113062", "113062027", "story_v_out_113062.awb")

						arg_113_1:RecordAudio("113062027", var_116_41)
						arg_113_1:RecordAudio("113062027", var_116_41)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_113062", "113062027", "story_v_out_113062.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_113062", "113062027", "story_v_out_113062.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_42 = math.max(var_116_33, arg_113_1.talkMaxDuration)

			if var_116_32 <= arg_113_1.time_ and arg_113_1.time_ < var_116_32 + var_116_42 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_32) / var_116_42

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_32 + var_116_42 and arg_113_1.time_ < var_116_32 + var_116_42 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113062028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113062028
		arg_117_1.duration_ = 4.9

		local var_117_0 = {
			ja = 4.9,
			ko = 4.833,
			zh = 4.8,
			en = 3.366
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play113062029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1084ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1084ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1084ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1042ui_story"].transform
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.var_.moveOldPos1042ui_story = var_120_9.localPosition
			end

			local var_120_11 = 0.001

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11
				local var_120_13 = Vector3.New(0, 100, 0)

				var_120_9.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1042ui_story, var_120_13, var_120_12)

				local var_120_14 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_14.x, var_120_14.y, var_120_14.z)

				local var_120_15 = var_120_9.localEulerAngles

				var_120_15.z = 0
				var_120_15.x = 0
				var_120_9.localEulerAngles = var_120_15
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				var_120_9.localPosition = Vector3.New(0, 100, 0)

				local var_120_16 = manager.ui.mainCamera.transform.position - var_120_9.position

				var_120_9.forward = Vector3.New(var_120_16.x, var_120_16.y, var_120_16.z)

				local var_120_17 = var_120_9.localEulerAngles

				var_120_17.z = 0
				var_120_17.x = 0
				var_120_9.localEulerAngles = var_120_17
			end

			local var_120_18 = 0
			local var_120_19 = 0.15

			if var_120_18 < arg_117_1.time_ and arg_117_1.time_ <= var_120_18 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_20 = arg_117_1:FormatText(StoryNameCfg[212].name)

				arg_117_1.leftNameTxt_.text = var_120_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_21 = arg_117_1:GetWordFromCfg(113062028)
				local var_120_22 = arg_117_1:FormatText(var_120_21.content)

				arg_117_1.text_.text = var_120_22

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_23 = 6
				local var_120_24 = utf8.len(var_120_22)
				local var_120_25 = var_120_23 <= 0 and var_120_19 or var_120_19 * (var_120_24 / var_120_23)

				if var_120_25 > 0 and var_120_19 < var_120_25 then
					arg_117_1.talkMaxDuration = var_120_25

					if var_120_25 + var_120_18 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_25 + var_120_18
					end
				end

				arg_117_1.text_.text = var_120_22
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062028", "story_v_out_113062.awb") ~= 0 then
					local var_120_26 = manager.audio:GetVoiceLength("story_v_out_113062", "113062028", "story_v_out_113062.awb") / 1000

					if var_120_26 + var_120_18 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_26 + var_120_18
					end

					if var_120_21.prefab_name ~= "" and arg_117_1.actors_[var_120_21.prefab_name] ~= nil then
						local var_120_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_21.prefab_name].transform, "story_v_out_113062", "113062028", "story_v_out_113062.awb")

						arg_117_1:RecordAudio("113062028", var_120_27)
						arg_117_1:RecordAudio("113062028", var_120_27)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113062", "113062028", "story_v_out_113062.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113062", "113062028", "story_v_out_113062.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_28 = math.max(var_120_19, arg_117_1.talkMaxDuration)

			if var_120_18 <= arg_117_1.time_ and arg_117_1.time_ < var_120_18 + var_120_28 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_18) / var_120_28

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_18 + var_120_28 and arg_117_1.time_ < var_120_18 + var_120_28 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play113062029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113062029
		arg_121_1.duration_ = 3.23

		local var_121_0 = {
			ja = 3.233,
			ko = 2.333,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113062030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_124_2 = arg_121_1.actors_["1042ui_story"].transform
			local var_124_3 = 0

			if var_124_3 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.var_.moveOldPos1042ui_story = var_124_2.localPosition
			end

			local var_124_4 = 0.001

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_3) / var_124_4
				local var_124_6 = Vector3.New(-0.7, -1.06, -6.2)

				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1042ui_story, var_124_6, var_124_5)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_2.position

				var_124_2.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_2.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_2.localEulerAngles = var_124_8
			end

			if arg_121_1.time_ >= var_124_3 + var_124_4 and arg_121_1.time_ < var_124_3 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_124_9 = manager.ui.mainCamera.transform.position - var_124_2.position

				var_124_2.forward = Vector3.New(var_124_9.x, var_124_9.y, var_124_9.z)

				local var_124_10 = var_124_2.localEulerAngles

				var_124_10.z = 0
				var_124_10.x = 0
				var_124_2.localEulerAngles = var_124_10
			end

			local var_124_11 = arg_121_1.actors_["1042ui_story"]
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_13 = 0.2

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_13 and not isNil(var_124_11) then
				local var_124_14 = (arg_121_1.time_ - var_124_12) / var_124_13

				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_11) then
					arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_12 + var_124_13 and arg_121_1.time_ < var_124_12 + var_124_13 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1042ui_story then
				arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_124_15 = 0
			local var_124_16 = 0.15

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[205].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(113062029)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 6
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062029", "story_v_out_113062.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_113062", "113062029", "story_v_out_113062.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_113062", "113062029", "story_v_out_113062.awb")

						arg_121_1:RecordAudio("113062029", var_124_24)
						arg_121_1:RecordAudio("113062029", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_113062", "113062029", "story_v_out_113062.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_113062", "113062029", "story_v_out_113062.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play113062030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113062030
		arg_125_1.duration_ = 10.63

		local var_125_0 = {
			ja = 10.633,
			ko = 6.7,
			zh = 5.366,
			en = 8.766
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113062031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1042ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1042ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1042ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1042ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1042ui_story.fillRatio = var_128_5
			end

			local var_128_6 = "1097ui_story"

			if arg_125_1.actors_[var_128_6] == nil then
				local var_128_7 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_128_7) then
					local var_128_8 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_125_1.stage_.transform)

					var_128_8.name = var_128_6
					var_128_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_125_1.actors_[var_128_6] = var_128_8

					local var_128_9 = var_128_8:GetComponentInChildren(typeof(CharacterEffect))

					var_128_9.enabled = true

					local var_128_10 = GameObjectTools.GetOrAddComponent(var_128_8, typeof(DynamicBoneHelper))

					if var_128_10 then
						var_128_10:EnableDynamicBone(false)
					end

					arg_125_1:ShowWeapon(var_128_9.transform, false)

					arg_125_1.var_[var_128_6 .. "Animator"] = var_128_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_125_1.var_[var_128_6 .. "Animator"].applyRootMotion = true
					arg_125_1.var_[var_128_6 .. "LipSync"] = var_128_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_128_11 = arg_125_1.actors_["1097ui_story"].transform
			local var_128_12 = 0

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.var_.moveOldPos1097ui_story = var_128_11.localPosition
			end

			local var_128_13 = 0.001

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_13 then
				local var_128_14 = (arg_125_1.time_ - var_128_12) / var_128_13
				local var_128_15 = Vector3.New(0.7, -0.54, -6.3)

				var_128_11.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1097ui_story, var_128_15, var_128_14)

				local var_128_16 = manager.ui.mainCamera.transform.position - var_128_11.position

				var_128_11.forward = Vector3.New(var_128_16.x, var_128_16.y, var_128_16.z)

				local var_128_17 = var_128_11.localEulerAngles

				var_128_17.z = 0
				var_128_17.x = 0
				var_128_11.localEulerAngles = var_128_17
			end

			if arg_125_1.time_ >= var_128_12 + var_128_13 and arg_125_1.time_ < var_128_12 + var_128_13 + arg_128_0 then
				var_128_11.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_128_18 = manager.ui.mainCamera.transform.position - var_128_11.position

				var_128_11.forward = Vector3.New(var_128_18.x, var_128_18.y, var_128_18.z)

				local var_128_19 = var_128_11.localEulerAngles

				var_128_19.z = 0
				var_128_19.x = 0
				var_128_11.localEulerAngles = var_128_19
			end

			local var_128_20 = 0

			if var_128_20 < arg_125_1.time_ and arg_125_1.time_ <= var_128_20 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_128_21 = arg_125_1.actors_["1097ui_story"]
			local var_128_22 = 0

			if var_128_22 < arg_125_1.time_ and arg_125_1.time_ <= var_128_22 + arg_128_0 and not isNil(var_128_21) and arg_125_1.var_.characterEffect1097ui_story == nil then
				arg_125_1.var_.characterEffect1097ui_story = var_128_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_23 = 0.2

			if var_128_22 <= arg_125_1.time_ and arg_125_1.time_ < var_128_22 + var_128_23 and not isNil(var_128_21) then
				local var_128_24 = (arg_125_1.time_ - var_128_22) / var_128_23

				if arg_125_1.var_.characterEffect1097ui_story and not isNil(var_128_21) then
					arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_22 + var_128_23 and arg_125_1.time_ < var_128_22 + var_128_23 + arg_128_0 and not isNil(var_128_21) and arg_125_1.var_.characterEffect1097ui_story then
				arg_125_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_128_25 = 0

			if var_128_25 < arg_125_1.time_ and arg_125_1.time_ <= var_128_25 + arg_128_0 then
				arg_125_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_26 = 0
			local var_128_27 = 0.55

			if var_128_26 < arg_125_1.time_ and arg_125_1.time_ <= var_128_26 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_28 = arg_125_1:FormatText(StoryNameCfg[216].name)

				arg_125_1.leftNameTxt_.text = var_128_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_29 = arg_125_1:GetWordFromCfg(113062030)
				local var_128_30 = arg_125_1:FormatText(var_128_29.content)

				arg_125_1.text_.text = var_128_30

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_31 = 22
				local var_128_32 = utf8.len(var_128_30)
				local var_128_33 = var_128_31 <= 0 and var_128_27 or var_128_27 * (var_128_32 / var_128_31)

				if var_128_33 > 0 and var_128_27 < var_128_33 then
					arg_125_1.talkMaxDuration = var_128_33

					if var_128_33 + var_128_26 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_33 + var_128_26
					end
				end

				arg_125_1.text_.text = var_128_30
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062030", "story_v_out_113062.awb") ~= 0 then
					local var_128_34 = manager.audio:GetVoiceLength("story_v_out_113062", "113062030", "story_v_out_113062.awb") / 1000

					if var_128_34 + var_128_26 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_34 + var_128_26
					end

					if var_128_29.prefab_name ~= "" and arg_125_1.actors_[var_128_29.prefab_name] ~= nil then
						local var_128_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_29.prefab_name].transform, "story_v_out_113062", "113062030", "story_v_out_113062.awb")

						arg_125_1:RecordAudio("113062030", var_128_35)
						arg_125_1:RecordAudio("113062030", var_128_35)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113062", "113062030", "story_v_out_113062.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113062", "113062030", "story_v_out_113062.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_36 = math.max(var_128_27, arg_125_1.talkMaxDuration)

			if var_128_26 <= arg_125_1.time_ and arg_125_1.time_ < var_128_26 + var_128_36 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_26) / var_128_36

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_26 + var_128_36 and arg_125_1.time_ < var_128_26 + var_128_36 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play113062031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113062031
		arg_129_1.duration_ = 10.5

		local var_129_0 = {
			ja = 10.5,
			ko = 8.066,
			zh = 8.5,
			en = 7.633
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play113062032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1097ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1097ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1097ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1097ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1097ui_story.fillRatio = var_132_5
			end

			local var_132_6 = arg_129_1.actors_["1042ui_story"].transform
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.var_.moveOldPos1042ui_story = var_132_6.localPosition
			end

			local var_132_8 = 0.001

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 then
				local var_132_9 = (arg_129_1.time_ - var_132_7) / var_132_8
				local var_132_10 = Vector3.New(0, 100, 0)

				var_132_6.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1042ui_story, var_132_10, var_132_9)

				local var_132_11 = manager.ui.mainCamera.transform.position - var_132_6.position

				var_132_6.forward = Vector3.New(var_132_11.x, var_132_11.y, var_132_11.z)

				local var_132_12 = var_132_6.localEulerAngles

				var_132_12.z = 0
				var_132_12.x = 0
				var_132_6.localEulerAngles = var_132_12
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 then
				var_132_6.localPosition = Vector3.New(0, 100, 0)

				local var_132_13 = manager.ui.mainCamera.transform.position - var_132_6.position

				var_132_6.forward = Vector3.New(var_132_13.x, var_132_13.y, var_132_13.z)

				local var_132_14 = var_132_6.localEulerAngles

				var_132_14.z = 0
				var_132_14.x = 0
				var_132_6.localEulerAngles = var_132_14
			end

			local var_132_15 = arg_129_1.actors_["6046_story"].transform
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.var_.moveOldPos6046_story = var_132_15.localPosition

				local var_132_17 = GameObjectTools.GetOrAddComponent(var_132_15.gameObject, typeof(DynamicBoneHelper))

				if var_132_17 then
					var_132_17:EnableDynamicBone(false)
				end
			end

			local var_132_18 = 0.001

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_18 then
				local var_132_19 = (arg_129_1.time_ - var_132_16) / var_132_18
				local var_132_20 = Vector3.New(-0.7, -0.5, -6.3)

				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos6046_story, var_132_20, var_132_19)

				local var_132_21 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_21.x, var_132_21.y, var_132_21.z)

				local var_132_22 = var_132_15.localEulerAngles

				var_132_22.z = 0
				var_132_22.x = 0
				var_132_15.localEulerAngles = var_132_22
			end

			if arg_129_1.time_ >= var_132_16 + var_132_18 and arg_129_1.time_ < var_132_16 + var_132_18 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_132_23 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_23.x, var_132_23.y, var_132_23.z)

				local var_132_24 = var_132_15.localEulerAngles

				var_132_24.z = 0
				var_132_24.x = 0
				var_132_15.localEulerAngles = var_132_24

				local var_132_25 = GameObjectTools.GetOrAddComponent(var_132_15.gameObject, typeof(DynamicBoneHelper))

				if var_132_25 then
					var_132_25:EnableDynamicBone(true)
				end
			end

			local var_132_26 = 0

			if var_132_26 < arg_129_1.time_ and arg_129_1.time_ <= var_132_26 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_132_27 = 0

			if var_132_27 < arg_129_1.time_ and arg_129_1.time_ <= var_132_27 + arg_132_0 then
				arg_129_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_132_28 = arg_129_1.actors_["6046_story"]
			local var_132_29 = 0

			if var_132_29 < arg_129_1.time_ and arg_129_1.time_ <= var_132_29 + arg_132_0 and not isNil(var_132_28) and arg_129_1.var_.characterEffect6046_story == nil then
				arg_129_1.var_.characterEffect6046_story = var_132_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_30 = 0.2

			if var_132_29 <= arg_129_1.time_ and arg_129_1.time_ < var_132_29 + var_132_30 and not isNil(var_132_28) then
				local var_132_31 = (arg_129_1.time_ - var_132_29) / var_132_30

				if arg_129_1.var_.characterEffect6046_story and not isNil(var_132_28) then
					arg_129_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_29 + var_132_30 and arg_129_1.time_ < var_132_29 + var_132_30 + arg_132_0 and not isNil(var_132_28) and arg_129_1.var_.characterEffect6046_story then
				arg_129_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_132_32 = 0
			local var_132_33 = 0.825

			if var_132_32 < arg_129_1.time_ and arg_129_1.time_ <= var_132_32 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_34 = arg_129_1:FormatText(StoryNameCfg[214].name)

				arg_129_1.leftNameTxt_.text = var_132_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_35 = arg_129_1:GetWordFromCfg(113062031)
				local var_132_36 = arg_129_1:FormatText(var_132_35.content)

				arg_129_1.text_.text = var_132_36

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_37 = 33
				local var_132_38 = utf8.len(var_132_36)
				local var_132_39 = var_132_37 <= 0 and var_132_33 or var_132_33 * (var_132_38 / var_132_37)

				if var_132_39 > 0 and var_132_33 < var_132_39 then
					arg_129_1.talkMaxDuration = var_132_39

					if var_132_39 + var_132_32 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_39 + var_132_32
					end
				end

				arg_129_1.text_.text = var_132_36
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062031", "story_v_out_113062.awb") ~= 0 then
					local var_132_40 = manager.audio:GetVoiceLength("story_v_out_113062", "113062031", "story_v_out_113062.awb") / 1000

					if var_132_40 + var_132_32 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_40 + var_132_32
					end

					if var_132_35.prefab_name ~= "" and arg_129_1.actors_[var_132_35.prefab_name] ~= nil then
						local var_132_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_35.prefab_name].transform, "story_v_out_113062", "113062031", "story_v_out_113062.awb")

						arg_129_1:RecordAudio("113062031", var_132_41)
						arg_129_1:RecordAudio("113062031", var_132_41)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113062", "113062031", "story_v_out_113062.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113062", "113062031", "story_v_out_113062.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_42 = math.max(var_132_33, arg_129_1.talkMaxDuration)

			if var_132_32 <= arg_129_1.time_ and arg_129_1.time_ < var_132_32 + var_132_42 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_32) / var_132_42

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_32 + var_132_42 and arg_129_1.time_ < var_132_32 + var_132_42 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play113062032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113062032
		arg_133_1.duration_ = 4.8

		local var_133_0 = {
			ja = 4.766,
			ko = 4.8,
			zh = 3.7,
			en = 4.666
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play113062033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["6046_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect6046_story == nil then
				arg_133_1.var_.characterEffect6046_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect6046_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect6046_story.fillFlat = true
					arg_133_1.var_.characterEffect6046_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect6046_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect6046_story.fillFlat = true
				arg_133_1.var_.characterEffect6046_story.fillRatio = var_136_5
			end

			local var_136_6 = arg_133_1.actors_["1097ui_story"]
			local var_136_7 = 0

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1097ui_story == nil then
				arg_133_1.var_.characterEffect1097ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_8 = 0.2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 and not isNil(var_136_6) then
				local var_136_9 = (arg_133_1.time_ - var_136_7) / var_136_8

				if arg_133_1.var_.characterEffect1097ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1097ui_story then
				arg_133_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_136_10 = 0

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			local var_136_11 = 0

			if var_136_11 < arg_133_1.time_ and arg_133_1.time_ <= var_136_11 + arg_136_0 then
				arg_133_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_136_12 = 0
			local var_136_13 = 0.275

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_14 = arg_133_1:FormatText(StoryNameCfg[216].name)

				arg_133_1.leftNameTxt_.text = var_136_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(113062032)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 11
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_13 or var_136_13 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_13 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_12
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062032", "story_v_out_113062.awb") ~= 0 then
					local var_136_20 = manager.audio:GetVoiceLength("story_v_out_113062", "113062032", "story_v_out_113062.awb") / 1000

					if var_136_20 + var_136_12 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_20 + var_136_12
					end

					if var_136_15.prefab_name ~= "" and arg_133_1.actors_[var_136_15.prefab_name] ~= nil then
						local var_136_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_15.prefab_name].transform, "story_v_out_113062", "113062032", "story_v_out_113062.awb")

						arg_133_1:RecordAudio("113062032", var_136_21)
						arg_133_1:RecordAudio("113062032", var_136_21)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113062", "113062032", "story_v_out_113062.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113062", "113062032", "story_v_out_113062.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_22 = math.max(var_136_13, arg_133_1.talkMaxDuration)

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_22 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_22

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_22 and arg_133_1.time_ < var_136_12 + var_136_22 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113062033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113062033
		arg_137_1.duration_ = 10.63

		local var_137_0 = {
			ja = 8.3,
			ko = 7.133,
			zh = 8.5,
			en = 10.633
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
			arg_137_1.auto_ = false
		end

		function arg_137_1.playNext_(arg_139_0)
			arg_137_1.onStoryFinished_()
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1097ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos1097ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, 100, 0)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1097ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, 100, 0)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["6046_story"].transform
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.var_.moveOldPos6046_story = var_140_9.localPosition

				local var_140_11 = GameObjectTools.GetOrAddComponent(var_140_9.gameObject, typeof(DynamicBoneHelper))

				if var_140_11 then
					var_140_11:EnableDynamicBone(false)
				end
			end

			local var_140_12 = 0.001

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_10) / var_140_12
				local var_140_14 = Vector3.New(0, 100, 0)

				var_140_9.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos6046_story, var_140_14, var_140_13)

				local var_140_15 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_15.x, var_140_15.y, var_140_15.z)

				local var_140_16 = var_140_9.localEulerAngles

				var_140_16.z = 0
				var_140_16.x = 0
				var_140_9.localEulerAngles = var_140_16
			end

			if arg_137_1.time_ >= var_140_10 + var_140_12 and arg_137_1.time_ < var_140_10 + var_140_12 + arg_140_0 then
				var_140_9.localPosition = Vector3.New(0, 100, 0)

				local var_140_17 = manager.ui.mainCamera.transform.position - var_140_9.position

				var_140_9.forward = Vector3.New(var_140_17.x, var_140_17.y, var_140_17.z)

				local var_140_18 = var_140_9.localEulerAngles

				var_140_18.z = 0
				var_140_18.x = 0
				var_140_9.localEulerAngles = var_140_18

				local var_140_19 = GameObjectTools.GetOrAddComponent(var_140_9.gameObject, typeof(DynamicBoneHelper))

				if var_140_19 then
					var_140_19:EnableDynamicBone(true)
				end
			end

			local var_140_20 = arg_137_1.actors_["1042ui_story"].transform
			local var_140_21 = 0

			if var_140_21 < arg_137_1.time_ and arg_137_1.time_ <= var_140_21 + arg_140_0 then
				arg_137_1.var_.moveOldPos1042ui_story = var_140_20.localPosition
			end

			local var_140_22 = 0.001

			if var_140_21 <= arg_137_1.time_ and arg_137_1.time_ < var_140_21 + var_140_22 then
				local var_140_23 = (arg_137_1.time_ - var_140_21) / var_140_22
				local var_140_24 = Vector3.New(0, -1.06, -6.2)

				var_140_20.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1042ui_story, var_140_24, var_140_23)

				local var_140_25 = manager.ui.mainCamera.transform.position - var_140_20.position

				var_140_20.forward = Vector3.New(var_140_25.x, var_140_25.y, var_140_25.z)

				local var_140_26 = var_140_20.localEulerAngles

				var_140_26.z = 0
				var_140_26.x = 0
				var_140_20.localEulerAngles = var_140_26
			end

			if arg_137_1.time_ >= var_140_21 + var_140_22 and arg_137_1.time_ < var_140_21 + var_140_22 + arg_140_0 then
				var_140_20.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_140_27 = manager.ui.mainCamera.transform.position - var_140_20.position

				var_140_20.forward = Vector3.New(var_140_27.x, var_140_27.y, var_140_27.z)

				local var_140_28 = var_140_20.localEulerAngles

				var_140_28.z = 0
				var_140_28.x = 0
				var_140_20.localEulerAngles = var_140_28
			end

			local var_140_29 = 0

			if var_140_29 < arg_137_1.time_ and arg_137_1.time_ <= var_140_29 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action5_1")
			end

			local var_140_30 = 0

			if var_140_30 < arg_137_1.time_ and arg_137_1.time_ <= var_140_30 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_140_31 = arg_137_1.actors_["1042ui_story"]
			local var_140_32 = 0

			if var_140_32 < arg_137_1.time_ and arg_137_1.time_ <= var_140_32 + arg_140_0 and not isNil(var_140_31) and arg_137_1.var_.characterEffect1042ui_story == nil then
				arg_137_1.var_.characterEffect1042ui_story = var_140_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_33 = 0.2

			if var_140_32 <= arg_137_1.time_ and arg_137_1.time_ < var_140_32 + var_140_33 and not isNil(var_140_31) then
				local var_140_34 = (arg_137_1.time_ - var_140_32) / var_140_33

				if arg_137_1.var_.characterEffect1042ui_story and not isNil(var_140_31) then
					arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_32 + var_140_33 and arg_137_1.time_ < var_140_32 + var_140_33 + arg_140_0 and not isNil(var_140_31) and arg_137_1.var_.characterEffect1042ui_story then
				arg_137_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_140_35 = 0
			local var_140_36 = 0.6

			if var_140_35 < arg_137_1.time_ and arg_137_1.time_ <= var_140_35 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_37 = arg_137_1:FormatText(StoryNameCfg[205].name)

				arg_137_1.leftNameTxt_.text = var_140_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_38 = arg_137_1:GetWordFromCfg(113062033)
				local var_140_39 = arg_137_1:FormatText(var_140_38.content)

				arg_137_1.text_.text = var_140_39

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_40 = 24
				local var_140_41 = utf8.len(var_140_39)
				local var_140_42 = var_140_40 <= 0 and var_140_36 or var_140_36 * (var_140_41 / var_140_40)

				if var_140_42 > 0 and var_140_36 < var_140_42 then
					arg_137_1.talkMaxDuration = var_140_42

					if var_140_42 + var_140_35 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_42 + var_140_35
					end
				end

				arg_137_1.text_.text = var_140_39
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113062", "113062033", "story_v_out_113062.awb") ~= 0 then
					local var_140_43 = manager.audio:GetVoiceLength("story_v_out_113062", "113062033", "story_v_out_113062.awb") / 1000

					if var_140_43 + var_140_35 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_43 + var_140_35
					end

					if var_140_38.prefab_name ~= "" and arg_137_1.actors_[var_140_38.prefab_name] ~= nil then
						local var_140_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_38.prefab_name].transform, "story_v_out_113062", "113062033", "story_v_out_113062.awb")

						arg_137_1:RecordAudio("113062033", var_140_44)
						arg_137_1:RecordAudio("113062033", var_140_44)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113062", "113062033", "story_v_out_113062.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113062", "113062033", "story_v_out_113062.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_45 = math.max(var_140_36, arg_137_1.talkMaxDuration)

			if var_140_35 <= arg_137_1.time_ and arg_137_1.time_ < var_140_35 + var_140_45 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_35) / var_140_45

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_35 + var_140_45 and arg_137_1.time_ < var_140_35 + var_140_45 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_out_113062.awb"
	}
}
